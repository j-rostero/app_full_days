import { z } from 'zod';
import { PRODUCT_CATEGORIES, PRODUCT_TYPES } from './product.ts';

export const SEARCH_ORDERS = {
  recomendados: 'Recomendados',
  fecha: 'Fecha más cercana',
  precio: 'Menor precio',
  cupos: 'Más puestos libres',
} as const;
export type SearchOrder = keyof typeof SEARCH_ORDERS;

export const SEARCH_PAGE_SIZE = 20;

const Text = z.string().trim().max(80);
const Day = z.string().regex(/^\d{4}-\d{2}-\d{2}$/, 'Escribe la fecha como AAAA-MM-DD.');
const Flag = z.enum(['true', 'false']).transform((v) => v === 'true');

/** Filtros de la búsqueda pública; todos llegan como texto en la URL. */
export const SearchQuerySchema = z.strictObject({
  q: Text.optional(),
  destino: Text.optional(),
  desde: Text.optional(),
  fechaDesde: Day.optional(),
  fechaHasta: Day.optional(),
  tipo: z.enum(PRODUCT_TYPES).optional(),
  categoria: z
    .enum(Object.keys(PRODUCT_CATEGORIES) as [keyof typeof PRODUCT_CATEGORIES])
    .optional(),
  tematica: Text.optional(),
  precioMax: z.coerce.number().min(0).max(100_000).optional(),
  incluye: Text.optional(),
  verificados: Flag.optional(),
  ninos: Flag.optional(),
  mascotas: Flag.optional(),
  orden: z.enum(Object.keys(SEARCH_ORDERS) as [SearchOrder]).default('recomendados'),
  pagina: z.coerce.number().int().min(1).max(500).default(1),
});
export type SearchQuery = z.infer<typeof SearchQuerySchema>;
