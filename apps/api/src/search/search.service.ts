import { Inject, Injectable, Logger } from '@nestjs/common';
import { Prisma, type PrismaClient } from '@fulldays/db';
import {
  type ProductSheet,
  providerBadge,
  SEARCH_PAGE_SIZE,
  type SearchQuery,
  seatsLeft,
  todayInVenezuela,
} from '@fulldays/shared';
import { normalize } from '../departures/facets.ts';
import { FilesService } from '../files/files.service.ts';
import { DB } from '../common/tokens.ts';
import type { DepartureCard, PublicProductCard } from './search.schemas.ts';

/** Similitud mínima de `word_similarity` para que un texto cuente como coincidencia. */
const MIN_SIMILARITY = 0.45;
const VISIBLE_STATUSES = ['open', 'closed'];

interface CardRow {
  id: string;
  product_id: string;
  date: Date;
  status: string;
  product_type: DepartureCard['type'];
  price_usd: Prisma.Decimal;
  capacity: number;
  reserved: number;
  cities: string[];
  sheet: ProductSheet;
  featured: boolean;
  provider_id: string;
  provider_name: string;
  provider_city: string;
  provider_status: 'approved';
  provider_rtn: string | null;
  destination_name: string | null;
}

/**
 * Lo que ve cualquiera: salidas `open` o `closed` desde hoy, de productos publicados de
 * agencias aprobadas.
 */
