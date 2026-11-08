import { Inject, Injectable } from '@nestjs/common';
import { createRemoteJWKSet, jwtVerify, type JWTVerifyGetKey } from 'jose';
import type { Config } from '../config.ts';
import { conflict, unauthorized } from '../common/api-exception.ts';
import { CONFIG } from '../common/tokens.ts';

export interface GoogleIdentity {
  googleId: string;
  email: string;
  name: string | null;
}

export const GOOGLE_KEYS = Symbol('GOOGLE_KEYS');

/** Claves públicas de Google. Las pruebas sustituyen este proveedor por claves propias. */
export const googleKeysProvider = {
  provide: GOOGLE_KEYS,
  useFactory: (): JWTVerifyGetKey =>
    createRemoteJWKSet(new URL('https://www.googleapis.com/oauth2/v3/certs')),
};

/**
 * Verifica un token de Google: firma, emisor, que la audiencia sea uno de
 * `GOOGLE_CLIENT_IDS` y que Google haya confirmado el correo.
 */
@Injectable()
export class GoogleVerifier {
  constructor(
    @Inject(CONFIG) private readonly config: Config,
    @Inject(GOOGLE_KEYS) private readonly keys: JWTVerifyGetKey,
  ) {}

  async verify(idToken: string): Promise<GoogleIdentity> {
    if (this.config.GOOGLE_CLIENT_IDS.length === 0) {
      throw conflict('Entrar con Google todavía no está disponible.');
    }
    try {
      const { payload } = await jwtVerify(idToken, this.keys, {
        issuer: ['https://accounts.google.com', 'accounts.google.com'],
        audience: this.config.GOOGLE_CLIENT_IDS,
      });
      if (typeof payload.sub !== 'string' || typeof payload.email !== 'string') throw new Error();
      if (payload.email_verified !== true) throw new Error();
      return {
        googleId: payload.sub,
        email: payload.email.trim().toLowerCase(),
        name: typeof payload.name === 'string' ? payload.name : null,
      };
    } catch {
      throw unauthorized('No pudimos confirmar tu cuenta de Google.');
    }
  }
}
