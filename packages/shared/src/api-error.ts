import { z } from 'zod';

/**
 * Códigos de error estables. Los clientes deciden por `code`, nunca por el texto de `message`.
 * Cada fase agrega los suyos aquí.
 */
export const API_ERROR_CODES = [
  'bad_request',
  'validation_failed',
  'unauthorized',
  'forbidden',
  'not_found',
  'conflict',
  'too_many_requests',
  'internal_error',
] as const;

export type ApiErrorCode = (typeof API_ERROR_CODES)[number];

/**
 * Un problema de validación por campo. `path` es la ruta en el cuerpo, con los índices como
 * texto: `["pasajeros", "0", "nombre"]`. Solo texto, para que todos los clientes generados
 * (también el de Dart) la lean igual.
 */
export const ApiIssueSchema = z.object({
  path: z.array(z.string()),
  message: z.string(),
});

/** Forma única de todos los errores de la API. */
export const ApiErrorSchema = z.object({
  statusCode: z.number().int(),
  code: z.enum(API_ERROR_CODES),
  message: z.string(),
  issues: z.array(ApiIssueSchema).optional(),
});

export type ApiIssue = z.infer<typeof ApiIssueSchema>;
export type ApiError = z.infer<typeof ApiErrorSchema>;

/** Código por defecto para cada estado HTTP, cuando la excepción no trae uno propio. */
export function codeForStatus(status: number): ApiErrorCode {
  switch (status) {
    case 400:
      return 'bad_request';
    case 401:
      return 'unauthorized';
    case 403:
      return 'forbidden';
    case 404:
      return 'not_found';
    case 409:
      return 'conflict';
    case 422:
      return 'validation_failed';
    case 429:
      return 'too_many_requests';
    default:
      return status >= 500 ? 'internal_error' : 'bad_request';
  }
}
