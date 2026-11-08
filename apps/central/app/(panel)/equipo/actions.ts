'use server';

import type { StaffRole } from '@fulldays/shared';
import { act, type ActionState, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

export async function setStaffRoles(_: ActionState, form: FormData): Promise<ActionState> {
  const api = await sessionApi();
  const body = {
    email: text(form, 'email'),
    roles: form.getAll('roles').filter((v): v is StaffRole => typeof v === 'string'),
  };
  return act(() => api.PUT('/v1/central/equipo', { body }), {
    ok: body.roles.length ? 'Roles guardados.' : 'La persona ya no es parte de Central.',
    revalidate: ['/equipo'],
  });
}
