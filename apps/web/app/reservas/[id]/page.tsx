import Link from 'next/link';
import { notFound } from 'next/navigation';
import {
  BOOKING_STATUS_LABELS,
  CONFIRMED_STATUSES,
  PASSENGER_TYPES,
  PAYMENT_METHODS,
  PAYMENT_STATUS_LABELS,
  REVIEW_ASPECTS,
} from '@fulldays/shared';
import { requireMe, sessionApi } from '@fulldays/web-session';
import { ActionForm } from '@fulldays/web-session/action-form';
import { bs, longDate, usd } from '../../../lib/format';
import { ClaimThread } from '../../../components/claim';
import { cancelBooking, openClaim, reviewBooking, savePassengers } from './actions';
import { PaymentForm } from './payment-form';

export const metadata = { title: 'Mi reserva', robots: { index: false } };

export default async function BookingPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  await requireMe(`/reservas/${id}`);
  const api = await sessionApi();
  const path = { params: { path: { id } } };
  const [
    { data: b },
    { data: payments },
    { data: settings },
    { data: rate },
    { data: notices },
    { data: quote },
    { data: claims },
  ] = await Promise.all([
    api.GET('/v1/reservas/{id}', path),
    api.GET('/v1/reservas/{id}/pagos', path),
    api.GET('/v1/ajustes'),
    api.GET('/v1/tasa'),
    api.GET('/v1/reservas/{id}/avisos', path),
    api.GET('/v1/reservas/{id}/cancelacion', path),
    api.GET('/v1/reclamos', { params: { query: { reserva: id } } }),
  ]);
  if (!b) notFound();
  const back = `/reservas/${id}`;
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
      {notices?.items.length ? (
        <section className="tarjeta avisos" aria-label="Avisos de la agencia">
          <h2>Avisos de la agencia</h2>
          {notices.items.map((n) => (
            <article key={n.id}>
              <p>{n.body}</p>
              <p className="suave">
                {new Date(n.createdAt).toLocaleString('es-VE', {
                  dateStyle: 'medium',
                  timeStyle: 'short',
                  timeZone: 'America/Caracas',
                })}
              </p>
            </article>
          ))}
        </section>
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
            action={savePassengers.bind(
              null,
              b.id,
              b.passengers.length,
              b.mealChoices.map((m) => m.mealId),
            )}
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
                {p.type !== 'infant'
                  ? b.mealChoices.map((m) =>
                      m.picksPerPassenger === 1 ? (
                        <label key={m.mealId} className="fd-field">
                          <span>{m.name}</span>
                          <select
                            name={`meal.${i}.${m.mealId}`}
                            defaultValue={p.mealPicks[m.mealId]?.[0] ?? ''}
                          >
                            <option value="">
                              {m.options.find((o) => o.isDefault)
                                ? `Lo de la casa (${m.options.find((o) => o.isDefault)!.name})`
                                : 'Escoger después'}
                            </option>
                            {m.options.map((o) => (
                              <option key={o.id} value={o.id}>
                                {o.name}
                              </option>
                            ))}
                          </select>
                        </label>
                      ) : (
                        <fieldset key={m.mealId} className="fd-inline">
                          <legend className="fd-etiqueta">
                            {m.name} (hasta {m.picksPerPassenger})
                          </legend>
                          {m.options.map((o) => (
                            <label key={o.id} className="fd-check">
                              <input
                                type="checkbox"
                                name={`meal.${i}.${m.mealId}`}
                                value={o.id}
                                defaultChecked={p.mealPicks[m.mealId]?.includes(o.id)}
                              />
                              {o.name}
                            </label>
                          ))}
                        </fieldset>
                      ),
                    )
                  : null}
              </fieldset>
            ))}
          </ActionForm>
        </section>
      ) : null}
      {b.status === 'cancelled' ? (
        <section className="tarjeta">
          <h2>Cancelación</h2>
          {b.refund ? (
            <p>
              Te corresponden <strong>{usd(b.refund.amountUsd)}</strong>. {b.refund.rule}{' '}
              {b.refund.status === 'paid'
                ? `La agencia ya te los devolvió${b.refund.reference ? ` (ref. ${b.refund.reference})` : ''}.`
                : 'La agencia te los devolverá por el mismo medio en que pagaste.'}
            </p>
          ) : (
            <p className="suave">Esta reserva no tiene reembolso.</p>
          )}
        </section>
      ) : null}
      {b.canReview ? (
        <section className="tarjeta">
          <h2>¿Cómo te fue?</h2>
          <p className="suave">Tu reseña ayuda a otros viajeros. Solo se publica tu nombre.</p>
          <ActionForm action={reviewBooking.bind(null, b.id)} submit="Publicar reseña">
            <label className="fd-field">
              <span>Calificación general</span>
              <select name="rating" required defaultValue="5">
                {[5, 4, 3, 2, 1].map((n) => (
                  <option key={n} value={n}>
                    {'★'.repeat(n)} ({n})
                  </option>
                ))}
              </select>
            </label>
            <div className="fila">
              {Object.entries(REVIEW_ASPECTS).map(([key, label]) => (
                <label key={key} className="fd-field">
                  <span>{label}</span>
                  <select name={`aspect.${key}`} defaultValue="">
                    <option value="">—</option>
                    {[5, 4, 3, 2, 1].map((n) => (
                      <option key={n} value={n}>
                        {n}
                      </option>
                    ))}
                  </select>
                </label>
              ))}
            </div>
            <fieldset className="fd-field">
              <legend>¿Fue como se describió?</legend>
              <label className="fd-check">
                <input type="radio" name="asDescribed" value="si" defaultChecked /> Sí
              </label>
              <label className="fd-check">
                <input type="radio" name="asDescribed" value="no" /> No
              </label>
            </fieldset>
            <label className="fd-field">
              <span>Comentario</span>
              <textarea name="comment" maxLength={2000} rows={3} />
            </label>
          </ActionForm>
        </section>
      ) : null}
      {quote?.allowed ? (
        <section className="tarjeta">
          <h2>Cancelar</h2>
          <p>
            Si cancelas hoy, te devuelven <strong>{usd(quote.amountUsd)}</strong>. {quote.rule}
          </p>
          <ActionForm
            action={cancelBooking.bind(null, b.id)}
            submit="Cancelar reserva"
            submitClassName="fd-button fd-button-secundario"
            confirm={`¿Cancelar la reserva ${b.code}? Te devolverán ${usd(quote.amountUsd)}. No se puede deshacer.`}
          />
        </section>
      ) : null}
      {b.paidUsd > 0 ? (
        <section className="tarjeta">
          <h2>Reclamos</h2>
          {claims?.items.map((c) => (
            <ClaimThread key={c.id} claim={c} back={back} />
          ))}
          <details>
            <summary>Abrir un reclamo</summary>
            <ActionForm action={openClaim.bind(null, b.id)} submit="Enviar a la agencia">
              <label className="fd-field">
                <span>Asunto</span>
                <input name="subject" required minLength={3} maxLength={150} />
              </label>
              <label className="fd-field">
                <span>Qué pasó</span>
                <textarea name="message" required maxLength={3000} rows={3} />
              </label>
            </ActionForm>
          </details>
        </section>
      ) : null}
    </main>
  );
}
