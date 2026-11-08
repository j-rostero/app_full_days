import { Body, Controller, Get, HttpCode, Inject, Param, Post, Query } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import { CONFIRMED_STATUSES, type ProductSheet } from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint, Public } from '../common/endpoint.ts';
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
import {
  BookingSchema,
  type BookingView,
  ManualBookingInput,
} from '../bookings/bookings.schemas.ts';
import { BookingsService } from '../bookings/bookings.service.ts';
import {
  PaymentListSchema,
  PaymentQuery,
  PaymentSchema,
  type PaymentView,
  RejectPaymentInput,
  ReportPaymentInput,
  VoucherKeysSchema,
  VoucherListSchema,
} from './payments.schemas.ts';
import { PAYMENT_INCLUDE, PaymentsService } from './payments.service.ts';
import { VOUCHER_SIGNER } from './payments.module.tokens.ts';
import type { VoucherSigner } from './vouchers.ts';

const TAG = ['pagos'];

/** Pagos y vouchers del viajero. */
@Controller()
export class TravelerPaymentsController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(PaymentsService) private readonly payments: PaymentsService,
    @Inject(BookingsService) private readonly bookings: BookingsService,
    @Inject(VOUCHER_SIGNER) private readonly signer: VoucherSigner,
  ) {}

  @Post('reservas/:id/pagos')
  @HttpCode(201)
  @Endpoint({
    operationId: 'reportPayment',
    summary:
      'Reporta un pago hecho a la agencia; la misma clave de idempotencia devuelve el mismo pago',
    tags: TAG,
    body: ReportPaymentInput,
    responses: { 201: PaymentSchema },
  })
  async report(
    @Auth() auth: AuthContext,
    @Param('id') id: string,
    @Body(new ZodPipe(ReportPaymentInput)) input: z.infer<typeof ReportPaymentInput>,
  ): Promise<PaymentView> {
    if (!isUuid(id)) throw notFound();
    const payment = await this.payments.report(auth.userId, id, input);
    const [view] = await this.payments.views([
      await this.db.payment.findUniqueOrThrow({
        where: { id: payment.id },
        include: PAYMENT_INCLUDE,
      }),
    ]);
    return view!;
  }

  @Get('reservas/:id/pagos')
  @Endpoint({
    operationId: 'listBookingPayments',
    summary: 'Pagos de una reserva propia con su estado y motivo de rechazo',
    tags: TAG,
    responses: { 200: PaymentListSchema },
  })
  async list(@Auth() auth: AuthContext, @Param('id') id: string) {
    if (!isUuid(id)) throw notFound();
    await this.bookings.load({ id, userId: auth.userId });
    const rows = await this.db.payment.findMany({
      where: { bookingId: id },
      include: PAYMENT_INCLUDE,
      orderBy: { createdAt: 'desc' },
    });
    return { items: await this.payments.views(rows) };
  }

  @Get('reservas/:id/vouchers')
  @Endpoint({
    operationId: 'getVouchers',
    summary:
      'Un voucher firmado por pasajero, cuando la reserva tiene el abono o el total confirmado',
    tags: TAG,
    responses: { 200: VoucherListSchema },
  })
  async vouchers(@Auth() auth: AuthContext, @Param('id') id: string) {
    if (!isUuid(id)) throw notFound();
    const booking = await this.bookings.load({ id, userId: auth.userId });
    if (!CONFIRMED_STATUSES.includes(booking.status))
      throw conflict('Los vouchers aparecen cuando la agencia confirma tu pago.');
    const date = booking.departure.date.toISOString().slice(0, 10);
    return {
      bookingCode: booking.code,
      title: (booking.departure.product.sheet as unknown as ProductSheet).general.title,
      date,
      items: booking.passengers.map((p) => ({
        passengerId: p.id,
        position: p.position,
        type: p.type,
        name: p.name,
        qr: this.signer.sign({
          code: booking.code,
          passengerId: p.id,
          departureId: booking.departureId,
          date,
        }),
      })),
    };
  }

  @Get('vouchers/llaves')
  @Public()
  @Endpoint({
    operationId: 'getVoucherKeys',
    summary: 'Claves públicas Ed25519 vigentes y retiradas, por id',
    tags: TAG,
    responses: { 200: VoucherKeysSchema },
  })
  keys() {
    return { items: this.signer.keys() };
  }
}

