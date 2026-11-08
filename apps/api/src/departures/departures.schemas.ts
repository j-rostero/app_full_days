import {
  DEPARTURE_STATUSES,
  DepartureUpdateSchema,
  ScheduleDeparturesSchema,
} from '@fulldays/shared';
import { z } from 'zod';
import { ProductTypeSchema } from '../products/products.schemas.ts';

export const DepartureStatusSchema = z.enum(DEPARTURE_STATUSES).meta({ id: 'DepartureStatus' });

export const DepartureSchema = z
  .object({
    id: z.uuid(),
    productId: z.uuid(),
    productType: ProductTypeSchema,
    title: z.string(),
    date: z.iso.date(),
    status: DepartureStatusSchema,
    capacity: z.number().int(),
    minCapacity: z.number().int(),
    reserved: z.number().int(),
    seatsLeft: z.number().int(),
    /** Precio propio de la salida; nulo usa el de la ficha. */
    adultPriceUsd: z.number().nullable(),
    /** Precio de adulto con que se vende. */
    priceUsd: z.number(),
    guides: z.array(z.object({ id: z.uuid(), email: z.string(), name: z.string().nullable() })),
  })
  .meta({ id: 'Departure' });
export const DepartureListSchema = z
  .object({ items: z.array(DepartureSchema) })
  .meta({ id: 'DepartureList' });
export const DepartureQuery = z.strictObject({
  productId: z.uuid().optional(),
  desde: z.iso.date().optional(),
});

export const ScheduleDeparturesInput = ScheduleDeparturesSchema.meta({
  id: 'ScheduleDeparturesInput',
});
export const DepartureUpdateInput = DepartureUpdateSchema.meta({ id: 'DepartureUpdateInput' });

export type DepartureView = z.infer<typeof DepartureSchema>;
