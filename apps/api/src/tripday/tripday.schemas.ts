import { CheckinSyncSchema, PASSENGER_TYPES } from '@fulldays/shared';
import { z } from 'zod';
import { DepartureStatusSchema } from '../departures/departures.schemas.ts';
import { VoucherKeySchema } from '../payments/payments.schemas.ts';
import { ProductTypeSchema } from '../products/products.schemas.ts';

const Mark = z.enum(['boarded', 'no_show']).nullable();
const PassengerType = z.enum(Object.keys(PASSENGER_TYPES) as [keyof typeof PASSENGER_TYPES]);
const Person = z.object({ id: z.uuid(), email: z.string(), name: z.string().nullable() });

export const TodayDepartureSchema = z
  .object({
    id: z.uuid(),
    date: z.iso.date(),
    title: z.string(),
    productType: ProductTypeSchema,
    status: DepartureStatusSchema,
    passengers: z.number().int(),
    boarded: z.number().int(),
    guides: z.array(Person),
  })
  .meta({ id: 'TodayDeparture' });
export const TodayListSchema = z
  .object({ items: z.array(TodayDepartureSchema) })
  .meta({ id: 'TodayList' });

export const ManifestPassengerSchema = z
  .object({
    id: z.uuid(),
    bookingId: z.uuid(),
    bookingCode: z.string(),
    position: z.number().int(),
    type: PassengerType,
    name: z.string().nullable(),
    cedula: z.string().nullable(),
    restrictions: z.string().nullable(),
    /** Platos en palabras, uno por comida a escoger. */
    meals: z.array(z.string()),
    boarding: z.string().nullable(),
    /** Lo que falta por pagar de la reserva; se cobra al abordar si la agencia lo permite. */
    balanceUsd: z.number(),
    checkin: Mark,
    checkinAt: z.iso.datetime().nullable(),
  })
  .meta({ id: 'ManifestPassenger' });

export const ManifestSchema = z
  .object({
    departure: z.object({
      id: z.uuid(),
      date: z.iso.date(),
      title: z.string(),
      status: DepartureStatusSchema,
    }),
    /** Llaves públicas para validar vouchers sin conexión. */
    keys: z.array(VoucherKeySchema),
    passengers: z.array(ManifestPassengerSchema),
    /** Marcas que no se aplicaron y por qué: pasajero ajeno, reloj adelantado o ya había una más nueva. */
    discarded: z.array(
      z.object({ passengerId: z.uuid(), reason: z.enum(['unknown', 'clock', 'older']) }),
    ),
  })
  .meta({ id: 'Manifest' });

export const CheckinSyncInput = CheckinSyncSchema.meta({ id: 'CheckinSyncInput' });

const Count = z.object({ name: z.string(), count: z.number().int() });
export const ProductionSchema = z
  .object({
    departure: z.object({ id: z.uuid(), date: z.iso.date(), title: z.string() }),
    passengers: z.array(
      z.object({ type: PassengerType, label: z.string(), count: z.number().int() }),
    ),
    meals: z.array(
      z.object({
        mealId: z.uuid(),
        name: z.string(),
        mode: z.string(),
        description: z.string(),
        servings: z.number().int(),
        options: z.array(Count.extend({ optionId: z.uuid() })),
        pending: z.number().int(),
      }),
    ),
    items: z.array(
      z.object({
        itemId: z.uuid(),
        name: z.string(),
        modality: z.string(),
        units: z.number().int(),
      }),
    ),
    rooms: z.array(z.object({ type: z.string(), label: z.string(), count: z.number().int() })),
    restrictions: z.array(z.object({ name: z.string(), restrictions: z.string() })),
  })
  .meta({ id: 'Production' });

export const CsvSchema = z.string().meta({ id: 'CsvText' });

export const NoticeSchema = z
  .object({
    id: z.uuid(),
    body: z.string(),
    author: z.string().nullable(),
    createdAt: z.iso.datetime(),
  })
  .meta({ id: 'Notice' });
export const NoticeListSchema = z
  .object({ items: z.array(NoticeSchema) })
  .meta({ id: 'NoticeList' });
export const NoticeInput = z
  .strictObject({
    body: z
      .string()
      .trim()
      .min(1, 'Escribe el aviso.')
      .max(1000, 'El aviso puede tener hasta 1000 caracteres.'),
  })
  .meta({ id: 'NoticeInput' });
