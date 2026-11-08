import { Module } from '@nestjs/common';
import { SearchController } from './search.controller.ts';
import { SearchService } from './search.service.ts';

@Module({ controllers: [SearchController], providers: [SearchService] })
export class SearchModule {}
