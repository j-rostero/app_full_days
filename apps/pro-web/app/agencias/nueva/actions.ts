'use server';

import { act, type ActionState, optional, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';
import { redirect } from 'next/navigation';

export async function registerProvider(_: ActionState, form: FormData): Promise<ActionState> {
  const api = await sessionApi();
  const result = await act(() =>
    api.POST('/v1/proveedores', {
      body: {
        kind: text(form, 'kind') as 'person' | 'company',
        name: text(form, 'name'),
        legalName: text(form, 'legalName'),
        rif: text(form, 'rif'),
        rtn: optional(form, 'rtn'),
        baseCity: text(form, 'baseCity'),
        phone: text(form, 'phone'),
        instagram: optional(form, 'instagram'),
        paymentInstructions: optional(form, 'paymentInstructions'),
      },
    }),
  );
  if (!result.data) return result;
  redirect(`/agencia/${result.data.id}/empresa`);
}
