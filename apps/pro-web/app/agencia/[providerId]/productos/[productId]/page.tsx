import { read } from '../../../../../lib/api';
import { Editor } from './editor';

export default async function ProductPage({
  params,
}: {
  params: Promise<{ providerId: string; productId: string }>;
}) {
  const { providerId, productId } = await params;
  const [product, destinations, points] = await Promise.all([
    read((api) =>
      api.GET('/v1/pro/{providerId}/productos/{productId}', {
        params: { path: { providerId, productId } },
      }),
    ),
    read((api) => api.GET('/v1/catalogos/destinos')),
    read((api) => api.GET('/v1/catalogos/puntos-de-embarque', { params: { query: {} } })),
  ]);
  const places = destinations.items.flatMap((d) => [
    { id: d.id, name: d.name },
    ...d.sites.map((s) => ({ id: s.id, name: `${d.name} · ${s.name}` })),
  ]);
  return (
    <Editor providerId={providerId} product={product} destinations={places} points={points.items} />
  );
}
