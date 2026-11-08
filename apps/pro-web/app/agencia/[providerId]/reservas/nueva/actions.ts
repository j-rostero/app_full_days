'use server';

import { redirect } from 'next/navigation';
import { type ActionState, failure, numberOrNull, optional, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

export async function createManualBooking(
  providerId: string,
  departureId: string,
  roomIds: string[],
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const count = (name: string) => numberOrNull(form, name) ?? 0;
  const amount = numberOrNull(form, 'amountUsd');
  const body = {
    departureId,
    selection: {
      boardingId: text(form, 'boardingId'),
      travelers: {
        adult: count('adult'),
        child: count('child'),
        senior: count('senior'),
        infant: count('infant'),
      },
      rooms: roomIds
        .map((roomId) => ({ roomId, count: count(`room.${roomId}`) }))
        .filter((r) => r.count > 0),
      mealIds: [],
      itemIds: [],
    },
    contact: {
      name: text(form, 'name'),
      phone: optional(form, 'phone'),
      email: optional(form, 'email'),
    },
    payment: amount
      ? {
          method: text(form, 'method') as 'cash_usd',
          reference: text(form, 'reference') || `CAJA-${Date.now()}`,
          amountUsd: amount,
        }
      : null,
  };
  const api = await sessionApi();
  const { data, error } = await api.POST('/v1/pro/{providerId}/reservas', {
    params: { path: { providerId } },
    body,
  });
  if (!data) return failure(error);
  redirect(`/agencia/${providerId}/reservas/${data.id}`);
}
