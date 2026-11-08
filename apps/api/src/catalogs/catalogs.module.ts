import { Global, Module } from '@nestjs/common';
import { CatalogsController } from './catalogs.controller.ts';
import { SettingsService } from './settings.service.ts';

@Global()
@Module({
  controllers: [CatalogsController],
  providers: [SettingsService],
  exports: [SettingsService],
})
export class CatalogsModule {}
