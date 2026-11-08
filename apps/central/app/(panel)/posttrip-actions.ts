'use server';

import { act, type ActionState, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

export async function answerClaim(
  id: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/central/reclamos/{id}/mensajes', {
        params: { path: { id } },
        body: { body: text(form, 'body') },
      }),
    { ok: 'Mensaje enviado.', revalidate: ['/reclamos'] },
  );
}

export async function resolveClaim(
  id: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/central/reclamos/{id}/resolver', {
        params: { path: { id } },
        body: { resolution: text(form, 'resolution') },
      }),
    { ok: 'Reclamo resuelto. Avisamos al viajero.', revalidate: ['/reclamos'] },
  );
}

export async function hideReview(id: string, _: ActionState, form: FormData): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/central/resenas/{id}/ocultar', {
        params: { path: { id } },
        body: { reason: text(form, 'reason') },
      }),
    { ok: 'Reseña oculta.', revalidate: ['/resenas'] },
  );
}

export async function showReview(id: string, _: ActionState): Promise<ActionState> {
  const api = await sessionApi();
  return act(() => api.POST('/v1/central/resenas/{id}/mostrar', { params: { path: { id } } }), {
    ok: 'Reseña visible.',
    revalidate: ['/resenas'],
  });
}

export async function blockUser(
  id: string,
  block: boolean,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  const params = { params: { path: { id } } };
  return act(
    () =>
      block
        ? api.POST('/v1/central/usuarios/{id}/bloquear', {
            ...params,
            body: { reason: text(form, 'reason') },
          })
        : api.POST('/v1/central/usuarios/{id}/desbloquear', params),
    {
      ok: block ? 'Cuenta bloqueada y sesiones cerradas.' : 'Cuenta desbloqueada.',
      revalidate: ['/usuarios'],
    },
  );
}
