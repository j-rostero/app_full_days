'use server';

import { weeklyDates } from '@fulldays/shared';
import { act, type ActionState, numberOrNull, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

export async function scheduleDepartures(
  providerId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const from = text(form, 'desde');
  const until = text(form, 'hasta') || from;
  const dates = text(form, 'repetir') === 'semanal' ? weeklyDates(from, until) : [from];
  const api = await sessionApi();
  const result = await act(
    () =>
      api.POST('/v1/pro/{providerId}/salidas', {
        params: { path: { providerId } },
        body: {
          productId: text(form, 'productId'),
          dates,
          capacity: Number(text(form, 'capacity')),
          minCapacity: Number(text(form, 'minCapacity') || '1'),
          adultPriceUsd: numberOrNull(form, 'adultPriceUsd'),
        },
      }),
    { revalidate: [`/agencia/${providerId}/salidas`] },
  );
  if (result.data)
    result.ok = `${result.data.items.length === 1 ? 'Salida programada' : `${result.data.items.length} salidas programadas`}.`;
  return result;
}

export async function updateDeparture(
  providerId: string,
  departureId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  const guideIds = form.getAll('guideIds').filter((v): v is string => typeof v === 'string');
  return act(
    () =>
      api.PATCH('/v1/pro/{providerId}/salidas/{departureId}', {
        params: { path: { providerId, departureId } },
        body: {
          capacity: Number(text(form, 'capacity')),
          minCapacity: Number(text(form, 'minCapacity')),
          adultPriceUsd: numberOrNull(form, 'adultPriceUsd'),
          status: text(form, 'status') as 'open',
          guideIds,
        },
      }),
    { ok: 'Salida actualizada.', revalidate: [`/agencia/${providerId}/salidas`] },
  );
}
