import { timingSafeEqual } from 'node:crypto';
import {
  type CanActivate,
  type ExecutionContext,
  Inject,
  Injectable,
  SetMetadata,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import type { Redis } from 'ioredis';
import type { Config } from '../config.ts';
import { rateLimited } from './api-exception.ts';
import type { ApiRequest } from './request.ts';
import { CONFIG, REDIS } from './tokens.ts';

export const RATE_LIMIT_METADATA = 'fulldays:rate-limit';
export type RateLimitBucket = 'global' | 'auth' | 'skip';

/** Usa el límite de acceso (`AUTH_RATE_LIMIT_PER_MINUTE`) además del global. */
export const AuthRateLimit = () =>
  SetMetadata(RATE_LIMIT_METADATA, 'auth' satisfies RateLimitBucket);
/** Sin límite de peticiones (monitoreo). */
export const SkipRateLimit = () =>
  SetMetadata(RATE_LIMIT_METADATA, 'skip' satisfies RateLimitBucket);

// INCR y, si es la primera de la ventana, fija su vencimiento. Atómico.
const HIT = `
local count = redis.call('INCR', KEYS[1])
if count == 1 then redis.call('PEXPIRE', KEYS[1], ARGV[1]) end
return count`;

const WINDOW_MS = 60_000;

export const WEB_KEY_HEADER = 'x-fulldays-web-key';
export const CLIENT_IP_HEADER = 'x-fulldays-client-ip';

function sameSecret(a: string, b: string): boolean {
  const x = Buffer.from(a);
  const y = Buffer.from(b);
  return x.length === y.length && timingSafeEqual(x, y);
}

/**
 * Límite de peticiones por IP con ventana fija de 60 s y contadores en Redis (compartidos
 * entre instancias). Quien se pasa queda bloqueado `RATE_LIMIT_BLOCK_SECONDS`.
 */
@Injectable()
export class RateLimitGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    @Inject(CONFIG) private readonly config: Config,
    @Inject(REDIS) private readonly redis: Redis,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const bucket = this.reflector.getAllAndOverride<RateLimitBucket | undefined>(
      RATE_LIMIT_METADATA,
      [context.getHandler(), context.getClass()],
    );
    if (bucket === 'skip') return true;
    const ip = this.clientIp(context.switchToHttp().getRequest<ApiRequest>());
    await this.hit('global', ip, this.config.RATE_LIMIT_PER_MINUTE);
    if (bucket === 'auth') await this.hit('auth', ip, this.config.AUTH_RATE_LIMIT_PER_MINUTE);
    return true;
  }

  /** La IP de la persona: la que informa un servidor web con la clave compartida, o la de la conexión. */
  clientIp(request: ApiRequest): string {
    const key = this.config.WEB_SERVER_KEY;
    const sent = request.headers[WEB_KEY_HEADER];
    const forwarded = request.headers[CLIENT_IP_HEADER];
    if (key && typeof sent === 'string' && typeof forwarded === 'string' && sameSecret(sent, key)) {
      return forwarded.slice(0, 64);
    }
    return request.ip ?? 'desconocida';
  }

  private async hit(bucket: string, ip: string, limit: number): Promise<void> {
    const blockKey = `rl:block:${bucket}:${ip}`;
    if (await this.redis.exists(blockKey)) throw rateLimited();
    const count = Number(await this.redis.eval(HIT, 1, `rl:${bucket}:${ip}`, WINDOW_MS));
    if (count > limit) {
      if (this.config.RATE_LIMIT_BLOCK_SECONDS > 0) {
        await this.redis.set(blockKey, '1', 'EX', this.config.RATE_LIMIT_BLOCK_SECONDS);
      }
      throw rateLimited();
    }
  }
}
