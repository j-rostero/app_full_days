import { Controller, Get, Inject, Res } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import type { Response } from 'express';
import type { Redis } from 'ioredis';
import { z } from 'zod';
import { Endpoint } from '../common/endpoint.ts';
import { DB, REDIS } from '../common/tokens.ts';

const CheckSchema = z.enum(['ok', 'down']);

export const HealthSchema = z
  .object({
    status: z.enum(['ok', 'degraded']),
    checks: z.object({ database: CheckSchema, redis: CheckSchema }),
  })
  .meta({ id: 'Health', description: 'Estado de la API y de los servicios de los que depende.' });

export type Health = z.infer<typeof HealthSchema>;

const TIMEOUT_MS = 2000;

/** Monitoreo. Vive fuera de `/v1`: no es parte del negocio y no cambia de versión. */
@Controller('salud')
export class HealthController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(REDIS) private readonly redis: Redis,
  ) {}

  @Get()
  @Endpoint({
    operationId: 'getHealth',
    summary: 'Estado de la API, la base de datos y Redis',
    tags: ['salud'],
    responses: { 200: HealthSchema, 503: HealthSchema },
  })
  async check(@Res({ passthrough: true }) res: Response): Promise<Health> {
    const [database, redis] = await Promise.all([
      probe(() => this.db.$queryRaw`SELECT 1`),
      probe(() => this.redis.ping()),
    ]);
    const status = database === 'ok' && redis === 'ok' ? 'ok' : 'degraded';
    res.status(status === 'ok' ? 200 : 503);
    return { status, checks: { database, redis } };
  }
}

async function probe(run: () => Promise<unknown>): Promise<'ok' | 'down'> {
  let timer: NodeJS.Timeout | undefined;
  const timeout = new Promise<never>((_, reject) => {
    timer = setTimeout(() => reject(new Error('timeout')), TIMEOUT_MS);
  });
  try {
    await Promise.race([run(), timeout]);
    return 'ok';
  } catch {
    return 'down';
  } finally {
    clearTimeout(timer);
  }
}
