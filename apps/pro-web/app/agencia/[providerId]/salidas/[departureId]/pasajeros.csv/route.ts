import { sessionApi } from '@fulldays/web-session';

/** Descarga la lista de pasajeros con la sesión de la agencia. */
export async function GET(
  _: Request,
  { params }: { params: Promise<{ providerId: string; departureId: string }> },
) {
  const { providerId, departureId } = await params;
  const api = await sessionApi();
  const { data, response } = await api.GET(
    '/v1/pro/{providerId}/salidas/{departureId}/pasajeros.csv',
    { params: { path: { providerId, departureId } }, parseAs: 'arrayBuffer' },
  );
  if (!data) return new Response('No se pudo descargar la lista.', { status: response.status });
  return new Response(data, {
    headers: {
      'content-type': 'text/csv; charset=utf-8',
      'content-disposition': `attachment; filename="pasajeros-${departureId.slice(0, 8)}.csv"`,
    },
  });
}
