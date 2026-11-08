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
  Query,
} from '@nestjs/common';
import type { PrismaClient, ProviderMember, User } from '@fulldays/db';
import type { ProviderRole } from '@fulldays/shared';
import type { z } from 'zod';
import { conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Membership, type MembershipContext, Trail, type AuditTrail } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { Can } from './access.decorators.ts';
import {
  AddTeamMemberInput,
  AuditPageSchema,
  AuditQuery,
  ChangeTeamRoleInput,
  type AuditPage,
  type TeamMember,
  TeamListSchema,
  TeamMemberSchema,
} from './access.schemas.ts';
import { readAudit } from './audit.read.ts';
import { ScopedDb } from './scoped-db.ts';

const TAG = ['equipo'];
const lastOwner = () =>
  conflict('La agencia necesita al menos un dueño. Nombra otro antes de cambiar este.');

type MemberWithUser = ProviderMember & { user: Pick<User, 'id' | 'email' | 'name'> };

/** Equipo de una agencia. Solo el rol dueño (`team`) lo gestiona. */
@Controller('pro/:providerId/equipo')
export class TeamController {
  constructor(@Inject(DB) private readonly db: PrismaClient) {}

  @Get()
  @Can('team')
  @Endpoint({
    operationId: 'listTeam',
    summary: 'Personas del equipo de la agencia y su rol',
    tags: TAG,
    responses: { 200: TeamListSchema },
  })
  async list(@ScopedDb() db: PrismaClient): Promise<{ items: TeamMember[] }> {
    const rows = await db.providerMember.findMany({
      include: { user: USER },
      orderBy: { createdAt: 'asc' },
    });
    return { items: rows.map(toMember) };
  }

  @Post()
  @HttpCode(201)
  @Can('team')
  @Endpoint({
    operationId: 'addTeamMember',
    summary:
      'Suma a una persona por su correo. Si aún no tiene cuenta, la tendrá al registrarse con ese correo',
    tags: TAG,
    body: AddTeamMemberInput,
    responses: { 201: TeamMemberSchema },
  })
  async add(
    @ScopedDb() db: PrismaClient,
    @Body(new ZodPipe(AddTeamMemberInput)) input: z.infer<typeof AddTeamMemberInput>,
  ): Promise<TeamMember> {
    const user = await this.db.user.upsert({
      where: { email: input.email },
      create: { email: input.email },
      update: {},
    });
    const existing = await db.providerMember.findFirst({ where: { userId: user.id } });
    if (existing) throw conflict('Esa persona ya es parte del equipo.');
    const row = await db.providerMember.create({
      data: { userId: user.id, role: input.role } as never,
      include: { user: USER },
    });
    return toMember(row as MemberWithUser);
  }

  @Patch(':memberId')
  @Can('team')
  @Endpoint({
    operationId: 'changeTeamRole',
    summary: 'Cambia el rol de una persona del equipo',
    tags: TAG,
    body: ChangeTeamRoleInput,
    responses: { 200: TeamMemberSchema },
  })
  async changeRole(
    @ScopedDb() db: PrismaClient,
    @Membership() membership: MembershipContext,
    @Param('memberId') memberId: string,
    @Body(new ZodPipe(ChangeTeamRoleInput)) input: z.infer<typeof ChangeTeamRoleInput>,
    @Trail() trail: AuditTrail,
  ): Promise<TeamMember> {
    const member = await this.lockAndFind(db, membership.providerId, memberId);
    trail.before = toMember(member);
    if (member.role === 'owner' && input.role !== 'owner') await this.keepAnOwner(db);
    const row = await db.providerMember.update({
      where: { id: member.id },
      data: { role: input.role },
      include: { user: USER },
    });
    return toMember(row);
  }

  @Delete(':memberId')
  @HttpCode(204)
  @Can('team')
  @Endpoint({
    operationId: 'removeTeamMember',
    summary: 'Quita a una persona del equipo',
    tags: TAG,
    responses: { 204: null },
  })
  async remove(
    @ScopedDb() db: PrismaClient,
    @Membership() membership: MembershipContext,
    @Param('memberId') memberId: string,
    @Trail() trail: AuditTrail,
  ): Promise<void> {
    const member = await this.lockAndFind(db, membership.providerId, memberId);
    trail.before = toMember(member);
    if (member.role === 'owner') await this.keepAnOwner(db);
    await db.providerMember.delete({ where: { id: member.id } });
  }

  /**
   * Bloquea la fila de la agencia hasta el fin de la transacción (la abre la auditoría): dos
   * cambios simultáneos sobre dueños no pueden dejarla sin ninguno.
   */
  private async lockAndFind(
    db: PrismaClient,
    providerId: string,
    memberId: string,
  ): Promise<MemberWithUser> {
    if (!isUuid(memberId)) throw notFound();
    await this.db.$queryRaw`SELECT id FROM providers WHERE id = ${providerId}::uuid FOR UPDATE`;
    const member = await db.providerMember.findFirst({
      where: { id: memberId },
      include: { user: USER },
    });
    if (!member) throw notFound();
    return member;
  }

  private async keepAnOwner(db: PrismaClient): Promise<void> {
    const owners = await db.providerMember.count({
      where: { role: 'owner' satisfies ProviderRole },
    });
    if (owners <= 1) throw lastOwner();
  }
}

const USER = { select: { id: true, email: true, name: true } } as const;

function toMember(row: MemberWithUser): TeamMember {
  return { id: row.id, role: row.role, user: row.user, createdAt: row.createdAt.toISOString() };
}

/** Lo que cambió en la agencia y quién lo hizo. */
@Controller('pro/:providerId/auditoria')
export class ProviderAuditController {
  @Get()
  @Can('team')
  @Endpoint({
    operationId: 'listProviderAudit',
    summary: 'Cambios hechos en la agencia, del más reciente al más antiguo',
    tags: ['auditoria'],
    query: AuditQuery,
    responses: { 200: AuditPageSchema },
  })
  async audit(
    @ScopedDb() db: PrismaClient,
    @Query(new ZodPipe(AuditQuery)) query: z.infer<typeof AuditQuery>,
  ): Promise<AuditPage> {
    return readAudit(db, {}, query);
  }
}
