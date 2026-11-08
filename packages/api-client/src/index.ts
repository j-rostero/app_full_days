import createClient from 'openapi-fetch';
import type { components, paths } from './schema.d.ts';

export type { components, paths } from './schema.d.ts';

/** Cuerpo de todo error de la API. Se decide por `code`, nunca por `message`. */
export type ApiError = components['schemas']['ApiError'];
export type Health = components['schemas']['Health'];

/**
 * Cliente tipado de la API, generado del contrato OpenAPI: una ruta o un cuerpo
 * mal escritos no compilan. En las webs solo se usa desde el servidor.
 */
export function createApiClient(baseUrl: string, accessToken?: string, fetchImpl?: typeof fetch) {
  return createClient<paths>({
    baseUrl,
    ...(fetchImpl ? { fetch: fetchImpl } : {}),
    ...(accessToken ? { headers: { Authorization: `Bearer ${accessToken}` } } : {}),
  });
}

export type ApiClient = ReturnType<typeof createApiClient>;
