import { Body, Controller, HttpCode, Inject, Post } from '@nestjs/common';
import type { PrismaClient, User } from '@fulldays/db';
import type { Redis } from 'ioredis';
import type { z } from 'zod';
import {
  ApiException,
  conflict,
  forbidden,
  rateLimited,
  unauthorized,
} from '../common/api-exception.ts';
import { Endpoint, Public } from '../common/endpoint.ts';
import { AuthRateLimit } from '../common/rate-limit.guard.ts';
import { Auth, type AuthContext, Device } from '../common/request.ts';
import { DB, REDIS } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import {
  type Account,
  GoogleSchema,
  RecoverSchema,
  RegisterSchema,
  RenewSchema,
  ResetSchema,
  type SignedIn,
  SignedInSchema,
  SignInSchema,
  TokensSchema,
  VerifySchema,
} from './auth.schemas.ts';
import { GoogleVerifier } from './google.ts';
import { OtpService } from './otp.service.ts';
import { hashPassword, verifyPassword } from './password.ts';
import { SessionService, type Tokens } from './session.service.ts';

const FAILED_LIMIT = 10;
const FAILED_WINDOW_SECONDS = 15 * 60;
const TAG = ['auth'];

const blocked = () => forbidden('Esta cuenta está bloqueada. Escríbenos para revisarla.');
const badCode = () => unauthorized('El código no es correcto o ya venció.');

