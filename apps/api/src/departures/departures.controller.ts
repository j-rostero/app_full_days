import { Body, Controller, Get, HttpCode, Inject, Param, Patch, Post, Query } from '@nestjs/common';
import type { Departure, DepartureGuide, PrismaClient, User } from '@fulldays/db';
import {
  canMoveDeparture,
  DEPARTURE_STATUS_LABELS,
  seatsLeft,
  todayInVenezuela,
} from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { ScopedDb } from '../access/scoped-db.ts';
import { ApiException, conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Membership, type MembershipContext, Trail, type AuditTrail } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { sheetOf } from '../products/products.service.ts';
import {
  DepartureListSchema,
  DepartureQuery,
  DepartureSchema,
  DepartureUpdateInput,
  type DepartureView,
  ScheduleDeparturesInput,
} from './departures.schemas.ts';
import { departureFacets } from './facets.ts';
import { BookingsService } from '../bookings/bookings.service.ts';
import { NotificationsService } from '../notifications/notifications.service.ts';

const TAG = ['salidas'];
type Row = Departure & {
  guides: (DepartureGuide & { user: Pick<User, 'id' | 'email' | 'name'> })[];
};
const INCLUDE = {
  guides: { include: { user: { select: { id: true, email: true, name: true } } } },
} as const;

