import { z } from 'zod';

// Ficha de un producto (fullday, tour o excursión): todo lo que la agencia declara del viaje
// y la regla que decide si se puede publicar. Es un documento JSON: un borrador se guarda a medias.

const keys = <T extends Record<string, string>>(labels: T) =>
  Object.keys(labels) as [keyof T & string, ...(keyof T & string)[]];

export const PRODUCT_TYPE_LABELS = {
  fullday: 'Fullday',
  tour: 'Tour',
  excursion: 'Excursión',
} as const;
export const PRODUCT_TYPE_HINTS: Record<ProductType, string> = {
  fullday: 'Un día completo con traslado de ida y vuelta.',
  tour: 'Varios días, con alojamiento.',
  excursion: 'Unas horas en el destino, con punto de encuentro.',
};
export const PRODUCT_TYPES = keys(PRODUCT_TYPE_LABELS);
export type ProductType = keyof typeof PRODUCT_TYPE_LABELS;

export const PRODUCT_STATUS_LABELS = {
  draft: 'Borrador',
  in_review: 'En revisión',
  published: 'Publicado',
  paused: 'Pausado',
} as const;
export const PRODUCT_STATUSES = keys(PRODUCT_STATUS_LABELS);
export type ProductStatus = keyof typeof PRODUCT_STATUS_LABELS;

export const PRODUCT_CATEGORIES = {
  beach: 'Playa',
  island: 'Isla',
  mountain: 'Montaña',
  nature: 'Naturaleza',
  river: 'Río y cascadas',
  adventure: 'Aventura',
  culture: 'Cultura e historia',
  gastronomy: 'Gastronomía',
  city: 'Ciudad',
} as const;
export const PRODUCT_TAGS = {
  family: 'En familia',
  couples: 'En pareja',
  friends: 'Con amigos',
  kids: 'Ideal para niños',
  pets: 'Se admiten mascotas',
  accessible: 'Accesible',
  hiking: 'Caminata',
  snorkel: 'Snorkel',
  camping: 'Campamento',
  photography: 'Fotografía',
} as const;
export const VEHICLES = {
  bus: 'Autobús',
  minibus: 'Minibús',
  van: 'Van',
  car_4x4: 'Rústico 4x4',
  boat: 'Lancha o peñero',
  plane: 'Avión',
  none: 'Sin traslado (punto de encuentro)',
} as const;
export const MEAL_MOMENTS = {
  breakfast: 'Desayuno',
  lunch: 'Almuerzo',
  dinner: 'Cena',
  snack: 'Merienda',
} as const;
export const MEAL_MODES = {
  fixed: 'Incluida, menú fijo',
  choice: 'Incluida, a escoger',
  optional: 'Opcional, se paga aparte',
  not_included: 'No incluida',
} as const;
export const ITEM_TYPES = {
  hydration: 'Hidratación',
  shade: 'Toldos y sombra',
  access: 'Entradas y accesos',
  service: 'Servicio',
  activity: 'Actividad',
} as const;
export const ITEM_MODALITIES = {
  included: 'Incluido',
  optional: 'Opcional',
  pay_at_destination: 'Se paga en el destino',
  not_included: 'No incluido',
} as const;
export const DESTINATION_PAYMENTS = {
  cash_usd: 'Efectivo en dólares',
  cash_bs: 'Efectivo en bolívares',
  mobile_payment: 'Pago móvil',
} as const;
export const ROOM_TYPES = {
  single: 'Sencilla',
  double: 'Doble',
  triple: 'Triple',
  quadruple: 'Cuádruple',
  shared: 'Compartida (por plaza)',
  camping: 'Carpa (por plaza)',
} as const;
export const LODGING_REGIMES = {
  room_only: 'Solo alojamiento',
  breakfast: 'Con desayuno',
  half_board: 'Media pensión',
  full_board: 'Pensión completa',
  all_inclusive: 'Todo incluido',
} as const;
export const PASSENGER_TYPES = {
  adult: 'Adulto',
  child: 'Niño (3 a 11)',
  senior: 'Adulto mayor',
  infant: 'Infante (0 a 2)',
} as const;
export const CANCELLATION_TEMPLATES = {
  flexible: 'Flexible: reembolso total hasta 48 horas antes.',
  moderate: 'Moderada: reembolso total hasta 7 días antes y 50 % hasta 48 horas antes.',
  strict: 'Estricta: reembolso del 50 % hasta 7 días antes; después no hay reembolso.',
} as const;

/** Fotos mínimas para publicar. */
export const MIN_PHOTOS = 5;
export const MAX_PHOTOS = 20;

