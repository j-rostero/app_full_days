'use server';

import { act, type ActionState, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

const page = (providerId: string, departureId: string) =>
  `/agencia/${providerId}/salidas/${departureId}`;

/** Marca desde la web: la hora es la del servidor al pulsar. */
export async function markPassenger(
  providerId: string,
  departureId: string,
  passengerId: string,
  checkin: 'boarded' | 'no_show' | null,
  _?: ActionState,
  __?: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/salidas/{departureId}/checkins', {
        params: { path: { providerId, departureId } },
        body: { events: [{ passengerId, checkin, at: new Date().toISOString() }] },
      }),
    { ok: 'Lista actualizada.', revalidate: [page(providerId, departureId)] },
  );
}

export async function moveDeparture(
  providerId: string,
  departureId: string,
  status: 'in_progress' | 'finished',
  _?: ActionState,
  __?: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.PATCH('/v1/pro/{providerId}/salidas/{departureId}', {
        params: { path: { providerId, departureId } },
        body: { status },
      }),
    {
      ok: status === 'in_progress' ? 'Salida en curso.' : 'Salida finalizada.',
      revalidate: [page(providerId, departureId)],
    },
  );
}

export async function publishNotice(
  providerId: string,
  departureId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/salidas/{departureId}/avisos', {
        params: { path: { providerId, departureId } },
        body: { body: text(form, 'body') ?? '' },
      }),
    { ok: 'Aviso publicado.', revalidate: [page(providerId, departureId)] },
  );
}
