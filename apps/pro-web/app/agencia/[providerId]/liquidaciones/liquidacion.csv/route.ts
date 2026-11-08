import { sessionApi } from '@fulldays/web-session';

/** Descarga la liquidación del mes con la sesión de la agencia. */
export async function GET(
  request: Request,
  { params }: { params: Promise<{ providerId: string }> },
) {
  const { providerId } = await params;
  const mes = new URL(request.url).searchParams.get('mes') ?? undefined;
  const api = await sessionApi();
  const { data, response } = await api.GET('/v1/pro/{providerId}/liquidaciones.csv', {
    params: { path: { providerId }, query: mes ? { mes } : {} },
    parseAs: 'arrayBuffer',
  });
  if (!data)
    return new Response('No se pudo descargar la liquidación.', { status: response.status });
  return new Response(data, {
    headers: {
      'content-type': 'text/csv; charset=utf-8',
      'content-disposition': `attachment; filename="liquidacion-${mes ?? 'mes'}.csv"`,
    },
  });
}
