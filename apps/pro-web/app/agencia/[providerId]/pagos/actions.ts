'use server';

import { act, type ActionState, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

export async function confirmPayment(
  providerId: string,
  paymentId: string,
  _: ActionState,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/pagos/{paymentId}/confirmar', {
        params: { path: { providerId, paymentId } },
      }),
    { ok: 'Pago confirmado.', revalidate: [`/agencia/${providerId}/pagos`] },
  );
}

export async function rejectPayment(
  providerId: string,
  paymentId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/pagos/{paymentId}/rechazar', {
        params: { path: { providerId, paymentId } },
        body: { reason: text(form, 'reason') },
      }),
    { ok: 'Pago rechazado.', revalidate: [`/agencia/${providerId}/pagos`] },
  );
}
