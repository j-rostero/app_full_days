import Link from 'next/link';
import { BOOKING_STATUS_LABELS, PASSENGER_TYPES } from '@fulldays/shared';
import { read } from '../../../../../lib/api';

export default async function ProviderBookingPage({
  params,
}: {
  params: Promise<{ providerId: string; bookingId: string }>;
}) {
  const { providerId, bookingId } = await params;
  const b = await read((api) =>
    api.GET('/v1/pro/{providerId}/reservas/{bookingId}', {
      params: { path: { providerId, bookingId } },
    }),
  );
  return (
    <section className="tarjeta">
      <p>
        <Link href={`/agencia/${providerId}/reservas`}>← Reservas</Link>
      </p>
      <h2>
        {b.code} · {b.product.title}
      </h2>
      <p>
        <span className="fd-pill">{BOOKING_STATUS_LABELS[b.status]}</span> · salida{' '}
        {b.departure.date} · {b.seats} puestos ·{' '}
        {b.source === 'agency' ? 'venta propia' : 'reservada en la app'}
      </p>
      {b.contact?.name ? (
        <p>
          Contacto: {b.contact.name} {b.contact.phone ? `· ${b.contact.phone}` : ''}{' '}
          {b.contact.email ? `· ${b.contact.email}` : ''}
        </p>
      ) : null}
      <table className="fd-table">
        <tbody>
          {b.lines.map((l) => (
            <tr key={l.label}>
              <td>{l.label}</td>
              <td>{l.amountUsd.toFixed(2)}</td>
            </tr>
          ))}
          <tr>
            <th>Total / pagado / saldo</th>
            <th>
              {b.totalUsd.toFixed(2)} / {b.paidUsd.toFixed(2)} / {b.balanceUsd.toFixed(2)} USD
            </th>
          </tr>
        </tbody>
      </table>
      <h3>Pasajeros</h3>
      <ol>
        {b.passengers.map((p) => (
          <li key={p.id}>
            {p.name ?? 'Sin nombre aún'} · {PASSENGER_TYPES[p.type]}{' '}
            {p.cedula ? `· ${p.cedula}` : ''} {p.restrictions ? `· ${p.restrictions}` : ''}
          </li>
        ))}
      </ol>
    </section>
  );
}
