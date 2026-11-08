// El día del viaje: marcas de check-in sin conexión, lo que la agencia debe preparar y la lista en CSV.
import { z } from 'zod';
import type { BookingSelection, PassengerType } from './booking.ts';
import { MEAL_MOMENTS, PASSENGER_TYPES, type ProductSheet, ROOM_TYPES } from './product.ts';

export const CHECKIN_MARKS = { boarded: 'Abordó', no_show: 'No se presentó' } as const;
export type CheckinMark = keyof typeof CHECKIN_MARKS;

/** Una marca hecha en el teléfono del guía; `checkin: null` deshace la anterior. */
export const CheckinEventSchema = z.strictObject({
  passengerId: z.uuid(),
  checkin: z.enum(['boarded', 'no_show']).nullable(),
  /** Hora del teléfono al marcar. */
  at: z.iso.datetime({ offset: true }),
});
export type CheckinEvent = z.infer<typeof CheckinEventSchema>;
export const CheckinSyncSchema = z.strictObject({
  events: z.array(CheckinEventSchema).min(1).max(500),
});

/** Cuánto puede ir adelantado el reloj de un teléfono antes de descartar su marca. */
export const CLOCK_TOLERANCE_MS = 10 * 60_000;

export interface PassengerMark {
  checkin: CheckinMark | null;
  checkinAt: Date | null;
}

/** Por qué no se aplicó una marca: pasajero ajeno, reloj adelantado o ya había una más nueva. */
export type CheckinDiscard = 'unknown' | 'clock' | 'older';

/**
 * Qué marcas aplicar: por pasajero gana la de hora más reciente, sin importar el orden en que
 * lleguen, para que dos guías que sincronizan en cualquier orden terminen con la misma lista.
 * Se descartan marcas de pasajeros ajenos y las que vienen del futuro (reloj adelantado).
 */
export function resolveCheckins(
  current: ReadonlyMap<string, PassengerMark>,
  events: readonly CheckinEvent[],
  now: Date = new Date(),
): {
  winners: Map<string, { checkin: CheckinMark | null; checkinAt: Date }>;
  discarded: { passengerId: string; reason: CheckinDiscard }[];
} {
  const winners = new Map<string, { checkin: CheckinMark | null; checkinAt: Date }>();
  const discarded: { passengerId: string; reason: CheckinDiscard }[] = [];
  for (const e of events) {
    const mark = current.get(e.passengerId);
    const at = new Date(e.at);
    if (!mark) discarded.push({ passengerId: e.passengerId, reason: 'unknown' });
    else if (at.getTime() > now.getTime() + CLOCK_TOLERANCE_MS)
      discarded.push({ passengerId: e.passengerId, reason: 'clock' });
    else if (mark.checkinAt && mark.checkinAt.getTime() >= at.getTime())
      discarded.push({ passengerId: e.passengerId, reason: 'older' });
    else {
      const best = winners.get(e.passengerId);
      if (!best || best.checkinAt.getTime() < at.getTime())
        winners.set(e.passengerId, { checkin: e.checkin, checkinAt: at });
    }
  }
  return { winners, discarded };
}

/** Platos escogidos por pasajero: id de la comida → ids de las opciones. */
export const MealPicksSchema = z.record(z.uuid(), z.array(z.uuid()).max(5)).default({});
export type MealPicks = z.infer<typeof MealPicksSchema>;

/** Problemas de los platos escogidos frente a la ficha, con su ruta. */
export function checkMealPicks(sheet: ProductSheet, picks: MealPicks): string[] {
  const issues: string[] = [];
  for (const [mealId, optionIds] of Object.entries(picks)) {
    const meal = sheet.meals.find((m) => m.id === mealId);
    if (!meal || meal.mode !== 'choice') {
      issues.push('Esa comida no tiene platos a escoger.');
      continue;
    }
    if (optionIds.length > meal.picksPerPassenger)
      issues.push(`En esa comida se escogen hasta ${meal.picksPerPassenger} platos.`);
    if (optionIds.some((id) => !meal.options.some((o) => o.id === id)))
      issues.push('Ese plato no está en el menú.');
  }
  return issues;
}

/** Nombre de una comida para la lista y la producción. */
export function mealName(meal: ProductSheet['meals'][number]): string {
  return `${MEAL_MOMENTS[meal.moment]} día ${meal.day}`;
}

/** Los platos de un pasajero en palabras: los escogidos o, si no escogió, el predeterminado. */
export function mealsInWords(sheet: ProductSheet, picks: MealPicks): string[] {
  const out: string[] = [];
  for (const meal of sheet.meals) {
    if (meal.mode !== 'choice') continue;
    const chosen = picks[meal.id]?.length
      ? meal.options.filter((o) => picks[meal.id]!.includes(o.id))
      : meal.options.filter((o) => o.isDefault);
    out.push(
      `${mealName(meal)}: ${chosen.length ? chosen.map((o) => o.name).join(', ') : 'por escoger'}`,
    );
  }
  return out;
}

