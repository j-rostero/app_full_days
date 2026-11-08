import { z } from 'zod';

export const DEPARTURE_STATUS_LABELS = {
  open: 'En venta',
  paused: 'Pausada',
  closed: 'Cerrada',
  in_progress: 'En curso',
  finished: 'Terminada',
  cancelled: 'Cancelada',
} as const;
export type DepartureStatus = keyof typeof DEPARTURE_STATUS_LABELS;
export const DEPARTURE_STATUSES = Object.keys(DEPARTURE_STATUS_LABELS) as [
  DepartureStatus,
  ...DepartureStatus[],
];

/** Fechas que programa una petición como máximo. */
export const MAX_DEPARTURES_PER_REQUEST = 60;

const IsoDate = z.iso.date('Escribe la fecha como AAAA-MM-DD.');

export const ScheduleDeparturesSchema = z
  .strictObject({
    productId: z.uuid(),
    // Texto AAAA-MM-DD validado aparte: los clientes generados manejan mejor una lista de textos que de fechas.
    dates: z
      .array(
        z
          .string()
          .regex(/^\d{4}-\d{2}-\d{2}$/, 'Escribe la fecha como AAAA-MM-DD.')
          .refine((d) => IsoDate.safeParse(d).success, 'Esa fecha no existe.'),
      )
      .min(1, 'Escoge al menos una fecha.')
      .max(MAX_DEPARTURES_PER_REQUEST, `Como máximo ${MAX_DEPARTURES_PER_REQUEST} fechas a la vez.`)
      .refine((dates) => new Set(dates).size === dates.length, 'Hay fechas repetidas.'),
    capacity: z.number().int().min(1).max(1000),
    minCapacity: z.number().int().min(1).max(1000).default(1),
    /** Precio de adulto de esta temporada; sin él vale el de la ficha. */
    adultPriceUsd: z.number().min(0.01).max(100_000).nullable().default(null),
  })
  .refine((v) => v.minCapacity <= v.capacity, {
    path: ['minCapacity'],
    message: 'El mínimo no puede pasar del cupo.',
  });

export const DepartureUpdateSchema = z.strictObject({
  capacity: z.number().int().min(1).max(1000).optional(),
  minCapacity: z.number().int().min(1).max(1000).optional(),
  adultPriceUsd: z.number().min(0.01).max(100_000).nullable().optional(),
  status: z.enum(DEPARTURE_STATUSES).optional(),
  guideIds: z.array(z.uuid()).max(10).optional(),
});

export type ScheduleDepartures = z.infer<typeof ScheduleDeparturesSchema>;
export type DepartureUpdate = z.infer<typeof DepartureUpdateSchema>;

const SELLING: DepartureStatus[] = ['open', 'paused', 'closed'];

/** Mientras vende se mueve libremente; luego a en curso o cancelada; en curso solo a terminada. */
export function canMoveDeparture(from: DepartureStatus, to: DepartureStatus): boolean {
  if (from === to) return true;
  if (SELLING.includes(from))
    return SELLING.includes(to) || to === 'in_progress' || to === 'cancelled';
  if (from === 'in_progress') return to === 'finished';
  return false;
}

/** Día calendario en Venezuela (UTC−4, sin horario de verano). */
export function todayInVenezuela(now: Date = new Date()): string {
  return new Date(now.getTime() - 4 * 3_600_000).toISOString().slice(0, 10);
}

/** El mismo día de la semana de `from` hasta `until`, inclusive, con el tope por petición. */
export function weeklyDates(from: string, until: string): string[] {
  const out: string[] = [];
  const end = Date.parse(`${until}T00:00:00Z`);
  for (
    let t = Date.parse(`${from}T00:00:00Z`);
    t <= end && out.length < MAX_DEPARTURES_PER_REQUEST;
    t += 7 * 86_400_000
  ) {
    out.push(new Date(t).toISOString().slice(0, 10));
  }
  return out;
}

export function seatsLeft(d: { capacity: number; reserved: number }): number {
  return Math.max(d.capacity - d.reserved, 0);
}
