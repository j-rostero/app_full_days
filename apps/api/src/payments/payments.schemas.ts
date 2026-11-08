import { PAYMENT_STATUSES, PASSENGER_TYPES, ReportPaymentSchema } from '@fulldays/shared';
import { z } from 'zod';

export const PaymentStatusSchema = z.enum(PAYMENT_STATUSES).meta({ id: 'PaymentStatus' });
export const PaymentMethodSchema = z
  .enum(['mobile_payment', 'bank_transfer', 'zelle', 'cash_usd'])
  .meta({ id: 'PaymentMethod' });

export const ReportPaymentInput = ReportPaymentSchema.meta({ id: 'ReportPaymentInput' });

export const PaymentSchema = z
  .object({
    id: z.uuid(),
    bookingId: z.uuid(),
    bookingCode: z.string(),
    departureDate: z.iso.date(),
    title: z.string(),
    method: PaymentMethodSchema,
    reference: z.string(),
    amountUsd: z.number(),
    bsPerUsd: z.number().nullable(),
    amountBs: z.number().nullable(),
    status: PaymentStatusSchema,
    reason: z.string().nullable(),
    /** Enlace de cinco minutos al comprobante. */
    proofUrl: z.string().nullable(),
    createdAt: z.iso.datetime(),
    reviewedAt: z.iso.datetime().nullable(),
  })
  .meta({ id: 'Payment' });
export const PaymentListSchema = z
  .object({ items: z.array(PaymentSchema) })
  .meta({ id: 'PaymentList' });

export const PaymentQuery = z.strictObject({ status: z.enum(PAYMENT_STATUSES).default('pending') });

export const RejectPaymentInput = z
  .strictObject({ reason: z.string().trim().min(5, 'Explica el motivo al viajero.').max(300) })
  .meta({ id: 'RejectPaymentInput' });

export const VoucherSchema = z
  .object({
    passengerId: z.uuid(),
    position: z.number().int(),
    type: z.enum(Object.keys(PASSENGER_TYPES) as [keyof typeof PASSENGER_TYPES]),
    name: z.string().nullable(),
    /** Texto del QR, firmado; se valida sin red con las claves públicas. */
    qr: z.string(),
  })
  .meta({ id: 'Voucher' });
export const VoucherListSchema = z
  .object({
    bookingCode: z.string(),
    title: z.string(),
    date: z.iso.date(),
    items: z.array(VoucherSchema),
  })
  .meta({ id: 'VoucherList' });

/** Llave pública Ed25519 (32 bytes en base64url) para validar vouchers sin conexión. */
export const VoucherKeySchema = z
  .object({ id: z.string(), publicKey: z.string(), retired: z.boolean() })
  .meta({ id: 'VoucherKey' });
export const VoucherKeysSchema = z
  .object({ items: z.array(VoucherKeySchema) })
  .meta({ id: 'VoucherKeys' });

export type PaymentView = z.infer<typeof PaymentSchema>;
