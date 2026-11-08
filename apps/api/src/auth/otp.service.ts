import { createHmac, randomInt, timingSafeEqual } from 'node:crypto';
import { Inject, Injectable } from '@nestjs/common';
import type { Redis } from 'ioredis';
import type { Config } from '../config.ts';
import { rateLimited } from '../common/api-exception.ts';
import { CONFIG, REDIS } from '../common/tokens.ts';
import { OTP_SENDER, type OtpPurpose, type OtpSender } from './otp-sender.ts';

const CODE_SECONDS = 5 * 60;
const MAX_ATTEMPTS = 5;
const SEND_WINDOW_SECONDS = 15 * 60;

/**
 * Códigos de seis dígitos. En Redis solo se guarda su HMAC con `JWT_SECRET`; viven cinco
 * minutos, admiten cinco intentos y se borran al acertar.
 */
@Injectable()
export class OtpService {
  constructor(
    @Inject(CONFIG) private readonly config: Config,
    @Inject(REDIS) private readonly redis: Redis,
    @Inject(OTP_SENDER) private readonly sender: OtpSender,
  ) {}

  /**
   * Genera y envía un código. Un buzón recibe como mucho `OTP_MAX_SENDS` cada 15 minutos:
   * con `quiet` el exceso no da error (recuperar no debe revelar si la cuenta existe).
   */
  async issue(
    purpose: OtpPurpose,
    email: string,
    options: { quiet?: boolean } = {},
  ): Promise<void> {
    const sentKey = `otp:sent:${email}`;
    const sent = await this.redis.incr(sentKey);
    if (sent === 1) await this.redis.expire(sentKey, SEND_WINDOW_SECONDS);
    if (sent > this.config.OTP_MAX_SENDS) {
      if (options.quiet) return;
      throw rateLimited('Ya te enviamos varios códigos. Espera unos minutos para pedir otro.');
    }
    const code = this.config.OTP_FIXED_CODE ?? String(randomInt(0, 1_000_000)).padStart(6, '0');
    const key = this.codeKey(purpose, email);
    await this.redis
      .multi()
      .hset(key, { hash: this.hmac(code), attempts: 0 })
      .expire(key, CODE_SECONDS)
      .exec();
    await this.sender.send(email, code, purpose);
  }

  /** ¿El código es el vigente? Cada intento cuenta; al acertar se borra. */
  async check(purpose: OtpPurpose, email: string, code: string): Promise<boolean> {
    const key = this.codeKey(purpose, email);
    const hash = await this.redis.hget(key, 'hash');
    if (!hash) return false;
    const attempts = await this.redis.hincrby(key, 'attempts', 1);
    if (attempts > MAX_ATTEMPTS) {
      await this.redis.del(key);
      return false;
    }
    const expected = Buffer.from(hash);
    const actual = Buffer.from(this.hmac(code));
    if (expected.length !== actual.length || !timingSafeEqual(expected, actual)) return false;
    await this.redis.del(key);
    return true;
  }

  private codeKey(purpose: OtpPurpose, email: string): string {
    return `otp:code:${purpose}:${email}`;
  }

  private hmac(code: string): string {
    return createHmac('sha256', this.config.JWT_SECRET).update(code).digest('base64url');
  }
}
