import { z } from 'zod';
import type { Settings } from './catalog.ts';
import { PASSENGER_TYPES, type ProductSheet } from './product.ts';

export type PassengerType = keyof typeof PASSENGER_TYPES;
const PASSENGER_KEYS = Object.keys(PASSENGER_TYPES) as [PassengerType, ...PassengerType[]];

export const BOOKING_STATUS_LABELS = {
  held: 'Apartada',
  in_review: 'Pago en revisión',
  deposit_paid: 'Abonada',
  paid: 'Pagada',
  expired: 'Vencida',
  cancelled: 'Cancelada',
  completed: 'Realizada',
  no_show: 'No se presentó',
} as const;
export type BookingStatus = keyof typeof BOOKING_STATUS_LABELS;
export const BOOKING_STATUSES = Object.keys(BOOKING_STATUS_LABELS) as [
  BookingStatus,
  ...BookingStatus[],
];
/** Estados que conservan los puestos tomados. */
export const SEAT_HOLDING_STATUSES: readonly BookingStatus[] = [
  'held',
  'in_review',
  'deposit_paid',
  'paid',
];
/** Reservas con pago confirmado: tienen voucher y entran a la lista de pasajeros. */
export const CONFIRMED_STATUSES: readonly BookingStatus[] = [
  'deposit_paid',
  'paid',
  'completed',
  'no_show',
];

/** Reservas apartadas sin pagar que una persona puede tener a la vez. */
export const MAX_HELD_BOOKINGS = 3;
/** Pasajeros por reserva. */
export const MAX_PASSENGERS_PER_BOOKING = 20;

const Count = z.number().int().min(0).max(MAX_PASSENGERS_PER_BOOKING).default(0);
export const TravelersSchema = z
  .strictObject({ adult: Count, child: Count, senior: Count, infant: Count })
  .prefault({});
export type Travelers = z.infer<typeof TravelersSchema>;

export const BookingSelectionSchema = z
  .strictObject({
    boardingId: z.uuid(),
    travelers: TravelersSchema,
    /** Habitaciones por tipo (solo con noches). */
    rooms: z
      .array(z.strictObject({ roomId: z.uuid(), count: z.number().int().min(1).max(20) }))
      .max(10)
      .default([]),
    /** Comidas opcionales que se suman para todos los que ocupan puesto. */
    mealIds: z.array(z.uuid()).max(90).default([]),
    /** Extras opcionales que se suman para todos los que ocupan puesto. */
    itemIds: z.array(z.uuid()).max(60).default([]),
  })
  .refine(
    (s) => passengerCount(s.travelers) <= MAX_PASSENGERS_PER_BOOKING,
    `Como máximo ${MAX_PASSENGERS_PER_BOOKING} pasajeros por reserva.`,
  );
export type BookingSelection = z.infer<typeof BookingSelectionSchema>;

export function passengerCount(t: Travelers): number {
  return t.adult + t.child + t.senior + t.infant;
}
/** Los infantes viajan en brazos: no ocupan puesto. */
export function seatCount(t: Travelers): number {
  return t.adult + t.child + t.senior;
}
/** Tipo de cada pasajero en orden: adultos, adultos mayores, niños, infantes. */
export function passengerTypes(t: Travelers): PassengerType[] {
  return (['adult', 'senior', 'child', 'infant'] as const).flatMap((type) =>
    Array.from({ length: t[type] }, () => type),
  );
}

export interface SelectionIssue {
  path: string[];
  message: string;
}

