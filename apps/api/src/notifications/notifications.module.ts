import { Global, Module } from '@nestjs/common';
import type { Config } from '../config.ts';
import { CONFIG } from '../common/tokens.ts';
import { NotificationsController } from './notifications.controller.ts';
import { NotificationsService } from './notifications.service.ts';
import {
  DisabledPushSender,
  EMAIL_SENDER,
  FcmPushSender,
  LogEmailSender,
  PUSH_SENDER,
  SmtpEmailSender,
} from './senders.ts';

/** Global: cualquier módulo encola mensajes sin importarlo. */
@Global()
@Module({
  controllers: [NotificationsController],
  providers: [
    NotificationsService,
    {
      provide: PUSH_SENDER,
      inject: [CONFIG],
      useFactory: (c: Config) =>
        c.FCM_SERVICE_ACCOUNT ? new FcmPushSender(c.FCM_SERVICE_ACCOUNT) : new DisabledPushSender(),
    },
    {
      provide: EMAIL_SENDER,
      inject: [CONFIG],
      useFactory: (c: Config) =>
        c.NOTIFICATION_EMAIL === 'smtp'
          ? new SmtpEmailSender(c.SMTP_URL, c.MAIL_FROM)
          : new LogEmailSender(),
    },
  ],
  exports: [NotificationsService],
})
export class NotificationsModule {}
