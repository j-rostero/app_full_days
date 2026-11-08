import { Body, Controller, Get, HttpCode, Inject, Param, Post, Put, Query } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import type { Quote } from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint, Public } from '../common/endpoint.ts';
import { Auth, type AuthContext, Membership, type MembershipContext } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { SettingsService } from '../catalogs/settings.service.ts';
import {
  BookingListSchema,
  BookingSchema,
  type BookingView,
  HoldInput,
  PassengersInput,
  ProBookingQuery,
  QuoteInput,
  QuoteSchema,
} from './bookings.schemas.ts';
import { BOOKING_INCLUDE, BookingsService } from './bookings.service.ts';

const TAG = ['reservas'];

/** Reservas del viajero: cotizar, apartar, ver y completar pasajeros. */
@Controller('reservas')
export class BookingsController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(BookingsService) private readonly bookings: BookingsService,
    @Inject(SettingsService) private readonly settings: SettingsService,
  ) {}

  @Post('cotizar')
  @HttpCode(200)
  @Public()
  @Endpoint({
    operationId: 'quoteBooking',
    summary: 'Precio exacto de una selección en una salida en venta, sin apartar',
    tags: TAG,
    body: QuoteInput,
    responses: { 200: QuoteSchema },
  })
  async quote(@Body(new ZodPipe(QuoteInput)) input: z.infer<typeof QuoteInput>): Promise<Quote> {
    return this.bookings.quoteFor(await this.bookings.sellable(input.departureId), input.selection);
  }

  @Post()
  @HttpCode(201)
  @Endpoint({
    operationId: 'holdBooking',
    summary: 'Aparta puestos y habitaciones y crea la reserva por los minutos de apartado',
    tags: TAG,
    body: HoldInput,
    responses: { 201: BookingSchema },
  })
  async hold(
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(HoldInput)) input: z.infer<typeof HoldInput>,
  ): Promise<BookingView> {
    const { holdMinutes } = await this.settings.get();
    const booking = await this.bookings.hold({
      ...input,
      userId: auth.userId,
      source: 'app',
      holdMinutes,
    });
    return this.one(booking.id, auth.userId);
  }

  @Get()
  @Endpoint({
    operationId: 'listMyBookings',
    summary: 'Reservas propias, la más nueva primero (máximo 100)',
    tags: TAG,
    responses: { 200: BookingListSchema },
  })
  async list(@Auth() auth: AuthContext) {
    const stale = await this.db.booking.findMany({
      where: { userId: auth.userId, status: 'held', heldUntil: { lt: new Date() } },
    });
    for (const b of stale) await this.bookings.refresh(b);
    const rows = await this.db.booking.findMany({
      where: { userId: auth.userId },
      include: BOOKING_INCLUDE,
      orderBy: { createdAt: 'desc' },
      take: 100,
    });
    return { items: await this.bookings.views(rows as never) };
  }

  @Get(':id')
  @Endpoint({
    operationId: 'getMyBooking',
    summary:
      'Una reserva propia con precio, abono, pagado, saldo, pasajeros e instrucciones de pago',
    tags: TAG,
    responses: { 200: BookingSchema },
  })
  async get(@Auth() auth: AuthContext, @Param('id') id: string): Promise<BookingView> {
    if (!isUuid(id)) throw notFound();
    return this.one(id, auth.userId);
  }

  @Put(':id/pasajeros')
  @Endpoint({
    operationId: 'setBookingPassengers',
    summary: 'Nombre, cédula, fecha de nacimiento y restricciones de cada pasajero, en orden',
    tags: TAG,
    body: PassengersInput,
    responses: { 200: BookingSchema },
  })
  async passengers(
    @Auth() auth: AuthContext,
    @Param('id') id: string,
    @Body(new ZodPipe(PassengersInput)) input: z.infer<typeof PassengersInput>,
  ): Promise<BookingView> {
    if (!isUuid(id)) throw notFound();
    const booking = await this.bookings.load({ id, userId: auth.userId });
    await this.bookings.refresh(booking);
    await this.bookings.setPassengers(
      await this.bookings.load({ id, userId: auth.userId }),
      input.passengers,
    );
    return this.one(id, auth.userId);
  }

  private async one(id: string, userId: string): Promise<BookingView> {
    const booking = await this.bookings.load({ id, userId });
    await this.bookings.refresh(booking);
    const [view] = await this.bookings.views([await this.bookings.load({ id, userId })]);
    return view!;
  }
}

/** Reservas de la agencia, de la app y propias. */
@Controller('pro/:providerId/reservas')
export class ProBookingsController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(BookingsService) private readonly bookings: BookingsService,
  ) {}

  @Get()
  @Can('bookings')
  @Endpoint({
    operationId: 'listProviderBookings',
    summary: 'Reservas de la agencia; filtros por salida y estado (máximo 300)',
    tags: TAG,
    query: ProBookingQuery,
    responses: { 200: BookingListSchema },
  })
  async list(
    @Membership() m: MembershipContext,
    @Query(new ZodPipe(ProBookingQuery)) query: z.infer<typeof ProBookingQuery>,
  ) {
    const rows = await this.db.booking.findMany({
      where: {
        providerId: m.providerId,
        ...(query.departureId ? { departureId: query.departureId } : {}),
        ...(query.status ? { status: query.status } : {}),
      },
      include: BOOKING_INCLUDE,
      orderBy: { createdAt: 'desc' },
      take: 300,
    });
    return { items: await this.bookings.views(rows as never, true) };
  }

  @Get(':bookingId')
  @Can('bookings')
  @Endpoint({
    operationId: 'getProviderBooking',
    summary: 'Una reserva de la agencia, con el contacto si es venta propia',
    tags: TAG,
    responses: { 200: BookingSchema },
  })
  async get(
    @Membership() m: MembershipContext,
    @Param('bookingId') bookingId: string,
  ): Promise<BookingView> {
    if (!isUuid(bookingId)) throw notFound();
    const [view] = await this.bookings.views(
      [await this.bookings.load({ id: bookingId, providerId: m.providerId })],
      true,
    );
    return view!;
  }
}
