import { z } from 'zod';

export const FILE_TYPES = {
  image: ['image/jpeg', 'image/png', 'image/webp'],
  document: ['application/pdf', 'image/jpeg', 'image/png'],
} as const;
/** 10 MB. */
export const MAX_FILE_BYTES = 10 * 1024 * 1024;

export const DeclareFileInput = z
  .strictObject({
    kind: z.enum(['image', 'document']),
    contentType: z.string(),
    size: z.number().int().min(1).max(MAX_FILE_BYTES, 'El archivo pasa de 10 MB.'),
  })
  .refine((v) => (FILE_TYPES[v.kind] as readonly string[]).includes(v.contentType), {
    path: ['contentType'],
    message:
      'Ese tipo de archivo no se admite. Usa JPG, PNG o WebP para fotos y PDF, JPG o PNG para documentos.',
  })
  .meta({ id: 'DeclareFileInput' });

export const ImageUrlsSchema = z
  .object({ sm: z.string(), md: z.string(), lg: z.string(), xl: z.string() })
  .meta({ id: 'ImageUrls' });

export const FileSchema = z
  .object({
    id: z.uuid(),
    kind: z.enum(['image', 'document']),
    contentType: z.string(),
    size: z.number().int(),
    status: z.enum(['pending', 'ready']),
    /** Para imágenes listas. */
    image: ImageUrlsSchema.nullable(),
    /** Enlace de descarga de cinco minutos, para documentos listos. */
    downloadUrl: z.string().nullable(),
  })
  .meta({ id: 'File' });

export const DeclaredFileSchema = z
  .object({
    file: FileSchema,
    upload: z.object({
      url: z.string(),
      method: z.literal('PUT'),
      /** Cabeceras que la subida debe enviar tal cual: son parte de la firma. */
      headers: z.record(z.string(), z.string()),
    }),
  })
  .meta({ id: 'DeclaredFile' });

export type FileView = z.infer<typeof FileSchema>;
export type ImageUrls = z.infer<typeof ImageUrlsSchema>;
