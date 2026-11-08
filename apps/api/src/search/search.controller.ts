import { Controller, Delete, Get, HttpCode, Inject, Param, Put, Query } from '@nestjs/common';
import type { Departure, PrismaClient, Provider } from '@fulldays/db';
import {
  cashAtDestination,
  inclusions,
  type ProductSheet,
  providerBadge,
  seatsLeft,
  todayInVenezuela,
} from '@fulldays/shared';
import type { z } from 'zod';
import { notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint, Public } from '../common/endpoint.ts';
import { Auth, type AuthContext } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { FilesService } from '../files/files.service.ts';
import {
  AvailabilitySchema,
  FavoriteListSchema,
  PublicAgencySchema,
  PublicProductSchema,
  SearchQuery,
  SearchResultSchema,
} from './search.schemas.ts';
import { SearchService } from './search.service.ts';

const TAG = ['catalogo'];
const VISIBLE = ['open', 'closed'] as const;

const day = (d: Date) => d.toISOString().slice(0, 10);
const fromToday = () => new Date(`${todayInVenezuela()}T00:00:00Z`);
const publicProvider = (p: Provider) => ({
  id: p.id,
  name: p.name,
  baseCity: p.baseCity,
  badge: providerBadge(p),
});
const dateView = (d: Departure) => ({
  id: d.id,
  date: day(d.date),
  status: d.status,
  priceUsd: Number(d.priceUsd),
  seatsLeft: seatsLeft(d),
});

/** Catálogo público: búsqueda, ficha, agencia, disponibilidad y favoritos. */
@Controller()
export class SearchController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(SearchService) private readonly search: SearchService,
    @Inject(FilesService) private readonly files: FilesService,
  ) {}

  @Get('salidas')
  @Public()
  @Endpoint({
    operationId: 'searchDepartures',
    summary: 'Busca salidas visibles con filtros y orden; páginas de 20',
    tags: TAG,
    query: SearchQuery,
    responses: { 200: SearchResultSchema },
  })
  find(@Query(new ZodPipe(SearchQuery)) query: z.infer<typeof SearchQuery>) {
    return this.search.search(query);
  }

  @Get('salidas/:id')
  @Public()
  @Endpoint({
    operationId: 'getAvailability',
    summary:
      'Disponibilidad de una salida visible: precio, puestos y habitaciones libres, y la ficha que se vende',
    tags: TAG,
    responses: { 200: AvailabilitySchema },
  })
  async availability(@Param('id') id: string): Promise<z.infer<typeof AvailabilitySchema>> {
    if (!isUuid(id)) throw notFound();
    const d = await this.db.departure.findFirst({
      where: {
        id,
        status: { in: [...VISIBLE] },
        date: { gte: fromToday() },
        product: { status: 'published' },
        provider: { status: 'approved' },
      },
      include: { provider: true, quotas: true },
    });
    if (!d) throw notFound('Esa salida ya no está disponible.');
    const sheet = d.sheet as unknown as ProductSheet;
    const roomsLeft: Record<string, number> = {};
    for (const room of sheet.lodging?.rooms ?? []) {
      if (room.quantity === null) continue;
      const taken = d.quotas.find((q) => q.key === `room:${room.id}`)?.taken ?? 0;
      roomsLeft[room.id] = Math.max(room.quantity - taken, 0);
    }
    return {
      departure: {
        ...dateView(d),
        productId: d.productId,
        adultPriceUsd: d.adultPriceUsd === null ? null : Number(d.adultPriceUsd),
      },
      type: d.productType,
      title: sheet.general.title,
      sheet,
      provider: publicProvider(d.provider),
      roomsLeft,
    };
  }

  @Get('productos/:id')
  @Public()
  @Endpoint({
    operationId: 'getPublicProduct',
    summary: 'Ficha publicada con fotos, agencia, destino y próximas fechas (hasta 60)',
    tags: TAG,
    responses: { 200: PublicProductSchema },
  })
  async product(@Param('id') id: string): Promise<z.infer<typeof PublicProductSchema>> {
    if (!isUuid(id)) throw notFound();
    const p = await this.db.product.findFirst({
      where: { id, status: 'published', provider: { status: 'approved' } },
      include: {
        provider: true,
        themes: { include: { theme: true } },
        departures: {
          where: { status: { in: [...VISIBLE] }, date: { gte: fromToday() } },
          orderBy: { date: 'asc' },
          take: 60,
        },
      },
    });
    if (!p) throw notFound('Ese viaje no está publicado.');
    const sheet = p.sheet as unknown as ProductSheet;
    const destination = sheet.general.destinationId
      ? await this.db.destination.findUnique({ where: { id: sheet.general.destinationId } })
      : null;
    return {
      id: p.id,
      type: p.type,
      sheet,
      photos: await this.files.images(sheet.general.photoIds),
      featured: p.featured,
      themes: p.themes.map((t) => ({ slug: t.theme.slug, name: t.theme.name })),
      destination: destination
        ? { id: destination.id, slug: destination.slug, name: destination.name }
        : null,
      cashAtDestination: cashAtDestination(sheet),
      inclusions: inclusions(sheet),
      provider: { ...publicProvider(p.provider), instagram: p.provider.instagram },
      departures: p.departures.map(dateView),
    };
  }

  @Get('agencias/:id')
  @Public()
  @Endpoint({
    operationId: 'getPublicAgency',
    summary: 'Agencia aprobada y sus viajes publicados; sin datos legales ni de contacto',
    tags: TAG,
    responses: { 200: PublicAgencySchema },
  })
  async agency(@Param('id') id: string): Promise<z.infer<typeof PublicAgencySchema>> {
    if (!isUuid(id)) throw notFound();
    const provider = await this.db.provider.findFirst({ where: { id, status: 'approved' } });
    if (!provider) throw notFound('Esa agencia no existe.');
    return {
      provider: { ...publicProvider(provider), instagram: provider.instagram },
      products: await this.search.productCards({ providerId: id }),
    };
  }

  @Get('yo/favoritos')
  @Endpoint({
    operationId: 'listFavorites',
    summary: 'Viajes guardados que siguen publicados',
    tags: TAG,
    responses: { 200: FavoriteListSchema },
  })
  async favorites(@Auth() auth: AuthContext) {
    return {
      items: await this.search.productCards({ favorites: { some: { userId: auth.userId } } }),
    };
  }

  @Put('yo/favoritos/:productId')
  @HttpCode(204)
  @Endpoint({
    operationId: 'addFavorite',
    summary: 'Guarda un viaje publicado (idempotente)',
    tags: TAG,
    responses: { 204: null },
  })
  async addFavorite(
    @Auth() auth: AuthContext,
    @Param('productId') productId: string,
  ): Promise<void> {
    if (!isUuid(productId)) throw notFound();
    const visible = await this.db.product.count({
      where: { id: productId, status: 'published', provider: { status: 'approved' } },
    });
    if (!visible) throw notFound('Ese viaje no está publicado.');
    await this.db.favorite.upsert({
      where: { userId_productId: { userId: auth.userId, productId } },
      create: { userId: auth.userId, productId },
      update: {},
    });
  }

  @Delete('yo/favoritos/:productId')
  @HttpCode(204)
  @Endpoint({
    operationId: 'removeFavorite',
    summary: 'Quita un viaje de los guardados',
    tags: TAG,
    responses: { 204: null },
  })
  async removeFavorite(
    @Auth() auth: AuthContext,
    @Param('productId') productId: string,
  ): Promise<void> {
    if (!isUuid(productId)) throw notFound();
    await this.db.favorite.deleteMany({ where: { userId: auth.userId, productId } });
  }
}