/** Fechas en que corre cada producto, con cupo, mínimo, precio y guías. */
@Controller('pro/:providerId/salidas')
export class DeparturesController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(BookingsService) private readonly bookings: BookingsService,
    @Inject(NotificationsService) private readonly notifications: NotificationsService,
  ) {}

  @Get()
  @Can('departures')
  @Endpoint({
    operationId: 'listDepartures',
    summary: 'Salidas de la agencia por fecha, desde hoy salvo que se pida otra fecha (máximo 500)',
    tags: TAG,
    query: DepartureQuery,
    responses: { 200: DepartureListSchema },
  })
  async list(
    @ScopedDb() db: PrismaClient,
    @Query(new ZodPipe(DepartureQuery)) query: z.infer<typeof DepartureQuery>,
  ) {
    const rows = await db.departure.findMany({
      where: {
        ...(query.productId ? { productId: query.productId } : {}),
        date: { gte: new Date(`${query.desde ?? todayInVenezuela()}T00:00:00Z`) },
      },
      include: INCLUDE,
      orderBy: [{ date: 'asc' }, { createdAt: 'asc' }],
      take: 500,
    });
    return { items: rows.map(toView) };
  }

  @Post()
  @HttpCode(201)
  @Can('departures')
  @Endpoint({
    operationId: 'scheduleDepartures',
    summary:
      'Programa una o varias fechas de un producto publicado con el mismo cupo, mínimo y precio',
    tags: TAG,
    body: ScheduleDeparturesInput,
    responses: { 201: DepartureListSchema },
  })
  async schedule(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Body(new ZodPipe(ScheduleDeparturesInput)) input: z.infer<typeof ScheduleDeparturesInput>,
  ) {
    const product = await db.product.findFirst({ where: { id: input.productId } });
    if (!product) throw notFound('Ese producto no existe.');
    if (product.status !== 'published')
      throw conflict('Solo se programan salidas de un producto publicado.');
    const today = todayInVenezuela();
    const past = input.dates.filter((d) => d < today);
    if (past.length) throw conflict(`Estas fechas ya pasaron: ${past.join(', ')}.`);
    const taken = await db.departure.findMany({
      where: {
        productId: product.id,
        date: { in: input.dates.map((d) => new Date(`${d}T00:00:00Z`)) },
      },
      select: { date: true },
    });
    if (taken.length)
      throw conflict(
        `Ya hay salidas en: ${taken.map((t) => t.date.toISOString().slice(0, 10)).join(', ')}.`,
      );

    const provider = await this.db.provider.findUniqueOrThrow({ where: { id: m.providerId } });
    const sheet = sheetOf(product);
    const facets = await departureFacets(
      this.db,
      product.type,
      sheet,
      { providerName: provider.name, providerCity: provider.baseCity },
      input.adultPriceUsd,
    );
    await db.departure.createMany({
      data: input.dates.map((date) => ({
        productId: product.id,
        date: new Date(`${date}T00:00:00Z`),
        capacity: input.capacity,
        minCapacity: input.minCapacity,
        adultPriceUsd: input.adultPriceUsd,
        sheet,
        ...facets,
      })) as never,
    });
    const rows = await db.departure.findMany({
      where: {
        productId: product.id,
        date: { in: input.dates.map((d) => new Date(`${d}T00:00:00Z`)) },
      },
      include: INCLUDE,
      orderBy: { date: 'asc' },
    });
    return { items: rows.map(toView) };
  }

  @Patch(':departureId')
  @Can('departures')
  @Endpoint({
    operationId: 'updateDeparture',
    summary: 'Cambia cupo, mínimo, precio propio, estado o guías de una salida',
    tags: TAG,
    body: DepartureUpdateInput,
    responses: { 200: DepartureSchema },
  })
  async update(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Param('departureId') departureId: string,
    @Body(new ZodPipe(DepartureUpdateInput)) input: z.infer<typeof DepartureUpdateInput>,
    @Trail() trail: AuditTrail,
  ): Promise<DepartureView> {
    if (!isUuid(departureId)) throw notFound();
    // Bloquea la fila: una reserva simultánea no puede pasar del cupo nuevo.
    await this.db
      .$queryRaw`SELECT id FROM departures WHERE id = ${departureId}::uuid AND provider_id = ${m.providerId}::uuid FOR UPDATE`;
    const departure = await db.departure.findFirst({
      where: { id: departureId },
      include: INCLUDE,
    });
    if (!departure) throw notFound();
    trail.before = toView(departure);

    if (input.status && !canMoveDeparture(departure.status, input.status)) {
      throw conflict(
        `Una salida «${DEPARTURE_STATUS_LABELS[departure.status]}» no puede pasar a «${DEPARTURE_STATUS_LABELS[input.status]}».`,
      );
    }
    const capacity = input.capacity ?? departure.capacity;
    const minCapacity = input.minCapacity ?? departure.minCapacity;
    if (capacity < departure.reserved)
      throw conflict(
        `Ya hay ${departure.reserved} puestos reservados: el cupo no puede bajar de ahí.`,
      );
    if (minCapacity > capacity) throw conflict('El mínimo para salir no puede pasar del cupo.');
    if (input.guideIds) await this.checkGuides(m.providerId, input.guideIds);

    const adultPriceUsd =
      input.adultPriceUsd === undefined
        ? departure.adultPriceUsd === null
          ? null
          : Number(departure.adultPriceUsd)
        : input.adultPriceUsd;
    await db.departure.update({
      where: { id: departure.id },
      data: {
        capacity,
        minCapacity,
        adultPriceUsd,
        priceUsd:
          adultPriceUsd ??
          sheetOf({ type: departure.productType, sheet: departure.sheet }).pricing.fares.adult,
        ...(input.status ? { status: input.status } : {}),
      },
    });
    if (input.guideIds) {
      await this.db.departureGuide.deleteMany({ where: { departureId: departure.id } });
      await this.db.departureGuide.createMany({
        data: [...new Set(input.guideIds)].map((userId) => ({ departureId: departure.id, userId })),
      });
    }
    if (input.status === 'finished' && departure.status !== 'finished') {
      // Al cerrar la salida, cada reserva confirmada queda realizada si alguien abordó, o sin presentarse.
      const paid = {
        departureId: departure.id,
        status: { in: ['deposit_paid' as const, 'paid' as const] },
      };
      await this.db.booking.updateMany({
        where: { ...paid, passengers: { some: { checkin: 'boarded' } } },
        data: { status: 'completed' },
      });
      await this.db.booking.updateMany({ where: paid, data: { status: 'no_show' } });
    }
    if (input.status === 'cancelled' && departure.status !== 'cancelled') {
      // Cancela cada reserva viva como agencia (reembolso total) y avisa a cada viajero.
      const live = await this.db.booking.findMany({
        where: {
          departureId: departure.id,
          status: { in: ['held', 'in_review', 'deposit_paid', 'paid'] },
        },
        include: { departure: { select: { date: true, sheet: true } } },
      });
      for (const b of live) await this.bookings.cancel(b, 'agency', 'cancel', false);
      const title = sheetOf({ type: departure.productType, sheet: departure.sheet }).general.title;
      await this.notifications.enqueue(
        live
          .filter((b) => b.userId)
          .map((b) => ({
            userId: b.userId!,
            event: 'departure_cancelled' as const,
            body: `La agencia canceló la salida del ${departure.date.toISOString().slice(0, 10)} de ${title}. Te devolverá todo lo pagado.`,
            link: `reserva:${b.id}`,
            dedupeKey: `departure_cancelled:${b.id}`,
          })),
      );
    }
    const updated = await db.departure.findFirstOrThrow({
      where: { id: departure.id },
      include: INCLUDE,
    });
    return toView(updated);
  }

  private async checkGuides(providerId: string, userIds: string[]) {
    const members = await this.db.providerMember.count({
      where: { providerId, userId: { in: [...new Set(userIds)] } },
    });
    if (members !== new Set(userIds).size) {
      throw new ApiException(400, 'validation_error', 'Revisa los datos.', {
        issues: [{ path: ['guideIds'], message: 'Los guías deben ser parte del equipo.' }],
      });
    }
  }
}

function toView(row: Row): DepartureView {
  return {
    id: row.id,
    productId: row.productId,
    productType: row.productType,
    title: sheetOf({ type: row.productType, sheet: row.sheet }).general.title,
    date: row.date.toISOString().slice(0, 10),
    status: row.status,
    capacity: row.capacity,
    minCapacity: row.minCapacity,
    reserved: row.reserved,
    seatsLeft: seatsLeft(row),
    adultPriceUsd: row.adultPriceUsd === null ? null : Number(row.adultPriceUsd),
    priceUsd: Number(row.priceUsd),
    guides: row.guides.map((g) => g.user),
  };
}