const Id = z.uuid();
const Time = z.string().regex(/^([01]\d|2[0-3]):[0-5]\d$/, 'Escribe la hora como HH:MM.');
const Usd = z.number().min(0).max(100_000);
const Short = (max: number) => z.string().trim().max(max);
const Day = z.number().int().min(1).max(30);

export const BoardingSchema = z.strictObject({
  id: Id,
  /** Punto del catálogo; si es nulo, la agencia escribe el suyo. */
  boardingPointId: Id.nullable().default(null),
  name: Short(120).default(''),
  address: Short(200).default(''),
  city: Short(80).default(''),
  departureTime: Time.nullable().default(null),
  returnTime: Time.nullable().default(null),
  priceDeltaUsd: z.number().min(-1000).max(1000).default(0),
});

export const MealOptionSchema = z.strictObject({
  id: Id,
  name: Short(120).default(''),
  /** Recargo por escoger esta opción. */
  priceUsd: Usd.default(0),
  /** Porciones disponibles por salida; nulo es ilimitada. */
  limit: z.number().int().min(1).max(10_000).nullable().default(null),
  isDefault: z.boolean().default(false),
});

export const MealSchema = z.strictObject({
  id: Id,
  day: Day.default(1),
  moment: z.enum(keys(MEAL_MOMENTS)),
  mode: z.enum(keys(MEAL_MODES)),
  description: Short(300).default(''),
  options: z.array(MealOptionSchema).max(10).default([]),
  picksPerPassenger: z.number().int().min(1).max(5).default(1),
  /** Precio de una comida opcional. */
  priceUsd: Usd.default(0),
});

export const ItemSchema = z.strictObject({
  id: Id,
  type: z.enum(keys(ITEM_TYPES)),
  name: Short(120).default(''),
  modality: z.enum(keys(ITEM_MODALITIES)),
  priceUsd: Usd.default(0),
  /** Forma de pago cuando se paga en el destino. */
  payment: z.enum(keys(DESTINATION_PAYMENTS)).nullable().default(null),
});

export const RoomSchema = z.strictObject({
  id: Id,
  type: z.enum(keys(ROOM_TYPES)),
  occupancy: z.number().int().min(1).max(12).default(2),
  /** Habitaciones disponibles por salida; nulo es sin tope. */
  quantity: z.number().int().min(1).max(1000).nullable().default(null),
  priceDeltaUsd: z.number().min(-1000).max(5000).default(0),
});

/** Abono para reservar: un porcentaje del total (1 a 100) o un monto en USD por puesto. */
const DepositSchema = z
  .strictObject({ kind: z.enum(['percent', 'amount']), value: z.number().min(0.01).max(100_000) })
  .refine((d) => d.kind === 'amount' || (Number.isInteger(d.value) && d.value <= 100), {
    path: ['value'],
    message: 'El porcentaje va de 1 a 100.',
  });

