import { Body, Controller, Get, HttpCode, Inject, Param, Post } from '@nestjs/common';
import type { PrismaClient, Prisma } from '@fulldays/db';
import {
  hasContactInfo,
  type ProductSheet,
  publicAuthor,
  reputation,
  type ReviewAspect,
  reviewWindowOpen,
  todayInVenezuela,
} from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint, Public } from '../common/endpoint.ts';
import { Auth, type AuthContext, Membership, type MembershipContext } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { NotificationsService } from '../notifications/notifications.service.ts';
import {
  ReasonInput,
  ReplyInput,
  ReviewInput,
  ReviewListSchema,
  ReviewSchema,
} from './posttrip.schemas.ts';

const TAG = ['resenas'];
const INCLUDE = {
  user: { select: { name: true } },
  booking: {
    select: {
      departure: { select: { date: true, sheet: true } },
      provider: { select: { name: true } },
    },
  },
} as const;
type Row = Prisma.ReviewGetPayload<{ include: typeof INCLUDE }>;
type View = z.infer<typeof ReviewSchema>;

export function reviewView(r: Row, moderation = false): View {
  return {
    id: r.id,
    productId: r.productId,
    title: (r.booking.departure.sheet as unknown as ProductSheet).general.title,
    rating: r.rating,
    aspects: r.aspects as Partial<Record<ReviewAspect, number>>,
    asDescribed: r.asDescribed,
    comment: r.comment,
    author: publicAuthor(r.user.name),
    tripDate: r.booking.departure.date.toISOString().slice(0, 10),
    reply: r.reply,
    repliedAt: r.repliedAt?.toISOString() ?? null,
    createdAt: r.createdAt.toISOString(),
    moderation: moderation
      ? {
          status: r.status,
          reported: r.reported,
          reportReason: r.reportReason,
          hiddenReason: r.hiddenReason,
          providerName: r.booking.provider.name,
        }
      : null,
  };
}

async function listed(db: PrismaClient, where: Prisma.ReviewWhereInput, take = 100) {
  const [rows, all] = await Promise.all([
    db.review.findMany({
      where: { ...where, status: 'visible' },
      include: INCLUDE,
      orderBy: { createdAt: 'desc' },
      take,
    }),
    db.review.findMany({
      where: { ...where, status: 'visible' },
      select: { rating: true, asDescribed: true, aspects: true },
    }),
  ]);
  return {
    reputation: reputation(
      all.map((r) => ({ ...r, aspects: r.aspects as Partial<Record<ReviewAspect, number>> })),
    ),
    items: rows.map((r) => reviewView(r)),
  };
}

