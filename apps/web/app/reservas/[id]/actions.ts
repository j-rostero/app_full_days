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
