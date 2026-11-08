import 'reflect-metadata';
import { Logger } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { Queue, Worker } from 'bullmq';
import { Redis } from 'ioredis';
import { CONFIG } from './common/tokens.ts';
import type { Config } from './config.ts';
import { JobsModule } from './jobs/jobs.module.ts';
import { JobsService } from './jobs/jobs.service.ts';
import { productionLogger } from './common/logger.ts';

/**
 * Proceso aparte de la API para las tareas periódicas. Se pueden correr varias instancias:
 * BullMQ agenda cada tarea una sola vez por intervalo y la entrega de mensajes toma filas con
 * `FOR UPDATE SKIP LOCKED`, así que ningún mensaje sale dos veces.
 */
const QUEUE = 'fulldays-jobs';
const DELIVER_EVERY_MS = 10_000;
const log = new Logger('Worker');

const app = await NestFactory.createApplicationContext(JobsModule, {
  logger: productionLogger(),
});
app.enableShutdownHooks();
const config = app.get<Config>(CONFIG);
const jobs = app.get(JobsService);
const connection = () => new Redis(config.REDIS_URL, { maxRetriesPerRequest: null });

const queue = new Queue(QUEUE, { connection: connection() });
await queue.upsertJobScheduler(
  'sweep',
  { every: config.JOBS_EVERY_SECONDS * 1000 },
  { name: 'sweep', opts: { removeOnComplete: 100, removeOnFail: 100 } },
);
await queue.upsertJobScheduler(
  'deliver',
  { every: DELIVER_EVERY_MS },
  { name: 'deliver', opts: { removeOnComplete: 100, removeOnFail: 100 } },
);

const worker = new Worker(
  QUEUE,
  async (job) => {
    if (job.name === 'deliver') return { sent: await jobs.deliver() };
    if (job.name === 'sweep') return jobs.sweep();
    throw new Error(`Tarea desconocida: ${job.name}`);
  },
  { connection: connection(), concurrency: 2 },
);
worker.on('completed', (job, result: Record<string, number>) => {
  if (Object.values(result ?? {}).some((n) => n > 0))
    log.log(`${job.name}: ${JSON.stringify(result)}`);
});
worker.on('failed', (job, error) => log.error(`${job?.name ?? 'tarea'} falló: ${error.message}`));
log.log(`Worker activo: mantenimiento cada ${config.JOBS_EVERY_SECONDS} s, entregas cada 10 s`);

const stop = async () => {
  await worker.close();
  await queue.close();
  await app.close();
  process.exit(0);
};
process.once('SIGTERM', () => void stop());
process.once('SIGINT', () => void stop());
