import { z } from 'zod';
import { PhoneSchema } from './identity.ts';

/** RIF venezolano normalizado a `J-12345678-9`. Letras admitidas: J, G, V, E, P, C. */
export const RifSchema = z
  .string()
  .trim()
  .transform((value, ctx) => {
    const match = /^([JGVEPCjgvepc])[\s.-]*(\d{8})[\s.-]*(\d)$/.exec(value.replace(/\./g, ''));
    if (!match) {
      ctx.addIssue({ code: 'custom', message: 'Escribe un RIF válido, como J-12345678-9.' });
      return z.NEVER;
    }
    return `${match[1]!.toUpperCase()}-${match[2]}-${match[3]}`;
  });

export const PROVIDER_KINDS = ['person', 'company'] as const;
export type ProviderKind = (typeof PROVIDER_KINDS)[number];
export const PROVIDER_KIND_LABELS: Record<ProviderKind, string> = {
  person: 'Persona (organizador independiente)',
  company: 'Empresa (agencia)',
};

export const PROVIDER_STATUSES = [
  'pending',
  'in_review',
  'approved',
  'rejected',
  'suspended',
] as const;
export type ProviderStatus = (typeof PROVIDER_STATUSES)[number];
export const PROVIDER_STATUS_LABELS: Record<ProviderStatus, string> = {
  pending: 'Por enviar',
  in_review: 'En revisión',
  approved: 'Aprobada',
  rejected: 'Rechazada',
  suspended: 'Suspendida',
};

export const PROVIDER_DOCUMENT_TYPES = [
  'rif',
  'representative_id',
  'rtn',
  'commercial_registry',
  'other',
] as const;
export type ProviderDocumentType = (typeof PROVIDER_DOCUMENT_TYPES)[number];
export const PROVIDER_DOCUMENT_LABELS: Record<ProviderDocumentType, string> = {
  rif: 'RIF',
  representative_id: 'Cédula del representante',
  rtn: 'Registro Turístico Nacional (RTN)',
  commercial_registry: 'Registro mercantil',
  other: 'Otro',
};
/** Sin estos documentos la agencia no se puede enviar a verificación. */
export const REQUIRED_PROVIDER_DOCUMENTS: readonly ProviderDocumentType[] = [
  'rif',
  'representative_id',
];

const Text = (min: number, max: number, message: string) =>
  z.string().trim().min(min, message).max(max);

/** Usuario de Instagram sin `@`. Acepta la URL del perfil. */
export const InstagramSchema = z
  .string()
  .trim()
  .transform((v) =>
    v
      .replace(/^https?:\/\/(www\.)?instagram\.com\//i, '')
      .replace(/^@/, '')
      .replace(/\/.*$/, ''),
  )
  .pipe(z.string().regex(/^[A-Za-z0-9._]{1,30}$/, 'Escribe tu usuario de Instagram, sin @.'));

const ProviderFields = {
  kind: z.enum(PROVIDER_KINDS),
  name: Text(2, 80, 'Escribe el nombre comercial.'),
  legalName: Text(2, 160, 'Escribe la razón social o el nombre completo.'),
  rtn: z.string().trim().max(40).nullable().default(null),
  baseCity: Text(2, 80, 'Escribe la ciudad desde donde operas.'),
  phone: PhoneSchema,
  instagram: InstagramSchema.nullable().default(null),
  paymentInstructions: z.string().trim().max(1000).nullable().default(null),
};

/** Alta de una agencia u organizador. Quien la registra queda como dueño. */
export const ProviderInputSchema = z.strictObject({ ...ProviderFields, rif: RifSchema });

/** Cambio de datos. El RIF no se cambia: identifica a la agencia. */
export const ProviderUpdateSchema = z.strictObject({
  kind: ProviderFields.kind.optional(),
  name: ProviderFields.name.optional(),
  legalName: ProviderFields.legalName.optional(),
  rtn: z.string().trim().max(40).nullable().optional(),
  baseCity: ProviderFields.baseCity.optional(),
  phone: PhoneSchema.optional(),
  instagram: InstagramSchema.nullable().optional(),
  paymentInstructions: z.string().trim().max(1000).nullable().optional(),
});

/** Distintivo público: `verified` con RTN, `new` sin él; ninguno mientras no esté aprobada. */
export function providerBadge(provider: {
  status: ProviderStatus;
  rtn: string | null;
}): 'verified' | 'new' | null {
  if (provider.status !== 'approved') return null;
  return provider.rtn ? 'verified' : 'new';
}

/** Transiciones que decide Central. */
export const PROVIDER_DECISIONS = {
  approve: { from: ['in_review', 'suspended'], to: 'approved' },
  reject: { from: ['in_review'], to: 'rejected' },
  suspend: { from: ['approved'], to: 'suspended' },
} as const satisfies Record<string, { from: readonly ProviderStatus[]; to: ProviderStatus }>;

export type ProviderInput = z.infer<typeof ProviderInputSchema>;
export type ProviderUpdate = z.infer<typeof ProviderUpdateSchema>;