/** Cuentas por correo con código de confirmación, contraseña o Google, y sesiones por dispositivo. */
@Controller('auth')
export class AuthController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(REDIS) private readonly redis: Redis,
    @Inject(OtpService) private readonly otp: OtpService,
    @Inject(SessionService) private readonly sessions: SessionService,
    @Inject(GoogleVerifier) private readonly google: GoogleVerifier,
  ) {}

  @Post('registrar')
  @HttpCode(204)
  @Public()
  @AuthRateLimit()
  @Endpoint({
    operationId: 'register',
    summary: 'Crea la cuenta (sin confirmar) y envía un código al correo',
    tags: TAG,
    body: RegisterSchema,
    responses: { 204: null },
  })
  async register(
    @Body(new ZodPipe(RegisterSchema)) input: z.infer<typeof RegisterSchema>,
  ): Promise<void> {
    const existing = await this.db.user.findUnique({ where: { email: input.email } });
    if (existing?.emailVerifiedAt) {
      throw conflict('Ya hay una cuenta con ese correo. Entra o recupera tu contraseña.');
    }
    // Sin confirmar, gana la contraseña más reciente: no vale nada hasta confirmar el código.
    const passwordHash = await hashPassword(input.password);
    await this.db.user.upsert({
      where: { email: input.email },
      create: { email: input.email, passwordHash },
      update: { passwordHash },
    });
    await this.otp.issue('verify', input.email);
  }

  @Post('verificar')
  @HttpCode(200)
  @Public()
  @AuthRateLimit()
  @Endpoint({
    operationId: 'verifyEmail',
    summary: 'Confirma el correo con el código y abre sesión',
    tags: TAG,
    body: VerifySchema,
    responses: { 200: SignedInSchema },
  })
  async verify(
    @Body(new ZodPipe(VerifySchema)) input: z.infer<typeof VerifySchema>,
    @Device() device: string,
  ): Promise<SignedIn> {
    if (!(await this.otp.check('verify', input.email, input.code))) throw badCode();
    const user = await this.db.user.findUnique({ where: { email: input.email } });
    if (!user) throw badCode();
    if (user.blockedAt) throw blocked();
    const verified = user.emailVerifiedAt
      ? user
      : await this.db.user.update({
          where: { id: user.id },
          data: { emailVerifiedAt: new Date() },
        });
    return this.signedIn(verified, await this.sessions.open(user.id, device));
  }

  @Post('entrar')
  @HttpCode(200)
  @Public()
  @AuthRateLimit()
  @Endpoint({
    operationId: 'signIn',
    summary: 'Entra con correo y contraseña',
    tags: TAG,
    body: SignInSchema,
    responses: { 200: SignedInSchema },
  })
  async signIn(
    @Body(new ZodPipe(SignInSchema)) input: z.infer<typeof SignInSchema>,
    @Device() device: string,
  ): Promise<SignedIn> {
    const failedKey = `signin:failed:${input.email}`;
    if (Number(await this.redis.get(failedKey)) >= FAILED_LIMIT) {
      throw rateLimited(
        'Demasiados intentos con este correo. Espera 15 minutos o recupera tu contraseña.',
      );
    }
    const user = await this.db.user.findUnique({ where: { email: input.email } });
    if (!(await verifyPassword(input.password, user?.passwordHash)) || !user) {
      const failed = await this.redis.incr(failedKey);
      if (failed === 1) await this.redis.expire(failedKey, FAILED_WINDOW_SECONDS);
      throw unauthorized('El correo o la contraseña no son correctos.');
    }
    if (user.blockedAt) throw blocked();
    if (!user.emailVerifiedAt) {
      await this.otp.issue('verify', user.email, { quiet: true });
      throw new ApiException(
        403,
        'email_not_verified',
        'Confirma tu correo con el código que te enviamos.',
      );
    }
    await this.redis.del(failedKey);
    return this.signedIn(user, await this.sessions.open(user.id, device));
  }

  @Post('recuperar')
  @HttpCode(204)
  @Public()
  @AuthRateLimit()
  @Endpoint({
    operationId: 'recoverPassword',
    summary:
      'Envía un código para elegir una contraseña nueva (responde igual exista o no la cuenta)',
    tags: TAG,
    body: RecoverSchema,
    responses: { 204: null },
  })
  async recover(
    @Body(new ZodPipe(RecoverSchema)) input: z.infer<typeof RecoverSchema>,
  ): Promise<void> {
    const user = await this.db.user.findUnique({ where: { email: input.email } });
    if (user && !user.blockedAt) await this.otp.issue('reset', user.email, { quiet: true });
  }

  @Post('restablecer')
  @HttpCode(200)
  @Public()
  @AuthRateLimit()
  @Endpoint({
    operationId: 'resetPassword',
    summary: 'Fija la contraseña nueva con el código, cierra las demás sesiones y abre una',
    tags: TAG,
    body: ResetSchema,
    responses: { 200: SignedInSchema },
  })
  async reset(
    @Body(new ZodPipe(ResetSchema)) input: z.infer<typeof ResetSchema>,
    @Device() device: string,
  ): Promise<SignedIn> {
    if (!(await this.otp.check('reset', input.email, input.code))) throw badCode();
    const user = await this.db.user.findUnique({ where: { email: input.email } });
    if (!user) throw badCode();
    if (user.blockedAt) throw blocked();
    const updated = await this.db.user.update({
      where: { id: user.id },
      // El código llegó a su buzón: el correo queda confirmado.
      data: {
        passwordHash: await hashPassword(input.password),
        emailVerifiedAt: user.emailVerifiedAt ?? new Date(),
      },
    });
    await this.sessions.revokeAll(user.id);
    await this.redis.del(`signin:failed:${user.email}`);
    return this.signedIn(updated, await this.sessions.open(user.id, device));
  }

  @Post('google')
  @HttpCode(200)
  @Public()
  @AuthRateLimit()
  @Endpoint({
    operationId: 'signInWithGoogle',
    summary: 'Entra con un token de Google; crea la cuenta la primera vez',
    tags: TAG,
    body: GoogleSchema,
    responses: { 200: SignedInSchema },
  })
  async signInWithGoogle(
    @Body(new ZodPipe(GoogleSchema)) input: z.infer<typeof GoogleSchema>,
    @Device() device: string,
  ): Promise<SignedIn> {
    const identity = await this.google.verify(input.idToken);
    const byGoogle = await this.db.user.findUnique({ where: { googleId: identity.googleId } });
    const byEmail =
      byGoogle ?? (await this.db.user.findUnique({ where: { email: identity.email } }));
    let user: User;
    if (byEmail) {
      if (byEmail.blockedAt) throw blocked();
      user = await this.db.user.update({
        where: { id: byEmail.id },
        data: {
          googleId: identity.googleId,
          name: byEmail.name ?? identity.name,
          emailVerifiedAt: byEmail.emailVerifiedAt ?? new Date(),
          // Un correo nunca confirmado pudo registrarlo otra persona: su contraseña no vale.
          ...(byEmail.emailVerifiedAt ? {} : { passwordHash: null }),
        },
      });
    } else {
      user = await this.db.user.create({
        data: {
          email: identity.email,
          name: identity.name,
          googleId: identity.googleId,
          emailVerifiedAt: new Date(),
        },
      });
    }
    return this.signedIn(user, await this.sessions.open(user.id, device));
  }

  @Post('renovar')
  @HttpCode(200)
  @Public()
  @Endpoint({
    operationId: 'renewSession',
    summary: 'Cambia un token de renovación por un par nuevo',
    tags: TAG,
    body: RenewSchema,
    responses: { 200: TokensSchema },
  })
  async renew(@Body(new ZodPipe(RenewSchema)) input: z.infer<typeof RenewSchema>): Promise<Tokens> {
    return this.sessions.renew(input.refreshToken);
  }

  @Post('salir')
  @HttpCode(204)
  @Endpoint({
    operationId: 'signOut',
    summary: 'Cierra la sesión de este dispositivo',
    tags: TAG,
    responses: { 204: null },
  })
  async signOut(@Auth() auth: AuthContext): Promise<void> {
    await this.sessions.revoke(auth.sessionId);
  }

  @Post('salir-de-todos')
  @HttpCode(204)
  @Endpoint({
    operationId: 'signOutEverywhere',
    summary: 'Cierra las sesiones de todos los dispositivos de la persona',
    tags: TAG,
    responses: { 204: null },
  })
  async signOutEverywhere(@Auth() auth: AuthContext): Promise<void> {
    await this.sessions.revokeAll(auth.userId);
  }

  private signedIn(user: User, tokens: Tokens): SignedIn {
    const account: Account = { id: user.id, email: user.email, name: user.name, phone: user.phone };
    return { ...tokens, user: account };
  }
}