/** Conciliación de pagos y ventas propias de la agencia. */
@Controller('pro/:providerId')
export class ProPaymentsController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(PaymentsService) private readonly payments: PaymentsService,
    @Inject(BookingsService) private readonly bookings: BookingsService,
  ) {}

  @Get('pagos')
  @Can('payments')
  @Endpoint({
    operationId: 'listProviderPayments',
    summary: 'Pagos por estado, el más antiguo primero (máximo 200)',
    tags: TAG,
    query: PaymentQuery,
    responses: { 200: PaymentListSchema },
  })
  async list(
    @Membership() m: MembershipContext,
    @Query(new ZodPipe(PaymentQuery)) q: z.infer<typeof PaymentQuery>,
  ) {
    const rows = await this.db.payment.findMany({
      where: { providerId: m.providerId, status: q.status },
      include: PAYMENT_INCLUDE,
      orderBy: { createdAt: q.status === 'pending' ? 'asc' : 'desc' },
      take: 200,
    });
    return { items: await this.payments.views(rows) };
  }

  @Post('pagos/:paymentId/confirmar')
  @HttpCode(200)
  @Can('payments')
  @Endpoint({
    operationId: 'confirmPayment',
    summary: 'Confirma un pago pendiente: lo aplica a la reserva y lo asienta',
    tags: TAG,
    responses: { 200: PaymentSchema },
  })
  async confirm(
    @Membership() m: MembershipContext,
    @Auth() auth: AuthContext,
    @Param('paymentId') paymentId: string,
  ): Promise<PaymentView> {
    if (!isUuid(paymentId)) throw notFound();
    await this.payments.confirm(m.providerId, paymentId, auth.userId);
    return this.one(paymentId);
  }

  @Post('pagos/:paymentId/rechazar')
  @HttpCode(200)
  @Can('payments')
  @Endpoint({
    operationId: 'rejectPayment',
    summary: 'Rechaza un pago pendiente con un motivo para el viajero',
    tags: TAG,
    body: RejectPaymentInput,
    responses: { 200: PaymentSchema },
  })
  async reject(
    @Membership() m: MembershipContext,
    @Auth() auth: AuthContext,
    @Param('paymentId') paymentId: string,
    @Body(new ZodPipe(RejectPaymentInput)) input: z.infer<typeof RejectPaymentInput>,
  ): Promise<PaymentView> {
    if (!isUuid(paymentId)) throw notFound();
    await this.payments.reject(m.providerId, paymentId, auth.userId, input.reason);
    return this.one(paymentId);
  }

  @Post('reservas')
  @HttpCode(201)
  @Can('bookings')
  @Endpoint({
    operationId: 'createManualBooking',
    summary: 'Venta propia (WhatsApp, oficina) con contacto y, si ya pagó, el dinero recibido',
    tags: TAG,
    body: ManualBookingInput,
    responses: { 201: BookingSchema },
  })
  async manual(
    @Membership() m: MembershipContext,
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(ManualBookingInput)) input: z.infer<typeof ManualBookingInput>,
    @Trail() trail: AuditTrail,
  ): Promise<BookingView> {
    const booking = await this.payments.manualBooking(m.providerId, auth.userId, input);
    const [view] = await this.bookings.views([await this.bookings.load({ id: booking.id })], true);
    trail.after = { id: booking.id, code: booking.code };
    return view!;
  }

  private async one(id: string): Promise<PaymentView> {
    const [view] = await this.payments.views([
      await this.db.payment.findUniqueOrThrow({ where: { id }, include: PAYMENT_INCLUDE }),
    ]);
    return view!;
  }
}
