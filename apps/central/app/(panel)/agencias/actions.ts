'use server';

import { act, type ActionState, numberOrNull, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

const again = { revalidate: ['/agencias'] };

export async function decideProvider(
  id: string,
  decision: 'aprobar' | 'rechazar' | 'suspender',
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  const params = { params: { path: { id } } };
  if (decision === 'aprobar')
    return act(() => api.POST('/v1/central/proveedores/{id}/aprobar', params), {
      ok: 'Agencia aprobada.',
      ...again,
    });
  const body = { reason: text(form, 'reason') };
  if (decision === 'rechazar')
    return act(() => api.POST('/v1/central/proveedores/{id}/rechazar', { ...params, body }), {
      ok: 'Agencia rechazada.',
      ...again,
    });
  return act(() => api.POST('/v1/central/proveedores/{id}/suspender', { ...params, body }), {
    ok: 'Agencia suspendida.',
    ...again,
  });
}

export async function setCommission(
  id: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.PUT('/v1/central/proveedores/{id}/comision', {
        params: { path: { id } },
        body: { commissionPercent: numberOrNull(form, 'commissionPercent') },
      }),
    {
      ok: 'Comisión guardada.',
      ...again,
    },
  );
}
