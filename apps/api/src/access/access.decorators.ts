import { SetMetadata } from '@nestjs/common';
import type { ProviderPermission, StaffPermission } from '@fulldays/shared';

export const CAN_METADATA = 'fulldays:can';

/**
 * Permiso que exige un endpoint bajo `/v1/pro/:providerId` (de agencia) o `/v1/central`
 * (de Central). Sin `@Can`, esos endpoints responden 403 a todo el mundo.
 */
export const Can = (permission: ProviderPermission | StaffPermission) =>
  SetMetadata(CAN_METADATA, permission);
