import type { MetadataRoute } from 'next';
import { serverApi } from '@fulldays/web-session';
import { SITE_URL } from '../lib/format';

export const revalidate = 3600;

/** Portada, temáticas, destinos, viajes con fechas y sus agencias. */
export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const api = serverApi();
  const [themes, destinations] = await Promise.all([
    api.GET('/v1/tematicas').then((r) => r.data?.items ?? []),
    api.GET('/v1/catalogos/destinos').then((r) => r.data?.items ?? []),
  ]);
  const products = new Set<string>();
  const agencies = new Set<string>();
  for (let pagina = 1; pagina <= 25; pagina++) {
    const { data } = await api.GET('/v1/salidas', {
      params: { query: { pagina, orden: 'fecha' } as never },
    });
    for (const card of data?.items ?? []) {
      products.add(card.productId);
      agencies.add(card.provider.id);
    }
    if (!data?.hasMore) break;
  }
  const url = (path: string, priority = 0.5) => ({
    url: `${SITE_URL}${path}`,
    changeFrequency: 'daily' as const,
    priority,
  });
  return [
    url('/', 1),
    url('/buscar', 0.8),
    ...themes.map((t) => url(`/tematicas/${t.slug}`, 0.6)),
    ...destinations.flatMap((d) => [d, ...d.sites]).map((d) => url(`/destinos/${d.slug}`, 0.6)),
    ...[...products].map((id) => url(`/viajes/${id}`, 0.9)),
    ...[...agencies].map((id) => url(`/agencias/${id}`, 0.4)),
  ];
}
