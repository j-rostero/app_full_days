import { z } from 'zod';
import { PAYMENT_METHODS, type PaymentMethod } from './catalog.ts';

export const PAYMENT_STATUS_LABELS = {
  pending: 'Por revisar',
  confirmed: 'Confirmado',
  rejected: 'Rechazado',
} as const;
export type PaymentStatus = keyof typeof PAYMENT_STATUS_LABELS;
export const PAYMENT_STATUSES = Object.keys(PAYMENT_STATUS_LABELS) as [
  PaymentStatus,
  ...PaymentStatus[],
];

/** Métodos que se pagan en bolívares: guardan la tasa del día. */
export const BOLIVAR_METHODS: readonly PaymentMethod[] = ['mobile_payment', 'bank_transfer'];

const METHOD_KEYS = Object.keys(PAYMENT_METHODS) as [PaymentMethod, ...PaymentMethod[]];

export const ReportPaymentSchema = z.strictObject({
  method: z.enum(METHOD_KEYS),
  reference: z.string().trim().min(4, 'Escribe la referencia del pago.').max(60),
  amountUsd: z.number().min(0.01).max(100_000),
  proofFileId: z.uuid().nullable().default(null),
  /** La misma clave en la misma reserva devuelve el pago ya creado. */
  idempotencyKey: z.string().min(8).max(80),
});
export type ReportPayment = z.infer<typeof ReportPaymentSchema>;

/** Referencia sin espacios ni guiones, en mayúsculas: así dos reportes del mismo pago chocan. */
export function normalizeReference(reference: string): string {
  return reference.replace(/[\s-]/g, '').toUpperCase();
}

export type LedgerAccount =
  | 'agency_cash'
  | 'agency_customer_deposits'
  | 'platform_commission_revenue'
  | 'platform_cash'
  | 'platform_payable_to_agency';

export interface Posting {
  account: LedgerAccount;
  debitUsd: number;
  creditUsd: number;
}

export type MoneyModel = 'direct' | 'retained';

const c = (usd: number) => Math.round(usd * 100);
const u = (cents: number) => cents / 100;

/**
 * Asientos de un pago confirmado. En `direct` el dinero llega a la agencia y la plataforma
 * reconoce su comisión contra los depósitos de clientes; en `retained` lo cobra la plataforma.
 * Los asientos en cero se omiten.
 */
export function paymentPostings(
  amountUsd: number,
  commissionPercent: number,
  model: MoneyModel = 'direct',
): Posting[] {
  const a = c(amountUsd);
  const fee = Math.round((a * commissionPercent) / 100);
  const rows: Posting[] =
    model === 'direct'
      ? [
          { account: 'agency_cash', debitUsd: u(a), creditUsd: 0 },
          { account: 'agency_customer_deposits', debitUsd: 0, creditUsd: u(a) },
          { account: 'agency_customer_deposits', debitUsd: u(fee), creditUsd: 0 },
          { account: 'platform_commission_revenue', debitUsd: 0, creditUsd: u(fee) },
        ]
      : [
          { account: 'platform_cash', debitUsd: u(a), creditUsd: 0 },
          { account: 'platform_payable_to_agency', debitUsd: 0, creditUsd: u(a - fee) },
          { account: 'platform_commission_revenue', debitUsd: 0, creditUsd: u(fee) },
        ];
  return rows.filter((r) => r.debitUsd !== 0 || r.creditUsd !== 0);
}

/** El espejo exacto de un pago: el dinero devuelto no deja comisión. */
export function refundPostings(
  amountUsd: number,
  commissionPercent: number,
  model: MoneyModel = 'direct',
): Posting[] {
  return paymentPostings(amountUsd, commissionPercent, model).map((p) => ({
    account: p.account,
    debitUsd: p.creditUsd,
    creditUsd: p.debitUsd,
  }));
}

/** Suma por cuenta y si debe y haber cuadran. */
export function balances(postings: readonly Posting[]): {
  byAccount: Record<string, number>;
  balanced: boolean;
} {
  const byAccount: Record<string, number> = {};
  let debit = 0;
  let credit = 0;
  for (const p of postings) {
    byAccount[p.account] = u(c(byAccount[p.account] ?? 0) + c(p.debitUsd) - c(p.creditUsd));
    debit += c(p.debitUsd);
    credit += c(p.creditUsd);
  }
  return { byAccount, balanced: debit === credit };
}
