import type { PrismaClient, Prisma } from '@fulldays/db';
import type { ProductSheet, ProductType } from '@fulldays/shared';

/** Minúsculas y sin acentos: así «Mérida» y «merida» se encuentran. */
export function normalize(text: string): string {
  return text
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()
    .replace(/\s+/g, ' ')
    .trim();
}

/** Lo que incluye una ficha, como claves fijas para filtrar. */
export function includesOf(sheet: ProductSheet): string[] {
  const out = new Set<string>();
  if (sheet.transfer.vehicle && sheet.transfer.vehicle !== 'none') out.add('transfer');
  if (sheet.meals.some((m) => m.mode === 'fixed' || m.mode === 'choice')) out.add('meals');
  for (const item of sheet.items) if (item.modality === 'included') out.add(item.type);
  if (sheet.lodging && sheet.duration.nights > 0 && sheet.lodging.name) out.add('lodging');
  return [...out].sort();
}

export interface FacetContext {
  providerName: string;
  providerCity: string;
}

/**
 * Columnas de búsqueda de una salida, derivadas de la ficha con que se vende. Se recalculan
 * al programarla y cada vez que la ficha cambia mientras nadie la ha reservado.
 */
export async function departureFacets(
  db: PrismaClient,
  type: ProductType,
  sheet: ProductSheet,
  context: FacetContext,
  adultPriceUsd: number | null,
): Promise<
  Pick<
    Prisma.DepartureUncheckedCreateInput,
    | 'productType'
    | 'category'
    | 'destinationId'
    | 'priceUsd'
    | 'cities'
    | 'includes'
    | 'tags'
    | 'searchText'
  >
> {
  const pointIds = sheet.transfer.boardingPoints
    .map((b) => b.boardingPointId)
    .filter((id): id is string => id !== null);
  const [points, destination] = await Promise.all([
    pointIds.length ? db.boardingPoint.findMany({ where: { id: { in: pointIds } } }) : [],
    sheet.general.destinationId
      ? db.destination.findUnique({
          where: { id: sheet.general.destinationId },
          include: { parent: true },
        })
      : null,
  ]);
  const cityOf = new Map(points.map((p) => [p.id, p.city]));
  const cities = new Set(
    sheet.transfer.boardingPoints
      .map(
        (b) => (b.boardingPointId ? cityOf.get(b.boardingPointId) : b.city) || context.providerCity,
      )
      .map(normalize)
      .filter(Boolean),
  );
  const text = [
    sheet.general.title,
    sheet.general.summary,
    destination?.name,
    destination?.parent?.name,
    destination?.state,
    context.providerName,
    ...cities,
  ]
    .filter(Boolean)
    .join(' ');
  return {
    productType: type,
    category: sheet.general.category,
    destinationId: sheet.general.destinationId,
    priceUsd: adultPriceUsd ?? sheet.pricing.fares.adult,
    cities: [...cities].sort(),
    includes: includesOf(sheet),
    tags: [...sheet.general.tags].sort(),
    searchText: normalize(text),
  };
}