/** Reseñas del viajero y reputación pública. */
@Controller()
export class ReviewsController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(NotificationsService) private readonly notifications: NotificationsService,
  ) {}

  @Post('reservas/:id/resena')
  @Endpoint({
    operationId: 'reviewBooking',
    summary: 'Reseña un viaje realizado: una vez y hasta 30 días después',
    tags: TAG,
    body: ReviewInput,
    responses: { 201: ReviewSchema },
  })
  async create(
    @Auth() auth: AuthContext,
    @Param('id') id: string,
    @Body(new ZodPipe(ReviewInput)) input: z.infer<typeof ReviewInput>,
  ): Promise<View> {
    if (!isUuid(id)) throw notFound();
    const booking = await this.db.booking.findFirst({
      where: { id, userId: auth.userId },
      include: { departure: true, review: true },
    });
    if (!booking) throw notFound('Esa reserva no existe.');
    if (booking.status !== 'completed') throw conflict('Solo se reseñan los viajes realizados.');
    if (booking.review) throw conflict('Ya reseñaste este viaje.');
    if (!reviewWindowOpen(booking.departure.date.toISOString().slice(0, 10), todayInVenezuela()))
      throw conflict('Pasaron más de 30 días desde el viaje.');
    // Teléfonos o WhatsApp sacan la venta de la plataforma: queda oculta hasta que Central la vea.
    const contact = hasContactInfo(input.comment);
    const review = await this.db.review.create({
      data: {
        providerId: booking.providerId,
        productId: booking.departure.productId,
        bookingId: booking.id,
        userId: auth.userId,
        rating: input.rating,
        aspects: input.aspects,
        asDescribed: input.asDescribed,
        comment: input.comment,
        ...(contact
          ? {
              status: 'hidden',
              reported: true,
              reportReason: 'Tiene datos de contacto (revisión automática).',
            }
          : {}),
      },
      include: INCLUDE,
    });
    return reviewView(review);
  }

  @Get('productos/:id/resenas')
  @Public()
  @Endpoint({
    operationId: 'listProductReviews',
    summary: 'Reputación del viaje y sus últimas 100 reseñas visibles',
    tags: TAG,
    responses: { 200: ReviewListSchema },
  })
  async product(@Param('id') id: string) {
    if (!isUuid(id)) throw notFound();
    return listed(this.db, { productId: id });
  }

  @Get('agencias/:id/reputacion')
  @Public()
  @Endpoint({
    operationId: 'getAgencyReputation',
    summary: 'Reputación de la agencia y sus últimas 100 reseñas visibles',
    tags: TAG,
    responses: { 200: ReviewListSchema },
  })
  async agency(@Param('id') id: string) {
    if (!isUuid(id)) throw notFound();
    return listed(this.db, { providerId: id });
  }

  @Get('pro/:providerId/resenas')
  @Can('bookings')
  @Endpoint({
    operationId: 'listProviderReviews',
    summary: 'Reseñas de la agencia, visibles u ocultas, con su moderación',
    tags: TAG,
    responses: { 200: ReviewListSchema },
  })
  async mine(@Membership() m: MembershipContext) {
    const base = await listed(this.db, { providerId: m.providerId }, 0);
    const rows = await this.db.review.findMany({
      where: { providerId: m.providerId },
      include: INCLUDE,
      orderBy: { createdAt: 'desc' },
      take: 300,
    });
    return { reputation: base.reputation, items: rows.map((r) => reviewView(r, true)) };
  }

  @Post('pro/:providerId/resenas/:reviewId/responder')
  @HttpCode(200)
  @Can('bookings')
  @Endpoint({
    operationId: 'replyReview',
    summary: 'La única respuesta pública de la agencia a una reseña',
    tags: TAG,
    body: ReplyInput,
    responses: { 200: ReviewSchema },
  })
  async reply(
    @Membership() m: MembershipContext,
    @Param('reviewId') reviewId: string,
    @Body(new ZodPipe(ReplyInput)) input: z.infer<typeof ReplyInput>,
  ): Promise<View> {
    if (!isUuid(reviewId)) throw notFound();
    if (hasContactInfo(input.reply))
      throw conflict('La respuesta no puede llevar teléfonos, correos ni enlaces de WhatsApp.');
    const done = await this.db.review.updateMany({
      where: { id: reviewId, providerId: m.providerId, reply: null },
      data: { reply: input.reply, repliedAt: new Date() },
    });
    const review = await this.db.review.findFirst({
      where: { id: reviewId, providerId: m.providerId },
      include: INCLUDE,
    });
    if (!review) throw notFound('Esa reseña no existe.');
    if (done.count === 0) throw conflict('Ya respondiste esta reseña.');
    await this.notifications.enqueue([
      {
        userId: review.userId,
        event: 'review_reply',
        body: `${review.booking.provider.name} respondió tu reseña.`,
        link: `resena:${review.id}`,
        dedupeKey: `review_reply:${review.id}`,
      },
    ]);
    return reviewView(review, true);
  }

  @Post('pro/:providerId/resenas/:reviewId/reportar')
  @HttpCode(204)
  @Can('bookings')
  @Endpoint({
    operationId: 'reportReview',
    summary: 'Pide a Central que revise una reseña, con motivo',
    tags: TAG,
    body: ReasonInput,
    responses: { 204: null },
  })
  async report(
    @Membership() m: MembershipContext,
    @Param('reviewId') reviewId: string,
    @Body(new ZodPipe(ReasonInput)) input: z.infer<typeof ReasonInput>,
  ): Promise<void> {
    if (!isUuid(reviewId)) throw notFound();
    const done = await this.db.review.updateMany({
      where: { id: reviewId, providerId: m.providerId },
      data: { reported: true, reportReason: input.reason },
    });
    if (done.count === 0) throw notFound('Esa reseña no existe.');
  }

  @Get('central/resenas')
  @Can('reviews')
  @Endpoint({
    operationId: 'listModerationQueue',
    summary: 'Cola de moderación: reseñas reportadas u ocultas',
    tags: TAG,
    responses: { 200: ReviewListSchema },
  })
  async queue() {
    const rows = await this.db.review.findMany({
      where: { OR: [{ reported: true }, { status: 'hidden' }] },
      include: INCLUDE,
      orderBy: [{ reported: 'desc' }, { createdAt: 'asc' }],
      take: 200,
    });
    return {
      reputation: reputation([]),
      items: rows.map((r) => reviewView(r, true)),
    };
  }

  @Post('central/resenas/:id/ocultar')
  @HttpCode(204)
  @Can('reviews')
  @Endpoint({
    operationId: 'hideReview',
    summary: 'Oculta una reseña con motivo y cierra el reporte',
    tags: TAG,
    body: ReasonInput,
    responses: { 204: null },
  })
  async hide(
    @Param('id') id: string,
    @Body(new ZodPipe(ReasonInput)) input: z.infer<typeof ReasonInput>,
  ): Promise<void> {
    await this.moderate(id, { status: 'hidden', hiddenReason: input.reason, reported: false });
  }

  @Post('central/resenas/:id/mostrar')
  @HttpCode(204)
  @Can('reviews')
  @Endpoint({
    operationId: 'showReview',
    summary: 'Vuelve a mostrar una reseña y cierra el reporte',
    tags: TAG,
    responses: { 204: null },
  })
  async show(@Param('id') id: string): Promise<void> {
    await this.moderate(id, { status: 'visible', hiddenReason: null, reported: false });
  }

  private async moderate(id: string, data: Prisma.ReviewUpdateManyMutationInput) {
    if (!isUuid(id)) throw notFound();
    const done = await this.db.review.updateMany({ where: { id }, data });
    if (done.count === 0) throw notFound('Esa reseña no existe.');
  }
}
