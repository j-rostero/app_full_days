'use server';

import { act, type ActionState, failure, optional, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';
import { revalidatePath } from 'next/cache';

export async function savePassengers(
  bookingId: string,
  count: number,
  mealIds: string[],
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const picks = (i: number) => {
    const out: Record<string, string[]> = {};
    for (const mealId of mealIds) {
      const ids = form
        .getAll(`meal.${i}.${mealId}`)
        .filter((v): v is string => typeof v === 'string' && v !== '');
      if (ids.length) out[mealId] = ids;
    }
    return out;
  };
  const passengers = Array.from({ length: count }, (_, i) => ({
    name: text(form, `name.${i}`),
    cedula: optional(form, `cedula.${i}`),
    birthDate: text(form, `birthDate.${i}`),
    restrictions: optional(form, `restrictions.${i}`),
    mealPicks: picks(i),
  }));
  const api = await sessionApi();
  return act(
    () =>
      api.PUT('/v1/reservas/{id}/pasajeros', {
        params: { path: { id: bookingId } },
        body: { passengers },
      }),
    {
      ok: 'Pasajeros guardados.',
      revalidate: [`/reservas/${bookingId}`],
    },
  );
}

export interface ReportInput {
  method: 'mobile_payment' | 'bank_transfer' | 'zelle' | 'cash_usd';
  reference: string;
  amountUsd: number;
  proofFileId: string | null;
  idempotencyKey: string;
}

export async function reportPayment(
  bookingId: string,
  input: ReportInput,
): Promise<{ error?: string; ok?: string }> {
  const { data, error } = await (
    await sessionApi()
  ).POST('/v1/reservas/{id}/pagos', { params: { path: { id: bookingId } }, body: input });
  if (!data) return { error: failure(error).error };
  revalidatePath(`/reservas/${bookingId}`);
  return { ok: 'Pago reportado. La agencia lo revisará y te avisaremos.' };
}

export async function cancelBooking(bookingId: string, _: ActionState): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () => api.POST('/v1/reservas/{id}/cancelar', { params: { path: { id: bookingId } } }),
    { ok: 'Reserva cancelada.', revalidate: [`/reservas/${bookingId}`, '/reservas'] },
  );
}

export async function reviewBooking(
  bookingId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const aspects: Record<string, number> = {};
  for (const key of ['punctuality', 'transport', 'food', 'guide', 'value']) {
    const v = Number(form.get(`aspect.${key}`));
    if (v >= 1 && v <= 5) aspects[key] = v;
  }
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/reservas/{id}/resena', {
        params: { path: { id: bookingId } },
        body: {
          rating: Number(form.get('rating')),
          aspects,
          asDescribed: form.get('asDescribed') === 'si',
          comment: text(form, 'comment'),
        },
      }),
    { ok: '¡Gracias por tu reseña!', revalidate: [`/reservas/${bookingId}`] },
  );
}

export async function openClaim(
  bookingId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/reservas/{id}/reclamos', {
        params: { path: { id: bookingId } },
        body: { subject: text(form, 'subject'), message: text(form, 'message') },
      }),
    {
      ok: 'Reclamo enviado a la agencia.',
      revalidate: [`/reservas/${bookingId}`, '/reclamos'],
    },
  );
}

export async function writeClaim(
  claimId: string,
  back: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/reclamos/{id}/mensajes', {
        params: { path: { id: claimId } },
        body: { body: text(form, 'body') },
      }),
    { ok: 'Mensaje enviado.', revalidate: [back, '/reclamos'] },
  );
}

export async function escalateClaim(
  claimId: string,
  back: string,
  _: ActionState,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(() => api.POST('/v1/reclamos/{id}/escalar', { params: { path: { id: claimId } } }), {
    ok: 'FullDays revisará tu reclamo.',
    revalidate: [back, '/reclamos'],
  });
}

export async function markAllRead(_: ActionState): Promise<ActionState> {
  const api = await sessionApi();
  return act(() => api.POST('/v1/yo/notificaciones/leidas', { body: {} }), {
    ok: 'Listo.',
    revalidate: ['/avisos'],
  });
}
