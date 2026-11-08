import { Inject, Injectable } from '@nestjs/common';
import type { PrismaClient, Product, Provider } from '@fulldays/db';
import {
  cashAtDestination,
  completeness,
  contactInfo,
  type ProductSheet,
  ProductSheetSchema,
  emptySheet,
} from '@fulldays/shared';
import { ApiException } from '../common/api-exception.ts';
import { DB } from '../common/tokens.ts';
import { departureFacets } from '../departures/facets.ts';
import { FilesService } from '../files/files.service.ts';
import type { ProductDetail, ProductSummary } from './products.schemas.ts';

/** Lee la ficha guardada; una ficha antigua que ya no valida se trata como vacía en lo que falle. */
export function sheetOf(product: Pick<Product, 'type' | 'sheet'>): ProductSheet {
  const parsed = ProductSheetSchema.safeParse(product.sheet);
  return parsed.success ? parsed.data : emptySheet(product.type);
}

@Injectable()
export class ProductsService {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(FilesService) private readonly files: FilesService,
  ) {}

  async detail(product: Product): Promise<ProductDetail> {
    const sheet = sheetOf(product);
    return {
      id: product.id,
      providerId: product.providerId,
      type: product.type,
      status: product.status,
      statusReason: product.statusReason,
      version: product.version,
      sheet,
      completeness: completeness(product.type, sheet),
      cashAtDestinationUsd: cashAtDestination(sheet).totalUsd,
      photos: await this.files.images(sheet.general.photoIds),
      updatedAt: product.updatedAt.toISOString(),
    };
  }

  async summaries(products: Product[]): Promise<ProductSummary[]> {
    const covers = await this.files.images(
      products.map((p) => sheetOf(p).general.photoIds[0]).filter((id): id is string => !!id),
    );
    const coverOf = new Map(covers.map((c) => [c.id, c.urls]));
    return products.map((p) => {
      const sheet = sheetOf(p);
      return {
        id: p.id,
        type: p.type,
        status: p.status,
        statusReason: p.statusReason,
        title: sheet.general.title || 'Sin título',
        percent: completeness(p.type, sheet).percent,
        cover: coverOf.get(sheet.general.photoIds[0] ?? '') ?? null,
        updatedAt: p.updatedAt.toISOString(),
      };
    });
  }

  /** Las referencias de la ficha existen: el destino, y fotos listas subidas por el equipo de la agencia. */
  async checkReferences(providerId: string, sheet: ProductSheet): Promise<void> {
    const issues: { path: string[]; message: string }[] = [];
    if (
      sheet.general.destinationId &&
      !(await this.db.destination.findUnique({ where: { id: sheet.general.destinationId } }))
    ) {
      issues.push({
        path: ['sheet', 'general', 'destinationId'],
        message: 'Ese destino no existe.',
      });
    }
    const pointIds = sheet.transfer.boardingPoints.flatMap((b) =>
      b.boardingPointId ? [b.boardingPointId] : [],
    );
    if (
      pointIds.length &&
      (await this.db.boardingPoint.count({ where: { id: { in: [...new Set(pointIds)] } } })) !==
        new Set(pointIds).size
    ) {
      issues.push({
        path: ['sheet', 'transfer', 'boardingPoints'],
        message: 'Hay puntos de embarque que no existen.',
      });
    }
    if (issues.length)
      throw new ApiException(400, 'validation_error', 'Revisa los datos.', { issues });
    const team = await this.db.providerMember.findMany({
      where: { providerId },
      select: { userId: true },
    });
    await this.files.requireReady(
      sheet.general.photoIds,
      'image',
      team.map((m) => m.userId),
      ['sheet', 'general', 'photoIds'],
    );
  }

  /** ¿Pasa por Central antes de publicarse? Sin RTN, devuelto antes o con datos de contacto. */
  needsReview(provider: Provider, product: Product, sheet: ProductSheet): boolean {
    return provider.rtn === null || product.statusReason !== null || contactInfo(sheet).length > 0;
  }

  /**
   * Las salidas que nadie ha reservado se venden con la ficha nueva. Las que ya tienen
   * reservas conservan la ficha con que se vendieron.
   */
  async refreshUnsoldDepartures(
    product: Product,
    sheet: ProductSheet,
    provider: Provider,
  ): Promise<void> {
    const unsold = await this.db.departure.findMany({
      where: { productId: product.id, reserved: 0, status: { in: ['open', 'paused', 'closed'] } },
    });
    for (const departure of unsold) {
      const facets = await departureFacets(
        this.db,
        product.type,
        sheet,
        { providerName: provider.name, providerCity: provider.baseCity },
        departure.adultPriceUsd === null ? null : Number(departure.adultPriceUsd),
      );
      await this.db.departure.update({ where: { id: departure.id }, data: { sheet, ...facets } });
    }
  }
}