export const ProductSheetSchema = z
  .strictObject({
    general: z
      .strictObject({
        title: Short(120).default(''),
        summary: Short(200).default(''),
        description: Short(5000).default(''),
        category: z.enum(keys(PRODUCT_CATEGORIES)).nullable().default(null),
        destinationId: Id.nullable().default(null),
        photoIds: z.array(Id).max(MAX_PHOTOS).default([]),
        tags: z
          .array(z.enum(keys(PRODUCT_TAGS)))
          .max(10)
          .default([]),
        minAge: z.number().int().min(0).max(99).default(0),
        childrenAllowed: z.boolean().default(true),
        petsAllowed: z.boolean().default(false),
      })
      .prefault({}),
    duration: z
      .strictObject({
        days: Day.default(1),
        nights: z.number().int().min(0).max(29).default(0),
        /** Horas de la experiencia; solo excursiones. */
        hours: z.number().min(1).max(24).nullable().default(null),
      })
      .prefault({}),
    itinerary: z
      .array(
        z.strictObject({
          day: Day.default(1),
          time: Time.nullable().default(null),
          title: Short(120),
          description: Short(1000).default(''),
        }),
      )
      .max(100)
      .default([]),
    transfer: z
      .strictObject({
        vehicle: z.enum(keys(VEHICLES)).nullable().default(null),
        notes: Short(500).default(''),
        boardingPoints: z.array(BoardingSchema).max(20).default([]),
      })
      .prefault({}),
    meals: z.array(MealSchema).max(90).default([]),
    items: z.array(ItemSchema).max(60).default([]),
    /** La agencia declara que no hay entradas ni accesos que pagar. */
    noAccessFees: z.boolean().default(false),
    lodging: z
      .strictObject({
        name: Short(160).default(''),
        regime: z.enum(keys(LODGING_REGIMES)).nullable().default(null),
        rooms: z.array(RoomSchema).max(10).default([]),
      })
      .nullable()
      .default(null),
    whatToBring: z.array(Short(120).min(1)).max(40).default([]),
    pricing: z
      .strictObject({
        fares: z
          .strictObject({
            adult: Usd.default(0),
            child: Usd.nullable().default(null),
            senior: Usd.nullable().default(null),
            infant: Usd.nullable().default(null),
          })
          .prefault({}),
        deposit: DepositSchema.nullable().default(null),
        /** Días antes de la salida en que vence el saldo. */
        balanceDueDaysBefore: z.number().int().min(0).max(60).nullable().default(null),
        cancellation: z
          .strictObject({
            template: z.enum(keys(CANCELLATION_TEMPLATES)).nullable().default(null),
            text: Short(2000).nullable().default(null),
          })
          .prefault({}),
      })
      .prefault({}),
  })
  .superRefine((sheet, ctx) => {
    if (sheet.duration.nights > sheet.duration.days) {
      ctx.addIssue({
        code: 'custom',
        path: ['duration', 'nights'],
        message: 'No puede haber más noches que días.',
      });
    }
    for (const meal of sheet.meals) {
      if (meal.day > sheet.duration.days) {
        ctx.addIssue({
          code: 'custom',
          path: ['meals'],
          message: 'Hay comidas en días que el viaje no tiene.',
        });
        break;
      }
    }
    const ids = [
      ...sheet.transfer.boardingPoints.map((b) => b.id),
      ...sheet.meals.flatMap((m) => [m.id, ...m.options.map((o) => o.id)]),
      ...sheet.items.map((i) => i.id),
      ...(sheet.lodging?.rooms.map((r) => r.id) ?? []),
    ];
    if (new Set(ids).size !== ids.length)
      ctx.addIssue({ code: 'custom', message: 'Hay ids repetidos en la ficha.' });
    if (new Set(sheet.general.photoIds).size !== sheet.general.photoIds.length) {
      ctx.addIssue({
        code: 'custom',
        path: ['general', 'photoIds'],
        message: 'Hay fotos repetidas.',
      });
    }
  });

export type ProductSheet = z.infer<typeof ProductSheetSchema>;
export type ProductSheetInput = z.input<typeof ProductSheetSchema>;

/** Ficha vacía de un tipo, con la duración que le corresponde. */
export function emptySheet(type: ProductType): ProductSheet {
  const duration =
    type === 'tour' ? { days: 2, nights: 1 } : type === 'excursion' ? { hours: 4 } : {};
  return ProductSheetSchema.parse({ duration, lodging: type === 'tour' ? {} : null });
}

// ── Completitud ──────────────────────────────────────────────────────────────

export const SHEET_BLOCKS = {
  general: 'Datos generales',
  itinerary: 'Itinerario',
  transfer: 'Traslado y embarque',
  meals: 'Comidas',
  essentials: 'Hidratación y sombra',
  lodging: 'Alojamiento',
  access: 'Entradas y accesos',
  whatToBring: 'Qué llevar',
  pricing: 'Precios y condiciones',
} as const;
export type SheetBlock = keyof typeof SHEET_BLOCKS;

export interface Completeness {
  percent: number;
  publishable: boolean;
  missing: string[];
  blocks: { block: SheetBlock; label: string; percent: number; missing: string[] }[];
}

/**
 * Qué le falta a la ficha para publicarse, por bloque. Las reglas cambian con el tipo: un
 * tour exige alojamiento y noches; una excursión no exige comidas ni vehículo.
 */
