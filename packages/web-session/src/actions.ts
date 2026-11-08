'use server';

import { cookies, headers } from 'next/headers';
import { redirect } from 'next/navigation';
import { clientIpFrom, serverApi } from './api.ts';
import { ACCESS_COOKIE, REFRESH_COOKIE, safeNext, sessionCookies, type Tokens } from './cookies.ts';

/** Estado de un formulario de acceso: el mensaje de la API y lo que la persona escribió. */
export interface FormState {
  error?: string;
  values?: Record<string, string>;
}

interface ApiErrorBody {
  code?: string;
  message?: string;
  issues?: { path: string[]; message: string }[];
}

const UNREACHABLE = 'No pudimos conectar. Revisa tu conexión e inténtalo de nuevo.';

async function api() {
  const incoming = await headers();
  return serverApi({ clientIp: clientIpFrom(incoming), userAgent: incoming.get('user-agent') });
}

function field(form: FormData, name: string): string {
  const value = form.get(name);
  return typeof value === 'string' ? value : '';
}

/** Lo que se devuelve al formulario: nunca las contraseñas ni los códigos. */
function keep(form: FormData, ...names: string[]): Record<string, string> {
  return Object.fromEntries(names.map((n) => [n, field(form, n)]));
}

function messageOf(error: unknown): string {
  const body = error as ApiErrorBody | undefined;
  return body?.issues?.[0]?.message ?? body?.message ?? UNREACHABLE;
}

async function saveSession(tokens: Tokens): Promise<void> {
  const store = await cookies();
  for (const cookie of sessionCookies(tokens)) store.set(cookie);
}

/** Corre la llamada y convierte una caída de red en un mensaje para la persona. */
async function attempt<T>(
  run: () => Promise<{ data?: T; error?: unknown }>,
): Promise<{ data?: T; error?: unknown }> {
  try {
    return await run();
  } catch {
    return { error: { message: UNREACHABLE } };
  }
}

export async function signInAction(_: FormState, form: FormData): Promise<FormState> {
  const email = field(form, 'email');
  const client = await api();
  const { data, error } = await attempt(() =>
    client.POST('/v1/auth/entrar', { body: { email, password: field(form, 'password') } }),
  );
  if (!data) {
    if ((error as ApiErrorBody | undefined)?.code === 'email_not_verified') {
      redirect(`/verificar?correo=${encodeURIComponent(email)}`);
    }
    return { error: messageOf(error), values: keep(form, 'email') };
  }
  await saveSession(data);
  redirect(safeNext(field(form, 'siguiente')));
}

export async function registerAction(_: FormState, form: FormData): Promise<FormState> {
  const email = field(form, 'email');
  const password = field(form, 'password');
  if (password !== field(form, 'confirmar')) {
    return { error: 'Las contraseñas no coinciden.', values: keep(form, 'email') };
  }
  const client = await api();
  const { error, data } = await attempt(async () => {
    const res = await client.POST('/v1/auth/registrar', { body: { email, password } });
    return { data: res.response.ok ? true : undefined, error: res.error };
  });
  if (!data) return { error: messageOf(error), values: keep(form, 'email') };
  redirect(`/verificar?correo=${encodeURIComponent(email)}`);
}

export async function verifyAction(_: FormState, form: FormData): Promise<FormState> {
  const client = await api();
  const { data, error } = await attempt(() =>
    client.POST('/v1/auth/verificar', {
      body: { email: field(form, 'email'), code: field(form, 'code') },
    }),
  );
  if (!data) return { error: messageOf(error), values: keep(form, 'email') };
  await saveSession(data);
  redirect('/');
}

export async function recoverAction(_: FormState, form: FormData): Promise<FormState> {
  const email = field(form, 'email');
  const client = await api();
  const { data, error } = await attempt(async () => {
    const res = await client.POST('/v1/auth/recuperar', { body: { email } });
    return { data: res.response.ok ? true : undefined, error: res.error };
  });
  if (!data) return { error: messageOf(error), values: keep(form, 'email') };
  redirect(`/restablecer?correo=${encodeURIComponent(email)}`);
}

export async function resetAction(_: FormState, form: FormData): Promise<FormState> {
  const password = field(form, 'password');
  if (password !== field(form, 'confirmar')) {
    return { error: 'Las contraseñas no coinciden.', values: keep(form, 'email') };
  }
  const client = await api();
  const { data, error } = await attempt(() =>
    client.POST('/v1/auth/restablecer', {
      body: { email: field(form, 'email'), code: field(form, 'code'), password },
    }),
  );
  if (!data) return { error: messageOf(error), values: keep(form, 'email') };
  await saveSession(data);
  redirect('/');
}

export async function signOutAction(): Promise<void> {
  const store = await cookies();
  const accessToken = store.get(ACCESS_COOKIE)?.value;
  if (accessToken) {
    const incoming = await headers();
    await serverApi({ accessToken, clientIp: clientIpFrom(incoming) })
      .POST('/v1/auth/salir')
      .catch(() => undefined);
  }
  store.delete(ACCESS_COOKIE);
  store.delete(REFRESH_COOKIE);
  redirect('/entrar');
}
