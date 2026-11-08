'use server';

import { act, type ActionState, numberOrNull, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

export async function setRate(_: ActionState, form: FormData): Promise<ActionState> {
  const api = await sessionApi();
  const body = { date: text(form, 'date'), bsPerUsd: numberOrNull(form, 'bsPerUsd') ?? 0 };
  return act(() => api.PUT('/v1/central/tasas', { body }), {
    ok: 'Tasa guardada.',
    revalidate: ['/tasa'],
  });
}
