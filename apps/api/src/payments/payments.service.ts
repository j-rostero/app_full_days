import { randomUUID } from 'node:crypto';
import { Inject, Injectable } from '@nestjs/common';
import type { Booking, File, Payment, PrismaClient } from '@fulldays/db';
import {
  BOLIVAR_METHODS,
  type BookingSelection,
  nextBookingStatus,
  normalizeReference,
  paymentPostings,
  type ReportPayment,
  todayInVenezuela,
} from '@fulldays/shared';
import type { Config } from '../config.ts';
import { conflict, notFound } from '../common/api-exception.ts';
import { CONFIG, DB } from '../common/tokens.ts';
import { SettingsService } from '../catalogs/settings.service.ts';
import { FilesService } from '../files/files.service.ts';
import { BookingsService } from '../bookings/bookings.service.ts';
import type { PaymentView } from './payments.schemas.ts';

const cents = (n: unknown) => Math.round(Number(n) * 100);
const ACCEPTS_PAYMENTS = ['held', 'in_review', 'deposit_paid'] as const;

type Row = Payment & {
  proof: File | null;
  booking: Booking & { departure: { date: Date; sheet: unknown } };
};

/** Pagos hechos fuera de la plataforma: el viajero los reporta y la agencia los concilia. */
@Injectable()
export class PaymentsService {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(CONFIG) private readonly config: Config,
    @Inject(SettingsService) private readonly settings: SettingsService,
    @Inject(FilesService) private readonly files: FilesService,
    @Inject(BookingsService) private readonly bookings: BookingsService,
  ) {}

  async report(userId: string, bookingId: string, input: ReportPayment): Promise<Payment> {
    const again = await this.db.payment.findUnique({
      where: { bookingId_idempotencyKey: { bookingId, idempotencyKey: input.idempotencyKey } },
    });
    if (again) return again;
    const booking = await this.bookings.load({ id: bookingId, userId });
    await this.bookings.refresh(booking);
    const { paymentMethods } = await this.settings.get();
    if (!paymentMethods.includes(input.method))
      throw conflict('Ese método de pago no está disponible.');
    return this.db.$transaction(async () => {
      // Bloquea la reserva: dos reportes simultáneos no pasan juntos del saldo.
      await this.db.$queryRaw`SELECT id FROM bookings WHERE id = ${bookingId}::uuid FOR UPDATE`;
      const current = await this.db.booking.findUniqueOrThrow({ where: { id: bookingId } });
      if (!(ACCEPTS_PAYMENTS as readonly string[]).includes(current.status))
        throw conflict('Esta reserva ya no admite pagos.');
      const pending = await this.db.payment.aggregate({
        where: { bookingId, status: 'pending' },
        _sum: { amountUsd: true },
      });
      const room =
        cents(current.totalUsd) - cents(current.paidUsd) - cents(pending._sum.amountUsd ?? 0);
      if (cents(input.amountUsd) > room)
        throw conflict(
          `El monto pasa de lo que falta por pagar (${(Math.max(room, 0) / 100).toFixed(2)} USD).`,
        );
      if (input.proofFileId)
        await this.files.requireReady([input.proofFileId], 'document', [userId], ['proofFileId']);
      const bolivars = await this.bolivars(input.method, input.amountUsd);
      const reference = normalizeReference(input.reference);
      if (await this.db.payment.count({ where: { reference } }))
        throw conflict('Esa referencia ya fue reportada en otro pago.');
      const payment = await this.db.payment.create({
        data: {
          providerId: current.providerId,
          bookingId,
          method: input.method,
          reference,
          amountUsd: input.amountUsd,
          ...bolivars,
          proofFileId: input.proofFileId,
          idempotencyKey: input.idempotencyKey,
          reportedById: userId,
        },
      });
      if (current.status === 'held') await this.bookings.move(current, 'submit_proof');
      return payment;
    });
  }

  private async bolivars(method: Payment['method'], amountUsd: number) {
    if (!BOLIVAR_METHODS.includes(method)) return {};
    const rate = await this.db.exchangeRate.findFirst({
      where: { date: { lte: new Date(`${todayInVenezuela()}T00:00:00Z`) } },
      orderBy: { date: 'desc' },
    });
    if (!rate) throw conflict('Aún no hay tasa del día. Intenta más tarde o paga en dólares.');
    return {
      bsPerUsd: rate.bsPerUsd,
      amountBs: Math.round(amountUsd * Number(rate.bsPerUsd) * 100) / 100,
    };
  }

  /** Aplica un pago confirmado a su reserva y lo asienta en el libro. */
  async apply(payment: Payment): Promise<void> {
    const booking = await this.db.booking.findUniqueOrThrow({ where: { id: payment.bookingId } });
    const paidUsd = (cents(booking.paidUsd) + cents(payment.amountUsd)) / 100;
    const to = nextBookingStatus(booking.status, 'confirm_payment', {
      paidUsd,
      depositUsd: Number(booking.depositUsd),
      totalUsd: Number(booking.totalUsd),
    });
    const { holdMinutes, platformCommissionPercent } = await this.settings.get();
    await this.bookings.move(
      booking,
      'confirm_payment',
      { paidUsd },
      {
        paidUsd,
        ...(to === 'held' && booking.source === 'app'
          ? { heldUntil: new Date(Date.now() + holdMinutes * 60_000) }
          : {}),
      },
    );
    const provider = await this.db.provider.findUniqueOrThrow({
      where: { id: payment.providerId },
    });
    const commission =
      provider.commissionPercent === null
        ? platformCommissionPercent
        : Number(provider.commissionPercent);
    const transactionId = randomUUID();
    await this.db.ledgerEntry.createMany({
      data: paymentPostings(Number(payment.amountUsd), commission, this.config.MONEY_MODEL).map(
        (p) => ({
          transactionId,
          providerId: payment.providerId,
          bookingId: payment.bookingId,
          paymentId: payment.id,
          account: p.account,
          debitUsd: p.debitUsd,
          creditUsd: p.creditUsd,
        }),
      ),
    });
  }

  async confirm(providerId: string, paymentId: string, reviewerId: string): Promise<void> {
    await this.db.$transaction(async () => {
      const payment = await this.review(providerId, paymentId, reviewerId, 'confirmed');
      await this.apply(payment);
    });
  }

  async reject(
    providerId: string,
    paymentId: string,
    reviewerId: string,
    reason: string,
  ): Promise<void> {
    await this.db.$transaction(async () => {
      const payment = await this.review(providerId, paymentId, reviewerId, 'rejected', reason);
      const booking = await this.db.booking.findUniqueOrThrow({ where: { id: payment.bookingId } });
      const stillPending = await this.db.payment.count({
        where: { bookingId: booking.id, status: 'pending' },
      });
      if (booking.status === 'in_review' && stillPending === 0) {
        const { holdMinutes } = await this.settings.get();
        await this.bookings.move(
          booking,
          'reject_proof',
          {},
          { heldUntil: new Date(Date.now() + holdMinutes * 60_000) },
        );
      }
    });
  }

  /** Marca el pago como revisado solo si sigue pendiente: dos personas no lo aplican dos veces. */
  private async review(
    providerId: string,
    paymentId: string,
    reviewerId: string,
    status: 'confirmed' | 'rejected',
    reason?: string,
  ): Promise<Payment> {
    const exists = await this.db.payment.findFirst({ where: { id: paymentId, providerId } });
    if (!exists) throw notFound('Ese pago no existe.');
    const done = await this.db.payment.updateMany({
      where: { id: paymentId, providerId, status: 'pending' },
      data: { status, reason: reason ?? null, reviewedById: reviewerId, reviewedAt: new Date() },
    });
    if (done.count === 0) throw conflict('Ese pago ya fue revisado.');
    return { ...exists, status, reason: reason ?? null };
  }

  /** Venta propia: aparta sin temporizador y, si trae dinero recibido, lo deja confirmado. */
  async manualBooking(
    providerId: string,
    userId: string,
    input: {
      departureId: string;
      selection: BookingSelection;
      contact: { name: string; phone: string | null; email: string | null };
      payment: { method: Payment['method']; reference: string; amountUsd: number } | null;
    },
  ): Promise<Booking> {
    await this.bookings.sellable(input.departureId, providerId);
    return this.db.$transaction(async () => {
      const booking = await this.bookings.hold({
        departureId: input.departureId,
        selection: input.selection,
        userId: null,
        source: 'agency',
        contact: input.contact,
        holdMinutes: null,
      });
      if (input.payment) {
        if (cents(input.payment.amountUsd) > cents(booking.totalUsd))
          throw conflict(
            `El pago pasa del total de la reserva (${Number(booking.totalUsd).toFixed(2)} USD).`,
          );
        const reference = normalizeReference(input.payment.reference);
        if (await this.db.payment.count({ where: { reference } }))
          throw conflict('Esa referencia ya fue reportada en otro pago.');
        const payment = await this.db.payment.create({
          data: {
            providerId,
            bookingId: booking.id,
            method: input.payment.method,
            reference,
            amountUsd: input.payment.amountUsd,
            ...(await this.bolivars(input.payment.method, input.payment.amountUsd)),
            status: 'confirmed',
            idempotencyKey: randomUUID(),
            reportedById: userId,
            reviewedById: userId,
            reviewedAt: new Date(),
          },
        });
        await this.apply(payment);
      }
      return booking;
    });
  }

  async views(rows: Row[]): Promise<PaymentView[]> {
    return Promise.all(
      rows.map(async (p) => ({
        id: p.id,
        bookingId: p.bookingId,
        bookingCode: p.booking.code,
        departureDate: p.booking.departure.date.toISOString().slice(0, 10),
        title: (p.booking.departure.sheet as { general: { title: string } }).general.title,
        method: p.method,
        reference: p.reference,
        amountUsd: Number(p.amountUsd),
        bsPerUsd: p.bsPerUsd === null ? null : Number(p.bsPerUsd),
        amountBs: p.amountBs === null ? null : Number(p.amountBs),
        status: p.status,
        reason: p.reason,
        proofUrl: p.proof ? (await this.files.view(p.proof)).downloadUrl : null,
        createdAt: p.createdAt.toISOString(),
        reviewedAt: p.reviewedAt?.toISOString() ?? null,
      })),
    );
  }
}

export const PAYMENT_INCLUDE = {
  proof: true,
  booking: { include: { departure: { select: { date: true, sheet: true } } } },
} as const;
