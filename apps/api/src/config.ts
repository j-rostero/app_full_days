import { z } from 'zod';

const Csv = z
  .string()
  .default('')
  .transform((value) =>
    value
      .split(',')
      .map((item) => item.trim())
      .filter(Boolean),
  );

/** Secreto de desarrollo: producción se niega a arrancar con él. */
export const DEV_JWT_SECRET = 'desarrollo-no-usar-en-produccion-0123456789';

/** Variables de entorno de la API. Se validan al arrancar: una falta o un error detienen el proceso. */
export const ConfigSchema = z
  .object({
    NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
    PORT: z.coerce.number().int().min(0).max(65535).default(4000),
    DATABASE_URL: z.url().default('postgresql://fulldays:fulldays@localhost:5432/fulldays'),
    REDIS_URL: z.url().default('redis://localhost:6379/0'),
    CORS_ORIGINS: Csv,
    /** Proxies delante de la API; sin el valor correcto el límite de peticiones ve la IP del proxy. */
    TRUST_PROXY: z.coerce.number().int().min(0).default(0),
    RATE_LIMIT_PER_MINUTE: z.coerce.number().int().min(1).default(120),
    AUTH_RATE_LIMIT_PER_MINUTE: z.coerce.number().int().min(1).default(20),
    /** Al pasarse del límite, la IP queda bloqueada estos segundos (además del resto de la ventana). */
    RATE_LIMIT_BLOCK_SECONDS: z.coerce.number().int().min(0).default(60),
    JWT_SECRET: z.string().min(32).default(DEV_JWT_SECRET),
    ACCESS_TOKEN_MINUTES: z.coerce.number().int().min(1).max(60).default(15),
    REFRESH_TOKEN_DAYS: z.coerce.number().int().min(1).max(365).default(60),
    OTP_SENDER: z.enum(['log', 'smtp']).default('log'),
    OTP_MAX_SENDS: z.coerce.number().int().min(1).default(3),
    /** Seis dígitos fijos para pruebas de punta a punta. Prohibido en producción. */
    OTP_FIXED_CODE: z
      .string()
      .regex(/^\d{6}$/)
      .optional(),
    SMTP_URL: z.string().default('smtp://localhost:1025'),
    MAIL_FROM: z.string().default('FullDays <no-responder@fulldays.local>'),
    GOOGLE_CLIENT_IDS: Csv,
    /**
     * Clave que comparten la API y los servidores de las webs. Con ella, la web informa la IP
     * de la persona (`X-Fulldays-Client-Ip`) para que el límite de peticiones no la confunda
     * con la del servidor web. Sin la clave, esa cabecera se ignora.
     */
    WEB_SERVER_KEY: z.string().min(32).optional(),
  })
  .superRefine((config, ctx) => {
    if (config.NODE_ENV !== 'production') return;
    const reject = (path: string, message: string) =>
      ctx.addIssue({ code: 'custom', path: [path], message });
    if (config.JWT_SECRET === DEV_JWT_SECRET) reject('JWT_SECRET', 'es el secreto de desarrollo');
    if (config.OTP_FIXED_CODE) reject('OTP_FIXED_CODE', 'no se admite en producción');
    if (config.OTP_SENDER === 'log') reject('OTP_SENDER', 'producción necesita smtp');
  });

export type Config = z.infer<typeof ConfigSchema>;

export function loadConfig(env: NodeJS.ProcessEnv = process.env): Config {
  const parsed = ConfigSchema.safeParse(env);
  if (!parsed.success) {
    const detail = parsed.error.issues.map((i) => `${i.path.join('.')}: ${i.message}`).join('; ');
    throw new Error(`Configuración inválida: ${detail}`);
  }
  return parsed.data;
}
