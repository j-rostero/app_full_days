'use server';

import { act, type ActionState, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

type Role = 'owner' | 'operations' | 'finance' | 'guide';
const again = (providerId: string) => ({ revalidate: [`/agencia/${providerId}/equipo`] });

export async function addMember(
  providerId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.POST('/v1/pro/{providerId}/equipo', {
        params: { path: { providerId } },
        body: { email: text(form, 'email'), role: text(form, 'role') as Role },
      }),
    {
      ok: 'Persona sumada. Si aún no tiene cuenta, verá la agencia al registrarse con ese correo.',
      ...again(providerId),
    },
  );
}

export async function changeRole(
  providerId: string,
  memberId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.PATCH('/v1/pro/{providerId}/equipo/{memberId}', {
        params: { path: { providerId, memberId } },
        body: { role: text(form, 'role') as Role },
      }),
    { ok: 'Rol cambiado.', ...again(providerId) },
  );
}

export async function removeMember(providerId: string, memberId: string): Promise<ActionState> {
  const api = await sessionApi();
  return act(
    () =>
      api.DELETE('/v1/pro/{providerId}/equipo/{memberId}', {
        params: { path: { providerId, memberId } },
      }),
    {
      ok: 'Persona quitada del equipo.',
      ...again(providerId),
    },
  );
}