export interface ProductionBooking {
  selection: BookingSelection;
  passengers: {
    name: string | null;
    type: PassengerType;
    restrictions: string | null;
    mealPicks: MealPicks;
  }[];
}

export interface Production {
  passengers: { type: PassengerType; label: string; count: number }[];
  meals: {
    mealId: string;
    name: string;
    mode: ProductSheet['meals'][number]['mode'];
    description: string;
    servings: number;
    options: { optionId: string; name: string; count: number }[];
    /** Pasajeros que no han escogido y no hay plato predeterminado. */
    pending: number;
  }[];
  items: { itemId: string; name: string; modality: string; units: number }[];
  rooms: { type: string; label: string; count: number }[];
  restrictions: { name: string; restrictions: string }[];
}

/** Lo que la agencia debe preparar para una salida, a partir de sus reservas confirmadas. */
export function production(
  sheet: ProductSheet,
  bookings: readonly ProductionBooking[],
): Production {
  const byType = new Map<PassengerType, number>();
  for (const b of bookings)
    for (const p of b.passengers) byType.set(p.type, (byType.get(p.type) ?? 0) + 1);
  // Comen y usan ítems quienes ocupan puesto: los infantes van en brazos.
  const eaters = (b: ProductionBooking) => b.passengers.filter((p) => p.type !== 'infant');
  const everyone = bookings.flatMap(eaters);

  const meals = sheet.meals
    .filter((m) => m.mode !== 'not_included')
    .map((meal) => {
      const diners =
        meal.mode === 'optional'
          ? bookings.filter((b) => b.selection.mealIds.includes(meal.id)).flatMap(eaters)
          : everyone;
      const counts = new Map(meal.options.map((o) => [o.id, 0]));
      const fallback = meal.options.find((o) => o.isDefault);
      let pending = 0;
      if (meal.mode === 'choice') {
        for (const p of diners) {
          const picks = (p.mealPicks[meal.id] ?? []).filter((id) => counts.has(id));
          if (picks.length) for (const id of picks) counts.set(id, counts.get(id)! + 1);
          else if (fallback) counts.set(fallback.id, counts.get(fallback.id)! + 1);
          else pending++;
        }
      }
      return {
        mealId: meal.id,
        name: mealName(meal),
        mode: meal.mode,
        description: meal.description,
        servings: diners.length,
        options:
          meal.mode === 'choice'
            ? meal.options.map((o) => ({ optionId: o.id, name: o.name, count: counts.get(o.id)! }))
            : [],
        pending,
      };
    });

  const items = sheet.items
    .filter((i) => i.modality === 'included' || i.modality === 'optional')
    .map((item) => ({
      itemId: item.id,
      name: item.name,
      modality: item.modality,
      units:
        item.modality === 'included'
          ? everyone.length
          : bookings.filter((b) => b.selection.itemIds.includes(item.id)).flatMap(eaters).length,
    }));

  const rooms = new Map<string, number>();
  for (const b of bookings)
    for (const r of b.selection.rooms) {
      const room = sheet.lodging?.rooms.find((x) => x.id === r.roomId);
      if (room) rooms.set(room.type, (rooms.get(room.type) ?? 0) + r.count);
    }

  return {
    passengers: [...byType].map(([type, count]) => ({
      type,
      label: PASSENGER_TYPES[type],
      count,
    })),
    meals,
    items,
    rooms: [...rooms].map(([type, count]) => ({
      type,
      label: ROOM_TYPES[type as keyof typeof ROOM_TYPES] ?? type,
      count,
    })),
    restrictions: bookings
      .flatMap((b) => b.passengers)
      .filter((p) => p.restrictions)
      .map((p) => ({ name: p.name ?? 'Sin nombre', restrictions: p.restrictions! })),
  };
}

/**
 * CSV para Excel: con BOM para que lea los acentos, separado por punto y coma (configuración
 * regional en español) y con las celdas que parecen fórmulas desactivadas con un apóstrofo.
 */
export function toCsv(rows: readonly (readonly (string | number | null)[])[]): string {
  const cell = (v: string | number | null) => {
    let text = v === null ? '' : String(v);
    if (/^[=+\-@\t\r]/.test(text)) text = `'${text}`;
    return /[";\n\r]/.test(text) ? `"${text.replace(/"/g, '""')}"` : text;
  };
  return `\uFEFF${rows.map((r) => r.map(cell).join(';')).join('\r\n')}\r\n`;
}
