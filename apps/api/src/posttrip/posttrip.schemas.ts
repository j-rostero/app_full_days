import {
  ClaimInputSchema,
  ClaimMessageSchema,
  ClaimResolveSchema,
  MonthSchema,
  ReviewInputSchema,
} from '@fulldays/shared';
import { z } from 'zod';

const Aspects = z
  .object({
    punctuality: z.number().optional(),
    transport: z.number().optional(),
    food: z.number().optional(),
    guide: z.number().optional(),
    value: z.number().optional(),
  })
  .meta({ id: 'ReviewAspects' });

export const ReputationSchema = z
  .object({
    average: z.number().nullable(),
    count: z.number().int(),
    asDescribedPercent: z.number().nullable(),
    aspects: Aspects,
  })
  .meta({ id: 'Reputation' });

export const ReviewSchema = z
  .object({
    id: z.uuid(),
    productId: z.uuid(),
    title: z.string(),
    rating: z.number().int(),
    aspects: Aspects,
    asDescribed: z.boolean(),
    comment: z.string(),
    author: z.string(),
    tripDate: z.iso.date(),
    reply: z.string().nullable(),
    repliedAt: z.iso.datetime().nullable(),
    createdAt: z.iso.datetime(),
    /** Solo para la agencia y Central. */
    moderation: z
      .object({
        status: z.enum(['visible', 'hidden']),
        reported: z.boolean(),
        reportReason: z.string().nullable(),
        hiddenReason: z.string().nullable(),
        providerName: z.string(),
      })
      .nullable(),
  })
  .meta({ id: 'Review' });
export const ReviewListSchema = z
  .object({ reputation: ReputationSchema, items: z.array(ReviewSchema) })
  .meta({ id: 'ReviewList' });
export const ReviewInput = ReviewInputSchema.meta({ id: 'ReviewInput' });
export const ReplyInput = z
  .strictObject({ reply: z.string().trim().min(2, 'Escribe la respuesta.').max(1500) })
  .meta({ id: 'ReplyInput' });
export const ReasonInput = z
  .strictObject({ reason: z.string().trim().min(3, 'Escribe el motivo.').max(500) })
  .meta({ id: 'ReasonInput' });

export const ClaimSchema = z
  .object({
    id: z.uuid(),
    bookingId: z.uuid(),
    bookingCode: z.string(),
    title: z.string(),
    providerName: z.string(),
    traveler: z.string(),
    subject: z.string(),
    status: z.enum(['open', 'escalated', 'resolved']),
    resolution: z.string().nullable(),
    createdAt: z.iso.datetime(),
    updatedAt: z.iso.datetime(),
    messages: z.array(
      z.object({
        id: z.uuid(),
        role: z.enum(['traveler', 'agency', 'central']),
        author: z.string().nullable(),
        body: z.string(),
        createdAt: z.iso.datetime(),
      }),
    ),
  })
  .meta({ id: 'Claim' });
export const ClaimListSchema = z.object({ items: z.array(ClaimSchema) }).meta({ id: 'ClaimList' });
export const ClaimInput = ClaimInputSchema.meta({ id: 'ClaimInput' });
export const ClaimMessageInput = ClaimMessageSchema.meta({ id: 'ClaimMessageInput' });
export const ClaimResolveInput = ClaimResolveSchema.meta({ id: 'ClaimResolveInput' });
export const ClaimQuery = z.strictObject({
  estado: z.enum(['open', 'escalated', 'resolved']).optional(),
  reserva: z.uuid().optional(),
});

export const MonthQuery = z.strictObject({ mes: MonthSchema.optional() });
const Totals = {
  paymentsUsd: z.number(),
  refundsUsd: z.number(),
  commissionUsd: z.number(),
  netUsd: z.number(),
};
export const SettlementSchema = z
  .object({
    month: z.string(),
    ...Totals,
    lines: z.array(
      z.object({
        at: z.iso.datetime(),
        kind: z.enum(['payment', 'refund']),
        bookingCode: z.string().nullable(),
        amountUsd: z.number(),
        commissionUsd: z.number(),
      }),
    ),
  })
  .meta({ id: 'Settlement' });
export const ProviderReportSchema = z
  .object({
    month: z.string(),
    salesUsd: z.number(),
    confirmedBookings: z.number().int(),
    cancellations: z.number().int(),
    occupancyPercent: z.number().nullable(),
    reputation: ReputationSchema,
  })
  .meta({ id: 'ProviderReport' });
export const CentralSettlementsSchema = z
  .object({
    month: z.string(),
    items: z.array(z.object({ providerId: z.uuid(), providerName: z.string(), ...Totals })),
  })
  .meta({ id: 'CentralSettlements' });
export const MetricsQuery = z.strictObject({
  desde: z.iso.date().optional(),
  hasta: z.iso.date().optional(),
});
const Term = z.object({ text: z.string(), count: z.number().int() });
export const MetricsSchema = z
  .object({
    from: z.iso.date(),
    to: z.iso.date(),
    bookings: z.number().int(),
    confirmed: z.number().int(),
    gmvUsd: z.number(),
    commissionUsd: z.number(),
    occupancyPercent: z.number().nullable(),
    sellingProviders: z.number().int(),
    searches: z.number().int(),
    topSearches: z.array(Term),
    emptySearches: z.array(Term),
  })
  .meta({ id: 'Metrics' });

export const UserQuery = z.strictObject({ q: z.string().trim().min(3).max(100) });
export const AdminUserListSchema = z
  .object({
    items: z.array(
      z.object({
        id: z.uuid(),
        email: z.string(),
        name: z.string().nullable(),
        phone: z.string().nullable(),
        blockedAt: z.iso.datetime().nullable(),
        createdAt: z.iso.datetime(),
        bookings: z.array(
          z.object({
            id: z.uuid(),
            code: z.string(),
            status: z.string(),
            title: z.string(),
            date: z.iso.date(),
          }),
        ),
      }),
    ),
  })
  .meta({ id: 'AdminUserList' });
