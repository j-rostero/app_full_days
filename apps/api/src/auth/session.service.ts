import { createHash, createHmac, randomBytes } from 'node:crypto';
import { Inject, Injectable } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import type { Redis } from 'ioredis';
import type { Config } from '../config.ts';
import { unauthorized } from '../common/api-exception.ts';
import { CONFIG, DB, REDIS } from '../common/tokens.ts';
import { TokenService } from './token.service.ts';

/** Ventana en que repetir una renovación ya hecha se trata como reintento y no como robo. */
const RETRY_WINDOW_MS = 60_000;

export interface Tokens {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
}

const sha256 = (value: string) => createHash('sha256').update(value).digest('base64url');

/**
 * Sesiones por dispositivo. El token de renovación se guarda solo como SHA-256 y rota en
 * cada renovación: el siguiente se deriva del anterior con HMAC, así que la misma
 * renovación repetida (respuesta perdida, dos pestañas) obtiene el mismo token. Los tokens
 * reemplazados se guardan (como hash): cualquiera que vuelva fuera de la ventana de reintento
 * se trata como copiado y se cierra la sesión entera.
 */
@Injectable()
export class SessionService {
  constructor(
    @Inject(CONFIG) private readonly config: Config,
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(REDIS) private readonly redis: Redis,
    @Inject(TokenService) private readonly tokens: TokenService,
  ) {}

  async open(userId: string, device: string): Promise<Tokens> {
    const refreshToken = randomBytes(32).toString('base64url');
    const session = await this.db.session.create({
      data: { userId, tokenHash: sha256(refreshToken), device, expiresAt: this.expiry() },
    });
    return this.pair(userId, session.id, refreshToken);
  }

  async renew(refreshToken: string): Promise<Tokens> {
    const hash = sha256(refreshToken);
    const successor = this.successorOf(refreshToken);
    const now = new Date();

    const rotated = await this.db.$transaction(async (tx) => {
      const [session] = await tx.session.updateManyAndReturn({
        where: { tokenHash: hash, revokedAt: null, expiresAt: { gt: now } },
        data: { tokenHash: sha256(successor), expiresAt: this.expiry() },
      });
      if (session)
        await tx.retiredToken.create({
          data: { tokenHash: hash, sessionId: session.id, retiredAt: now },
        });
      return session;
    });
    if (rotated) return this.pair(rotated.userId, rotated.id, successor);

    const retired = await this.db.retiredToken.findUnique({
      where: { tokenHash: hash },
      include: { session: true },
    });
    const session = retired?.session;
    if (retired && session && !session.revokedAt && session.expiresAt > now) {
      // La misma renovación repetida (respuesta perdida, dos pestañas): su sucesor sigue vigente.
      const isRetry =
        session.tokenHash === sha256(successor) &&
        now.getTime() - retired.retiredAt.getTime() <= RETRY_WINDOW_MS;
      if (isRetry) return this.pair(session.userId, session.id, successor);
      // Un token reemplazado que vuelve: alguien tiene una copia. Se cierra la sesión.
      await this.revoke(session.id);
    }
    throw unauthorized('Tu sesión venció. Vuelve a entrar.');
  }

  async revoke(sessionId: string): Promise<void> {
    await this.db.session.updateMany({
      where: { id: sessionId, revokedAt: null },
      data: { revokedAt: new Date() },
    });
    await this.markRevoked([sessionId]);
  }

  /** Cierra todas las sesiones de la persona, salvo `exceptSessionId` si se da. */
  async revokeAll(userId: string, exceptSessionId?: string): Promise<void> {
    const open = await this.db.session.findMany({
      where: {
        userId,
        revokedAt: null,
        ...(exceptSessionId ? { id: { not: exceptSessionId } } : {}),
      },
      select: { id: true },
    });
    if (open.length === 0) return;
    await this.db.session.updateMany({
      where: { id: { in: open.map((s) => s.id) } },
      data: { revokedAt: new Date() },
    });
    await this.markRevoked(open.map((s) => s.id));
  }

  /** Corta al instante los tokens de acceso aún vigentes de una sesión cerrada. */
  async isRevoked(sessionId: string): Promise<boolean> {
    return (await this.redis.exists(`revoked:${sessionId}`)) === 1;
  }

  private async markRevoked(sessionIds: string[]): Promise<void> {
    const pipeline = this.redis.multi();
    for (const id of sessionIds)
      pipeline.set(`revoked:${id}`, '1', 'EX', this.tokens.accessSeconds);
    await pipeline.exec();
  }

  private successorOf(refreshToken: string): string {
    return createHmac('sha256', this.config.JWT_SECRET).update(refreshToken).digest('base64url');
  }

  private expiry(): Date {
    return new Date(Date.now() + this.config.REFRESH_TOKEN_DAYS * 86_400_000);
  }

  private async pair(userId: string, sessionId: string, refreshToken: string): Promise<Tokens> {
    return {
      accessToken: await this.tokens.signAccess(userId, sessionId),
      refreshToken,
      expiresIn: this.tokens.accessSeconds,
    };
  }
}
