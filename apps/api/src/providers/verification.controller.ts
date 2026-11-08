import { Body, Controller, Get, HttpCode, Inject, Param, Post, Put, Query } from '@nestjs/common';
import type { PrismaClient, ProviderStatus } from '@fulldays/db';
import { PROVIDER_DECISIONS, PROVIDER_STATUS_LABELS } from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Trail, type AuditTrail } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import {
  CommissionInput,
  type Company,
  CompanySchema,
  ProviderQueueQuery,
  ProviderQueueSchema,
  ProviderReviewSchema,
  ReasonInput,
} from './providers.schemas.ts';
import { ProvidersService } from './providers.service.ts';

const TAG = ['central'];

/** Verificación de agencias en Central. */
@Controller('central/proveedores')
export class VerificationController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(ProvidersService) private readonly providers: ProvidersService,
  ) {}

  @Get()
  @Can('providers')
  @Endpoint({
    operationId: 'listProviderQueue',
    summary: 'Agencias por estado, la enviada hace más tiempo primero (máximo 200)',
    tags: TAG,
    query: ProviderQueueQuery,
    responses: { 200: ProviderQueueSchema },
  })
  async queue(@Query(new ZodPipe(ProviderQueueQuery)) query: z.infer<typeof ProviderQueueQuery>) {
    const rows = await this.db.provider.findMany({
      where: { status: query.status },
      orderBy: [{ submittedAt: 'asc' }, { createdAt: 'asc' }],
      take: 200,
    });
    return {
      items: rows.map((p) => ({
        id: p.id,
        name: p.name,
        kind: p.kind,
        rif: p.rif,
        baseCity: p.baseCity,
        status: p.status,
        hasRtn: p.rtn !== null,
        submittedAt: p.submittedAt?.toISOString() ?? null,
      })),
    };
  }

  @Get(':id')
  @Can('providers')
  @Endpoint({
    operationId: 'getProviderReview',
    summary: 'Agencia con sus documentos descargables y sus dueños',
    tags: TAG,
    responses: { 200: ProviderReviewSchema },
  })
  async detail(@Param('id') id: string) {
    const provider = await this.find(id);
    const owners = await this.db.providerMember.findMany({
      where: { providerId: id, role: 'owner' },
      include: { user: { select: { id: true, email: true, name: true } } },
    });
    return {
      company: await this.providers.company(provider),
      documents: await this.providers.documents(id),
      owners: owners.map((o) => o.user),
    };
  }

  @Post(':id/aprobar')
  @HttpCode(200)
  @Can('providers')
  @Endpoint({
    operationId: 'approveProvider',
    summary: 'Aprueba una agencia en revisión o suspendida',
    tags: TAG,
    responses: { 200: CompanySchema },
  })
  approve(@Param('id') id: string, @Trail() trail: AuditTrail): Promise<Company> {
    return this.decide(id, 'approve', null, trail);
  }

  @Post(':id/rechazar')
  @HttpCode(200)
  @Can('providers')
  @Endpoint({
    operationId: 'rejectProvider',
    summary: 'Rechaza una agencia en revisión, con motivo',
    tags: TAG,
    body: ReasonInput,
    responses: { 200: CompanySchema },
  })
  reject(
    @Param('id') id: string,
    @Body(new ZodPipe(ReasonInput)) input: z.infer<typeof ReasonInput>,
    @Trail() trail: AuditTrail,
  ) {
    return this.decide(id, 'reject', input.reason, trail);
  }

  @Post(':id/suspender')
  @HttpCode(200)
  @Can('providers')
  @Endpoint({
    operationId: 'suspendProvider',
    summary: 'Suspende una agencia aprobada, con motivo: sale del catálogo público',
    tags: TAG,
    body: ReasonInput,
    responses: { 200: CompanySchema },
  })
  suspend(
    @Param('id') id: string,
    @Body(new ZodPipe(ReasonInput)) input: z.infer<typeof ReasonInput>,
    @Trail() trail: AuditTrail,
  ) {
    return this.decide(id, 'suspend', input.reason, trail);
  }

  @Put(':id/comision')
  @Can('commissions')
  @Endpoint({
    operationId: 'setProviderCommission',
    summary: 'Fija la comisión propia de la agencia (0 a 50) o la quita (null)',
    tags: TAG,
    body: CommissionInput,
    responses: { 200: CompanySchema },
  })
  async commission(
    @Param('id') id: string,
    @Body(new ZodPipe(CommissionInput)) input: z.infer<typeof CommissionInput>,
    @Trail() trail: AuditTrail,
  ) {
    trail.before = { commissionPercent: (await this.find(id)).commissionPercent };
    const updated = await this.db.provider.update({
      where: { id },
      data: { commissionPercent: input.commissionPercent },
    });
    return this.providers.company(updated);
  }

  /** Cambio condicionado al estado de origen: dos decisiones simultáneas no se pisan. */
  private async decide(
    id: string,
    decision: keyof typeof PROVIDER_DECISIONS,
    reason: string | null,
    trail: AuditTrail,
  ): Promise<Company> {
    const before = await this.find(id);
    trail.before = { status: before.status, statusReason: before.statusReason };
    const rule = PROVIDER_DECISIONS[decision];
    const { count } = await this.db.provider.updateMany({
      where: { id, status: { in: [...rule.from] as ProviderStatus[] } },
      data: { status: rule.to, statusReason: reason },
    });
    if (count === 0)
      throw conflict(`No se puede: la agencia está «${PROVIDER_STATUS_LABELS[before.status]}».`);
    return this.providers.company(await this.find(id));
  }

  private async find(id: string) {
    if (!isUuid(id)) throw notFound();
    const provider = await this.db.provider.findUnique({ where: { id } });
    if (!provider) throw notFound();
    return provider;
  }
}
