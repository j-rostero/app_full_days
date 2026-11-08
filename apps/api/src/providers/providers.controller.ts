import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Inject,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import type { PrismaClient, Provider } from '@fulldays/db';
import { PROVIDER_DOCUMENT_LABELS } from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { ScopedDb } from '../access/scoped-db.ts';
import { conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import {
  Auth,
  type AuthContext,
  Membership,
  type MembershipContext,
  Trail,
  type AuditTrail,
} from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { FilesService } from '../files/files.service.ts';
import {
  AttachDocumentInput,
  type Company,
  CompanySchema,
  ProviderDocumentListSchema,
  ProviderDocumentSchema,
  type ProviderDocumentView,
  ProviderInput,
  ProviderUpdateInput,
} from './providers.schemas.ts';
import { ProvidersService } from './providers.service.ts';

const TAG = ['agencia'];
const inReview = () =>
  conflict('Tu agencia está en revisión: espera la respuesta de Central para hacer cambios.');

/** Alta de agencias y lo que la agencia gestiona de sí misma. */
@Controller()
export class ProvidersController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(ProvidersService) private readonly providers: ProvidersService,
    @Inject(FilesService) private readonly files: FilesService,
  ) {}

  @Post('proveedores')
  @HttpCode(201)
  @Endpoint({
    operationId: 'registerProvider',
    summary: 'Registra una agencia u organizador; quien la registra queda como dueño',
    tags: TAG,
    body: ProviderInput,
    responses: { 201: CompanySchema },
  })
  async register(
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(ProviderInput)) input: z.infer<typeof ProviderInput>,
  ): Promise<Company> {
    if (await this.db.provider.findUnique({ where: { rif: input.rif } })) {
      throw conflict(
        'Ya hay una agencia registrada con ese RIF. Pide a su dueño que te sume al equipo.',
      );
    }
    const provider = await this.db.$transaction(async (tx) => {
      const created = await tx.provider.create({ data: input });
      await tx.providerMember.create({
        data: { providerId: created.id, userId: auth.userId, role: 'owner' },
      });
      return created;
    });
    return this.providers.company(provider);
  }

  @Get('pro/:providerId/empresa')
  @Can('company')
  @Endpoint({
    operationId: 'getCompany',
    summary: 'Datos de la agencia, estado y distintivo',
    tags: TAG,
    responses: { 200: CompanySchema },
  })
  async get(@ScopedDb() db: PrismaClient, @Membership() m: MembershipContext): Promise<Company> {
    return this.providers.company(await this.load(m.providerId), db);
  }

  @Patch('pro/:providerId/empresa')
  @Can('company')
  @Endpoint({
    operationId: 'updateCompany',
    summary: 'Cambia los datos de la agencia (el RIF no cambia)',
    tags: TAG,
    body: ProviderUpdateInput,
    responses: { 200: CompanySchema },
  })
  async update(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Body(new ZodPipe(ProviderUpdateInput)) input: z.infer<typeof ProviderUpdateInput>,
    @Trail() trail: AuditTrail,
  ): Promise<Company> {
    const provider = await this.lock(m.providerId);
    trail.before = provider;
    if (provider.status === 'in_review') throw inReview();
    const updated = await this.db.provider.update({ where: { id: provider.id }, data: input });
    return this.providers.company(updated, db);
  }

  @Post('pro/:providerId/empresa/enviar')
  @HttpCode(200)
  @Can('company')
  @Endpoint({
    operationId: 'submitCompany',
    summary: 'Envía la agencia a verificación de Central',
    tags: TAG,
    responses: { 200: CompanySchema },
  })
  async submit(@ScopedDb() db: PrismaClient, @Membership() m: MembershipContext): Promise<Company> {
    const provider = await this.lock(m.providerId);
    if (provider.status === 'in_review') throw inReview();
    if (provider.status === 'approved') throw conflict('Tu agencia ya está aprobada.');
    if (provider.status === 'suspended')
      throw conflict('Tu agencia está suspendida. Escríbenos para revisarla.');
    const company = await this.providers.company(provider, db);
    if (company.missingDocuments.length) {
      throw conflict(
        `Faltan documentos: ${company.missingDocuments.map((t) => PROVIDER_DOCUMENT_LABELS[t]).join(', ')}.`,
      );
    }
    const updated = await this.db.provider.update({
      where: { id: provider.id },
      data: { status: 'in_review', submittedAt: new Date() },
    });
    return this.providers.company(updated, db);
  }

  @Get('pro/:providerId/documentos')
  @Can('company')
  @Endpoint({
    operationId: 'listCompanyDocuments',
    summary: 'Documentos de verificación, con enlace de descarga de cinco minutos',
    tags: TAG,
    responses: { 200: ProviderDocumentListSchema },
  })
  async documents(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
  ): Promise<{ items: ProviderDocumentView[] }> {
    return { items: await this.providers.documents(m.providerId, db) };
  }

  @Post('pro/:providerId/documentos')
  @HttpCode(201)
  @Can('company')
  @Endpoint({
    operationId: 'attachCompanyDocument',
    summary: 'Adjunta un documento ya subido (archivo propio y listo)',
    tags: TAG,
    body: AttachDocumentInput,
    responses: { 201: ProviderDocumentSchema },
  })
  async attach(
    @Auth() auth: AuthContext,
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Body(new ZodPipe(AttachDocumentInput)) input: z.infer<typeof AttachDocumentInput>,
  ): Promise<ProviderDocumentView> {
    const provider = await this.lock(m.providerId);
    if (provider.status === 'in_review') throw inReview();
    await this.files.requireReady([input.fileId], 'document', [auth.userId], ['fileId']);
    if (await this.db.providerDocument.findUnique({ where: { fileId: input.fileId } })) {
      throw conflict('Ese archivo ya está adjunto.');
    }
    const row = await db.providerDocument.create({
      data: { type: input.type, fileId: input.fileId } as never,
      include: { file: true },
    });
    return this.providers.document(row as never);
  }

  @Delete('pro/:providerId/documentos/:documentId')
  @HttpCode(204)
  @Can('company')
  @Endpoint({
    operationId: 'removeCompanyDocument',
    summary: 'Quita un documento',
    tags: TAG,
    responses: { 204: null },
  })
  async remove(
    @ScopedDb() db: PrismaClient,
    @Membership() m: MembershipContext,
    @Param('documentId') documentId: string,
    @Trail() trail: AuditTrail,
  ): Promise<void> {
    if (!isUuid(documentId)) throw notFound();
    const provider = await this.lock(m.providerId);
    if (provider.status === 'in_review') throw inReview();
    const doc = await db.providerDocument.findFirst({ where: { id: documentId } });
    if (!doc) throw notFound();
    trail.before = doc;
    await db.providerDocument.delete({ where: { id: doc.id } });
  }

  private async load(providerId: string): Promise<Provider> {
    const provider = await this.db.provider.findUnique({ where: { id: providerId } });
    if (!provider) throw notFound();
    return provider;
  }

  /** Lee la agencia bloqueando su fila hasta el fin de la transacción: no cambia de estado a mitad de una edición. */
  private async lock(providerId: string): Promise<Provider> {
    await this.db.$queryRaw`SELECT id FROM providers WHERE id = ${providerId}::uuid FOR UPDATE`;
    return this.load(providerId);
  }
}
