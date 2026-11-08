import { Inject, Injectable, Logger } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import { type ProductSheet, todayInVenezuela } from '@fulldays/shared';
import { BookingsService } from '../bookings/bookings.service.ts';
import { DB } from '../common/tokens.ts';
import { bucketOf } from '../files/files.service.ts';
import { STORAGE, type Storage } from '../files/storage.ts';
import { NotificationsService } from '../notifications/notifications.service.ts';

/** Un archivo declarado y nunca confirmado se borra pasado este tiempo. */
export const ORPHAN_FILE_MS = 24 * 3_600_000;
/** Con cuántos días de anticipación se recuerda el saldo. */
export const BALANCE_REMINDER_DAYS = 2;

const day = (iso: string, plus = 0) => new Date(Date.parse(`${iso}T00:00:00Z`) + plus * 86_400_000);
const titleOf = (sheet: unknown) => (sheet as ProductSheet).general.title;

/**
 * Tareas periódicas. Cada una es idempotente: correrla dos veces, o en dos instancias a la vez,
 * no repite efectos (movimientos condicionales y avisos con `dedupeKey`).
 */
@Injectable()
export class JobsService {
  private readonly log = new Logger('Tareas');

  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(BookingsService) private readonly bookings: BookingsService,
    @Inject(NotificationsService) private readonly notifications: NotificationsService,
    @Inject(STORAGE) private readonly storage: Storage,
  ) {}

  expireHolds(now = new Date()): Promise<number> {
    return this.bookings.expireHolds(now);
  }

  /** Reservas con abono cuyo saldo venció sin pagarse: se cancelan con la política del viaje. */
  async cancelOverdueBalances(today = todayInVenezuela()): Promise<number> {
    const due = await this.db.booking.findMany({
      where: { status: 'deposit_paid', balanceDueDate: { lt: day(today) } },
      include: { departure: true },
      take: 200,
    });
    let done = 0;
    for (const b of due) {
      try {
        await this.bookings.cancel(b, 'system', 'balance_overdue');
        done++;
      } catch {
        // Pagó o la canceló otra instancia mientras tanto.
      }
    }
    return done;
  }

  /** Recordatorio del viaje de mañana y del saldo que vence pronto. Una vez por reserva. */
  async remind(today = todayInVenezuela()): Promise<number> {
    const [tomorrow, balance] = await Promise.all([
      this.db.booking.findMany({
        where: {
          status: { in: ['deposit_paid', 'paid'] },
          userId: { not: null },
          departure: { date: day(today, 1), status: { not: 'cancelled' } },
        },
        include: { departure: { select: { sheet: true } } },
      }),
      this.db.booking.findMany({
        where: {
          status: 'deposit_paid',
          userId: { not: null },
          balanceDueDate: { gte: day(today), lte: day(today, BALANCE_REMINDER_DAYS) },
        },
        include: { departure: { select: { sheet: true } } },
      }),
    ]);
    return this.notifications.enqueue([
      ...tomorrow.map((b) => ({
        userId: b.userId!,
        event: 'trip_tomorrow' as const,
        body: `Mañana es tu viaje ${titleOf(b.departure.sheet)}. Lleva tu código ${b.code}.`,
        link: `reserva:${b.id}`,
        dedupeKey: `trip_tomorrow:${b.id}`,
      })),
      ...balance.map((b) => ({
        userId: b.userId!,
        event: 'balance_due' as const,
        body:
          `El saldo de ${(Number(b.totalUsd) - Number(b.paidUsd)).toFixed(2)} USD de tu reserva ` +
          `${b.code} vence el ${b.balanceDueDate.toISOString().slice(0, 10)}.`,
        link: `reserva:${b.id}`,
        dedupeKey: `balance_due:${b.id}:${b.balanceDueDate.toISOString().slice(0, 10)}`,
      })),
    ]);
  }

  /** Salidas que pasaron su fecha sin arrancar dejan de venderse. */
  async closePastDepartures(today = todayInVenezuela()): Promise<number> {
    const { count } = await this.db.departure.updateMany({
      where: { status: { in: ['open', 'paused'] }, date: { lt: day(today) } },
      data: { status: 'closed' },
    });
    return count;
  }

  /** Archivos declarados que nunca se confirmaron: se borra el objeto y su registro. */
  async removeOrphanFiles(now = new Date()): Promise<number> {
    const files = await this.db.file.findMany({
      where: { status: 'pending', createdAt: { lt: new Date(now.getTime() - ORPHAN_FILE_MS) } },
      take: 200,
    });
    let done = 0;
    for (const f of files) {
      try {
        await this.storage.delete(bucketOf(f), f.key);
        await this.db.file.delete({ where: { id: f.id } });
        done++;
      } catch (e) {
        this.log.warn(`No se borró el archivo ${f.id}: ${(e as Error).message}`);
      }
    }
    return done;
  }

  /** Entrega la cola de mensajes por tandas hasta vaciar lo vencido. */
  async deliver(): Promise<number> {
    let total = 0;
    for (let i = 0; i < 20; i++) {
      const sent = await this.notifications.deliverPending(50);
      total += sent;
      if (sent < 50) break;
    }
    return total;
  }

  /** Todas las tareas de mantenimiento, en orden. */
  async sweep(): Promise<Record<string, number>> {
    return {
      expired: await this.expireHolds(),
      overdue: await this.cancelOverdueBalances(),
      closed: await this.closePastDepartures(),
      reminded: await this.remind(),
      orphans: await this.removeOrphanFiles(),
    };
  }
}
