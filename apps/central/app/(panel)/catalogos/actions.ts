'use server';

import { act, type ActionState, numberOrNull, optional, text } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

const again = { revalidate: ['/catalogos'] };
const path = (id: string) => ({ params: { path: { id } } });

export async function createDestination(
  parentId: string | null,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  const body = {
    slug: text(form, 'slug'),
    name: text(form, 'name'),
    state: text(form, 'state'),
    region: text(form, 'region'),
    lat: numberOrNull(form, 'lat'),
    lng: numberOrNull(form, 'lng'),
    parentId,
  };
  return act(() => api.POST('/v1/central/catalogos/destinos', { body }), {
    ok: parentId ? 'Sitio creado.' : 'Destino creado.',
    ...again,
  });
}

export async function deleteDestination(
  id: string,
  _?: ActionState,
  __?: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(() => api.DELETE('/v1/central/catalogos/destinos/{id}', path(id)), {
    ok: 'Borrado.',
    ...again,
  });
}

export async function addFee(
  destinationId: string,
  _: ActionState,
  form: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  const body = {
    name: text(form, 'name'),
    amountUsd: numberOrNull(form, 'amountUsd') ?? 0,
    payment: text(form, 'payment') as 'cash_usd' | 'cash_bs' | 'mobile_payment',
  };
  return act(
    () => api.POST('/v1/central/catalogos/destinos/{id}/tasas', { ...path(destinationId), body }),
    { ok: 'Tasa añadida.', ...again },
  );
}

export async function deleteFee(id: string, _?: ActionState, __?: FormData): Promise<ActionState> {
  const api = await sessionApi();
  return act(() => api.DELETE('/v1/central/catalogos/tasas/{id}', path(id)), {
    ok: 'Tasa borrada.',
    ...again,
  });
}

export async function createBoardingPoint(_: ActionState, form: FormData): Promise<ActionState> {
  const api = await sessionApi();
  const body = {
    city: text(form, 'city'),
    name: text(form, 'name'),
    address: optional(form, 'address') ?? '',
    lat: numberOrNull(form, 'lat'),
    lng: numberOrNull(form, 'lng'),
  };
  return act(() => api.POST('/v1/central/catalogos/puntos-de-embarque', { body }), {
    ok: 'Punto creado.',
    ...again,
  });
}

export async function deleteBoardingPoint(
  id: string,
  _?: ActionState,
  __?: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(() => api.DELETE('/v1/central/catalogos/puntos-de-embarque/{id}', path(id)), {
    ok: 'Punto borrado.',
    ...again,
  });
}

export async function createTheme(_: ActionState, form: FormData): Promise<ActionState> {
  const api = await sessionApi();
  const body = {
    slug: text(form, 'slug'),
    name: text(form, 'name'),
    description: text(form, 'description'),
  };
  return act(() => api.POST('/v1/central/tematicas', { body }), {
    ok: 'Temática creada.',
    ...again,
  });
}

export async function deleteTheme(
  id: string,
  _?: ActionState,
  __?: FormData,
): Promise<ActionState> {
  const api = await sessionApi();
  return act(() => api.DELETE('/v1/central/tematicas/{id}', path(id)), {
    ok: 'Temática borrada.',
    ...again,
  });
}
