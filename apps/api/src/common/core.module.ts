import { Global, Inject, Module, type OnApplicationShutdown } from '@nestjs/common';
import { createDb, type PrismaClient } from '@fulldays/db';
import { Redis } from 'ioredis';
import { loadConfig, type Config } from '../config.ts';
import { transactionalDb } from './db.ts';
import { CONFIG, DB, REDIS } from './tokens.ts';

/** Configuración, base de datos y Redis, disponibles en toda la API. */
@Global()
@Module({
  providers: [
    { provide: CONFIG, useFactory: () => loadConfig() },
    {
      provide: DB,
      inject: [CONFIG],
      useFactory: (config: Config) => transactionalDb(createDb(config.DATABASE_URL)),
    },
    {
      provide: REDIS,
      inject: [CONFIG],
      // lazyConnect: generar el contrato OpenAPI no necesita Redis encendido.
      useFactory: (config: Config) =>
        new Redis(config.REDIS_URL, { lazyConnect: true, maxRetriesPerRequest: 1 }),
    },
  ],
  exports: [CONFIG, DB, REDIS],
})
export class CoreModule implements OnApplicationShutdown {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(REDIS) private readonly redis: Redis,
  ) {}

  async onApplicationShutdown(): Promise<void> {
    await this.db.$disconnect();
    this.redis.disconnect();
  }
}
