// Después del viaje: reseñas y reputación, reclamos, liquidaciones del mes y notificaciones.
import { z } from 'zod';

export const REVIEW_WINDOW_DAYS = 30;

export const REVIEW_ASPECTS = {
  punctuality: 'Puntualidad',
  transport: 'Transporte',
  food: 'Comida',
  guide: 'Guía',
  value: 'Precio-calidad',
} as const;
export type ReviewAspect = keyof typeof REVIEW_ASPECTS;

const Stars = z.number().int().min(1, 'De 1 a 5.').max(5, 'De 1 a 5.');

export const ReviewInputSchema = z.strictObject({
  rating: Stars,
  aspects: z
    .strictObject({
      punctuality: Stars.optional(),
      transport: Stars.optional(),
      food: Stars.optional(),
      guide: Stars.optional(),
      value: Stars.optional(),
    })
    .default({}),
  /** ¿Se cumplió lo que decía la ficha? */
  asDescribed: z.boolean(),
  comment: z.string().trim().max(2000, 'Hasta 2000 caracteres.').default(''),
});
export type ReviewInput = z.infer<typeof ReviewInputSchema>;

/**
 * Datos de contacto en un texto público: un teléfono (7 dígitos o más, con o sin separadores),
 * un enlace o mención de WhatsApp o un correo. Sacan la venta de la plataforma.
 */
export function hasContactInfo(text: string): boolean {
  const digits = text.replace(/[\s().-]/g, '');
  return (
    /\+?\d{7,}/.test(digits) ||
    /wa\.me|whats\s*app|wsp\b|api\.whatsapp/i.test(text) ||
    /[\w.+-]+@[\w-]+\.[\w.]+/.test(text)
  );
}

/** Se reseña una reserva realizada, una vez, hasta 30 días después del viaje. */
export function reviewWindowOpen(departureDate: string, today: string): boolean {
  const days =
    (Date.parse(`${today}T00:00:00Z`) - Date.parse(`${departureDate}T00:00:00Z`)) / 86_400_000;
  return days >= 0 && days <= REVIEW_WINDOW_DAYS;
}

/** Solo el primer nombre del autor es público. */
export function publicAuthor(name: string | null): string {
  return name?.trim().split(/\s+/)[0] || 'Viajero';
}

export interface Reputation {
  average: number | null;
  count: number;
  /** Porcentaje de reseñas que dicen que se cumplió la ficha. */
  asDescribedPercent: number | null;
  aspects: Partial<Record<ReviewAspect, number>>;
}

const oneDecimal = (n: number) => Math.round(n * 10) / 10;

export function reputation(
  reviews: readonly {
    rating: number;
    asDescribed: boolean;
    aspects: Partial<Record<ReviewAspect, number>>;
  }[],
): Reputation {
  if (reviews.length === 0)
    return { average: null, count: 0, asDescribedPercent: null, aspects: {} };
  const aspects: Partial<Record<ReviewAspect, number>> = {};
  for (const key of Object.keys(REVIEW_ASPECTS) as ReviewAspect[]) {
    const marks = reviews.map((r) => r.aspects[key]).filter((v): v is number => v !== undefined);
    if (marks.length) aspects[key] = oneDecimal(marks.reduce((a, b) => a + b, 0) / marks.length);
  }
  return {
    average: oneDecimal(reviews.reduce((a, r) => a + r.rating, 0) / reviews.length),
    count: reviews.length,
    asDescribedPercent: Math.round(
      (reviews.filter((r) => r.asDescribed).length * 100) / reviews.length,
    ),
    aspects,
  };
}

export const CLAIM_STATUS_LABELS = {
  open: 'Abierto',
  escalated: 'Con FullDays',
  resolved: 'Resuelto',
} as const;
export type ClaimStatus = keyof typeof CLAIM_STATUS_LABELS;

const Message = z.string().trim().min(1, 'Escribe tu mensaje.').max(3000, 'Hasta 3000 caracteres.');
export const ClaimInputSchema = z.strictObject({
  subject: z.string().trim().min(3, 'Escribe el asunto.').max(150, 'Hasta 150 caracteres.'),
  message: Message,
});
export const ClaimMessageSchema = z.strictObject({ body: Message });
export const ClaimResolveSchema = z.strictObject({
  resolution: z.string().trim().min(3, 'Escribe la resolución.').max(2000),
});

/** Inicio y fin (exclusivo) de un mes en Venezuela (UTC−4), como instantes. */
export function monthRange(month: string): { from: Date; to: Date } {
  const [y, m] = month.split('-').map(Number) as [number, number];
  return {
    from: new Date(Date.UTC(y, m - 1, 1, 4)),
    to: new Date(Date.UTC(m === 12 ? y + 1 : y, m === 12 ? 0 : m, 1, 4)),
  };
}

export const MonthSchema = z
  .string()
  .regex(/^\d{4}-(0[1-9]|1[0-2])$/, 'Escribe el mes como AAAA-MM.');

const cents = (n: number) => Math.round(n * 100);

export interface SettlementEntry {
  account: string;
  debitUsd: number;
  creditUsd: number;
  paymentId: string | null;
  refundId: string | null;
}

/**
 * Totales de una liquidación a partir de los asientos del mes. Cobrado y devuelto se leen de la
 * caja (de la agencia o de la plataforma, según el modelo); la comisión, de su cuenta de ingresos.
 */
export function settlementTotals(entries: readonly SettlementEntry[]): {
  paymentsUsd: number;
  refundsUsd: number;
  commissionUsd: number;
  netUsd: number;
} {
  let payments = 0;
  let refunds = 0;
  let commission = 0;
  for (const e of entries) {
    if (e.account === 'agency_cash' || e.account === 'platform_cash') {
      payments += cents(e.debitUsd);
      refunds += cents(e.creditUsd);
    }
    if (e.account === 'platform_commission_revenue')
      commission += cents(e.creditUsd) - cents(e.debitUsd);
  }
  return {
    paymentsUsd: payments / 100,
    refundsUsd: refunds / 100,
    commissionUsd: commission / 100,
    netUsd: (payments - refunds - commission) / 100,
  };
}

export const NOTIFICATION_EVENTS = {
  payment_confirmed: 'Pago confirmado',
  payment_rejected: 'Pago rechazado',
  booking_cancelled: 'Reserva cancelada',
  departure_cancelled: 'Salida cancelada',
  refund_paid: 'Reembolso enviado',
  notice: 'Aviso de la agencia',
  trip_tomorrow: 'Tu viaje es mañana',
  balance_due: 'Saldo por pagar',
  review_reply: 'Respuesta a tu reseña',
  claim_message: 'Respuesta a tu reclamo',
  claim_resolved: 'Reclamo resuelto',
  team_decision: 'Decisión de FullDays',
} as const;
export type NotificationEvent = keyof typeof NOTIFICATION_EVENTS;

/** Intentos de entrega antes de dar una notificación por fallida. */
export const MAX_NOTIFICATION_ATTEMPTS = 5;

/** Espera antes del siguiente intento: 1, 2, 4, 8… minutos. */
export function retryDelayMs(attempts: number): number {
  return 60_000 * 2 ** Math.max(attempts - 1, 0);
}
