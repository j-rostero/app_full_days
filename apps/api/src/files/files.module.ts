import { Global, Module } from '@nestjs/common';
import type { Config } from '../config.ts';
import { CONFIG } from '../common/tokens.ts';
import { FilesController } from './files.controller.ts';
import { FilesService } from './files.service.ts';
import { MemoryStorage, S3Storage, STORAGE } from './storage.ts';

@Global()
@Module({
  controllers: [FilesController],
  providers: [
    FilesService,
    {
      provide: STORAGE,
      inject: [CONFIG],
      useFactory: (config: Config) =>
        config.STORAGE_DRIVER === 'memory' ? new MemoryStorage(config) : new S3Storage(config),
    },
  ],
  exports: [FilesService, STORAGE],
})
export class FilesModule {}
