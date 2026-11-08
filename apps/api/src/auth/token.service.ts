import { Inject, Injectable } from '@nestjs/common';
import { jwtVerify, SignJWT } from 'jose';
import type { Config } from '../config.ts';
import type { AuthContext } from '../common/request.ts';
import { CONFIG } from '../common/tokens.ts';

/** Tokens de acceso: JWT HS256 con `sub` = persona y `sid` = sesión. */
@Injectable()
export class TokenService {
  private readonly key: Uint8Array;

  constructor(@Inject(CONFIG) private readonly config: Config) {
    this.key = new TextEncoder().encode(config.JWT_SECRET);
  }

  get accessSeconds(): number {
    return this.config.ACCESS_TOKEN_MINUTES * 60;
  }

  async signAccess(userId: string, sessionId: string): Promise<string> {
    return new SignJWT({ sid: sessionId })
      .setProtectedHeader({ alg: 'HS256' })
      .setSubject(userId)
      .setIssuedAt()
      .setExpirationTime(`${this.accessSeconds}s`)
      .sign(this.key);
  }

  /** Devuelve la sesión del token, o `null` si la firma o la vigencia no valen. */
  async verifyAccess(token: string): Promise<AuthContext | null> {
    try {
      const { payload } = await jwtVerify(token, this.key, { algorithms: ['HS256'] });
      if (typeof payload.sub !== 'string' || typeof payload.sid !== 'string') return null;
      return { userId: payload.sub, sessionId: payload.sid };
    } catch {
      return null;
    }
  }
}
