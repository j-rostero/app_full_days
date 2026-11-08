import { z } from 'zod';

/** Semilla pública de desarrollo: sus vouchers no valen en producción. */
const DEV_VOUCHER_KEY = 'd1'.repeat(32);

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
    /** Correo de las notificaciones: `log` las escribe en la salida; `smtp` las envía. */
    NOTIFICATION_EMAIL: z.enum(['log', 'smtp']).default('log'),
    /**
     * Cuenta de servicio de Firebase (JSON completo, o en base64) para enviar push con FCM.
     * Sin ella, el push queda solo en la bandeja de la app.
     */
    FCM_SERVICE_ACCOUNT: z.string().optional(),
    /** Cada cuántos segundos corren los trabajos del worker (vencer apartados, entregar, etc.). */
    JOBS_EVERY_SECONDS: z.coerce.number().int().min(5).default(60),
    GOOGLE_CLIENT_IDS: Csv,
    /**
     * Clave que comparten la API y los servidores de las webs. Con ella, la web informa la IP
     * de la persona (`X-Fulldays-Client-Ip`) para que el límite de peticiones no la confunda
     * con la del servidor web. Sin la clave, esa cabecera se ignora.
     */
    WEB_SERVER_KEY: z.string().min(32).optional(),
    /** `s3` en local y producción; `memory` en las pruebas (no necesita almacenamiento encendido). */
    STORAGE_DRIVER: z.enum(['s3', 'memory']).default('s3'),
    S3_ENDPOINT: z.url().default('http://localhost:9000'),
    /** Dirección del almacenamiento que usan navegadores y apps para subir; por defecto `S3_ENDPOINT`. */
    S3_PUBLIC_ENDPOINT: z.url().optional(),
    S3_REGION: z.string().default('us-east-1'),
    S3_ACCESS_KEY: z.string().default('fulldays'),
    S3_SECRET_KEY: z.string().default('fulldays-secret'),
    S3_BUCKET_IMAGES: z.string().default('fulldays-imagenes'),
    S3_BUCKET_DOCUMENTS: z.string().default('fulldays-documentos'),
    IMGPROXY_URL: z.url().default('http://localhost:8080'),
    /** Clave y sal de imgproxy en hexadecimal (las mismas de la infraestructura). */
    IMGPROXY_KEY: z
      .string()
      .regex(/^[0-9a-f]+$/i)
      .default('736563726574'),
    IMGPROXY_SALT: z
      .string()
      .regex(/^[0-9a-f]+$/i)
      .default('68656C6C6F'),
    /** Semilla Ed25519 (64 caracteres hex) con que se firman los vouchers. */
    VOUCHER_SIGNING_KEY: z
      .string()
      .regex(/^[0-9a-f]{64}$/i, 'debe ser una semilla Ed25519 de 32 bytes en hexadecimal')
      .default(DEV_VOUCHER_KEY),
    /** Claves públicas retiradas (base64url, separadas por comas) cuyos vouchers siguen valiendo. */
    VOUCHER_RETIRED_PUBLIC_KEYS: Csv,
    /** `direct`: el viajero paga a la agencia; `retained`: la plataforma cobra y liquida después. */
    MONEY_MODEL: z.enum(['direct', 'retained']).default('direct'),
  })
  .superRefine((config, ctx) => {
    if (config.NODE_ENV !== 'production') return;
    const reject = (path: string, message: string) =>
      ctx.addIssue({ code: 'custom', path: [path], message });
    if (config.JWT_SECRET === DEV_JWT_SECRET) reject('JWT_SECRET', 'es el secreto de desarrollo');
    if (config.OTP_FIXED_CODE) reject('OTP_FIXED_CODE', 'no se admite en producción');
    if (config.OTP_SENDER === 'log') reject('OTP_SENDER', 'producción necesita smtp');
    if (config.NOTIFICATION_EMAIL === 'log')
      reject('NOTIFICATION_EMAIL', 'producción necesita smtp');
    if (config.STORAGE_DRIVER === 'memory') reject('STORAGE_DRIVER', 'producción necesita s3');
    if (config.VOUCHER_SIGNING_KEY === DEV_VOUCHER_KEY)
      reject('VOUCHER_SIGNING_KEY', 'es la clave de desarrollo');
    if (config.IMGPROXY_KEY === '736563726574') reject('IMGPROXY_KEY', 'es la clave de desarrollo');
    if (config.IMGPROXY_SALT === '68656C6C6F') reject('IMGPROXY_SALT', 'es la sal de desarrollo');
    if (config.S3_SECRET_KEY === 'fulldays-secret')
      reject('S3_SECRET_KEY', 'es la clave del almacenamiento local');
    // Sin la clave, el límite de peticiones ve a todos los visitantes de las webs como una IP.
    if (!config.WEB_SERVER_KEY) reject('WEB_SERVER_KEY', 'producción la necesita');
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
