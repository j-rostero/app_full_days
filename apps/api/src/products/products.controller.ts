import { Body, Controller, Get, HttpCode, Inject, Param, Post, Put } from '@nestjs/common';
import type { PrismaClient, Product, Provider } from '@fulldays/db';
import { completeness, contactInfo, emptySheet } from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { ScopedDb } from '../access/scoped-db.ts';
import { conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Membership, type MembershipContext, Trail, type AuditTrail } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import {
  CreateProductInput,
  type ProductDetail,
  ProductDetailSchema,
  ProductListSchema,
  type ProductSummary,
  SaveProductInput,
} from './products.schemas.ts';
import { ProductsService, sheetOf } from './products.service.ts';

const TAG = ['productos'];

/** Fichas de la agencia: borrador, guardado con control de versión, publicación y pausa. */
@Controller('pro/:providerId/productos')
export class ProductsController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(ProductsService) private readonly products: ProductsService,
  ) {}

  @Get()
  @Can('fulldays')
  @Endpoint({
    operationId: 'listProducts',
    summary: 'Productos de la agencia, el último cambiado primero',
    tags: TAG,
    responses: { 200: ProductListSchema },
  })
  async list(@ScopedDb() db: PrismaClient): Promise<{ items: ProductSummary[] }> {
    const rows = await db.product.findMany({ orderBy: { updatedAt: 'desc' }, take: 500 });
    return { items: await this.products.summaries(rows) };
  }

  @Post()
  @HttpCode(201)
  @Can('fulldays')
  @Endpoint({
    operationId: 'createProduct',
    summary: 'Crea un borrador de fullday, tour o excursión',
    tags: TAG,
    body: CreateProductInput,
    responses: { 201: ProductDetailSchema },
  })
  async create(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Body(new ZodPipe(CreateProductInput)) input: z.infer<typeof CreateProductInput>,
  ): Promise<ProductDetail> {
    const sheet = input.sheet ?? emptySheet(input.type);
    await this.products.checkReferences(m.providerId, sheet);
    const row = await db.product.create({ data: { type: input.type, sheet } as never });
    return this.products.detail(row);
  }

  @Get(':productId')
  @Can('fulldays')
  @Endpoint({
    operationId: 'getProduct',
    summary: 'Ficha con completitud por bloque y fotos',
    tags: TAG,
    responses: { 200: ProductDetailSchema },
  })
  async get(
    @ScopedDb() db: PrismaClient,
    @Param('productId') productId: string,
  ): Promise<ProductDetail> {
    return this.products.detail(await this.find(db, productId));
  }

  @Put(':productId')
  @Can('fulldays')
  @Endpoint({
    operationId: 'saveProduct',
    summary: 'Guarda la ficha entera; falla si otra pestaña la cambió desde la versión leída',
    tags: TAG,
    body: SaveProductInput,
    responses: { 200: ProductDetailSchema },
  })
  async save(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Param('productId') productId: string,
    @Body(new ZodPipe(SaveProductInput)) input: z.infer<typeof SaveProductInput>,
    @Trail() trail: AuditTrail,
  ): Promise<ProductDetail> {
    const product = await this.find(db, productId);
    trail.before = { version: product.version, status: product.status };
    if (product.status === 'in_review')
      throw conflict('Está en revisión de Central: espera su respuesta para cambiarlo.');
    await this.products.checkReferences(m.providerId, input.sheet);
    if (product.status === 'published') {
      if (!completeness(product.type, input.sheet).publishable) {
        throw conflict(
          'Un producto publicado debe seguir completo. Pausa la venta para hacer este cambio.',
        );
      }
      if (contactInfo(input.sheet).length) {
        throw conflict(
          'La ficha no puede llevar teléfonos ni enlaces de WhatsApp: las reservas se hacen en FullDays.',
        );
      }
    }
    const { count } = await db.product.updateMany({
      where: { id: product.id, version: input.version },
      data: { sheet: input.sheet, version: { increment: 1 } },
    });
    if (count === 0)
      throw conflict(
        'Este producto cambió en otra pestaña o dispositivo. Recarga para ver la última versión.',
      );
    const saved = await this.find(db, productId);
    await this.products.refreshUnsoldDepartures(
      saved,
      input.sheet,
      await this.provider(m.providerId),
    );
    return this.products.detail(saved);
  }

  @Post(':productId/publicar')
  @HttpCode(200)
  @Can('fulldays')
  @Endpoint({
    operationId: 'publishProduct',
    summary: 'Publica, o envía a revisión de Central cuando corresponde',
    tags: TAG,
    responses: { 200: ProductDetailSchema },
  })
  async publish(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Param('productId') productId: string,
  ): Promise<ProductDetail> {
    const product = await this.find(db, productId);
    const provider = await this.provider(m.providerId);
    if (provider.status !== 'approved')
      throw conflict('Tu agencia debe estar aprobada por Central para publicar.');
    if (product.status === 'published') throw conflict('Ya está publicado.');
    if (product.status === 'in_review') throw conflict('Ya está en revisión de Central.');
    const sheet = sheetOf(product);
    const result = completeness(product.type, sheet);
    if (!result.publishable)
      throw conflict(`Faltan datos para publicar: ${result.missing.join(', ')}.`);
    const status = this.products.needsReview(provider, product, sheet) ? 'in_review' : 'published';
    const updated = await db.product.update({
      where: { id: product.id },
      data: { status, statusAt: new Date() },
    });
    return this.products.detail(updated);
  }

  @Post(':productId/pausar')
  @HttpCode(200)
  @Can('fulldays')
  @Endpoint({
    operationId: 'pauseProduct',
    summary: 'Pausa la venta de un producto publicado',
    tags: TAG,
    responses: { 200: ProductDetailSchema },
  })
  async pause(
    @ScopedDb() db: PrismaClient,
    @Param('productId') productId: string,
  ): Promise<ProductDetail> {
    const product = await this.find(db, productId);
    const { count } = await db.product.updateMany({
      where: { id: product.id, status: 'published' },
      data: { status: 'paused', statusAt: new Date() },
    });
    if (count === 0) throw conflict('Solo se pausa un producto publicado.');
    return this.products.detail(await this.find(db, productId));
  }

  private async find(db: PrismaClient, productId: string): Promise<Product> {
    if (!isUuid(productId)) throw notFound();
    const product = await db.product.findFirst({ where: { id: productId } });
    if (!product) throw notFound();
    return product;
  }

  private async provider(providerId: string): Promise<Provider> {
    return this.db.provider.findUniqueOrThrow({ where: { id: providerId } });
  }
}
