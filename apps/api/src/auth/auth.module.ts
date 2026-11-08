import { Module } from '@nestjs/common';
import type { Config } from '../config.ts';
import { CONFIG } from '../common/tokens.ts';
import { AuthController } from './auth.controller.ts';
import { GoogleVerifier, googleKeysProvider } from './google.ts';
import { LogOtpSender, OTP_SENDER, SmtpOtpSender } from './otp-sender.ts';
import { OtpService } from './otp.service.ts';
import { SessionService } from './session.service.ts';
import { TokenService } from './token.service.ts';

@Module({
  controllers: [AuthController],
  providers: [
    TokenService,
    SessionService,
    OtpService,
    GoogleVerifier,
    googleKeysProvider,
    {
      provide: OTP_SENDER,
      inject: [CONFIG],
      useFactory: (config: Config) =>
        config.OTP_SENDER === 'smtp'
          ? new SmtpOtpSender(config.SMTP_URL, config.MAIL_FROM)
          : new LogOtpSender(),
    },
  ],
  exports: [TokenService, SessionService],
})
export class AuthModule {}
