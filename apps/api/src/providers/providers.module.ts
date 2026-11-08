import { Module } from '@nestjs/common';
import { ProvidersController } from './providers.controller.ts';
import { ProvidersService } from './providers.service.ts';
import { VerificationController } from './verification.controller.ts';

@Module({
  controllers: [ProvidersController, VerificationController],
  providers: [ProvidersService],
  exports: [ProvidersService],
})
export class ProvidersModule {}
