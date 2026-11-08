'use server';

import type { ProductSheet } from '@fulldays/shared';
import { act, type ActionState, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';
import { redirect } from 'next/navigation';

const base = (providerId: string) => `/agencia/${providerId}/productos`;

export async function createProduct(
  providerId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  const result = await act(() =>
    api.POST('/v1/pro/{providerId}/productos', {
      params: { path: { providerId } },
      body: { type: text(form, 'type') as 'fullday' },
    }),
  );
  if (!result.data) return result;
  redirect(`${base(providerId)}/${result.data.id}`);
}

export async function saveProduct(
  providerId: string,
  productId: string,
  version: number,
  sheet: ProductSheet,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.PUT('/v1/pro/{providerId}/productos/{productId}', {
        params: { path: { providerId, productId } },
        body: { version, sheet },
      }),
    { ok: 'Guardado.', revalidate: [base(providerId)] },
  );
}

export async function publishProduct(providerId: string, productId: string): Promise<ActionState> {
  const api = await sessionApi();
  const result = await act(
    () =>
      api.POST('/v1/pro/{providerId}/productos/{productId}/publicar', {
        params: { path: { providerId, productId } },
      }),
    {
      revalidate: [base(providerId)],
    },
  );
  if (result.data)
    result.ok =
      result.data.status === 'published'
        ? 'Publicado: ya puedes programar salidas.'
        : 'Enviado a revisión de Central.';
  return result;
}

export async function pauseProduct(providerId: string, productId: string): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/productos/{productId}/pausar', {
        params: { path: { providerId, productId } },
      }),
    {
      ok: 'Venta pausada.',
      revalidate: [base(providerId)],
    },
  );
}
