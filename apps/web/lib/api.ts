import 'server-only';
import type { components } from '@fulldays/api-client';
import { sessionApi } from '@fulldays/web-session';
import { notFound } from 'next/navigation';

export type Schemas = components['schemas'];

/** Lee de la API con la sesión; un 404 muestra la página de no encontrado. */
export async function read<T>(
  call: (api: Awaited<ReturnType<typeof sessionApi>>) => Promise<{ data?: T; response: Response }>,
): Promise<T> {
  const { data, response } = await call(await sessionApi());
  if (response.status === 404 || response.status === 403) notFound();
  if (!data) throw new Error(`La API respondió ${response.status}`);
  return data;
}
