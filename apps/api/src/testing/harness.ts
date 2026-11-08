import { randomUUID } from 'node:crypto';
import type { INestApplication } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import { createApp } from '../app.setup.ts';
import { DB } from '../common/tokens.ts';

/** Código fijo de las pruebas (OTP_FIXED_CODE). */
export const CODE = '123456';
export const PASSWORD = 'clave-segura-1';

/**
 * API real contra PostgreSQL y Redis del entorno, con código fijo y límites altos.
 * Cada archivo de pruebas corre en su propio proceso, así que fijar el entorno aquí no se
 * filtra a otros.
 */
export async function startApi(env: Record<string, string> = {}): Promise<Api> {
  Object.assign(process.env, {
    NODE_ENV: 'test',
    OTP_FIXED_CODE: CODE,
    STORAGE_DRIVER: 'memory',
    OTP_MAX_SENDS: '1000',
    RATE_LIMIT_PER_MINUTE: '100000',
    AUTH_RATE_LIMIT_PER_MINUTE: '100000',
    ...env,
  });
  const app = await createApp({ logger: false });
  await app.listen(0);
  return new Api(app, await app.getUrl());
}

export interface Reply<T = Record<string, unknown>> {
  status: number;
  body: T;
}

export class Api {
  constructor(
    readonly app: INestApplication,
    readonly base: string,
  ) {}

  get db(): PrismaClient {
    return this.app.get<PrismaClient>(DB);
  }

  async call<T = Record<string, unknown>>(
    method: string,
    path: string,
    options: { body?: unknown; token?: string; headers?: Record<string, string> } = {},
  ): Promise<Reply<T>> {
    const res = await fetch(`${this.base}${path}`, {
      method,
      headers: {
        ...(options.body !== undefined ? { 'content-type': 'application/json' } : {}),
        ...(options.token ? { authorization: `Bearer ${options.token}` } : {}),
        ...options.headers,
      },
      body: options.body === undefined ? undefined : JSON.stringify(options.body),
    });
    const text = await res.text();
    return { status: res.status, body: (text ? JSON.parse(text) : null) as T };
  }

  /** Registra y confirma una cuenta nueva; devuelve sus tokens. */
  async signUp(email = uniqueEmail()): Promise<Session> {
    await this.call('POST', '/v1/auth/registrar', { body: { email, password: PASSWORD } });
    const res = await this.call<Session>('POST', '/v1/auth/verificar', {
      body: { email, code: CODE },
    });
    if (res.status !== 200) throw new Error(`verificar: ${res.status} ${JSON.stringify(res.body)}`);
    return res.body;
  }

  close(): Promise<void> {
    return this.app.close();
  }
}

export interface Session {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
  user: { id: string; email: string; name: string | null; phone: string | null };
}

export function uniqueEmail(prefix = 'prueba'): string {
  return `${prefix}-${randomUUID().slice(0, 8)}@ejemplo.com`;
}

/** RIF aleatorio válido (`J-########-#`). */
export function randomRif(): string {
  const digits = String(Math.floor(Math.random() * 1e8)).padStart(8, '0');
  return `J-${digits}-${Math.floor(Math.random() * 10)}`;
}

/** Agencia creada directo en la base, con `ownerId` como dueño. */
export async function createProvider(
  db: PrismaClient,
  ownerId: string,
  data: Partial<{
    name: string;
    status: 'pending' | 'in_review' | 'approved';
    rtn: string | null;
  }> = {},
): Promise<string> {
  const provider = await db.provider.create({
    data: {
      kind: 'company',
      name: data.name ?? 'Viajes Prueba',
      legalName: 'Viajes Prueba C.A.',
      rif: randomRif(),
      rtn: data.rtn ?? null,
      baseCity: 'Caracas',
      phone: '+584141234567',
      status: data.status ?? 'pending',
    },
  });
  await db.providerMember.create({
    data: { providerId: provider.id, userId: ownerId, role: 'owner' },
  });
  return provider.id;
}
