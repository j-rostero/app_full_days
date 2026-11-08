'use server';

import { act, type ActionState, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

const again = { revalidate: ['/productos'] };

export async function decideProduct(
  id: string,
  decision: 'aprobar' | 'devolver' | 'despublicar',
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  const params = { params: { path: { id } } };
  if (decision === 'aprobar')
    return act(() => api.POST('/v1/central/productos/{id}/aprobar', params), {
      ok: 'Publicado.',
      ...again,
    });
  const body = { reason: text(form, 'reason') };
  if (decision === 'devolver')
    return act(() => api.POST('/v1/central/productos/{id}/devolver', { ...params, body }), {
      ok: 'Devuelto a la agencia.',
      ...again,
    });
  return act(() => api.POST('/v1/central/productos/{id}/despublicar', { ...params, body }), {
    ok: 'Despublicado.',
    ...again,
  });
}

export async function curate(id: string, _: ActionState, form: FormData): Promise<ActionState> {
  const api = await sessionApi();
  const themeIds = form.getAll('themeIds').filter((v): v is string => typeof v === 'string');
  return act(
    () =>
      api.PUT('/v1/central/productos/{id}/portada', {
        params: { path: { id } },
        body: { featured: form.get('featured') === 'on', themeIds },
      }),
    {
      ok: 'Portada guardada.',
      ...again,
    },
  );
}
