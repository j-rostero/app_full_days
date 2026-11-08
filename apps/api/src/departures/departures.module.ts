import { Module } from '@nestjs/common';
import { BookingsModule } from '../bookings/bookings.module.ts';
import { DeparturesController } from './departures.controller.ts';

@Module({ imports: [BookingsModule], controllers: [DeparturesController] })
export class DeparturesModule {}
