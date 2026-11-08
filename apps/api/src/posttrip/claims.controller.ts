import { Body, Controller, Get, HttpCode, Inject, Param, Post, Query } from '@nestjs/common';
import type { Prisma, PrismaClient } from '@fulldays/db';
import type { ProductSheet } from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Auth, type AuthContext, Membership, type MembershipContext } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { NotificationsService } from '../notifications/notifications.service.ts';
import {
  ClaimInput,
  ClaimListSchema,
  ClaimMessageInput,
  ClaimQuery,
  ClaimResolveInput,
  ClaimSchema,
} from './posttrip.schemas.ts';

const TAG = ['reclamos'];
const INCLUDE = {
  user: { select: { name: true, email: true } },
  booking: {
    select: {
      code: true,
      departure: { select: { sheet: true } },
      provider: { select: { name: true } },
    },
  },
  messages: { include: { author: { select: { name: true } } }, orderBy: { createdAt: 'asc' } },
} as const;
type Row = Prisma.ClaimGetPayload<{ include: typeof INCLUDE }>;
type View = z.infer<typeof ClaimSchema>;
type Role = 'traveler' | 'agency' | 'central';

const view = (c: Row): View => ({
  id: c.id,
  bookingId: c.bookingId,
  bookingCode: c.booking.code,
  title: (c.booking.departure.sheet as unknown as ProductSheet).general.title,
  providerName: c.booking.provider.name,
  traveler: c.user.name ?? c.user.email,
  subject: c.subject,
  status: c.status,
  resolution: c.resolution,
  createdAt: c.createdAt.toISOString(),
  updatedAt: c.updatedAt.toISOString(),
  messages: c.messages.map((m) => ({
    id: m.id,
    role: m.role as Role,
    author: m.role === 'traveler' ? (m.author.name ?? null) : null,
    body: m.body,
    createdAt: m.createdAt.toISOString(),
  })),
});

