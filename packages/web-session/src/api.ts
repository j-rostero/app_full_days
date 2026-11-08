import { createApiClient } from '@fulldays/api-client';

export const API_URL = process.env.API_URL ?? 'http://localhost:4000';

/**
 * Cliente de la API para el servidor de la web. Con `WEB_SERVER_KEY` informa la IP de la
 * persona, para que el límite de peticiones de la API cuente por persona y no por servidor.
 */
export function serverApi(
  options: { accessToken?: string; clientIp?: string | null; userAgent?: string | null } = {},
) {
  const headers: Record<string, string> = {};
  const key = process.env.WEB_SERVER_KEY;
  if (key && options.clientIp) {
    headers['x-fulldays-web-key'] = key;
    headers['x-fulldays-client-ip'] = options.clientIp;
  }
  if (options.userAgent) headers['user-agent'] = options.userAgent;
  const fetchWithHeaders: typeof fetch = (input, init) => {
    const request = new Request(input, init);
    for (const [name, value] of Object.entries(headers)) request.headers.set(name, value);
    return fetch(request, { signal: AbortSignal.timeout(8000) });
  };
  return createApiClient(API_URL, options.accessToken, fetchWithHeaders);
}

/** IP de quien navega, según el proxy delante de la web (la primera de `X-Forwarded-For`). */
export function clientIpFrom(headers: Headers): string | null {
  return headers.get('x-forwarded-for')?.split(',')[0]?.trim() || headers.get('x-real-ip') || null;
}
