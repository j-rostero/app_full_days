import { Module } from '@nestjs/common';
import type { Config } from '../config.ts';
import { CONFIG } from '../common/tokens.ts';
import { BookingsModule } from '../bookings/bookings.module.ts';
import { ProPaymentsController, TravelerPaymentsController } from './payments.controller.ts';
import { VOUCHER_SIGNER } from './payments.module.tokens.ts';
import { PaymentsService } from './payments.service.ts';
import { VoucherSigner } from './vouchers.ts';

@Module({
  imports: [BookingsModule],
  controllers: [TravelerPaymentsController, ProPaymentsController],
  providers: [
    PaymentsService,
    {
      provide: VOUCHER_SIGNER,
      inject: [CONFIG],
      useFactory: (config: Config) =>
        new VoucherSigner(config.VOUCHER_SIGNING_KEY, config.VOUCHER_RETIRED_PUBLIC_KEYS),
    },
  ],
  exports: [PaymentsService, VOUCHER_SIGNER],
})
export class PaymentsModule {}