/** Reclamos: el viajero los abre, la agencia responde y Central interviene si se escalan. */
@Controller()
export class ClaimsController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(NotificationsService) private readonly notifications: NotificationsService,
  ) {}

  @Post('reservas/:id/reclamos')
  @Endpoint({
    operationId: 'openClaim',
    summary: 'Abre un reclamo sobre una reserva con algún pago confirmado',
    tags: TAG,
    body: ClaimInput,
    responses: { 201: ClaimSchema },
  })
  async open(
    @Auth() auth: AuthContext,
    @Param('id') id: string,
    @Body(new ZodPipe(ClaimInput)) input: z.infer<typeof ClaimInput>,
  ): Promise<View> {
    if (!isUuid(id)) throw notFound();
    const booking = await this.db.booking.findFirst({ where: { id, userId: auth.userId } });
    if (!booking) throw notFound('Esa reserva no existe.');
    if (Number(booking.paidUsd) <= 0)
      throw conflict('Solo se reclama sobre una reserva con algún pago confirmado.');
    const claim = await this.db.claim.create({
      data: {
        providerId: booking.providerId,
        bookingId: booking.id,
        userId: auth.userId,
        subject: input.subject,
        messages: { create: { authorId: auth.userId, role: 'traveler', body: input.message } },
      },
      include: INCLUDE,
    });
    return view(claim);
  }

  @Get('reclamos')
  @Endpoint({
    operationId: 'listMyClaims',
    summary: 'Reclamos propios con sus mensajes',
    tags: TAG,
    query: ClaimQuery,
    responses: { 200: ClaimListSchema },
  })
  async mine(
    @Auth() auth: AuthContext,
    @Query(new ZodPipe(ClaimQuery)) q: z.infer<typeof ClaimQuery>,
  ) {
    return this.list({
      userId: auth.userId,
      ...(q.reserva ? { bookingId: q.reserva } : {}),
      ...(q.estado ? { status: q.estado } : {}),
    });
  }

  @Post('reclamos/:id/mensajes')
  @Endpoint({
    operationId: 'writeClaim',
    summary: 'El viajero responde en su reclamo',
    tags: TAG,
    body: ClaimMessageInput,
    responses: { 201: ClaimSchema },
  })
  async write(
    @Auth() auth: AuthContext,
    @Param('id') id: string,
    @Body(new ZodPipe(ClaimMessageInput)) input: z.infer<typeof ClaimMessageInput>,
  ) {
    return this.say({ id, userId: auth.userId }, auth.userId, 'traveler', input.body);
  }

  @Post('reclamos/:id/escalar')
  @HttpCode(200)
  @Endpoint({
    operationId: 'escalateClaim',
    summary: 'Pide que FullDays intervenga en el reclamo',
    tags: TAG,
    responses: { 200: ClaimSchema },
  })
  async escalate(@Auth() auth: AuthContext, @Param('id') id: string): Promise<View> {
    if (!isUuid(id)) throw notFound();
    const done = await this.db.claim.updateMany({
      where: { id, userId: auth.userId, status: 'open' },
      data: { status: 'escalated' },
    });
    const claim = await this.db.claim.findFirst({
      where: { id, userId: auth.userId },
      include: INCLUDE,
    });
    if (!claim) throw notFound('Ese reclamo no existe.');
    if (done.count === 0) throw conflict('Ese reclamo ya está con FullDays o resuelto.');
    return view(claim);
  }

  @Get('pro/:providerId/reclamos')
  @Can('bookings')
  @Endpoint({
    operationId: 'listProviderClaims',
    summary: 'Reclamos sobre reservas de la agencia',
    tags: TAG,
    query: ClaimQuery,
    responses: { 200: ClaimListSchema },
  })
  async provider(
    @Membership() m: MembershipContext,
    @Query(new ZodPipe(ClaimQuery)) q: z.infer<typeof ClaimQuery>,
  ) {
    return this.list({ providerId: m.providerId, ...(q.estado ? { status: q.estado } : {}) });
  }

  @Post('pro/:providerId/reclamos/:claimId/mensajes')
  @Can('bookings')
  @Endpoint({
    operationId: 'answerClaim',
    summary: 'La agencia responde en un reclamo',
    tags: TAG,
    body: ClaimMessageInput,
    responses: { 201: ClaimSchema },
  })
  async answer(
    @Membership() m: MembershipContext,
    @Auth() auth: AuthContext,
    @Param('claimId') claimId: string,
    @Body(new ZodPipe(ClaimMessageInput)) input: z.infer<typeof ClaimMessageInput>,
  ) {
    return this.say({ id: claimId, providerId: m.providerId }, auth.userId, 'agency', input.body);
  }

  @Get('central/reclamos')
  @Can('claims')
  @Endpoint({
    operationId: 'listAllClaims',
    summary: 'Todos los reclamos por estado, el que más espera primero',
    tags: TAG,
    query: ClaimQuery,
    responses: { 200: ClaimListSchema },
  })
  async all(@Query(new ZodPipe(ClaimQuery)) q: z.infer<typeof ClaimQuery>) {
    return this.list(q.estado ? { status: q.estado } : { status: { not: 'resolved' } }, 'asc');
  }

  @Post('central/reclamos/:id/mensajes')
  @Can('claims')
  @Endpoint({
    operationId: 'centralAnswerClaim',
    summary: 'Central responde en un reclamo',
    tags: TAG,
    body: ClaimMessageInput,
    responses: { 201: ClaimSchema },
  })
  async central(
    @Auth() auth: AuthContext,
    @Param('id') id: string,
    @Body(new ZodPipe(ClaimMessageInput)) input: z.infer<typeof ClaimMessageInput>,
  ) {
    return this.say({ id }, auth.userId, 'central', input.body);
  }

  @Post('central/reclamos/:id/resolver')
  @HttpCode(200)
  @Can('claims')
  @Endpoint({
    operationId: 'resolveClaim',
    summary: 'Cierra el reclamo con la resolución y avisa al viajero',
    tags: TAG,
    body: ClaimResolveInput,
    responses: { 200: ClaimSchema },
  })
  async resolve(
    @Param('id') id: string,
    @Body(new ZodPipe(ClaimResolveInput)) input: z.infer<typeof ClaimResolveInput>,
  ): Promise<View> {
    if (!isUuid(id)) throw notFound();
    const done = await this.db.claim.updateMany({
      where: { id, status: { not: 'resolved' } },
      data: { status: 'resolved', resolution: input.resolution, resolvedAt: new Date() },
    });
    const claim = await this.db.claim.findUnique({ where: { id }, include: INCLUDE });
    if (!claim) throw notFound('Ese reclamo no existe.');
    if (done.count === 0) throw conflict('Ese reclamo ya está resuelto.');
    await this.notifications.enqueue([
      {
        userId: claim.userId,
        event: 'claim_resolved',
        body: `Tu reclamo «${claim.subject}» quedó resuelto: ${input.resolution}`,
        link: `reclamo:${claim.id}`,
        dedupeKey: `claim_resolved:${claim.id}`,
      },
    ]);
    return view(claim);
  }

  private async list(where: Prisma.ClaimWhereInput, order: 'asc' | 'desc' = 'desc') {
    const rows = await this.db.claim.findMany({
      where,
      include: INCLUDE,
      orderBy: { updatedAt: order },
      take: 200,
    });
    return { items: rows.map(view) };
  }

  private async say(
    where: Prisma.ClaimWhereInput & { id: string },
    authorId: string,
    role: Role,
    body: string,
  ): Promise<View> {
    if (!isUuid(where.id)) throw notFound();
    const claim = await this.db.claim.findFirst({ where });
    if (!claim) throw notFound('Ese reclamo no existe.');
    if (claim.status === 'resolved') throw conflict('Ese reclamo ya está resuelto.');
    await this.db.claimMessage.create({ data: { claimId: claim.id, authorId, role, body } });
    // Toca `updatedAt` para que el reclamo suba en las colas.
    await this.db.claim.update({ where: { id: claim.id }, data: { subject: claim.subject } });
    if (role !== 'traveler')
      await this.notifications.enqueue([
        {
          userId: claim.userId,
          event: 'claim_message',
          body: `${role === 'agency' ? 'La agencia' : 'FullDays'} respondió tu reclamo «${claim.subject}».`,
          link: `reclamo:${claim.id}`,
        },
      ]);
    const full = await this.db.claim.findUniqueOrThrow({
      where: { id: claim.id },
      include: INCLUDE,
    });
    return view(full);
  }
}
