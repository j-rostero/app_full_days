import { createApiClient, type Health } from '@fulldays/api-client';

const API_URL = process.env.API_URL ?? 'http://localhost:4000';

/** Lee `/salud` desde el servidor Next: las webs nunca llaman a la API desde el navegador. */
async function readHealth(): Promise<Health | null> {
  try {
    const { data, error } = await createApiClient(API_URL).GET('/salud', {
      signal: AbortSignal.timeout(3000),
    });
    // 503 (degradada) trae el mismo cuerpo de estado que 200.
    return data ?? (error as Health | undefined) ?? null;
  } catch {
    return null;
  }
}

const label = (check: 'ok' | 'down') => (check === 'ok' ? 'en línea' : 'sin respuesta');

export async function HealthCard() {
  const health = await readHealth();
  if (!health) {
    return (
      <section className="tarjeta" role="alert">
        <h2>No pudimos conectar con la API</h2>
        <p className="suave">Revisa que esté corriendo en {API_URL}.</p>
      </section>
    );
  }
  return (
    <section className="tarjeta">
      <h2>{health.status === 'ok' ? 'API conectada' : 'API con problemas'}</h2>
      <p>Base de datos: {label(health.checks.database)}</p>
      <p>Redis: {label(health.checks.redis)}</p>
    </section>
  );
}
