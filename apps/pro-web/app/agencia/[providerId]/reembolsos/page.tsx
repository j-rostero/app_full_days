import Link from 'next/link';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { payRefund } from '../posttrip-actions';

export default async function RefundsPage({ params }: { params: Promise<{ providerId: string }> }) {
  const { providerId } = await params;
  const { items } = await read((api) =>
    api.GET('/v1/pro/{providerId}/reembolsos', { params: { path: { providerId } } }),
  );
  const pending = items.filter((r) => r.status === 'pending');
  const paid = items.filter((r) => r.status === 'paid');
  return (
    <section className="tarjeta">
      <h2>Reembolsos</h2>
      <p className="suave">
        Cada cancelación con dinero a devolver queda aquí con el monto que dice la política. Haz la
        transferencia y márcalo pagado con su referencia: el viajero recibe el aviso y la
        liquidación del mes lo descuenta.
      </p>
      <h3>Por pagar ({pending.length})</h3>
      {pending.length === 0 ? <p className="suave">No hay reembolsos por pagar.</p> : null}
      {pending.map((r) => (
        <article key={r.id} className="bloque">
          <p>
            <strong>{r.amountUsd.toFixed(2)} USD</strong> a {r.traveler ?? 'viajero'} ·{' '}
            <Link href={`/agencia/${providerId}/reservas/${r.bookingId}`}>{r.bookingCode}</Link> ·{' '}
            {r.title} · salida {r.departureDate}
          </p>
          <p className="suave">{r.rule}</p>
          <ActionForm
            action={payRefund.bind(null, providerId, r.id)}
            submit="Marcar pagado"
            className="fd-inline"
            confirm={`¿Ya transferiste ${r.amountUsd.toFixed(2)} USD?`}
          >
            <label className="fd-field">
              <span>Referencia de la transferencia</span>
              <input name="reference" maxLength={80} placeholder="Opcional" />
            </label>
          </ActionForm>
        </article>
      ))}
      <h3>Pagados</h3>
      {paid.length === 0 ? <p className="suave">Todavía no hay reembolsos pagados.</p> : null}
      {paid.length ? (
        <table className="fd-table">
          <thead>
            <tr>
              <th>Reserva</th>
              <th>Monto</th>
              <th>Referencia</th>
              <th>Pagado</th>
            </tr>
          </thead>
          <tbody>
            {paid.map((r) => (
              <tr key={r.id}>
                <td>{r.bookingCode}</td>
                <td>{r.amountUsd.toFixed(2)} USD</td>
                <td>{r.reference ?? '—'}</td>
                <td>{r.paidAt ? new Date(r.paidAt).toLocaleDateString('es-VE') : ''}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : null}
    </section>
  );
}