/** Problemas de una selección frente a la ficha que se vende. */
export function checkSelection(sheet: ProductSheet, s: BookingSelection): SelectionIssue[] {
  const issues: SelectionIssue[] = [];
  const add = (path: string[], message: string) => issues.push({ path, message });
  if (!sheet.transfer.boardingPoints.some((b) => b.id === s.boardingId))
    add(['boardingId'], 'Escoge un punto de embarque de este viaje.');
  if (s.travelers.adult + s.travelers.senior < 1)
    add(['travelers', 'adult'], 'Cada reserva necesita al menos un adulto.');
  if (!sheet.general.childrenAllowed && s.travelers.child + s.travelers.infant > 0)
    add(['travelers', 'child'], 'Este viaje no admite niños.');
  const rooms = sheet.lodging?.rooms ?? [];
  for (const [i, r] of s.rooms.entries())
    if (!rooms.some((room) => room.id === r.roomId))
      add(['rooms', String(i), 'roomId'], 'Esa habitación no es de este viaje.');
  if (new Set(s.rooms.map((r) => r.roomId)).size !== s.rooms.length)
    add(['rooms'], 'Hay habitaciones repetidas.');
  if (sheet.duration.nights > 0 && rooms.length > 0) {
    const beds = s.rooms.reduce(
      (sum, r) => sum + (rooms.find((room) => room.id === r.roomId)?.occupancy ?? 0) * r.count,
      0,
    );
    if (beds < seatCount(s.travelers))
      add(['rooms'], 'Las habitaciones escogidas no alcanzan para todos los pasajeros.');
  }
  for (const [i, id] of s.mealIds.entries())
    if (!sheet.meals.some((m) => m.id === id && m.mode === 'optional'))
      add(['mealIds', String(i)], 'Esa comida no es opcional en este viaje.');
  for (const [i, id] of s.itemIds.entries())
    if (!sheet.items.some((it) => it.id === id && it.modality === 'optional'))
      add(['itemIds', String(i)], 'Ese extra no es opcional en este viaje.');
  return issues;
}

export interface QuoteLine {
  label: string;
  amountUsd: number;
}
export interface Quote {
  lines: QuoteLine[];
  totalUsd: number;
  depositUsd: number;
  seats: number;
  /** Día (AAAA-MM-DD) en que vence el saldo. */
  balanceDueDate: string;
}

const cents = (usd: number) => Math.round(usd * 100);
const usd = (c: number) => c / 100;

/**
 * Precio de una selección. Un tipo de pasajero sin tarifa paga como adulto, salvo el infante,
 * que sin tarifa no paga. El abono es el mayor entre el de la ficha y el mínimo de Central, sin
 * pasar del total; sin abono en la ficha ni mínimo, se paga todo.
 */
export function quote(
  sheet: ProductSheet,
  departure: { date: string; adultPriceUsd: number | null },
  s: BookingSelection,
  settings: Pick<Settings, 'minDepositPercent'>,
): Quote {
  const fares = sheet.pricing.fares;
  const adult = cents(departure.adultPriceUsd ?? fares.adult);
  const fareOf = (type: PassengerType) =>
    type === 'adult'
      ? adult
      : fares[type] === null
        ? type === 'infant'
          ? 0
          : adult
        : cents(fares[type]);
  const seats = seatCount(s.travelers);
  const lines: { label: string; cents: number }[] = [];
  for (const type of PASSENGER_KEYS) {
    const n = s.travelers[type];
    if (n > 0) lines.push({ label: `${n} × ${PASSENGER_TYPES[type]}`, cents: n * fareOf(type) });
  }
  const boarding = sheet.transfer.boardingPoints.find((b) => b.id === s.boardingId);
  if (boarding && boarding.priceDeltaUsd !== 0)
    lines.push({
      label: `Embarque en ${boarding.name || boarding.city}`,
      cents: seats * cents(boarding.priceDeltaUsd),
    });
  for (const r of s.rooms) {
    const room = sheet.lodging?.rooms.find((x) => x.id === r.roomId);
    if (room && room.priceDeltaUsd !== 0)
      lines.push({
        label: `${r.count} × habitación ${room.type}`,
        cents: r.count * cents(room.priceDeltaUsd),
      });
  }
  for (const id of s.mealIds) {
    const meal = sheet.meals.find((m) => m.id === id);
    if (meal)
      lines.push({
        label: `Comida día ${meal.day}: ${meal.description || meal.moment}`,
        cents: seats * cents(meal.priceUsd),
      });
  }
  for (const id of s.itemIds) {
    const item = sheet.items.find((it) => it.id === id);
    if (item) lines.push({ label: item.name, cents: seats * cents(item.priceUsd) });
  }
  const total = Math.max(
    0,
    lines.reduce((sum, l) => sum + l.cents, 0),
  );
  const d = sheet.pricing.deposit;
  const fromSheet =
    d === null
      ? 0
      : d.kind === 'percent'
        ? Math.round((total * d.value) / 100)
        : seats * cents(d.value);
  const fromCentral = Math.round((total * settings.minDepositPercent) / 100);
  const deposit =
    d === null && settings.minDepositPercent === 0
      ? total
      : Math.min(total, Math.max(fromSheet, fromCentral));
  const daysBefore = sheet.pricing.balanceDueDaysBefore ?? 0;
  const due = new Date(Date.parse(`${departure.date}T00:00:00Z`) - daysBefore * 86_400_000);
  return {
    lines: lines.map((l) => ({ label: l.label, amountUsd: usd(l.cents) })),
    totalUsd: usd(total),
    depositUsd: usd(deposit),
    seats,
    balanceDueDate: due.toISOString().slice(0, 10),
  };
}

