import {
  PRODUCT_STATUSES,
  PRODUCT_TYPES,
  ProductSheetSchema,
  SHEET_BLOCKS,
} from '@fulldays/shared';
import { z } from 'zod';
import { ImageUrlsSchema } from '../files/files.schemas.ts';

export const ProductSheet = ProductSheetSchema.meta({ id: 'ProductSheet' });
export const ProductTypeSchema = z.enum(PRODUCT_TYPES).meta({ id: 'ProductType' });
export const ProductStatusSchema = z.enum(PRODUCT_STATUSES).meta({ id: 'ProductStatus' });

export const CompletenessSchema = z
  .object({
    percent: z.number().int(),
    publishable: z.boolean(),
    missing: z.array(z.string()),
    blocks: z.array(
      z.object({
        block: z.enum(Object.keys(SHEET_BLOCKS) as [keyof typeof SHEET_BLOCKS]),
        label: z.string(),
        percent: z.number().int(),
        missing: z.array(z.string()),
      }),
    ),
  })
  .meta({ id: 'Completeness' });

export const PhotoSchema = z.object({ id: z.uuid(), urls: ImageUrlsSchema }).meta({ id: 'Photo' });

export const ProductSummarySchema = z
  .object({
    id: z.uuid(),
    type: ProductTypeSchema,
    status: ProductStatusSchema,
    statusReason: z.string().nullable(),
    title: z.string(),
    percent: z.number().int(),
    cover: ImageUrlsSchema.nullable(),
    updatedAt: z.iso.datetime(),
  })
  .meta({ id: 'ProductSummary' });
export const ProductListSchema = z
  .object({ items: z.array(ProductSummarySchema) })
  .meta({ id: 'ProductList' });

export const ProductDetailSchema = z
  .object({
    id: z.uuid(),
    providerId: z.uuid(),
    type: ProductTypeSchema,
    status: ProductStatusSchema,
    statusReason: z.string().nullable(),
    version: z.number().int(),
    sheet: ProductSheet,
    completeness: CompletenessSchema,
    cashAtDestinationUsd: z.number(),
    photos: z.array(PhotoSchema),
    updatedAt: z.iso.datetime(),
  })
  .meta({ id: 'ProductDetail' });

export const CreateProductInput = z
  .strictObject({ type: z.enum(PRODUCT_TYPES), sheet: ProductSheet.optional() })
  .meta({ id: 'CreateProductInput' });
export const SaveProductInput = z
  .strictObject({ version: z.number().int().min(1), sheet: ProductSheet })
  .meta({ id: 'SaveProductInput' });

export const ProductQueueQuery = z.strictObject({
  status: z.enum(PRODUCT_STATUSES).default('in_review'),
});
export const ProductQueueItemSchema = z
  .object({
    id: z.uuid(),
    type: ProductTypeSchema,
    status: ProductStatusSchema,
    title: z.string(),
    providerId: z.uuid(),
    providerName: z.string(),
    statusAt: z.iso.datetime(),
  })
  .meta({ id: 'ProductQueueItem' });
export const ProductQueueSchema = z
  .object({ items: z.array(ProductQueueItemSchema) })
  .meta({ id: 'ProductQueue' });

export const ProductReviewSchema = z
  .object({
    product: ProductDetailSchema,
    providerName: z.string(),
    providerHasRtn: z.boolean(),
    /** Teléfonos y enlaces de WhatsApp encontrados en los textos. */
    contacts: z.array(z.string()),
    featured: z.boolean(),
    themeIds: z.array(z.uuid()),
  })
  .meta({ id: 'ProductReview' });

export const CurationInput = z
  .strictObject({ featured: z.boolean(), themeIds: z.array(z.uuid()).max(10) })
  .meta({ id: 'CurationInput' });

export type ProductDetail = z.infer<typeof ProductDetailSchema>;
export type ProductSummary = z.infer<typeof ProductSummarySchema>;
