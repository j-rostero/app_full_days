import {
  BOOKING_STATUSES,
  BookingSelectionSchema,
  DEPARTURE_STATUSES,
  MealPicksSchema,
  PassengerInputSchema,
  PASSENGER_TYPES,
} from '@fulldays/shared';
import { z } from 'zod';
import { ImageUrlsSchema } from '../files/files.schemas.ts';
import { ProductTypeSchema } from '../products/products.schemas.ts';

export const BookingStatusSchema = z.enum(BOOKING_STATUSES).meta({ id: 'BookingStatus' });
export const BookingSelection = BookingSelectionSchema.meta({ id: 'BookingSelection' });

export const HoldInput = z
  .strictObject({ departureId: z.uuid(), selection: BookingSelection })
  .meta({ id: 'HoldInput' });

export const QuoteInput = HoldInput.meta({ id: 'QuoteInput' });

const Line = z.object({ label: z.string(), amountUsd: z.number() });
export const QuoteSchema = z
  .object({
    lines: z.array(Line),
    totalUsd: z.number(),
    depositUsd: z.number(),
    seats: z.number().int(),
    balanceDueDate: z.iso.date(),
  })
  .meta({ id: 'Quote' });

export const BookingPassengerSchema = z
  .object({
    id: z.uuid(),
    position: z.number().int(),
    type: z.enum(Object.keys(PASSENGER_TYPES) as [keyof typeof PASSENGER_TYPES]),
    name: z.string().nullable(),
    cedula: z.string().nullable(),
    birthDate: z.iso.date().nullable(),
    restrictions: z.string().nullable(),
    /** Platos escogidos: id de la comida → ids de las opciones. */
    mealPicks: z.record(z.string(), z.array(z.string())),
    checkin: z.enum(['boarded', 'no_show']).nullable(),
  })
  .meta({ id: 'BookingPassenger' });

/** Comida con platos a escoger, tal como se vendió la salida. */
export const MealChoiceSchema = z
  .object({
    mealId: z.uuid(),
    name: z.string(),
    picksPerPassenger: z.number().int(),
    options: z.array(z.object({ id: z.uuid(), name: z.string(), isDefault: z.boolean() })),
  })
  .meta({ id: 'MealChoice' });

export const BookingSchema = z
  .object({
    id: z.uuid(),
    code: z.string(),
    status: BookingStatusSchema,
    source: z.enum(['app', 'agency']),
    departure: z.object({ id: z.uuid(), date: z.iso.date(), status: z.enum(DEPARTURE_STATUSES) }),
    product: z.object({
      id: z.uuid(),
      type: ProductTypeSchema,
      title: z.string(),
      cover: ImageUrlsSchema.nullable(),
    }),
    provider: z.object({
      id: z.uuid(),
      name: z.string(),
      paymentInstructions: z.string().nullable(),
    }),
    selection: BookingSelection,
    lines: z.array(Line),
    seats: z.number().int(),
    totalUsd: z.number(),
    depositUsd: z.number(),
    paidUsd: z.number(),
    /** Reportado y aún sin revisar. */
    pendingUsd: z.number(),
    balanceUsd: z.number(),
    balanceDueDate: z.iso.date(),
    heldUntil: z.iso.datetime().nullable(),
    cancelledBy: z.enum(['traveler', 'agency', 'system']).nullable(),
    refund: z
      .object({
        id: z.uuid(),
        amountUsd: z.number(),
        rule: z.string(),
        status: z.enum(['pending', 'paid']),
        reference: z.string().nullable(),
      })
      .nullable(),
    /** Si el viajero ya puede reseñar esta reserva. */
    canReview: z.boolean(),
    contact: z
      .object({
        name: z.string().nullable(),
        phone: z.string().nullable(),
        email: z.string().nullable(),
      })
      .nullable(),
    passengers: z.array(BookingPassengerSchema),
    mealChoices: z.array(MealChoiceSchema),
    createdAt: z.iso.datetime(),
  })
  .meta({ id: 'Booking' });
export const BookingListSchema = z
  .object({ items: z.array(BookingSchema) })
  .meta({ id: 'BookingList' });

export const PassengersInput = z
  .strictObject({
    passengers: z
      .array(PassengerInputSchema.extend({ mealPicks: MealPicksSchema }))
      .min(1)
      .max(40),
  })
  .meta({ id: 'PassengersInput' });

export const ProBookingQuery = z.strictObject({
  departureId: z.uuid().optional(),
  status: z.enum(BOOKING_STATUSES).optional(),
});

export const ManualBookingInput = z
  .strictObject({
    departureId: z.uuid(),
    selection: BookingSelection,
    contact: z.strictObject({
      name: z.string().trim().min(2).max(120),
      phone: z.string().trim().max(30).nullable().default(null),
      email: z.email().nullable().default(null),
    }),
    /** Dinero ya recibido por la agencia. */
    payment: z
      .strictObject({
        method: z.enum(['mobile_payment', 'bank_transfer', 'zelle', 'cash_usd']),
        reference: z.string().trim().min(2).max(60),
        amountUsd: z.number().min(0.01).max(100_000),
      })
      .nullable()
      .default(null),
  })
  .meta({ id: 'ManualBookingInput' });

export type BookingView = z.infer<typeof BookingSchema>;

export const CancellationSchema = z
  .object({
    allowed: z.boolean(),
    amountUsd: z.number(),
    rule: z.string(),
    daysBefore: z.number().int(),
  })
  .meta({ id: 'Cancellation' });
