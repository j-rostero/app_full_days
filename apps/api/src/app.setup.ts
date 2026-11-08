import 'reflect-metadata';
import { type INestApplication, RequestMethod } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import type { NestExpressApplication } from '@nestjs/platform-express';
import { AppModule } from './app.module.ts';
import { ApiErrorFilter } from './common/api-error.filter.ts';
import { CONFIG } from './common/tokens.ts';
import type { Config } from './config.ts';

/** Prefijo de todas las rutas del negocio. `/salud` queda fuera. */
export const API_PREFIX = 'v1';
export const UNPREFIXED = [{ path: 'salud', method: RequestMethod.ALL }];

/** Crea la aplicación configurada, sin escuchar. La usan `main`, las pruebas y la generación del contrato. */
export async function createApp(options: { logger?: false } = {}): Promise<INestApplication> {
  const app = await NestFactory.create<NestExpressApplication>(AppModule, {
    logger: options.logger,
  });
  const config = app.get<Config>(CONFIG);
  // Sin esto, detrás de un proxy todas las peticiones parecen venir de la misma IP.
  app.set('trust proxy', config.TRUST_PROXY);
  app.disable('x-powered-by');
  app.setGlobalPrefix(API_PREFIX, { exclude: UNPREFIXED });
  app.useGlobalFilters(new ApiErrorFilter());
  // Las webs llaman desde su servidor y las apps nativas no envían origen:
  // CORS solo hace falta para orígenes de navegador declarados.
  app.enableCors({ origin: config.CORS_ORIGINS, credentials: false });
  app.enableShutdownHooks();
  return app;
}
