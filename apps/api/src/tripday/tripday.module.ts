import { Module } from '@nestjs/common';
import { PaymentsModule } from '../payments/payments.module.ts';
import { TravelerNoticesController, TripdayController } from './tripday.controller.ts';

@Module({
  imports: [PaymentsModule],
  controllers: [TripdayController, TravelerNoticesController],
})
export class TripdayModule {}
