import Link from 'next/link';
import { BOOKING_STATUS_LABELS } from '@fulldays/shared';
import { requireMe, sessionApi } from '@fulldays/web-session';
import { longDate, usd } from '../../lib/format';

export const metadata = { title: 'Mis viajes', robots: { index: false } };

export default async function MyTrips() {
  await requireMe('/reservas');
  const { data } = await (await sessionApi()).GET('/v1/reservas');
  const items = data?.items ?? [];
  return (
    <main>
      <h1>Mis viajes</h1>
      {items.length === 0 ? (
        <p>
          Aún no tienes reservas. <Link href="/buscar">Busca tu próximo viaje</Link>.
        </p>
      ) : null}
      <ul className="lista-reservas">
        {items.map((b) => (
          <li key={b.id}>
            <Link href={`/reservas/${b.id}`}>
              {b.product.cover ? <img src={b.product.cover.sm} alt="" /> : null}
              <span>
                <strong>{b.product.title}</strong>
                <br />
                <span className="suave">
                  {longDate(b.departure.date)} · {b.code} · {usd(b.totalUsd)}
                </span>
              </span>
              <span className={`fd-pill estado-${b.status}`}>
                {BOOKING_STATUS_LABELS[b.status]}
              </span>
            </Link>
          </li>
        ))}
      </ul>
    </main>
  );
}
