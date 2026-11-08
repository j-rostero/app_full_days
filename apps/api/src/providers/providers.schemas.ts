import {
  PROVIDER_DOCUMENT_TYPES,
  PROVIDER_KINDS,
  PROVIDER_STATUSES,
  ProviderInputSchema,
  ProviderUpdateSchema,
} from '@fulldays/shared';
import { z } from 'zod';

export const ProviderInput = ProviderInputSchema.meta({ id: 'ProviderInput' });
export const ProviderUpdateInput = ProviderUpdateSchema.meta({ id: 'ProviderUpdateInput' });

export const ProviderStatusSchema = z.enum(PROVIDER_STATUSES).meta({ id: 'ProviderStatus' });
export const ProviderDocumentTypeSchema = z
  .enum(PROVIDER_DOCUMENT_TYPES)
  .meta({ id: 'ProviderDocumentType' });

export const CompanySchema = z
  .object({
    id: z.uuid(),
    kind: z.enum(PROVIDER_KINDS),
    name: z.string(),
    legalName: z.string(),
    rif: z.string(),
    rtn: z.string().nullable(),
    baseCity: z.string(),
    phone: z.string(),
    instagram: z.string().nullable(),
    paymentInstructions: z.string().nullable(),
    status: ProviderStatusSchema,
    statusReason: z.string().nullable(),
    badge: z.enum(['verified', 'new']).nullable(),
    /** Comisión propia; nula usa la de la plataforma. */
    commissionPercent: z.number().nullable(),
    missingDocuments: z.array(ProviderDocumentTypeSchema),
  })
  .meta({ id: 'Company' });

export const ProviderDocumentSchema = z
  .object({
    id: z.uuid(),
    type: ProviderDocumentTypeSchema,
    fileId: z.uuid(),
    contentType: z.string(),
    downloadUrl: z.string(),
    createdAt: z.iso.datetime(),
  })
  .meta({ id: 'ProviderDocument' });
export const ProviderDocumentListSchema = z
  .object({ items: z.array(ProviderDocumentSchema) })
  .meta({ id: 'ProviderDocumentList' });

export const AttachDocumentInput = z
  .strictObject({ type: z.enum(PROVIDER_DOCUMENT_TYPES), fileId: z.uuid() })
  .meta({ id: 'AttachDocumentInput' });

export const ProviderQueueItemSchema = z
  .object({
    id: z.uuid(),
    name: z.string(),
    kind: z.enum(PROVIDER_KINDS),
    rif: z.string(),
    baseCity: z.string(),
    status: ProviderStatusSchema,
    hasRtn: z.boolean(),
    submittedAt: z.iso.datetime().nullable(),
  })
  .meta({ id: 'ProviderQueueItem' });
export const ProviderQueueSchema = z
  .object({ items: z.array(ProviderQueueItemSchema) })
  .meta({ id: 'ProviderQueue' });
export const ProviderQueueQuery = z.strictObject({
  status: z.enum(PROVIDER_STATUSES).default('in_review'),
});

export const ProviderReviewSchema = z
  .object({
    company: CompanySchema,
    documents: z.array(ProviderDocumentSchema),
    owners: z.array(z.object({ id: z.uuid(), email: z.string(), name: z.string().nullable() })),
  })
  .meta({ id: 'ProviderReview' });

export const ReasonInput = z
  .strictObject({
    reason: z.string().trim().min(10, 'Explica el motivo (al menos 10 caracteres).').max(1000),
  })
  .meta({ id: 'ReasonInput' });
export const CommissionInput = z
  .strictObject({ commissionPercent: z.number().min(0).max(50).nullable() })
  .meta({ id: 'CommissionInput' });

export type Company = z.infer<typeof CompanySchema>;
export type ProviderDocumentView = z.infer<typeof ProviderDocumentSchema>;
