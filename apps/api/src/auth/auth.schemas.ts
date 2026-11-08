import { EmailSchema, OtpCodeSchema, PasswordSchema } from '@fulldays/shared';
import { z } from 'zod';

export const RegisterSchema = z
  .strictObject({ email: EmailSchema, password: PasswordSchema })
  .meta({ id: 'RegisterInput' });

export const VerifySchema = z
  .strictObject({ email: EmailSchema, code: OtpCodeSchema })
  .meta({ id: 'VerifyInput' });

export const SignInSchema = z
  .strictObject({ email: EmailSchema, password: z.string().min(1).max(128) })
  .meta({ id: 'SignInInput' });

export const RecoverSchema = z.strictObject({ email: EmailSchema }).meta({ id: 'RecoverInput' });

export const ResetSchema = z
  .strictObject({ email: EmailSchema, code: OtpCodeSchema, password: PasswordSchema })
  .meta({ id: 'ResetInput' });

export const GoogleSchema = z
  .strictObject({ idToken: z.string().min(10).max(4096) })
  .meta({ id: 'GoogleInput' });

export const RenewSchema = z
  .strictObject({ refreshToken: z.string().min(10).max(200) })
  .meta({ id: 'RenewInput' });

export const TokensSchema = z
  .object({
    accessToken: z.string(),
    refreshToken: z.string(),
    /** Segundos de vida del token de acceso. */
    expiresIn: z.number().int(),
  })
  .meta({ id: 'Tokens' });

export const AccountSchema = z
  .object({
    id: z.uuid(),
    email: z.string(),
    name: z.string().nullable(),
    phone: z.string().nullable(),
  })
  .meta({ id: 'Account' });

export const SignedInSchema = z
  .object({
    accessToken: z.string(),
    refreshToken: z.string(),
    expiresIn: z.number().int(),
    user: AccountSchema,
  })
  .meta({ id: 'SignedIn' });

export type Account = z.infer<typeof AccountSchema>;
export type SignedIn = z.infer<typeof SignedInSchema>;
