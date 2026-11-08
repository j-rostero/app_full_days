// Roles y permisos. La API los hace cumplir; webs y apps los leen para ocultar lo que no se puede usar.

export const PROVIDER_PERMISSIONS = [
  'team',
  'company',
  'fulldays',
  'departures',
  'bookings',
  'notices',
  'payments',
  'settlements',
  'reports',
  'checkin',
] as const;
export type ProviderPermission = (typeof PROVIDER_PERMISSIONS)[number];

export const PROVIDER_ROLES = ['owner', 'operations', 'finance', 'guide'] as const;
export type ProviderRole = (typeof PROVIDER_ROLES)[number];

const PROVIDER_ROLE_PERMISSIONS: Record<ProviderRole, readonly ProviderPermission[]> = {
  owner: PROVIDER_PERMISSIONS,
  operations: ['fulldays', 'departures', 'bookings', 'notices'],
  finance: ['payments', 'settlements', 'reports'],
  guide: ['checkin', 'notices'],
};

export const PROVIDER_ROLE_LABELS: Record<ProviderRole, string> = {
  owner: 'Dueño',
  operations: 'Operaciones',
  finance: 'Finanzas',
  guide: 'Guía',
};

export function providerPermissions(role: ProviderRole): ProviderPermission[] {
  return [...PROVIDER_ROLE_PERMISSIONS[role]];
}

export const STAFF_PERMISSIONS = [
  'staff',
  'audit',
  'providers',
  'users',
  'bookings',
  'claims',
  'reviews',
  'content',
  'fulldays',
  'catalogs',
  'themes',
  'commissions',
  'payments',
  'refunds',
  'settlements',
  'rates',
  'settings',
  'metrics',
] as const;
export type StaffPermission = (typeof STAFF_PERMISSIONS)[number];

export const STAFF_ROLES = ['super', 'support', 'moderation', 'content', 'finance'] as const;
export type StaffRole = (typeof STAFF_ROLES)[number];

const STAFF_ROLE_PERMISSIONS: Record<StaffRole, readonly StaffPermission[]> = {
  super: STAFF_PERMISSIONS,
  support: ['users', 'bookings', 'claims'],
  moderation: ['reviews', 'content', 'fulldays'],
  content: ['catalogs', 'themes'],
  finance: ['commissions', 'payments', 'refunds', 'settlements', 'rates', 'metrics'],
};

export const STAFF_ROLE_LABELS: Record<StaffRole, string> = {
  super: 'Super',
  support: 'Soporte',
  moderation: 'Moderación',
  content: 'Contenido',
  finance: 'Finanzas',
};

/** Una persona de Central puede tener varios roles: los permisos se suman sin duplicar, en el orden canónico. */
export function staffPermissions(roles: readonly StaffRole[]): StaffPermission[] {
  const granted = new Set(roles.flatMap((role) => STAFF_ROLE_PERMISSIONS[role]));
  return STAFF_PERMISSIONS.filter((permission) => granted.has(permission));
}
