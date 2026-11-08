import { Body, Controller, Get, Inject, Put, Query } from '@nestjs/common';
import type { PrismaClient, StaffRole } from '@fulldays/db';
import type { z } from 'zod';
import { conflict } from '../common/api-exception.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Trail, type AuditTrail } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { Can } from './access.decorators.ts';
import {
  AuditPageSchema,
  AuditQuery,
  SetStaffRolesInput,
  type AuditPage,
  type StaffPerson,
  StaffListSchema,
  StaffPersonSchema,
} from './access.schemas.ts';
import { readAudit } from './audit.read.ts';

/** Clave del candado de transacción que serializa los cambios de roles de Central. */
const STAFF_LOCK = 0x46_44_53_54; // "FDST"

/** Equipo de Central. Solo `super` (`staff`) lo gestiona. */
@Controller('central/equipo')
export class StaffController {
  constructor(@Inject(DB) private readonly db: PrismaClient) {}

  @Get()
  @Can('staff')
  @Endpoint({
    operationId: 'listStaff',
    summary: 'Personas de Central y sus roles',
    tags: ['central'],
    responses: { 200: StaffListSchema },
  })
  async list(): Promise<{ items: StaffPerson[] }> {
    const users = await this.db.user.findMany({
      where: { staffRoles: { some: {} } },
      select: { ...PERSON, staffRoles: { select: { role: true } } },
      orderBy: { email: 'asc' },
    });
    return { items: users.map(toStaffPerson) };
  }

  @Put()
  @Can('staff')
  @Endpoint({
    operationId: 'setStaffRoles',
    summary:
      'Fija los roles de Central de una persona por su correo (una lista vacía la saca de Central)',
    tags: ['central'],
    body: SetStaffRolesInput,
    responses: { 200: StaffPersonSchema },
  })
  async set(
    @Body(new ZodPipe(SetStaffRolesInput)) input: z.infer<typeof SetStaffRolesInput>,
    @Trail() trail: AuditTrail,
  ): Promise<StaffPerson> {
    // Dentro de la transacción de la auditoría: dos cambios a la vez no pueden dejar a Central sin super.
    await this.db.$executeRaw`SELECT pg_advisory_xact_lock(${STAFF_LOCK})`;
    const user = await this.db.user.upsert({
      where: { email: input.email },
      create: { email: input.email },
      update: {},
    });
    const current = await this.db.staffMember.findMany({ where: { userId: user.id } });
    trail.before = current.map((r) => r.role);
    const roles = [...new Set(input.roles)] as StaffRole[];

    if (current.some((r) => r.role === 'super') && !roles.includes('super')) {
      const supers = await this.db.staffMember.count({ where: { role: 'super' } });
      if (supers <= 1)
        throw conflict('Central necesita al menos una persona super. Nombra otra antes.');
    }
    await this.db.staffMember.deleteMany({ where: { userId: user.id, role: { notIn: roles } } });
    await this.db.staffMember.createMany({
      data: roles.map((role) => ({ userId: user.id, role })),
      skipDuplicates: true,
    });
    const updated = await this.db.user.findUniqueOrThrow({
      where: { id: user.id },
      select: { ...PERSON, staffRoles: { select: { role: true } } },
    });
    return toStaffPerson(updated);
  }
}

@Controller('central/auditoria')
export class CentralAuditController {
  constructor(@Inject(DB) private readonly db: PrismaClient) {}

  @Get()
  @Can('audit')
  @Endpoint({
    operationId: 'listAudit',
    summary: 'Todos los cambios de agencias y de Central, del más reciente al más antiguo',
    tags: ['auditoria'],
    query: AuditQuery,
    responses: { 200: AuditPageSchema },
  })
  async list(
    @Query(new ZodPipe(AuditQuery)) query: z.infer<typeof AuditQuery>,
  ): Promise<AuditPage> {
    return readAudit(this.db, query.providerId ? { providerId: query.providerId } : {}, query);
  }
}

const PERSON = { id: true, email: true, name: true } as const;
const ORDER: StaffRole[] = ['super', 'support', 'moderation', 'content', 'finance'];

function toStaffPerson(user: {
  id: string;
  email: string;
  name: string | null;
  staffRoles: { role: StaffRole }[];
}): StaffPerson {
  const roles = ORDER.filter((role) => user.staffRoles.some((r) => r.role === role));
  return { user: { id: user.id, email: user.email, name: user.name }, roles };
}