@Injectable()
export class SearchService {
  private readonly log = new Logger(SearchService.name);

  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(FilesService) private readonly files: FilesService,
  ) {}

  /** Condición SQL de salida visible sobre los alias `d`, `p` y `v`. */
  static visible(today = todayInVenezuela()): Prisma.Sql {
    return Prisma.sql`d.status::text IN (${Prisma.join(VISIBLE_STATUSES)})
      AND d.date >= ${today}::date AND p.status = 'published' AND v.status = 'approved'`;
  }

  async search(
    q: SearchQuery,
  ): Promise<{ items: DepartureCard[]; page: number; hasMore: boolean }> {
    const where: Prisma.Sql[] = [SearchService.visible()];
    const text = q.q ? normalize(q.q) : '';
    if (text)
      where.push(
        Prisma.sql`(d.search_text LIKE ${`%${text}%`} OR word_similarity(${text}, d.search_text) >= ${MIN_SIMILARITY})`,
      );
    if (q.destino)
      where.push(Prisma.sql`d.destination_id IN (
        SELECT id FROM destinations WHERE slug = ${q.destino}
        UNION SELECT c.id FROM destinations c JOIN destinations r ON c.parent_id = r.id WHERE r.slug = ${q.destino})`);
    if (q.desde) where.push(Prisma.sql`${normalize(q.desde)} = ANY(d.cities)`);
    if (q.fechaDesde) where.push(Prisma.sql`d.date >= ${q.fechaDesde}::date`);
    if (q.fechaHasta) where.push(Prisma.sql`d.date <= ${q.fechaHasta}::date`);
    if (q.tipo) where.push(Prisma.sql`d.product_type::text = ${q.tipo}`);
    if (q.categoria) where.push(Prisma.sql`d.category = ${q.categoria}`);
    if (q.tematica)
      where.push(Prisma.sql`d.product_id IN (
        SELECT pt.product_id FROM product_themes pt JOIN themes t ON t.id = pt.theme_id WHERE t.slug = ${q.tematica})`);
    if (q.precioMax !== undefined) where.push(Prisma.sql`d.price_usd <= ${q.precioMax}`);
    const includes = (q.incluye ?? '')
      .split(',')
      .map((s) => s.trim())
      .filter(Boolean);
    if (includes.length) where.push(Prisma.sql`d.includes @> ${includes}::text[]`);
    if (q.verificados) where.push(Prisma.sql`v.rtn IS NOT NULL`);
    if (q.ninos) where.push(Prisma.sql`(d.sheet->'general'->>'childrenAllowed')::boolean`);
    if (q.mascotas) where.push(Prisma.sql`(d.sheet->'general'->>'petsAllowed')::boolean`);

    const order = {
      recomendados: Prisma.sql`p.featured DESC, d.date ASC, d.price_usd ASC`,
      fecha: Prisma.sql`d.date ASC, d.price_usd ASC`,
      precio: Prisma.sql`d.price_usd ASC, d.date ASC`,
      cupos: Prisma.sql`(d.capacity - d.reserved) DESC, d.date ASC`,
    }[q.orden];
    const offset = (q.pagina - 1) * SEARCH_PAGE_SIZE;
    const rows = await this.db.$queryRaw<CardRow[]>`
      SELECT d.id, d.product_id, d.date, d.status::text AS status, d.product_type, d.price_usd,
             d.capacity, d.reserved, d.cities, d.sheet, p.featured,
             v.id AS provider_id, v.name AS provider_name, v.base_city AS provider_city,
             v.status::text AS provider_status, v.rtn AS provider_rtn, dest.name AS destination_name
      FROM departures d
      JOIN products p ON p.id = d.product_id
      JOIN providers v ON v.id = d.provider_id
      LEFT JOIN destinations dest ON dest.id = d.destination_id
      WHERE ${Prisma.join(where, ' AND ')}
      ORDER BY ${order}, d.id
      LIMIT ${SEARCH_PAGE_SIZE + 1} OFFSET ${offset}`;
    const hasMore = rows.length > SEARCH_PAGE_SIZE;
    const items = await this.cards(rows.slice(0, SEARCH_PAGE_SIZE));
    if (q.pagina === 1) void this.logSearch(q, items.length);
    return { items, page: q.pagina, hasMore };
  }

  private async cards(rows: CardRow[]): Promise<DepartureCard[]> {
    const covers = await this.files.images(
      rows.map((r) => r.sheet.general.photoIds[0]).filter((id): id is string => Boolean(id)),
    );
    const coverOf = new Map(covers.map((c) => [c.id, c.urls]));
    return rows.map((r) => ({
      departureId: r.id,
      productId: r.product_id,
      date: r.date.toISOString().slice(0, 10),
      status: r.status as DepartureCard['status'],
      type: r.product_type,
      title: r.sheet.general.title,
      summary: r.sheet.general.summary,
      cover: coverOf.get(r.sheet.general.photoIds[0] ?? '') ?? null,
      priceUsd: Number(r.price_usd),
      seatsLeft: seatsLeft(r),
      days: r.sheet.duration.days,
      destination: r.destination_name,
      cities: r.cities,
      featured: r.featured,
      provider: {
        id: r.provider_id,
        name: r.provider_name,
        baseCity: r.provider_city,
        badge: providerBadge({ status: 'approved', rtn: r.provider_rtn }),
      },
    }));
  }

  /** Las métricas de búsqueda nunca hacen fallar una búsqueda. */
  private async logSearch(q: SearchQuery, results: number): Promise<void> {
    try {
      const { q: text, pagina: _page, ...filters } = q;
      await this.db.searchLog.create({ data: { text: text ?? null, filters, results } });
    } catch (error) {
      this.log.warn(`No se pudo registrar la búsqueda: ${(error as Error).message}`);
    }
  }

  /** Tarjetas de productos publicados de agencias aprobadas, con su próxima fecha en venta. */
  async productCards(where: Prisma.ProductWhereInput): Promise<PublicProductCard[]> {
    const products = await this.db.product.findMany({
      where: { ...where, status: 'published', provider: { status: 'approved' } },
      include: {
        departures: {
          where: { status: 'open', date: { gte: new Date(`${todayInVenezuela()}T00:00:00Z`) } },
          orderBy: { date: 'asc' },
          take: 1,
        },
      },
      orderBy: [{ featured: 'desc' }, { statusAt: 'desc' }],
      take: 100,
    });
    const sheets = products.map((p) => p.sheet as unknown as ProductSheet);
    const covers = await this.files.images(
      sheets.map((s) => s.general.photoIds[0]).filter((id): id is string => Boolean(id)),
    );
    const coverOf = new Map(covers.map((c) => [c.id, c.urls]));
    return products.map((p, i) => {
      const sheet = sheets[i]!;
      const next = p.departures[0];
      return {
        id: p.id,
        type: p.type,
        title: sheet.general.title,
        summary: sheet.general.summary,
        cover: coverOf.get(sheet.general.photoIds[0] ?? '') ?? null,
        priceUsd: next ? Number(next.priceUsd) : sheet.pricing.fares.adult,
        nextDate: next ? next.date.toISOString().slice(0, 10) : null,
      };
    });
  }
}
