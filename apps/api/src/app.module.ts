import { Module } from '@nestjs/common';
import { APP_GUARD, APP_INTERCEPTOR, DiscoveryModule } from '@nestjs/core';
import { AccessGuard } from './access/access.guard.ts';
import { AccessModule } from './access/access.module.ts';
import { CatalogsModule } from './catalogs/catalogs.module.ts';
import { SearchModule } from './search/search.module.ts';
import { BookingsModule } from './bookings/bookings.module.ts';
import { PaymentsModule } from './payments/payments.module.ts';
import { TripdayModule } from './tripday/tripday.module.ts';
import { DeparturesModule } from './departures/departures.module.ts';
import { FilesModule } from './files/files.module.ts';
import { ProductsModule } from './products/products.module.ts';
import { ProvidersModule } from './providers/providers.module.ts';
import { AuditInterceptor } from './audit/audit.interceptor.ts';
import { AuthGuard } from './auth/auth.guard.ts';
import { AuthModule } from './auth/auth.module.ts';
import { CoreModule } from './common/core.module.ts';
import { RateLimitGuard } from './common/rate-limit.guard.ts';
import { HealthModule } from './health/health.module.ts';
import { UsersModule } from './users/users.module.ts';

/**
 * Cada área del negocio es un módulo de este único proceso. Llegan uno por fase.
 *
 * Toda petición pasa, en este orden, por: límite de peticiones, sesión (cerrada por
 * defecto), acceso por URL (`/v1/pro/:providerId`, `/v1/central`) y auditoría de escrituras.
 */
@Module({
  imports: [
    DiscoveryModule,
    CoreModule,
    HealthModule,
    AuthModule,
    UsersModule,
    AccessModule,
    FilesModule,
    ProvidersModule,
    CatalogsModule,
    ProductsModule,
    DeparturesModule,
    SearchModule,
    BookingsModule,
    PaymentsModule,
    TripdayModule,
  ],
  providers: [
    { provide: APP_GUARD, useClass: RateLimitGuard },
    { provide: APP_GUARD, useClass: AuthGuard },
    { provide: APP_GUARD, useClass: AccessGuard },
    { provide: APP_INTERCEPTOR, useClass: AuditInterceptor },
  ],
})
export class AppModule {}
