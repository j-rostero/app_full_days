import { z } from 'zod';
import { DESTINATION_PAYMENTS } from './product.ts';

const Slug = z
  .string()
  .trim()
  .toLowerCase()
  .regex(/^[a-z0-9]+(?:-[a-z0-9]+)*$/, 'Usa minúsculas, números y guiones, como los-roques.')
  .max(80);
const Name = z.string().trim().min(2, 'Escribe el nombre.').max(120);
const Lat = z.number().min(-90).max(90).nullable().default(null);
const Lng = z.number().min(-180).max(180).nullable().default(null);

export const DestinationInputSchema = z.strictObject({
  slug: Slug,
  name: Name,
  state: z.string().trim().max(80).default(''),
  region: z.string().trim().max(80).default(''),
  lat: Lat,
  lng: Lng,
  parentId: z.uuid().nullable().default(null),
});
export const DestinationFeeInputSchema = z.strictObject({
  name: Name,
  amountUsd: z.number().min(0).max(10_000),
  payment: z.enum(Object.keys(DESTINATION_PAYMENTS) as ['cash_usd', 'cash_bs', 'mobile_payment']),
});
export const BoardingPointInputSchema = z.strictObject({
  city: z.string().trim().min(2).max(80),
  name: Name,
  address: z.string().trim().max(200).default(''),
  lat: Lat,
  lng: Lng,
});
export const ThemeInputSchema = z.strictObject({
  slug: Slug,
  name: Name,
  description: z.string().trim().max(500).default(''),
});

/** Tasa bolívares por dólar de un día. */
export const RateInputSchema = z.strictObject({
  date: z.iso.date('Escribe la fecha como AAAA-MM-DD.'),
  bsPerUsd: z.number().positive().max(1_000_000),
});

export const PAYMENT_METHODS = {
  mobile_payment: 'Pago móvil',
  bank_transfer: 'Transferencia bancaria',
  zelle: 'Zelle',
  cash_usd: 'Efectivo en dólares',
} as const;
export type PaymentMethod = keyof typeof PAYMENT_METHODS;

/** Reglas de reserva que Central ajusta sin desplegar. */
export const SettingsSchema = z.strictObject({
  holdMinutes: z.number().int().min(5).max(120),
  minDepositPercent: z.number().int().min(0).max(100),
  mealChoiceDeadlineHours: z.number().int().min(0).max(720),
  paymentMethods: z
    .array(z.enum(Object.keys(PAYMENT_METHODS) as [PaymentMethod, ...PaymentMethod[]]))
    .min(1, 'Activa al menos un método de pago.')
    .refine((m) => new Set(m).size === m.length, 'Hay métodos repetidos.'),
  platformCommissionPercent: z.number().min(0).max(50),
});
export type Settings = z.infer<typeof SettingsSchema>;
export const DEFAULT_SETTINGS: Settings = {
  holdMinutes: 30,
  minDepositPercent: 0,
  mealChoiceDeadlineHours: 48,
  paymentMethods: ['mobile_payment', 'bank_transfer', 'zelle'],
  platformCommissionPercent: 10,
};
