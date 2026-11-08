import { EmailSchema, PROVIDER_ROLES, STAFF_ROLES } from '@fulldays/shared';
import { z } from 'zod';
import { ProviderRoleSchema, StaffRoleSchema } from '../users/users.schemas.ts';

const PersonSchema = z.object({ id: z.uuid(), email: z.string(), name: z.string().nullable() });

export const TeamMemberSchema = z
  .object({
    id: z.uuid(),
    role: ProviderRoleSchema,
    user: PersonSchema,
    createdAt: z.iso.datetime(),
  })
  .meta({ id: 'TeamMember' });
export const TeamListSchema = z
  .object({ items: z.array(TeamMemberSchema) })
  .meta({ id: 'TeamList' });

export const AddTeamMemberInput = z
  .strictObject({ email: EmailSchema, role: z.enum(PROVIDER_ROLES) })
  .meta({ id: 'AddTeamMemberInput' });
export const ChangeTeamRoleInput = z
  .strictObject({ role: z.enum(PROVIDER_ROLES) })
  .meta({ id: 'ChangeTeamRoleInput' });

export const StaffPersonSchema = z
  .object({ user: PersonSchema, roles: z.array(StaffRoleSchema) })
  .meta({ id: 'StaffPerson' });
export const StaffListSchema = z
  .object({ items: z.array(StaffPersonSchema) })
  .meta({ id: 'StaffList' });

export const SetStaffRolesInput = z
  .strictObject({ email: EmailSchema, roles: z.array(z.enum(STAFF_ROLES)).max(STAFF_ROLES.length) })
  .meta({ id: 'SetStaffRolesInput' });

export const AuditEntrySchema = z
  .object({
    id: z.uuid(),
    actor: PersonSchema,
    scope: z.enum(['provider', 'central']),
    providerId: z.uuid().nullable(),
    action: z.string(),
    params: z.unknown(),
    input: z.unknown(),
    before: z.unknown(),
    after: z.unknown(),
    createdAt: z.iso.datetime(),
  })
  .meta({ id: 'AuditEntry' });
export const AuditPageSchema = z
  .object({ items: z.array(AuditEntrySchema), nextCursor: z.uuid().nullable() })
  .meta({ id: 'AuditPage' });

export const AuditQuery = z.strictObject({
  cursor: z.uuid().optional(),
  limit: z.coerce.number().int().min(1).max(100).default(50),
  providerId: z.uuid().optional(),
});

export type TeamMember = z.infer<typeof TeamMemberSchema>;
export type StaffPerson = z.infer<typeof StaffPersonSchema>;
export type AuditEntry = z.infer<typeof AuditEntrySchema>;
export type AuditPage = z.infer<typeof AuditPageSchema>;
