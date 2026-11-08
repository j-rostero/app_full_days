import { createParamDecorator, type ExecutionContext } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import type { ApiRequest } from '../common/request.ts';

/**
 * Cliente de base limitado a la agencia de la URL (lo prepara `AccessGuard`): un endpoint de
 * agencia que olvide filtrar no puede ver ni cambiar datos de otra. Usa la transacción en
 * curso si la hay.
 */
export const ScopedDb = createParamDecorator((_: unknown, ctx: ExecutionContext): PrismaClient => {
  const scoped = ctx.switchToHttp().getRequest<ApiRequest>().scopedDb;
  if (!scoped) throw new Error('@ScopedDb() fuera de /v1/pro/:providerId');
  return scoped;
});
