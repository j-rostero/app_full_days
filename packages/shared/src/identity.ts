import { z } from 'zod';

/** Correo: se recorta y se pasa a minúsculas antes de validar, así `Ana@x.com` y `ana@x.com` son la misma cuenta. */
export const EmailSchema = z
  .string()
  .trim()
  .toLowerCase()
  .max(254, 'El correo es demasiado largo.')
  .pipe(z.email('Escribe un correo válido.'));

export const PasswordSchema = z
  .string()
  .min(8, 'La contraseña debe tener al menos 8 caracteres.')
  .max(128, 'La contraseña no puede pasar de 128 caracteres.');

export const OtpCodeSchema = z
  .string()
  .trim()
  .regex(/^\d{6}$/, 'El código tiene 6 dígitos.');

/**
 * Teléfono en formato E.164. Acepta `0412…`, `58412…`, `+58 412…` y `00…`.
 * Los números venezolanos deben ser celulares (412, 414, 416, 422, 424, 426);
 * los extranjeros necesitan prefijo internacional.
 */
export const PhoneSchema = z
  .string()
  .trim()
  .transform((value, ctx) => {
    const normalized = normalizePhone(value);
    if (!normalized) {
      ctx.addIssue({ code: 'custom', message: 'Escribe un celular válido, como 0414 1234567.' });
      return z.NEVER;
    }
    return normalized;
  });

const VE_MOBILE = /^58(412|414|416|422|424|426)\d{7}$/;

export function normalizePhone(value: string): string | null {
  const digits = value.replace(/[\s().-]/g, '');
  if (!/^\+?\d+$/.test(digits)) return null;
  let international: string;
  if (digits.startsWith('+')) international = digits.slice(1);
  else if (digits.startsWith('00')) international = digits.slice(2);
  else if (digits.startsWith('0')) international = `58${digits.slice(1)}`;
  else if (digits.startsWith('58')) international = digits;
  else return null;
  if (international.startsWith('58'))
    return VE_MOBILE.test(international) ? `+${international}` : null;
  return international.length >= 8 && international.length <= 15 ? `+${international}` : null;
}

/** Cédula venezolana normalizada a `V-12345678` o `E-12345678`. Sin letra se asume `V`. */
export const CedulaSchema = z
  .string()
  .trim()
  .transform((value, ctx) => {
    const match = /^([VEve])?[\s.-]*(\d[\d.]{4,11})$/.exec(value);
    const number = match?.[2]?.replace(/\./g, '') ?? '';
    if (!match || number.length < 6 || number.length > 9) {
      ctx.addIssue({ code: 'custom', message: 'Escribe una cédula válida, como V-12345678.' });
      return z.NEVER;
    }
    return `${(match[1] ?? 'V').toUpperCase()}-${number}`;
  });

const NameSchema = z.string().trim().min(2, 'Escribe el nombre.').max(120);

/** Datos que la persona cambia de sí misma. El correo no se cambia aquí. */
export const ProfileUpdateSchema = z.strictObject({
  name: NameSchema.optional(),
  phone: PhoneSchema.nullable().optional(),
});

/** Pasajero frecuente de una persona. */
export const PassengerInputSchema = z.strictObject({
  name: NameSchema,
  cedula: CedulaSchema.nullable().default(null),
  birthDate: z.iso.date('Escribe la fecha como AAAA-MM-DD.').refine(isPlausibleBirthDate, {
    message: 'La fecha de nacimiento no es válida.',
  }),
  restrictions: z.string().trim().max(300).nullable().default(null),
});

function isPlausibleBirthDate(value: string): boolean {
  const date = new Date(`${value}T00:00:00Z`);
  const now = Date.now();
  return date.getTime() <= now && now - date.getTime() < 120 * 365.25 * 86_400_000;
}

export type ProfileUpdate = z.infer<typeof ProfileUpdateSchema>;
export type PassengerInput = z.infer<typeof PassengerInputSchema>;
