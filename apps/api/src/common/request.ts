import { createParamDecorator, type ExecutionContext } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import type { ProviderPermission, ProviderRole } from '@fulldays/shared';
import type { Request } from 'express';

/** Quién hace la petición. Lo deja `AuthGuard`. */
export interface AuthContext {
  userId: string;
  sessionId: string;
}

/** Pertenencia a la agencia de la URL. La deja `AccessGuard` en `/v1/pro/:providerId/*`. */
export interface MembershipContext {
  providerId: string;
  role: ProviderRole;
  permissions: ProviderPermission[];
}

/** Lo que un endpoint auditado quiere guardar además de la entrada y la respuesta. */
export interface AuditTrail {
  before?: unknown;
  after?: unknown;
}

export interface ApiRequest extends Request {
  auth?: AuthContext;
  membership?: MembershipContext;
  scopedDb?: PrismaClient;
  trail?: AuditTrail;
}

/** La sesión de quien llama (`@Auth() auth: AuthContext`). Solo en endpoints con sesión. */
export const Auth = createParamDecorator((_: unknown, ctx: ExecutionContext): AuthContext => {
  const auth = ctx.switchToHttp().getRequest<ApiRequest>().auth;
  if (!auth) throw new Error('@Auth() en un endpoint público');
  return auth;
});

export const Membership = createParamDecorator(
  (_: unknown, ctx: ExecutionContext): MembershipContext => {
    const membership = ctx.switchToHttp().getRequest<ApiRequest>().membership;
    if (!membership) throw new Error('@Membership() fuera de /v1/pro/:providerId');
    return membership;
  },
);

/** Objeto donde el endpoint deja `before` (y opcionalmente `after`) para la auditoría. */
export const Trail = createParamDecorator((_: unknown, ctx: ExecutionContext): AuditTrail => {
  const request = ctx.switchToHttp().getRequest<ApiRequest>();
  request.trail ??= {};
  return request.trail;
});

/** Dirección del dispositivo, recortada, para nombrar la sesión. */
export const Device = createParamDecorator((_: unknown, ctx: ExecutionContext): string =>
  String(ctx.switchToHttp().getRequest<ApiRequest>().headers['user-agent'] ?? '').slice(0, 200),
);
