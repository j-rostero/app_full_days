import {
  Inject,
  Injectable,
  Logger,
  type OnModuleDestroy,
  type OnModuleInit,
} from '@nestjs/common';
import type {
  Booking,
  BookingPassenger,
  Departure,
  PrismaClient,
  Product,
  Provider,
} from '@fulldays/db';
import {
  type BookingEvent,
  type BookingSelection,
  type BookingStatus,
  checkMealPicks,
  checkSelection,
  MAX_HELD_BOOKINGS,
  type MealPicks,
  mealName,
  nextBookingStatus,
  type PassengerInput,
  passengerCount,
  passengerTypes,
  type ProductSheet,
  type Quote,
  quote,
  SEAT_HOLDING_STATUSES,
  bookingCode,
  todayInVenezuela,
} from '@fulldays/shared';
import type { Config } from '../config.ts';
import { ApiException, conflict, notFound } from '../common/api-exception.ts';
import { CONFIG, DB } from '../common/tokens.ts';
import { SettingsService } from '../catalogs/settings.service.ts';
import { FilesService } from '../files/files.service.ts';
import type { BookingView } from './bookings.schemas.ts';

type Full = Booking & {
  departure: Departure & { product: Product };
  provider: Provider;
  passengers: BookingPassenger[];
  payments: { amountUsd: { toString(): string }; status: string }[];
};
export const BOOKING_INCLUDE = {
  departure: { include: { product: true } },
  provider: true,
  passengers: { orderBy: { position: 'asc' } },
  payments: { select: { amountUsd: true, status: true } },
} as const;

const SWEEP_MS = 60_000;
/** Espera por conexión: muchos compradores del último puesto hacen cola en vez de fallar. */
const HOLD_TX = { maxWait: 20_000, timeout: 20_000 };
const cents = (n: unknown) => Math.round(Number(n) * 100);

export interface HoldRequest {
  departureId: string;
  selection: BookingSelection;
  userId: string | null;
  source: 'app' | 'agency';
  contact?: { name: string; phone: string | null; email: string | null };
  /** Sin temporizador (ventas propias) cuando es nulo. */
  holdMinutes: number | null;
}

