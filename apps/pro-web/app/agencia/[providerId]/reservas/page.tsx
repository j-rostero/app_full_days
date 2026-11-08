import Link from 'next/link';
import { BOOKING_STATUS_LABELS, type BookingStatus } from '@fulldays/shared';
import { read } from '../../../../lib/api';

export default async function BookingsPage({
  params,
  searchParams,
}: {
  params: Promise<{ providerId: string }>;
  searchParams: Promise<{ salida?: string; estado?: string }>;
}) {
  const { providerId } = await params;
  const { salida, estado } = await searchParams;
  const [bookings, departures] = await Promise.all([
    read((api) =>
      api.GET('/v1/pro/{providerId}/reservas', {
        params: {
          path: { providerId },
          query: {
            ...(salida ? { departureId: salida } : {}),
            ...(estado ? { status: estado as BookingStatus } : {}),
          },
        },
      }),
    ),
    read((api) =>
      api.GET('/v1/pro/{providerId}/salidas', { params: { path: { providerId }, query: {} } }),
    ),
  ]);
  const base = `/agencia/${providerId}/reservas`;
  return (
    <section className="tarjeta">
      <div className="barra">
        <h2>Reservas</h2>
        <Link className="fd-button" href={`${base}/nueva${salida ? `?salida=${salida}` : ''}`}>
          Venta propia
        </Link>
      </div>
      <form className="fd-inline">
        <label className="fd-field">
          <span>Salida</span>
          <select name="salida" defaultValue={salida ?? ''}>
            <option value="">Todas</option>
            {departures.items.map((d) => (
              <option key={d.id} value={d.id}>
                {d.date} · {d.title} ({d.reserved}/{d.capacity})
              </option>
            ))}
          </select>
        </label>
        <label className="fd-field">
          <span>Estado</span>
          <select name="estado" defaultValue={estado ?? ''}>
            <option value="">Todos</option>
            {Object.entries(BOOKING_STATUS_LABELS).map(([k, v]) => (
              <option key={k} value={k}>
                {v}
              </option>
            ))}
          </select>
        </label>
        <button className="fd-button fd-button-secundario" type="submit">
          Filtrar
        </button>
      </form>
      {bookings.items.length === 0 ? (
        <p className="suave">No hay reservas con esos filtros.</p>
      ) : null}
      <table className="fd-table">
        <thead>
          <tr>
            <th>Código</th>
            <th>Viaje</th>
            <th>Puestos</th>
            <th>Total</th>
            <th>Pagado</th>
            <th>Estado</th>
            <th>Origen</th>
          </tr>
        </thead>
        <tbody>
          {bookings.items.map((b) => (
            <tr key={b.id}>
              <td>
                <Link href={`${base}/${b.id}`}>{b.code}</Link>
              </td>
              <td>
                {b.departure.date} · {b.product.title}
              </td>
              <td>{b.seats}</td>
              <td>{b.totalUsd.toFixed(2)}</td>
              <td>{b.paidUsd.toFixed(2)}</td>
              <td>{BOOKING_STATUS_LABELS[b.status]}</td>
              <td>{b.source === 'agency' ? (b.contact?.name ?? 'Venta propia') : 'App'}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </section>
  );
}
