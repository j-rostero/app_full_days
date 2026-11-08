import {
  type CallHandler,
  type ExecutionContext,
  Inject,
  Injectable,
  type NestInterceptor,
} from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import type { Prisma } from '@fulldays/db';
import { from, lastValueFrom, type Observable } from 'rxjs';
import { CENTRAL_PREFIX, PRO_PREFIX } from '../access/access.guard.ts';
import type { ApiRequest } from '../common/request.ts';
import { DB } from '../common/tokens.ts';

const READS = new Set(['GET', 'HEAD', 'OPTIONS']);
const SECRET_FIELDS = /password|token|secret|code/i;

/**
 * Toda escritura en `/v1/pro/*` o `/v1/central/*` corre en una transacción y deja su fila
 * en `audit_log` dentro de esa misma transacción: si la auditoría no se puede escribir, la
 * acción se deshace. Guarda autor, ámbito, agencia, acción, parámetros, entrada (sin
 * secretos), `before` (lo que el endpoint deja con `@Trail()`) y `after` (por defecto, la
 * respuesta).
 */
@Injectable()
export class AuditInterceptor implements NestInterceptor {
  constructor(@Inject(DB) private readonly db: PrismaClient) {}

  intercept(context: ExecutionContext, next: CallHandler): Observable<unknown> {
    const request = context.switchToHttp().getRequest<ApiRequest>();
    const isPro = request.path.startsWith(PRO_PREFIX);
    const isCentral = request.path.startsWith(CENTRAL_PREFIX);
    if (READS.has(request.method) || (!isPro && !isCentral) || !request.auth) return next.handle();

    const auth = request.auth;
    return from(
      this.db.$transaction(async (tx) => {
        const result = await lastValueFrom(next.handle(), { defaultValue: undefined });
        const route = (request.route as { path?: string } | undefined)?.path ?? request.path;
        await tx.auditLog.create({
          data: {
            actorId: auth.userId,
            scope: isPro ? 'provider' : 'central',
            providerId: request.membership?.providerId ?? null,
            action: `${request.method} ${route}`,
            params: json(request.params) ?? {},
            input: json(redact(request.body)),
            before: json(request.trail?.before),
            after: json(request.trail?.after ?? result),
          },
        });
        return result;
      }),
    );
  }
}

function redact(value: unknown): unknown {
  if (Array.isArray(value)) return value.map(redact);
  if (!value || typeof value !== 'object') return value;
  return Object.fromEntries(
    Object.entries(value).map(([k, v]) => [k, SECRET_FIELDS.test(k) ? '[oculto]' : redact(v)]),
  );
}

function json(value: unknown): Prisma.InputJsonValue | undefined {
  if (value === undefined || value === null) return undefined;
  return JSON.parse(JSON.stringify(value)) as Prisma.InputJsonValue;
}
