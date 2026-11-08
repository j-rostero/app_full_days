import { type CanActivate, type ExecutionContext, Inject, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { scopeToProvider, type PrismaClient } from '@fulldays/db';
import {
  providerPermissions,
  staffPermissions,
  type ProviderPermission,
  type StaffPermission,
} from '@fulldays/shared';
import { forbidden, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import type { ApiRequest } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { CAN_METADATA } from './access.decorators.ts';

export const PRO_PREFIX = '/v1/pro/';
export const CENTRAL_PREFIX = '/v1/central/';

/**
 * Decide por la URL, para que ninguna ruta quede fuera por olvidar un decorador:
 * - `/v1/pro/:providerId/*`: miembro de esa agencia con un rol que tenga el permiso de `@Can`.
 * - `/v1/central/*`: roles de Central cuya suma de permisos incluya el de `@Can`.
 * - El resto pasa sin comprobación de rol.
 */
@Injectable()
export class AccessGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    @Inject(DB) private readonly db: PrismaClient,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest<ApiRequest>();
    const path = request.path;
    const isPro = path.startsWith(PRO_PREFIX);
    const isCentral = path.startsWith(CENTRAL_PREFIX) || path === '/v1/central';
    if (!isPro && !isCentral) return true;

    const required = this.reflector.get<ProviderPermission | StaffPermission | undefined>(
      CAN_METADATA,
      context.getHandler(),
    );
    const auth = request.auth;
    if (!required || !auth) throw forbidden();

    if (isPro) {
      const providerId = String(request.params.providerId ?? '');
      if (!isUuid(providerId)) throw notFound();
      const member = await this.db.providerMember.findUnique({
        where: { providerId_userId: { providerId, userId: auth.userId } },
      });
      // Una agencia ajena responde 404: no se revela que existe.
      if (!member) throw notFound();
      const permissions = providerPermissions(member.role);
      if (!permissions.includes(required as ProviderPermission)) throw forbidden();
      request.membership = { providerId, role: member.role, permissions };
      request.scopedDb = scopeToProvider(this.db, providerId);
      return true;
    }

    const roles = await this.db.staffMember.findMany({ where: { userId: auth.userId } });
    if (!staffPermissions(roles.map((r) => r.role)).includes(required as StaffPermission)) {
      throw forbidden();
    }
    return true;
  }
}
