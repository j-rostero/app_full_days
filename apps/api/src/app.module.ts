import { Module } from '@nestjs/common';
import { DiscoveryModule } from '@nestjs/core';
import { CoreModule } from './common/core.module.ts';
import { HealthModule } from './health/health.module.ts';

/** Cada área del negocio es un módulo de este único proceso. Llegan uno por fase. */
@Module({ imports: [DiscoveryModule, CoreModule, HealthModule] })
export class AppModule {}
