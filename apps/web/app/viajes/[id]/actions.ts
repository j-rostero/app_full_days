'use server';

import { revalidatePath } from 'next/cache';
import { redirect } from 'next/navigation';
import { getMe, sessionApi } from '@fulldays/web-session';

/** Guarda o quita un viaje; sin sesión lleva a entrar y vuelve aquí. */
export async function toggleFavorite(productId: string, saved: boolean): Promise<void> {
  if (!(await getMe())) redirect(`/entrar?siguiente=${encodeURIComponent(`/viajes/${productId}`)}`);
  const api = await sessionApi();
  const params = { params: { path: { productId } } };
  if (saved) await api.DELETE('/v1/yo/favoritos/{productId}', params);
  else await api.PUT('/v1/yo/favoritos/{productId}', params);
  revalidatePath(`/viajes/${productId}`);
  revalidatePath('/favoritos');
}
