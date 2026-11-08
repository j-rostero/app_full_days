import Link from 'next/link';
import { DEPARTURE_STATUS_LABELS, todayInVenezuela } from '@fulldays/shared';
import { read } from '../../../../lib/api';

export default async function TodayPage({ params }: { params: Promise<{ providerId: string }> }) {
  const { providerId } = await params;
  const { items } = await read((api) =>
    api.GET('/v1/pro/{providerId}/salidas/hoy', { params: { path: { providerId } } }),
  );
  const today = todayInVenezuela();
  return (
    <section className="tarjeta">
      <h2>Salidas de hoy y mañana</h2>
      <p className="suave">
        Abre una salida para pasar lista. En el teléfono, la app del guía guarda la lista y marca
        sin señal.
      </p>
      {items.length === 0 ? <p className="suave">No tienes salidas hoy ni mañana.</p> : null}
      {items.map((d) => (
        <article key={d.id} className="bloque">
          <p>
            <strong>{d.date === today ? 'Hoy' : 'Mañana'}</strong> ·{' '}
            <Link prefetch={false} href={`/agencia/${providerId}/salidas/${d.id}`}>
              {d.title}
            </Link>{' '}
            · <span className="fd-pill">{DEPARTURE_STATUS_LABELS[d.status]}</span>
          </p>
          <p className="suave">
            {d.boarded} de {d.passengers} a bordo
            {d.guides.length
              ? ` · Guías: ${d.guides.map((g) => g.name ?? g.email).join(', ')}`
              : ''}
          </p>
        </article>
      ))}
    </section>
  );
}
