import { Module } from '@nestjs/common';
import { BookingsModule } from '../bookings/bookings.module.ts';
import { CatalogsModule } from '../catalogs/catalogs.module.ts';
import { CoreModule } from '../common/core.module.ts';
import { FilesModule } from '../files/files.module.ts';
import { NotificationsModule } from '../notifications/notifications.module.ts';
import { JobsService } from './jobs.service.ts';

/** Lo que necesita el worker: sin rutas HTTP, solo servicios. */
@Module({
  imports: [CoreModule, NotificationsModule, FilesModule, CatalogsModule, BookingsModule],
  providers: [JobsService],
  exports: [JobsService],
})
export class JobsModule {}
