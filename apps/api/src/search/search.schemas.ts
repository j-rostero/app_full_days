import { DEPARTURE_STATUSES, SearchQuerySchema } from '@fulldays/shared';
import { z } from 'zod';
import { ImageUrlsSchema } from '../files/files.schemas.ts';
import { PhotoSchema, ProductSheet, ProductTypeSchema } from '../products/products.schemas.ts';

export const SearchQuery = SearchQuerySchema;

const Badge = z.enum(['verified', 'new']).nullable();

export const PublicProviderRefSchema = z
  .object({ id: z.uuid(), name: z.string(), badge: Badge, baseCity: z.string() })
  .meta({ id: 'PublicProviderRef' });

export const DepartureCardSchema = z
  .object({
    departureId: z.uuid(),
    productId: z.uuid(),
    date: z.iso.date(),
    status: z.enum(DEPARTURE_STATUSES),
    type: ProductTypeSchema,
    title: z.string(),
    summary: z.string(),
    cover: ImageUrlsSchema.nullable(),
    priceUsd: z.number(),
    seatsLeft: z.number().int(),
    days: z.number().int(),
    destination: z.string().nullable(),
    cities: z.array(z.string()),
    featured: z.boolean(),
    provider: PublicProviderRefSchema,
  })
  .meta({ id: 'DepartureCard' });

export const SearchResultSchema = z
  .object({ items: z.array(DepartureCardSchema), page: z.number().int(), hasMore: z.boolean() })
  .meta({ id: 'SearchResult' });

export const DepartureDateSchema = z
  .object({
    id: z.uuid(),
    date: z.iso.date(),
    status: z.enum(DEPARTURE_STATUSES),
    priceUsd: z.number(),
    seatsLeft: z.number().int(),
  })
  .meta({ id: 'DepartureDate' });

export const PublicProductSchema = z
  .object({
    id: z.uuid(),
    type: ProductTypeSchema,
    sheet: ProductSheet,
    photos: z.array(PhotoSchema),
    featured: z.boolean(),
    themes: z.array(z.object({ slug: z.string(), name: z.string() })),
    destination: z.object({ id: z.uuid(), slug: z.string(), name: z.string() }).nullable(),
    cashAtDestination: z.object({ totalUsd: z.number(), concepts: z.array(z.string()) }),
    inclusions: z.object({
      included: z.array(z.string()),
      optional: z.array(z.string()),
      payAtDestination: z.array(z.string()),
      notIncluded: z.array(z.string()),
    }),
    provider: PublicProviderRefSchema.extend({ instagram: z.string().nullable() }),
    departures: z.array(DepartureDateSchema),
  })
  .meta({ id: 'PublicProduct' });

export const PublicProductCardSchema = z
  .object({
    id: z.uuid(),
    type: ProductTypeSchema,
    title: z.string(),
    summary: z.string(),
    cover: ImageUrlsSchema.nullable(),
    priceUsd: z.number(),
    nextDate: z.iso.date().nullable(),
  })
  .meta({ id: 'PublicProductCard' });

export const PublicAgencySchema = z
  .object({
    provider: PublicProviderRefSchema.extend({ instagram: z.string().nullable() }),
    products: z.array(PublicProductCardSchema),
  })
  .meta({ id: 'PublicAgency' });

export const FavoriteListSchema = z
  .object({ items: z.array(PublicProductCardSchema) })
  .meta({ id: 'FavoriteList' });

export const AvailabilitySchema = z
  .object({
    departure: DepartureDateSchema.extend({
      productId: z.uuid(),
      adultPriceUsd: z.number().nullable(),
    }),
    type: ProductTypeSchema,
    title: z.string(),
    sheet: ProductSheet,
    provider: PublicProviderRefSchema,
    /** Habitaciones libres por id de habitación de la ficha; sin tope no aparece. */
    roomsLeft: z.record(z.string(), z.number().int()),
  })
  .meta({ id: 'Availability' });

export type DepartureCard = z.infer<typeof DepartureCardSchema>;
export type PublicProductCard = z.infer<typeof PublicProductCardSchema>;