export type BookingEvent =
  | 'submit_proof'
  | 'reject_proof'
  | 'confirm_payment'
  | 'expire'
  | 'cancel'
  | 'balance_overdue'
  | 'finish';

/**
 * Siguiente estado de una reserva, o `null` si el evento no se admite. `paidUsd` es lo pagado
 * ya confirmado (incluido el pago que se confirma) y `boarded` si alguien abordó.
 */
export function nextBookingStatus(
  from: BookingStatus,
  event: BookingEvent,
  ctx: { paidUsd?: number; depositUsd?: number; totalUsd?: number; boarded?: boolean } = {},
): BookingStatus | null {
  const paid = cents(ctx.paidUsd ?? 0);
  const byPayment = (): BookingStatus =>
    paid >= cents(ctx.totalUsd ?? Infinity)
      ? 'paid'
      : paid >= cents(ctx.depositUsd ?? Infinity)
        ? 'deposit_paid'
        : 'held';
  switch (from) {
    case 'held':
      if (event === 'submit_proof') return 'in_review';
      if (event === 'confirm_payment') return byPayment();
      if (event === 'expire') return 'expired';
      if (event === 'cancel') return 'cancelled';
      return null;
    case 'in_review':
      if (event === 'reject_proof') return 'held';
      if (event === 'confirm_payment') return byPayment();
      if (event === 'submit_proof') return 'in_review';
      if (event === 'cancel') return 'cancelled';
      return null;
    case 'deposit_paid':
      if (event === 'confirm_payment') return byPayment() === 'paid' ? 'paid' : 'deposit_paid';
      if (event === 'submit_proof') return 'deposit_paid';
      if (event === 'balance_overdue' || event === 'cancel') return 'cancelled';
      if (event === 'finish') return ctx.boarded ? 'completed' : 'no_show';
      return null;
    case 'paid':
      if (event === 'cancel') return 'cancelled';
      if (event === 'finish') return ctx.boarded ? 'completed' : 'no_show';
      return null;
    default:
      return null;
  }
}

/** Alfabeto de códigos sin 0/O ni 1/I, que se confunden al dictarlos. */
const CODE_ALPHABET = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';

export function bookingCode(
  random: (n: number) => Uint8Array = (n) => globalThis.crypto.getRandomValues(new Uint8Array(n)),
): string {
  const bytes = random(8);
  return `FD-${Array.from(bytes, (b) => CODE_ALPHABET[b % CODE_ALPHABET.length]).join('')}`;
}

/** Reglas de devolución de las plantillas de cancelación de la ficha. */
export function refundFor(
  template: ProductSheet['pricing']['cancellation']['template'],
  daysBefore: number,
  paidUsd: number,
  byAgency = false,
): { amountUsd: number; rule: string } {
  if (byAgency)
    return { amountUsd: paidUsd, rule: 'Cancelada por la agencia: se devuelve todo lo pagado.' };
  switch (template) {
    case 'flexible':
      return daysBefore >= 2
        ? { amountUsd: paidUsd, rule: 'Flexible: reembolso total hasta 48 horas antes.' }
        : { amountUsd: 0, rule: 'Flexible: faltan menos de 48 horas.' };
    case 'moderate':
      if (daysBefore >= 7)
        return { amountUsd: paidUsd, rule: 'Moderada: reembolso total hasta 7 días antes.' };
      if (daysBefore >= 2)
        return {
          amountUsd: usd(Math.round(cents(paidUsd) / 2)),
          rule: 'Moderada: 50 % hasta 48 horas antes.',
        };
      return { amountUsd: 0, rule: 'Moderada: faltan menos de 48 horas.' };
    case 'strict':
      return daysBefore >= 7
        ? {
            amountUsd: usd(Math.round(cents(paidUsd) / 2)),
            rule: 'Estricta: 50 % hasta 7 días antes.',
          }
        : { amountUsd: 0, rule: 'Estricta: faltan menos de 7 días.' };
    default:
      return {
        amountUsd: 0,
        rule: 'La ficha no tiene plantilla: el reembolso se acuerda con la agencia.',
      };
  }
}