export function completeness(type: ProductType, sheet: ProductSheet): Completeness {
  const checks: Record<SheetBlock, [boolean, string][]> = {
    general: [],
    itinerary: [],
    transfer: [],
    meals: [],
    essentials: [],
    lodging: [],
    access: [],
    whatToBring: [],
    pricing: [],
  };
  const g = sheet.general;
  const d = sheet.duration;
  checks.general.push(
    [g.title.length >= 5, 'un título'],
    [g.summary.length >= 20, 'un resumen de al menos 20 caracteres'],
    [g.description.length >= 80, 'una descripción de al menos 80 caracteres'],
    [g.category !== null, 'la categoría'],
    [g.destinationId !== null, 'el destino'],
    [g.photoIds.length >= MIN_PHOTOS, `al menos ${MIN_PHOTOS} fotos`],
  );
  if (type === 'tour')
    checks.general.push([
      d.days >= 2 && d.nights >= 1,
      'la duración: un tour tiene al menos 2 días y 1 noche',
    ]);
  if (type === 'fullday')
    checks.general.push([d.days === 1 && d.nights === 0, 'la duración: un fullday dura un día']);
  if (type === 'excursion')
    checks.general.push([
      d.days === 1 && d.nights === 0 && d.hours !== null,
      'las horas que dura la excursión',
    ]);

  for (let day = 1; day <= d.days; day++) {
    checks.itinerary.push([
      sheet.itinerary.some((i) => i.day === day),
      d.days > 1 ? `el itinerario del día ${day}` : 'el itinerario',
    ]);
  }

  const t = sheet.transfer;
  const points = t.boardingPoints;
  if (type !== 'excursion')
    checks.transfer.push([t.vehicle !== null && t.vehicle !== 'none', 'el vehículo']);
  checks.transfer.push(
    [
      points.length > 0,
      type === 'excursion' ? 'el punto de encuentro' : 'al menos un punto de embarque',
    ],
    [
      points.every((p) => p.boardingPointId !== null || (p.name.length > 0 && p.city.length > 0)),
      'nombre y ciudad de cada punto',
    ],
    [
      points.every((p) => p.departureTime !== null && p.returnTime !== null),
      'hora de salida y de regreso de cada punto',
    ],
  );

  if (type !== 'excursion') {
    for (let day = 1; day <= d.days; day++) {
      checks.meals.push([
        sheet.meals.some((m) => m.day === day),
        d.days > 1 ? `al menos una comida del día ${day}` : 'al menos una comida',
      ]);
    }
  }
  for (const meal of sheet.meals) {
    const name = `${MEAL_MOMENTS[meal.moment].toLowerCase()} del día ${meal.day}`;
    if (meal.mode === 'fixed')
      checks.meals.push([meal.description.length > 0, `qué se sirve en el ${name}`]);
    if (meal.mode === 'optional')
      checks.meals.push([
        meal.description.length > 0 && meal.priceUsd > 0,
        `qué es y cuánto cuesta el ${name}`,
      ]);
    if (meal.mode === 'choice') {
      checks.meals.push(
        [
          meal.options.length >= 2 && meal.options.every((o) => o.name.length > 0),
          `al menos dos opciones con nombre en el ${name}`,
        ],
        [
          meal.options.filter((o) => o.isDefault).length === 1,
          `una opción por defecto en el ${name}`,
        ],
        [
          meal.picksPerPassenger <= meal.options.length,
          `cuántas opciones escoge cada pasajero en el ${name}`,
        ],
      );
    }
  }

  checks.essentials.push(
    [
      sheet.items.some((i) => i.type === 'hydration'),
      'si hay hidratación (aunque no esté incluida)',
    ],
    [
      sheet.items.some((i) => i.type === 'shade'),
      'si hay toldos o sombra (aunque no estén incluidos)',
    ],
  );

  if (type === 'tour' || d.nights > 0) {
    const l = sheet.lodging;
    checks.lodging.push(
      [!!l && l.name.length > 0, 'el nombre del alojamiento'],
      [!!l && l.regime !== null, 'el régimen del alojamiento'],
      [!!l && l.rooms.length > 0, 'al menos un tipo de habitación'],
    );
  }

  const accesses = sheet.items.filter((i) => i.type === 'access');
  checks.access.push([
    sheet.noAccessFees || accesses.length > 0,
    'las entradas o indicar que no hay',
  ]);
  for (const item of sheet.items.filter(
    (i) => i.modality === 'pay_at_destination' || i.modality === 'optional',
  )) {
    checks.access.push([item.priceUsd > 0, `el precio de «${item.name || ITEM_TYPES[item.type]}»`]);
    if (item.modality === 'pay_at_destination') {
      checks.access.push([
        item.payment !== null,
        `cómo se paga «${item.name || ITEM_TYPES[item.type]}» en el destino`,
      ]);
    }
  }

  checks.whatToBring.push([sheet.whatToBring.length > 0, 'qué llevar']);

  const p = sheet.pricing;
  checks.pricing.push(
    [p.fares.adult > 0, 'el precio de adulto'],
    [p.deposit !== null, 'el abono para reservar'],
    [p.balanceDueDaysBefore !== null, 'cuándo vence el saldo'],
    [
      p.cancellation.template !== null || (p.cancellation.text?.length ?? 0) >= 20,
      'la política de cancelación',
    ],
  );

  const blocks = (Object.keys(checks) as SheetBlock[])
    .filter((block) => checks[block].length > 0)
    .map((block) => {
      const list = checks[block];
      const missing = list.filter(([ok]) => !ok).map(([, what]) => what);
      return {
        block,
        label: SHEET_BLOCKS[block],
        percent: Math.floor(((list.length - missing.length) / list.length) * 100),
        missing,
      };
    });
  const all = Object.values(checks).flat();
  const missing = blocks.flatMap((b) => b.missing);
  return {
    percent: Math.floor(((all.length - missing.length) / all.length) * 100),
    publishable: missing.length === 0,
    missing,
    blocks,
  };
}

