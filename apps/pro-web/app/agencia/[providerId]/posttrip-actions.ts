'use server';

import { act, type ActionState, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

export async function payRefund(
  providerId: string,
  refundId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  const reference = text(form, 'reference');
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/reembolsos/{refundId}/pagar', {
        params: { path: { providerId, refundId } },
        body: { reference: reference || null },
      }),
    { ok: 'Reembolso marcado como pagado.', revalidate: [`/agencia/${providerId}/reembolsos`] },
  );
}

export async function cancelBooking(
  providerId: string,
  bookingId: string,
  _: ActionState,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/reservas/{bookingId}/cancelar', {
        params: { path: { providerId, bookingId } },
      }),
    {
      ok: 'Reserva cancelada. El reembolso quedó en Reembolsos.',
      revalidate: [`/agencia/${providerId}/reservas/${bookingId}`],
    },
  );
}

export async function replyReview(
  providerId: string,
  reviewId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/resenas/{reviewId}/responder', {
        params: { path: { providerId, reviewId } },
        body: { reply: text(form, 'reply') },
      }),
    { ok: 'Respuesta publicada.', revalidate: [`/agencia/${providerId}/resenas`] },
  );
}

export async function reportReview(
  providerId: string,
  reviewId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/resenas/{reviewId}/reportar', {
        params: { path: { providerId, reviewId } },
        body: { reason: text(form, 'reason') },
      }),
    { ok: 'Enviada a FullDays para revisión.', revalidate: [`/agencia/${providerId}/resenas`] },
  );
}

export async function answerClaim(
  providerId: string,
  claimId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/reclamos/{claimId}/mensajes', {
        params: { path: { providerId, claimId } },
        body: { body: text(form, 'body') },
      }),
    { ok: 'Respuesta enviada al viajero.', revalidate: [`/agencia/${providerId}/reclamos`] },
  );
}
