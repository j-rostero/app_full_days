import { Body, Controller, Get, Header, HttpCode, Inject, Param, Post } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import {
  type BookingSelection,
  CONFIRMED_STATUSES,
  type MealPicks,
  mealsInWords,
  PASSENGER_TYPES,
  type ProductSheet,
  production,
  resolveCheckins,
  toCsv,
  todayInVenezuela,
  CHECKIN_MARKS,
} from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { ScopedDb } from '../access/scoped-db.ts';
import { forbidden, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import {
  Auth,
  type AuthContext,
  Membership,
  type MembershipContext,
  Trail,
  type AuditTrail,
} from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { VOUCHER_SIGNER } from '../payments/payments.module.tokens.ts';
import { NotificationsService } from '../notifications/notifications.service.ts';
import type { VoucherSigner } from '../payments/vouchers.ts';
import {
  CheckinSyncInput,
  CsvSchema,
  ManifestSchema,
  NoticeInput,
  NoticeListSchema,
  NoticeSchema,
  ProductionSchema,
  TodayListSchema,
} from './tripday.schemas.ts';

const TAG = ['dia-del-viaje'];
const CONFIRMED = [...CONFIRMED_STATUSES];
const cents = (n: unknown) => Math.round(Number(n) * 100);
const day = (d: Date) => d.toISOString().slice(0, 10);
const titleOf = (sheet: unknown) => (sheet as ProductSheet).general.title;

type Manifest = z.infer<typeof ManifestSchema>;

/** Lo que pasa el día del viaje: lista de pasajeros, check-in sin conexión, producción y avisos. */
@Controller('pro/:providerId/salidas')
export class TripdayController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(VOUCHER_SIGNER) private readonly signer: VoucherSigner,
    @Inject(NotificationsService) private readonly notifications: NotificationsService,
  ) {}

  @Get('hoy')
  @Can('checkin')
  @Endpoint({
    operationId: 'listTodayDepartures',
    summary:
      'Salidas no canceladas de hoy y mañana, con pasajeros y abordados; un guía solo ve las suyas',
    tags: TAG,
    responses: { 200: TodayListSchema },
  })
  async today(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Auth() auth: AuthContext,
  ): Promise<z.infer<typeof TodayListSchema>> {
    const today = new Date(`${todayInVenezuela()}T00:00:00Z`);
    const rows = await db.departure.findMany({
      where: {
        date: { gte: today, lte: new Date(today.getTime() + 86_400_000) },
        status: { not: 'cancelled' },
        ...(m.role === 'guide' ? { guides: { some: { userId: auth.userId } } } : {}),
      },
      include: {
        guides: { include: { user: { select: { id: true, email: true, name: true } } } },
        bookings: {
          where: { status: { in: CONFIRMED } },
          select: { passengers: { select: { checkin: true } } },
        },
      },
      orderBy: [{ date: 'asc' }, { createdAt: 'asc' }],
    });
    return {
      items: rows.map((d) => {
        const passengers = d.bookings.flatMap((b) => b.passengers);
        return {
          id: d.id,
          date: day(d.date),
          title: titleOf(d.sheet),
          productType: d.productType,
          status: d.status,
          passengers: passengers.length,
          boarded: passengers.filter((p) => p.checkin === 'boarded').length,
          guides: d.guides.map((g) => g.user),
        };
      }),
    };
  }

  @Get(':departureId/pasajeros')
  @Can('checkin')
  @Endpoint({
    operationId: 'getManifest',
    summary:
      'Lista de pasajeros con reserva confirmada, platos, saldo, check-in y las llaves para validar vouchers',
    tags: TAG,
    responses: { 200: ManifestSchema },
  })
  async manifest(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Auth() auth: AuthContext,
    @Param('departureId') departureId: string,
  ): Promise<Manifest> {
    await this.departureFor(db, m, auth, departureId);
    return this.load(db, departureId, []);
  }

  @Post(':departureId/checkins')
  @HttpCode(200)
  @Can('checkin')
  @Endpoint({
    operationId: 'syncCheckins',
    summary:
      'Aplica las marcas hechas sin conexión (gana la más reciente por hora del teléfono) y devuelve la lista',
    tags: TAG,
    body: CheckinSyncInput,
    responses: { 200: ManifestSchema },
  })
  async sync(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Auth() auth: AuthContext,
    @Param('departureId') departureId: string,
    @Body(new ZodPipe(CheckinSyncInput)) input: z.infer<typeof CheckinSyncInput>,
    @Trail() trail: AuditTrail,
  ): Promise<Manifest> {
    await this.departureFor(db, m, auth, departureId);
    const passengers = await this.db.bookingPassenger.findMany({
      where: { booking: { departureId, providerId: m.providerId, status: { in: CONFIRMED } } },
      select: { id: true, checkin: true, checkinAt: true },
    });
    const { winners, discarded } = resolveCheckins(
      new Map(passengers.map((p) => [p.id, p])),
      input.events,
    );
    let applied = 0;
    for (const [id, mark] of winners) {
      // Condicional: si otro guía guardó una marca más nueva mientras tanto, esta no la pisa.
      const done = await this.db.bookingPassenger.updateMany({
        where: {
          id,
          OR: [{ checkinAt: null }, { checkinAt: { lt: mark.checkinAt } }],
        },
        data: { checkin: mark.checkin, checkinAt: mark.checkinAt, checkinById: auth.userId },
      });
      if (done.count) applied++;
      else discarded.push({ passengerId: id, reason: 'older' });
    }
    trail.after = { received: input.events.length, applied };
    return this.load(db, departureId, discarded);
  }

  @Get(':departureId/produccion')
  @Can('bookings')
  @Endpoint({
    operationId: 'getProduction',
    summary:
      'Lo que hay que preparar: platos por opción y pendientes, ítems, habitaciones por tipo y restricciones',
    tags: TAG,
    responses: { 200: ProductionSchema },
  })
  async production(
    @ScopedDb() db: PrismaClient,
    @Param('departureId') departureId: string,
  ): Promise<z.infer<typeof ProductionSchema>> {
    const d = await this.confirmed(db, departureId);
    const sheet = d.sheet as unknown as ProductSheet;
    return {
      departure: { id: d.id, date: day(d.date), title: sheet.general.title },
      ...production(
        sheet,
        d.bookings.map((b) => ({
          selection: b.selection as unknown as BookingSelection,
          passengers: b.passengers.map((p) => ({
            name: p.name,
            type: p.type,
            restrictions: p.restrictions,
            mealPicks: p.mealPicks as MealPicks,
          })),
        })),
      ),
    };
  }

  @Get(':departureId/pasajeros.csv')
  @Can('bookings')
  @Header('content-type', 'text/csv; charset=utf-8')
  @Header('content-disposition', 'attachment; filename="pasajeros.csv"')
  @Endpoint({
    operationId: 'getManifestCsv',
    summary: 'La lista de pasajeros como CSV para Excel',
    tags: TAG,
    contentType: 'text/csv',
    responses: { 200: CsvSchema },
  })
  async csv(
    @ScopedDb() db: PrismaClient,
    @Param('departureId') departureId: string,
  ): Promise<string> {
    const d = await this.confirmed(db, departureId);
    const sheet = d.sheet as unknown as ProductSheet;
    const boardingName = (s: BookingSelection) => {
      const b = sheet.transfer.boardingPoints.find((x) => x.id === s.boardingId);
      return b ? b.name || b.city : '';
    };
    const rows: (string | number | null)[][] = [
      [
        'Reserva',
        'Pasajero',
        'Tipo',
        'Cédula',
        'Nacimiento',
        'Embarque',
        'Platos',
        'Restricciones',
        'Contacto',
        'Teléfono',
        'Saldo USD',
        'Check-in',
      ],
    ];
    for (const b of d.bookings) {
      const balance = Math.max(cents(b.totalUsd) - cents(b.paidUsd), 0) / 100;
      for (const p of b.passengers)
        rows.push([
          b.code,
          p.name,
          PASSENGER_TYPES[p.type],
          p.cedula,
          p.birthDate ? day(p.birthDate) : null,
          boardingName(b.selection as unknown as BookingSelection),
          mealsInWords(sheet, p.mealPicks as MealPicks).join(' · '),
          p.restrictions,
          b.contactName ?? b.user?.name ?? null,
          b.contactPhone ?? b.user?.phone ?? null,
          p.position === 0 ? balance.toFixed(2) : null,
          p.checkin ? CHECKIN_MARKS[p.checkin] : null,
        ]);
    }
    return toCsv(rows);
  }

  @Get(':departureId/avisos')
  @Can('notices')
  @Endpoint({
    operationId: 'listDepartureNotices',
    summary: 'Avisos publicados en la salida, el más nuevo primero',
    tags: TAG,
    responses: { 200: NoticeListSchema },
  })
  async notices(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Auth() auth: AuthContext,
    @Param('departureId') departureId: string,
  ) {
    await this.departureFor(db, m, auth, departureId);
    return { items: await noticesOf(this.db, departureId) };
  }

  @Post(':departureId/avisos')
  @Can('notices')
  @Endpoint({
    operationId: 'publishDepartureNotice',
    summary: 'Publica un aviso para los viajeros con reserva confirmada en la salida',
    tags: TAG,
    body: NoticeInput,
    responses: { 201: NoticeSchema },
  })
  async publish(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Auth() auth: AuthContext,
    @Param('departureId') departureId: string,
    @Body(new ZodPipe(NoticeInput)) input: z.infer<typeof NoticeInput>,
  ): Promise<z.infer<typeof NoticeSchema>> {
    const d = await this.departureFor(db, m, auth, departureId);
    if (d.status === 'cancelled' || d.status === 'finished')
      throw forbidden('Esa salida ya no recibe avisos.');
    const notice = await db.departureNotice.create({
      data: { departureId, authorId: auth.userId, body: input.body } as never,
      include: { author: { select: { name: true } } },
    });
    // Un aviso por viajero con reserva confirmada, aunque tenga varias reservas en la salida.
    const travelers = await this.db.booking.findMany({
      where: { departureId, status: { in: CONFIRMED }, userId: { not: null } },
      select: { id: true, userId: true },
      distinct: ['userId'],
    });
    const title = titleOf(d.sheet);
    await this.notifications.enqueue(
      travelers.map((b) => ({
        userId: b.userId!,
        event: 'notice' as const,
        title: `Aviso: ${title}`,
        body: input.body,
        link: `reserva:${b.id}`,
        dedupeKey: `notice:${notice.id}:${b.userId}`,
      })),
    );
    return view(notice);
  }

  /** La salida de la agencia; un guía solo abre las que tiene asignadas. */
  private async departureFor(
    db: PrismaClient,
    m: MembershipContext,
    auth: AuthContext,
    departureId: string,
  ) {
    if (!isUuid(departureId)) throw notFound();
    const d = await db.departure.findFirst({
      where: { id: departureId },
      include: { guides: { select: { userId: true } } },
    });
    if (!d) throw notFound('Esa salida no existe.');
    if (m.role === 'guide' && !d.guides.some((g) => g.userId === auth.userId))
      throw forbidden('No estás asignado a esta salida.');
    return d;
  }

  private async confirmed(db: PrismaClient, departureId: string) {
    if (!isUuid(departureId)) throw notFound();
    const d = await db.departure.findFirst({
      where: { id: departureId },
      include: {
        bookings: {
          where: { status: { in: CONFIRMED } },
          include: {
            passengers: { orderBy: { position: 'asc' } },
            user: { select: { name: true, phone: true } },
          },
          orderBy: { createdAt: 'asc' },
        },
      },
    });
    if (!d) throw notFound('Esa salida no existe.');
    return d;
  }

  private async load(
    db: PrismaClient,
    departureId: string,
    discarded: Manifest['discarded'],
  ): Promise<Manifest> {
    const d = await this.confirmed(db, departureId);
    const sheet = d.sheet as unknown as ProductSheet;
    return {
      departure: { id: d.id, date: day(d.date), title: sheet.general.title, status: d.status },
      keys: this.signer.keys(),
      passengers: d.bookings.flatMap((b) => {
        const s = b.selection as unknown as BookingSelection;
        const boarding = sheet.transfer.boardingPoints.find((x) => x.id === s.boardingId);
        const balance = Math.max(cents(b.totalUsd) - cents(b.paidUsd), 0) / 100;
        return b.passengers.map((p) => ({
          id: p.id,
          bookingId: b.id,
          bookingCode: b.code,
          position: p.position,
          type: p.type,
          name: p.name,
          cedula: p.cedula,
          restrictions: p.restrictions,
          meals: mealsInWords(sheet, p.mealPicks as MealPicks),
          boarding: boarding ? boarding.name || boarding.city : null,
          balanceUsd: balance,
          checkin: p.checkin,
          checkinAt: p.checkinAt?.toISOString() ?? null,
        }));
      }),
      discarded,
    };
  }
}

