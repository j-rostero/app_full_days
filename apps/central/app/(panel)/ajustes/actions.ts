'use server';

import type { PaymentMethod } from '@fulldays/shared';
import { act, type ActionState, numberOrNull } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

export async function saveSettings(_: ActionState, form: FormData): Promise<ActionState> {
  const api = await sessionApi();
  const body = {
    holdMinutes: numberOrNull(form, 'holdMinutes') ?? 0,
    minDepositPercent: numberOrNull(form, 'minDepositPercent') ?? 0,
    mealChoiceDeadlineHours: numberOrNull(form, 'mealChoiceDeadlineHours') ?? 0,
    platformCommissionPercent: numberOrNull(form, 'platformCommissionPercent') ?? 0,
    paymentMethods: form
      .getAll('paymentMethods')
      .filter((v): v is PaymentMethod => typeof v === 'string'),
  };
  return act(() => api.PUT('/v1/central/ajustes', { body }), {
    ok: 'Ajustes guardados.',
    revalidate: ['/ajustes'],
  });
}
