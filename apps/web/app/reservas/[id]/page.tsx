import Link from 'next/link';
import { notFound } from 'next/navigation';
import {
  BOOKING_STATUS_LABELS,
  CONFIRMED_STATUSES,
  PASSENGER_TYPES,
  PAYMENT_METHODS,
  PAYMENT_STATUS_LABELS,
} from '@fulldays/shared';
import { requireMe, sessionApi } from '@fulldays/web-session';
import { ActionForm } from '@fulldays/web-session/action-form';
import { bs, longDate, usd } from '../../../lib/format';
import { savePassengers } from './actions';
import { PaymentForm } from './payment-form';

export const metadata = { title: 'Mi reserva', robots: { index: false } };

export default async function BookingPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  await requireMe(`/reservas/${id}`);
  const api = await sessionApi();
  const path = { params: { path: { id } } };
  const [{ data: b }, { data: payments }, { data: settings }, { data: rate }] = await Promise.all([
    api.GET('/v1/reservas/{id}', path),
    api.GET('/v1/reservas/{id}/pagos', path),
    api.GET('/v1/ajustes'),
    api.GET('/v1/tasa'),
  ]);
  if (!b) notFound();
  const accepts = ['held', 'in_review', 'deposit_paid'].includes(b.status);
  const toDeposit = Math.max(b.depositUsd - b.paidUsd - b.pendingUsd, 0);
  const toTotal = Math.max(b.totalUsd - b.paidUsd - b.pendingUsd, 0);
  const confirmed = (CONFIRMED_STATUSES as readonly string[]).includes(b.status);
  return (
    <main>
      <p className="suave">
        Reserva <strong>{b.code}</strong>
      </p>
      <h1>{b.product.title}</h1>
      <p>
        <span className={`fd-pill estado-${b.status}`}>{BOOKING_STATUS_LABELS[b.status]}</span> ·{' '}
        {longDate(b.departure.date)} · {b.provider.name}
      </p>
      {b.status === 'held' && b.heldUntil ? (
        <p className="aviso">
          Tus puestos están apartados hasta las{' '}
          {new Date(b.heldUntil).toLocaleTimeString('es-VE', {
            hour: '2-digit',
            minute: '2-digit',
            timeZone: 'America/Caracas',
          })}
          . Reporta tu pago antes para no perderlos.
        </p>
      ) : null}
      {b.status === 'in_review' ? (
        <p className="aviso">La agencia está revisando tu pago. Tus puestos siguen apartados.</p>
      ) : null}
      {confirmed ? (
        <p>
          <Link className="fd-button" href={`/reservas/${b.id}/vouchers`}>
            Ver vouchers
          </Link>
        </p>
      ) : null}

      <section className="tarjeta">
        <h2>Precio</h2>
        <table className="fd-table">
          <tbody>
            {b.lines.map((l) => (
              <tr key={l.label}>
                <td>{l.label}</td>
                <td className="cifra">{usd(l.amountUsd)}</td>
              </tr>
            ))}
            <tr>
              <th>Total</th>
              <th className="cifra">{usd(b.totalUsd)}</th>
            </tr>
            <tr>
              <td>Pagado y confirmado</td>
              <td className="cifra">{usd(b.paidUsd)}</td>
            </tr>
            {b.pendingUsd ? (
              <tr>
                <td>Reportado, por revisar</td>
                <td className="cifra">{usd(b.pendingUsd)}</td>
              </tr>
            ) : null}
            <tr>
              <th>Saldo</th>
              <th className="cifra">{usd(b.balanceUsd)}</th>
            </tr>
          </tbody>
        </table>
        <p className="suave">
          Abono para confirmar: {usd(b.depositUsd)}.{' '}
          {b.balanceUsd > 0 ? `El saldo vence el ${b.balanceDueDate}.` : ''}
        </p>
      </section>

      {accepts && toTotal > 0 ? (
        <section className="tarjeta">
          <h2>Pagar</h2>
          {b.provider.paymentInstructions ? (
            <>
              <p>Paga directo a {b.provider.name}:</p>
              <p className="texto-largo instrucciones">{b.provider.paymentInstructions}</p>
            </>
          ) : (
            <p className="suave">
              {b.provider.name} te enviará los datos de pago. Después repórtalo aquí.
            </p>
          )}
          <PaymentForm
            bookingId={b.id}
            methods={settings?.paymentMethods ?? ['zelle']}
            suggestedUsd={toDeposit > 0 ? toDeposit : toTotal}
            bsPerUsd={rate?.bsPerUsd ?? null}
          />
        </section>
      ) : null}

      {payments?.items.length ? (
        <section className="tarjeta">
          <h2>Pagos</h2>
          <ul>
            {payments.items.map((p) => (
              <li key={p.id}>
                {PAYMENT_METHODS[p.method]} · {usd(p.amountUsd)}
                {p.amountBs ? ` (${bs(p.amountBs)})` : ''} · ref. {p.reference} ·{' '}
                <strong>{PAYMENT_STATUS_LABELS[p.status]}</strong>
                {p.reason ? <span className="fd-form-error"> {p.reason}</span> : null}
              </li>
            ))}
          </ul>
        </section>
      ) : null}

      {accepts || b.status === 'paid' ? (
        <section className="tarjeta">
          <h2>Pasajeros</h2>
          <p className="suave">
            La agencia necesita estos datos para la lista del viaje y el seguro.
          </p>
          <ActionForm
            action={savePassengers.bind(null, b.id, b.passengers.length)}
            submit="Guardar pasajeros"
          >
            {b.passengers.map((p, i) => (
              <fieldset key={p.id} className="pasajero">
                <legend>
                  Pasajero {i + 1} · {PASSENGER_TYPES[p.type]}
                </legend>
                <label className="fd-field">
                  <span>Nombre y apellido</span>
                  <input name={`name.${i}`} defaultValue={p.name ?? ''} required />
                </label>
                <label className="fd-field">
                  <span>Cédula (opcional en menores)</span>
                  <input
                    name={`cedula.${i}`}
                    defaultValue={p.cedula ?? ''}
                    placeholder="V-12345678"
                  />
                </label>
                <label className="fd-field">
                  <span>Fecha de nacimiento</span>
                  <input
                    type="date"
                    name={`birthDate.${i}`}
                    defaultValue={p.birthDate ?? ''}
                    required
                  />
                </label>
                <label className="fd-field">
                  <span>Alergias o restricciones</span>
                  <input name={`restrictions.${i}`} defaultValue={p.restrictions ?? ''} />
                </label>
              </fieldset>
            ))}
          </ActionForm>
        </section>
      ) : null}
    </main>
  );
}
