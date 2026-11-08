import { Body, Controller, Get, HttpCode, Inject, Param, Post, Put, Query } from '@nestjs/common';
import type { PrismaClient, ProductStatus } from '@fulldays/db';
import { contactInfo, PRODUCT_STATUS_LABELS } from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { ApiException, conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Trail, type AuditTrail } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { ReasonInput } from '../providers/providers.schemas.ts';
import {
  CurationInput,
  type ProductDetail,
  ProductDetailSchema,
  ProductQueueQuery,
  ProductQueueSchema,
  ProductReviewSchema,
} from './products.schemas.ts';
import { ProductsService, sheetOf } from './products.service.ts';

const TAG = ['central'];

/** Revisión de fichas en Central y curación de portada. */
@Controller('central/productos')
export class ReviewController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(ProductsService) private readonly products: ProductsService,
  ) {}

  @Get()
  @Can('fulldays')
  @Endpoint({
    operationId: 'listProductQueue',
    summary: 'Productos por estado, el cambio más antiguo primero (máximo 200)',
    tags: TAG,
    query: ProductQueueQuery,
    responses: { 200: ProductQueueSchema },
  })
  async queue(@Query(new ZodPipe(ProductQueueQuery)) query: z.infer<typeof ProductQueueQuery>) {
    const rows = await this.db.product.findMany({
      where: { status: query.status },
      include: { provider: { select: { name: true } } },
      orderBy: { statusAt: 'asc' },
      take: 200,
    });
    return {
      items: rows.map((p) => ({
        id: p.id,
        type: p.type,
        status: p.status,
        title: sheetOf(p).general.title || 'Sin título',
        providerId: p.providerId,
        providerName: p.provider.name,
        statusAt: p.statusAt.toISOString(),
      })),
    };
  }

  @Get(':id')
  @Can('fulldays')
  @Endpoint({
    operationId: 'getProductReview',
    summary: 'Ficha con agencia, contactos detectados, destacado y temáticas',
    tags: TAG,
    responses: { 200: ProductReviewSchema },
  })
  async detail(@Param('id') id: string) {
    const product = await this.find(id);
    const [provider, themes] = await Promise.all([
      this.db.provider.findUniqueOrThrow({ where: { id: product.providerId } }),
      this.db.productTheme.findMany({ where: { productId: id } }),
    ]);
    return {
      product: await this.products.detail(product),
      providerName: provider.name,
      providerHasRtn: provider.rtn !== null,
      contacts: contactInfo(sheetOf(product)),
      featured: product.featured,
      themeIds: themes.map((t) => t.themeId),
    };
  }

  @Post(':id/aprobar')
  @HttpCode(200)
  @Can('fulldays')
  @Endpoint({
    operationId: 'approveProduct',
    summary: 'Publica un producto en revisión',
    tags: TAG,
    responses: { 200: ProductDetailSchema },
  })
  approve(@Param('id') id: string, @Trail() trail: AuditTrail): Promise<ProductDetail> {
    return this.move(id, 'in_review', 'published', null, trail);
  }

  @Post(':id/devolver')
  @HttpCode(200)
  @Can('fulldays')
  @Endpoint({
    operationId: 'returnProduct',
    summary: 'Devuelve a borrador un producto en revisión, con motivo',
    tags: TAG,
    body: ReasonInput,
    responses: { 200: ProductDetailSchema },
  })
  return(
    @Param('id') id: string,
    @Body(new ZodPipe(ReasonInput)) input: z.infer<typeof ReasonInput>,
    @Trail() trail: AuditTrail,
  ) {
    return this.move(id, 'in_review', 'draft', input.reason, trail);
  }

  @Post(':id/despublicar')
  @HttpCode(200)
  @Can('fulldays')
  @Endpoint({
    operationId: 'unpublishProduct',
    summary: 'Pausa un producto publicado por contenido engañoso, con motivo',
    tags: TAG,
    body: ReasonInput,
    responses: { 200: ProductDetailSchema },
  })
  unpublish(
    @Param('id') id: string,
    @Body(new ZodPipe(ReasonInput)) input: z.infer<typeof ReasonInput>,
    @Trail() trail: AuditTrail,
  ) {
    return this.move(id, 'published', 'paused', input.reason, trail);
  }

  @Put(':id/portada')
  @Can('themes')
  @Endpoint({
    operationId: 'curateProduct',
    summary: 'Fija si es destacado y la lista completa de sus temáticas',
    tags: TAG,
    body: CurationInput,
    responses: { 200: ProductReviewSchema },
  })
  async curate(
    @Param('id') id: string,
    @Body(new ZodPipe(CurationInput)) input: z.infer<typeof CurationInput>,
    @Trail() trail: AuditTrail,
  ) {
    const product = await this.find(id);
    const themeIds = [...new Set(input.themeIds)];
    if ((await this.db.theme.count({ where: { id: { in: themeIds } } })) !== themeIds.length) {
      throw new ApiException(400, 'validation_error', 'Revisa los datos.', {
        issues: [{ path: ['themeIds'], message: 'Hay temáticas que no existen.' }],
      });
    }
    trail.before = {
      featured: product.featured,
      themeIds: (await this.db.productTheme.findMany({ where: { productId: id } })).map(
        (t) => t.themeId,
      ),
    };
    await this.db.product.update({ where: { id }, data: { featured: input.featured } });
    await this.db.productTheme.deleteMany({ where: { productId: id } });
    await this.db.productTheme.createMany({
      data: themeIds.map((themeId) => ({ productId: id, themeId })),
    });
    return this.detail(id);
  }

  /** Cambio condicionado al estado de origen: dos decisiones simultáneas no se pisan. */
  private async move(
    id: string,
    from: ProductStatus,
    to: ProductStatus,
    reason: string | null,
    trail: AuditTrail,
  ): Promise<ProductDetail> {
    const before = await this.find(id);
    trail.before = { status: before.status, statusReason: before.statusReason };
    const { count } = await this.db.product.updateMany({
      where: { id, status: from },
      // Aprobar limpia el motivo: las próximas publicaciones ya no pasan por revisión por eso.
      data: { status: to, statusReason: reason, statusAt: new Date() },
    });
    if (count === 0)
      throw conflict(`No se puede: el producto está «${PRODUCT_STATUS_LABELS[before.status]}».`);
    return this.products.detail(await this.find(id));
  }

  private async find(id: string) {
    if (!isUuid(id)) throw notFound();
    const product = await this.db.product.findUnique({ where: { id } });
    if (!product) throw notFound();
    return product;
  }
}
