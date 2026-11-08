import {
  PassengerInputSchema,
  PROVIDER_PERMISSIONS,
  PROVIDER_ROLES,
  PROVIDER_STATUSES,
  ProfileUpdateSchema,
  STAFF_PERMISSIONS,
  STAFF_ROLES,
} from '@fulldays/shared';
import { z } from 'zod';

export const ProviderRoleSchema = z.enum(PROVIDER_ROLES).meta({ id: 'ProviderRole' });
export const ProviderPermissionSchema = z
  .enum(PROVIDER_PERMISSIONS)
  .meta({ id: 'ProviderPermission' });
export const StaffRoleSchema = z.enum(STAFF_ROLES).meta({ id: 'StaffRole' });
export const StaffPermissionSchema = z.enum(STAFF_PERMISSIONS).meta({ id: 'StaffPermission' });

export const MembershipSchema = z
  .object({
    providerId: z.uuid(),
    providerName: z.string(),
    providerStatus: z.enum(PROVIDER_STATUSES),
    role: ProviderRoleSchema,
    permissions: z.array(ProviderPermissionSchema),
  })
  .meta({ id: 'Membership' });

export const MeSchema = z
  .object({
    id: z.uuid(),
    email: z.string(),
    name: z.string().nullable(),
    phone: z.string().nullable(),
    hasPassword: z.boolean(),
    hasGoogle: z.boolean(),
    memberships: z.array(MembershipSchema),
    staff: z.object({
      roles: z.array(StaffRoleSchema),
      permissions: z.array(StaffPermissionSchema),
    }),
  })
  .meta({ id: 'Me' });

export const ProfileUpdateInput = ProfileUpdateSchema.meta({ id: 'ProfileUpdateInput' });

export const PassengerInput = PassengerInputSchema.meta({ id: 'PassengerInput' });

export const PassengerSchema = z
  .object({
    id: z.uuid(),
    name: z.string(),
    cedula: z.string().nullable(),
    birthDate: z.string().meta({ description: 'AAAA-MM-DD' }),
    restrictions: z.string().nullable(),
  })
  .meta({ id: 'Passenger' });

export const PassengerListSchema = z
  .object({ items: z.array(PassengerSchema) })
  .meta({ id: 'PassengerList' });

export type Me = z.infer<typeof MeSchema>;
export type Passenger = z.infer<typeof PassengerSchema>;
