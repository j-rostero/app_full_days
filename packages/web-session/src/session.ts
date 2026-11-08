import 'server-only';
import type { components } from '@fulldays/api-client';
import { cookies, headers } from 'next/headers';
import { redirect } from 'next/navigation';
import { cache } from 'react';
import { clientIpFrom, serverApi } from './api.ts';
import { ACCESS_COOKIE } from './cookies.ts';

export { API_URL, serverApi } from './api.ts';
export { safeNext } from './cookies.ts';

export type Me = components['schemas']['Me'];

/** API con la sesión de quien navega (o sin sesión), desde un componente de servidor. */
export async function sessionApi() {
  const [store, incoming] = await Promise.all([cookies(), headers()]);
  return serverApi({
    accessToken: store.get(ACCESS_COOKIE)?.value,
    clientIp: clientIpFrom(incoming),
    userAgent: incoming.get('user-agent'),
  });
}

/**
 * La cuenta de quien navega, o `null` sin sesión. Una vez por petición. La renovación del
 * token ocurre antes, en el `proxy` de la web, porque un componente no puede fijar cookies.
 */
export const getMe = cache(async (): Promise<Me | null> => {
  const store = await cookies();
  if (!store.get(ACCESS_COOKIE)) return null;
  const { data } = await (await sessionApi()).GET('/v1/yo');
  return data ?? null;
});

/** Como `getMe`, pero sin sesión manda a `/entrar` y vuelve aquí después. */
export async function requireMe(here: string): Promise<Me> {
  const me = await getMe();
  if (!me) redirect(`/entrar?siguiente=${encodeURIComponent(here)}`);
  return me;
}
