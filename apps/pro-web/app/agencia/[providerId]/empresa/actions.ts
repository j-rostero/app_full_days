'use server';

import { act, type ActionState, optional, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

const path = (providerId: string) => ({ params: { path: { providerId } } });

export async function updateCompany(
  providerId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.PATCH('/v1/pro/{providerId}/empresa', {
        ...path(providerId),
        body: {
          kind: text(form, 'kind') as 'person' | 'company',
          name: text(form, 'name'),
          legalName: text(form, 'legalName'),
          rtn: optional(form, 'rtn'),
          baseCity: text(form, 'baseCity'),
          phone: text(form, 'phone'),
          instagram: optional(form, 'instagram'),
          paymentInstructions: optional(form, 'paymentInstructions'),
        },
      }),
    { ok: 'Datos guardados.', revalidate: [`/agencia/${providerId}`] },
  );
}

export async function attachDocument(
  providerId: string,
  type: string,
  fileId: string,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/documentos', {
        ...path(providerId),
        body: { type: type as 'rif', fileId },
      }),
    { ok: 'Documento adjunto.', revalidate: [`/agencia/${providerId}/empresa`] },
  );
}

export async function removeDocument(providerId: string, documentId: string): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.DELETE('/v1/pro/{providerId}/documentos/{documentId}', {
        params: { path: { providerId, documentId } },
      }),
    { ok: 'Documento quitado.', revalidate: [`/agencia/${providerId}/empresa`] },
  );
}

export async function submitCompany(providerId: string): Promise<ActionState> {
  const api = await sessionApi();
  return act(() => api.POST('/v1/pro/{providerId}/empresa/enviar', path(providerId)), {
    ok: 'Enviada a verificación. Central te responderá pronto.',
    revalidate: [`/agencia/${providerId}`, '/'],
  });
}
