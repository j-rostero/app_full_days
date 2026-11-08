import 'server-only';
import { SearchQuerySchema } from '@fulldays/shared';
import { sessionApi } from '@fulldays/web-session';
import type { Schemas } from './api';

/** Busca con los parámetros de la URL; los que no validan se ignoran en vez de romper la página. */
export async function searchDepartures(
  params: Record<string, string | string[] | undefined>,
): Promise<Schemas['SearchResult']> {
  const flat = Object.fromEntries(
    Object.entries(params)
      .map(([k, v]) => [k, Array.isArray(v) ? v[0] : v])
      .filter(([, v]) => v !== undefined && v !== ''),
  ) as Record<string, string>;
  const parsed = SearchQuerySchema.safeParse(flat);
  const query = parsed.success
    ? flat
    : Object.fromEntries(
        Object.entries(flat).filter(([k]) => !parsed.error.issues.some((i) => i.path[0] === k)),
      );
  const api = await sessionApi();
  const { data } = await api.GET('/v1/salidas', { params: { query: query as never } });
  return data ?? { items: [], page: 1, hasMore: false };
}
