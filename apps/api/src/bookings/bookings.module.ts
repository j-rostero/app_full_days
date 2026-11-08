import { Module } from '@nestjs/common';
import { BookingsController, ProBookingsController } from './bookings.controller.ts';
import { BookingsService } from './bookings.service.ts';

@Module({
  controllers: [BookingsController, ProBookingsController],
  providers: [BookingsService],
  exports: [BookingsService],
})
export class BookingsModule {}
