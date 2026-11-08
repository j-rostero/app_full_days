import { Module } from '@nestjs/common';
import { DeparturesController } from './departures.controller.ts';

@Module({ controllers: [DeparturesController] })
export class DeparturesModule {}
