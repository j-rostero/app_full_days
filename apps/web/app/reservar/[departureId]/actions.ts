'use server';

import { redirect } from 'next/navigation';
import type { BookingSelection } from '@fulldays/shared';
import { failure } from '@fulldays/web-session/act';
import { sessionApi } from '@fulldays/web-session';

export interface QuoteState {
  quote?: {
    lines: { label: string; amountUsd: number }[];
    totalUsd: number;
    depositUsd: number;
    balanceDueDate: string;
  };
  error?: string;
}

export async function quoteAction(
  departureId: string,
  selection: BookingSelection,
): Promise<QuoteState> {
  const { data, error } = await (
    await sessionApi()
  ).POST('/v1/reservas/cotizar', { body: { departureId, selection } });
  return data ? { quote: data } : { error: failure(error).error };
}

export async function holdAction(
  departureId: string,
  selection: BookingSelection,
): Promise<{ error?: string }> {
  const { data, error } = await (
    await sessionApi()
  ).POST('/v1/reservas', { body: { departureId, selection } });
  if (!data) return { error: failure(error).error };
  redirect(`/reservas/${data.id}`);
}