/** Apartado de cupos sin sobreventa, estados de la reserva y pasajeros. */
@Injectable()
export class BookingsService implements OnModuleInit, OnModuleDestroy {
  private readonly log = new Logger(BookingsService.name);
  private timer: NodeJS.Timeout | undefined;

  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(CONFIG) private readonly config: Config,
    @Inject(SettingsService) private readonly settings: SettingsService,
    @Inject(FilesService) private readonly files: FilesService,
  ) {}

  onModuleInit(): void {
    // Hasta que exista el worker (fase 5), la API libera los apartados vencidos.
    if (this.config.NODE_ENV === 'test') return;
    this.timer = setInterval(() => {
      this.expireHolds().catch((e: Error) => this.log.warn(`Vencer apartados: ${e.message}`));
    }, SWEEP_MS);
    this.timer.unref();
  }

  onModuleDestroy(): void {
    clearInterval(this.timer);
  }

  /** Salida que se puede vender ahora: visible, `open` y desde hoy. */
  async sellable(
    departureId: string,
    providerId?: string,
  ): Promise<Departure & { provider: Provider }> {
    const d = await this.db.departure.findFirst({
      where: {
        id: departureId,
        ...(providerId ? { providerId } : {}),
        status: 'open',
        date: { gte: new Date(`${todayInVenezuela()}T00:00:00Z`) },
        product: { status: 'published' },
        provider: { status: 'approved' },
      },
      include: { provider: true },
    });
    if (!d) throw notFound('Esa salida no está en venta.');
    return d;
  }

  /** Valida la selección contra la ficha de la salida y la cotiza. */
  async quoteFor(departure: Departure, selection: BookingSelection): Promise<Quote> {
    const sheet = departure.sheet as unknown as ProductSheet;
    const issues = checkSelection(sheet, selection);
    if (issues.length)
      throw new ApiException(400, 'validation_error', issues[0]!.message, {
        issues: issues.map((i) => ({ ...i, path: ['selection', ...i.path] })),
      });
    return quote(
      sheet,
      {
        date: departure.date.toISOString().slice(0, 10),
        adultPriceUsd: departure.adultPriceUsd === null ? null : Number(departure.adultPriceUsd),
      },
      selection,
      await this.settings.get(),
    );
  }

  /** Toma los puestos y los cupos de habitaciones y crea la reserva. */
  async hold(req: HoldRequest): Promise<Booking> {
    const departure = await this.sellable(req.departureId);
    const q = await this.quoteFor(departure, req.selection);
    const sheet = departure.sheet as unknown as ProductSheet;
    const rooms = req.selection.rooms
      .map((r) => ({ ...r, room: sheet.lodging?.rooms.find((x) => x.id === r.roomId) }))
      .filter((r) => r.room?.quantity != null)
      // Siempre en el mismo orden: dos apartados simultáneos no se bloquean entre sí.
      .sort((a, b) => a.roomId.localeCompare(b.roomId));
    return this.db.$transaction(async () => {
      if (req.userId) {
        const held = await this.db.booking.count({
          where: { userId: req.userId, status: 'held', heldUntil: { gt: new Date() } },
        });
        if (held >= MAX_HELD_BOOKINGS)
          throw conflict(
            `Ya tienes ${MAX_HELD_BOOKINGS} reservas apartadas sin pagar. Paga o deja vencer alguna antes de apartar otra.`,
          );
      }
      const taken = await this.db.$executeRaw`
        UPDATE departures SET reserved = reserved + ${q.seats}, updated_at = now()
        WHERE id = ${departure.id}::uuid AND status = 'open' AND reserved + ${q.seats} <= capacity`;
      if (taken === 0) throw conflict('No quedan suficientes puestos en esta salida.');
      for (const r of rooms) {
        const key = `room:${r.roomId}`;
        await this.db.$executeRaw`
          INSERT INTO departure_quotas (departure_id, key, "limit") VALUES (${departure.id}::uuid, ${key}, ${r.room!.quantity})
          ON CONFLICT DO NOTHING`;
        const ok = await this.db.$executeRaw`
          UPDATE departure_quotas SET taken = taken + ${r.count}
          WHERE departure_id = ${departure.id}::uuid AND key = ${key} AND taken + ${r.count} <= "limit"`;
        if (ok === 0) throw conflict('Se agotaron las habitaciones de ese tipo.');
      }
      return this.db.booking.create({
        data: {
          code: bookingCode(),
          providerId: departure.providerId,
          departureId: departure.id,
          userId: req.userId,
          source: req.source,
          selection: req.selection,
          lines: q.lines as never,
          seats: q.seats,
          totalUsd: q.totalUsd,
          depositUsd: q.depositUsd,
          balanceDueDate: new Date(`${q.balanceDueDate}T00:00:00Z`),
          heldUntil:
            req.holdMinutes === null ? null : new Date(Date.now() + req.holdMinutes * 60_000),
          contactName: req.contact?.name ?? null,
          contactPhone: req.contact?.phone ?? null,
          contactEmail: req.contact?.email ?? null,
          passengers: {
            create: passengerTypes(req.selection.travelers).map((type, position) => ({
              position,
              type,
            })),
          },
        },
      });
    }, HOLD_TX);
  }

  /**
   * Mueve la reserva solo si sigue en el estado leído; al vencer o cancelar devuelve los
   * puestos y las habitaciones en la misma transacción.
   */
  async move(
    booking: Booking,
    event: BookingEvent,
    ctx: { paidUsd?: number; boarded?: boolean } = {},
    data: { heldUntil?: Date | null; paidUsd?: number } = {},
  ): Promise<BookingStatus> {
    const to = nextBookingStatus(booking.status, event, {
      paidUsd: ctx.paidUsd ?? Number(booking.paidUsd),
      depositUsd: Number(booking.depositUsd),
      totalUsd: Number(booking.totalUsd),
      boarded: ctx.boarded,
    });
    if (to === null) throw conflict('La reserva ya no admite esa acción.');
    return this.db.$transaction(async () => {
      const moved = await this.db.booking.updateMany({
        where: { id: booking.id, status: booking.status },
        data: {
          status: to,
          ...(to === 'cancelled' ? { cancelledAt: new Date() } : {}),
          ...(to !== 'held' ? { heldUntil: null } : {}),
          ...data,
        },
      });
      if (moved.count === 0) throw conflict('La reserva cambió mientras tanto. Vuelve a cargarla.');
      if (SEAT_HOLDING_STATUSES.includes(booking.status) && !SEAT_HOLDING_STATUSES.includes(to))
        await this.release(booking);
      return to;
    });
  }

  private async release(booking: Booking): Promise<void> {
    await this.db.$executeRaw`
      UPDATE departures SET reserved = GREATEST(reserved - ${booking.seats}, 0), updated_at = now()
      WHERE id = ${booking.departureId}::uuid`;
    const selection = booking.selection as unknown as BookingSelection;
    for (const r of [...selection.rooms].sort((a, b) => a.roomId.localeCompare(b.roomId)))
      await this.db.$executeRaw`
        UPDATE departure_quotas SET taken = GREATEST(taken - ${r.count}, 0)
        WHERE departure_id = ${booking.departureId}::uuid AND key = ${`room:${r.roomId}`}`;
  }

  /** Vence los apartados cuyo tiempo pasó. Devuelve cuántos venció. */
  async expireHolds(now = new Date()): Promise<number> {
    const due = await this.db.booking.findMany({
      where: { status: 'held', heldUntil: { lt: now } },
      take: 200,
    });
    let done = 0;
    for (const b of due) {
      try {
        await this.move(b, 'expire');
        done++;
      } catch {
        // Otra petición la movió antes (pagó o la venció otro barrido).
      }
    }
    return done;
  }

  /** Vence esta reserva si su apartado pasó; así quien la mira nunca ve un apartado caducado. */
  async refresh(booking: Booking): Promise<void> {
    if (booking.status === 'held' && booking.heldUntil && booking.heldUntil < new Date())
      await this.move(booking, 'expire').catch(() => undefined);
  }

  async setPassengers(
    booking: Booking & { departure: { sheet: unknown } },
    passengers: (PassengerInput & { mealPicks: MealPicks })[],
  ): Promise<void> {
    if (!SEAT_HOLDING_STATUSES.includes(booking.status))
      throw conflict('Esta reserva ya no admite cambios de pasajeros.');
    const sold = booking.departure.sheet as ProductSheet;
    const issues = passengers.flatMap((p, i) =>
      checkMealPicks(sold, p.mealPicks).map((message) => ({
        path: ['passengers', String(i), 'mealPicks'],
        message,
      })),
    );
    if (issues.length)
      throw new ApiException(400, 'validation_error', issues[0]!.message, { issues });
    const count = passengerCount((booking.selection as unknown as BookingSelection).travelers);
    if (passengers.length !== count)
      throw new ApiException(
        400,
        'validation_error',
        `Escribe los datos de los ${count} pasajeros.`,
        {
          issues: [{ path: ['passengers'], message: `Son ${count} pasajeros.` }],
        },
      );
    await this.db.$transaction(async () => {
      for (const [position, p] of passengers.entries())
        await this.db.bookingPassenger.update({
          where: { bookingId_position: { bookingId: booking.id, position } },
          data: {
            name: p.name,
            cedula: p.cedula,
            birthDate: new Date(`${p.birthDate}T00:00:00Z`),
            restrictions: p.restrictions,
            mealPicks: p.mealPicks,
          },
        });
    });
  }

  async load(where: { id: string; userId?: string; providerId?: string }): Promise<Full> {
    const booking = await this.db.booking.findFirst({ where, include: BOOKING_INCLUDE });
    if (!booking) throw notFound('Esa reserva no existe.');
    return booking as Full;
  }

  async views(rows: Full[], withContact = false): Promise<BookingView[]> {
    const sheets = rows.map((b) => b.departure.product.sheet as unknown as ProductSheet);
    const covers = await this.files.images(
      sheets.map((s) => s.general.photoIds[0]).filter((id): id is string => Boolean(id)),
    );
    const coverOf = new Map(covers.map((c) => [c.id, c.urls]));
    return rows.map((b, i) => {
      const sheet = sheets[i]!;
      const pending = b.payments
        .filter((p) => p.status === 'pending')
        .reduce((s, p) => s + cents(p.amountUsd), 0);
      return {
        id: b.id,
        code: b.code,
        status: b.status,
        source: b.source,
        departure: {
          id: b.departure.id,
          date: b.departure.date.toISOString().slice(0, 10),
          status: b.departure.status,
        },
        product: {
          id: b.departure.product.id,
          type: b.departure.product.type,
          title: sheet.general.title,
          cover: coverOf.get(sheet.general.photoIds[0] ?? '') ?? null,
        },
        provider: {
          id: b.provider.id,
          name: b.provider.name,
          paymentInstructions: b.provider.paymentInstructions,
        },
        selection: b.selection as unknown as BookingSelection,
        lines: b.lines as unknown as BookingView['lines'],
        seats: b.seats,
        totalUsd: Number(b.totalUsd),
        depositUsd: Number(b.depositUsd),
        paidUsd: Number(b.paidUsd),
        pendingUsd: pending / 100,
        balanceUsd: Math.max(cents(b.totalUsd) - cents(b.paidUsd), 0) / 100,
        balanceDueDate: b.balanceDueDate.toISOString().slice(0, 10),
        heldUntil: b.heldUntil?.toISOString() ?? null,
        contact: withContact
          ? { name: b.contactName, phone: b.contactPhone, email: b.contactEmail }
          : null,
        passengers: b.passengers.map((p) => ({
          id: p.id,
          position: p.position,
          type: p.type,
          name: p.name,
          cedula: p.cedula,
          birthDate: p.birthDate?.toISOString().slice(0, 10) ?? null,
          restrictions: p.restrictions,
          mealPicks: p.mealPicks as Record<string, string[]>,
          checkin: p.checkin,
        })),
        mealChoices: (b.departure.sheet as ProductSheet).meals
          .filter((m) => m.mode === 'choice')
          .map((m) => ({
            mealId: m.id,
            name: mealName(m),
            picksPerPassenger: m.picksPerPassenger,
            options: m.options.map((o) => ({ id: o.id, name: o.name, isDefault: o.isDefault })),
          })),
        createdAt: b.createdAt.toISOString(),
      };
    });
  }
}