// ── Lectura para el viajero ──────────────────────────────────────────────────

export interface Inclusions {
  included: string[];
  optional: string[];
  payAtDestination: string[];
  notIncluded: string[];
}

/** La ficha como la lee el viajero, siempre en cuatro grupos. */
export function inclusions(sheet: ProductSheet): Inclusions {
  const out: Inclusions = { included: [], optional: [], payAtDestination: [], notIncluded: [] };
  const many = sheet.duration.days > 1;
  if (sheet.transfer.vehicle && sheet.transfer.vehicle !== 'none')
    out.included.push(`Traslado en ${VEHICLES[sheet.transfer.vehicle].toLowerCase()}`);
  for (const m of sheet.meals) {
    const label = `${MEAL_MOMENTS[m.moment]}${many ? ` (día ${m.day})` : ''}${m.description ? `: ${m.description}` : ''}`;
    if (m.mode === 'fixed' || m.mode === 'choice') out.included.push(label);
    else if (m.mode === 'optional') out.optional.push(`${label} · ${usd(m.priceUsd)}`);
    else out.notIncluded.push(label);
  }
  for (const i of sheet.items) {
    const label = i.name || ITEM_TYPES[i.type];
    if (i.modality === 'included') out.included.push(label);
    else if (i.modality === 'optional') out.optional.push(`${label} · ${usd(i.priceUsd)}`);
    else if (i.modality === 'pay_at_destination')
      out.payAtDestination.push(
        `${label} · ${usd(i.priceUsd)}${i.payment ? ` (${DESTINATION_PAYMENTS[i.payment].toLowerCase()})` : ''}`,
      );
    else out.notIncluded.push(label);
  }
  if (sheet.lodging && sheet.duration.nights > 0 && sheet.lodging.name) {
    out.included.push(
      `${sheet.duration.nights} ${sheet.duration.nights === 1 ? 'noche' : 'noches'} en ${sheet.lodging.name}`,
    );
  }
  return out;
}

/** Lo que cada pasajero lleva en efectivo o paga en el destino, en USD. Nunca se suma al total. */
export function cashAtDestination(sheet: ProductSheet): { totalUsd: number; concepts: string[] } {
  const items = sheet.items.filter((i) => i.modality === 'pay_at_destination');
  return {
    totalUsd: Math.round(items.reduce((sum, i) => sum + i.priceUsd, 0) * 100) / 100,
    concepts: items.map((i) => i.name || ITEM_TYPES[i.type]),
  };
}

const usd = (value: number) => `${value.toFixed(2).replace(/\.00$/, '')} USD`;

// ── Datos de contacto ────────────────────────────────────────────────────────

const UUID_START = /^[0-9a-f]{8}-[0-9a-f]{4}-/i;
const VE_PHONE =
  /(?:\+?58[\s.-]*|\b0)4(?:12|14|16|22|24|26)[\s.-]*\d{3}[\s.-]*\d{2}[\s.-]*\d{2}\b/g;
const WHATSAPP = /(?:https?:\/\/)?(?:wa\.me|api\.whatsapp\.com|chat\.whatsapp\.com)\/[^\s]*/gi;

/**
 * Teléfonos venezolanos y enlaces de WhatsApp escritos en cualquier texto del valor. Una ficha
 * con contactos pasa por revisión: las reservas deben quedarse dentro de la plataforma.
 */
export function contactInfo(value: unknown): string[] {
  const found = new Set<string>();
  const visit = (v: unknown) => {
    if (typeof v === 'string') {
      if (UUID_START.test(v)) return;
      for (const m of v.matchAll(WHATSAPP)) found.add(m[0]);
      for (const m of v.replace(WHATSAPP, ' ').matchAll(VE_PHONE)) found.add(m[0].trim());
    } else if (Array.isArray(v)) v.forEach(visit);
    else if (v && typeof v === 'object') Object.values(v).forEach(visit);
  };
  visit(value);
  return [...found];
}