type NoticeRow = { id: string; body: string; createdAt: Date; author: { name: string | null } };
const view = (n: NoticeRow) => ({
  id: n.id,
  body: n.body,
  author: n.author.name,
  createdAt: n.createdAt.toISOString(),
});

export async function noticesOf(db: PrismaClient, departureId: string) {
  const rows = await db.departureNotice.findMany({
    where: { departureId },
    include: { author: { select: { name: true } } },
    orderBy: { createdAt: 'desc' },
    take: 100,
  });
  return rows.map(view);
}

/** Avisos que ve el viajero en su reserva. */
@Controller('reservas')
export class TravelerNoticesController {
  constructor(@Inject(DB) private readonly db: PrismaClient) {}

  @Get(':id/avisos')
  @Endpoint({
    operationId: 'listBookingNotices',
    summary: 'Avisos de la agencia para la salida de esta reserva, el más nuevo primero',
    tags: TAG,
    responses: { 200: NoticeListSchema },
  })
  async list(@Auth() auth: AuthContext, @Param('id') id: string) {
    if (!isUuid(id)) throw notFound();
    const booking = await this.db.booking.findFirst({ where: { id, userId: auth.userId } });
    if (!booking) throw notFound('Esa reserva no existe.');
    return { items: await noticesOf(this.db, booking.departureId) };
  }
}
