import Link from 'next/link';
import { notFound } from 'next/navigation';
import { CHECKIN_MARKS, DEPARTURE_STATUS_LABELS, PASSENGER_TYPES } from '@fulldays/shared';
import { requireMe } from '@fulldays/web-session';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../../lib/api';
import { markPassenger, moveDeparture, publishNotice } from './actions';

const money = (n: number) => `${n.toFixed(2)} USD`;

export default async function OperateDeparturePage({
  params,
}: {
  params: Promise<{ providerId: string; departureId: string }>;
}) {
  const { providerId, departureId } = await params;
  const me = await requireMe(`/agencia/${providerId}/salidas/${departureId}`);
  const membership = me.memberships.find((m) => m.providerId === providerId);
  if (!membership) notFound();
  const can = (p: string) => membership.permissions.includes(p as never);
  const path = { params: { path: { providerId, departureId } } };
  const [manifest, production, notices] = await Promise.all([
    can('checkin')
      ? read((api) => api.GET('/v1/pro/{providerId}/salidas/{departureId}/pasajeros', path))
      : null,
    can('bookings')
      ? read((api) => api.GET('/v1/pro/{providerId}/salidas/{departureId}/produccion', path))
      : null,
    can('notices')
      ? read((api) => api.GET('/v1/pro/{providerId}/salidas/{departureId}/avisos', path))
      : null,
  ]);
  const departure = manifest?.departure ?? production?.departure;
  if (!departure) notFound();
  const status = manifest?.departure.status;
  const boarded = manifest?.passengers.filter((p) => p.checkin === 'boarded').length ?? 0;

  return (
    <>
      <section className="tarjeta">
        <h2>
          {departure.title} · {departure.date}
        </h2>
        <p className="suave">
          {status ? <span className="fd-pill">{DEPARTURE_STATUS_LABELS[status]}</span> : null}
          {manifest ? ` · ${boarded} de ${manifest.passengers.length} a bordo` : null}
        </p>
        <div className="fd-inline">
          {can('departures') && status && ['open', 'closed', 'paused'].includes(status) ? (
            <ActionForm
              action={moveDeparture.bind(null, providerId, departureId, 'in_progress')}
              submit="Iniciar salida"
              confirm="¿Iniciar la salida? Ya no se venderán puestos."
            />
          ) : null}
          {can('departures') && status === 'in_progress' ? (
            <ActionForm
              action={moveDeparture.bind(null, providerId, departureId, 'finished')}
              submit="Finalizar salida"
              confirm="¿Finalizar? Quien no abordó queda como «No se presentó»."
            />
          ) : null}
          {can('bookings') ? (
            <a
              className="fd-link-button"
              href={`/agencia/${providerId}/salidas/${departureId}/pasajeros.csv`}
            >
              Descargar lista (Excel)
            </a>
          ) : null}
        </div>
      </section>

      {manifest ? (
        <section className="tarjeta">
          <h2>Pasajeros</h2>
          {manifest.passengers.length === 0 ? (
            <p className="suave">Aún no hay reservas confirmadas.</p>
          ) : null}
          {manifest.passengers.map((p) => (
            <article key={p.id} className="bloque">
              <p>
                <strong>{p.name ?? `Pasajero ${p.position + 1}`}</strong> ·{' '}
                {PASSENGER_TYPES[p.type]}
                {p.cedula ? ` · C.I. ${p.cedula}` : ''} · {p.bookingCode}
                {p.boarding ? ` · ${p.boarding}` : ''}{' '}
                {p.checkin ? <span className="fd-pill">{CHECKIN_MARKS[p.checkin]}</span> : null}
              </p>
              {p.meals.length || p.restrictions || p.balanceUsd > 0 ? (
                <p className="suave">
                  {[
                    ...p.meals,
                    p.restrictions ? `Restricciones: ${p.restrictions}` : null,
                    p.balanceUsd > 0 && p.position === 0 ? `Saldo: ${money(p.balanceUsd)}` : null,
                  ]
                    .filter(Boolean)
                    .join(' · ')}
                </p>
              ) : null}
              <div className="fd-inline">
                {p.checkin !== 'boarded' ? (
                  <ActionForm
                    action={markPassenger.bind(null, providerId, departureId, p.id, 'boarded')}
                    submit="Abordó"
                  />
                ) : null}
                {p.checkin !== 'no_show' ? (
                  <ActionForm
                    action={markPassenger.bind(null, providerId, departureId, p.id, 'no_show')}
                    submit="No se presentó"
                    submitClassName="fd-link-button"
                  />
                ) : null}
                {p.checkin ? (
                  <ActionForm
                    action={markPassenger.bind(null, providerId, departureId, p.id, null)}
                    submit="Deshacer"
                    submitClassName="fd-link-button"
                  />
                ) : null}
              </div>
            </article>
          ))}
        </section>
      ) : null}

      {production ? (
        <section className="tarjeta">
          <h2>Producción</h2>
          <p>
            {production.passengers.map((p) => `${p.label}: ${p.count}`).join(' · ') ||
              'Sin pasajeros confirmados.'}
          </p>
          {production.meals.map((m) => (
            <div key={m.mealId} className="bloque">
              <p>
                <strong>{m.name}</strong> · {m.servings} porciones
                {m.description ? ` · ${m.description}` : ''}
              </p>
              {m.options.length ? (
                <ul>
                  {m.options.map((o) => (
                    <li key={o.optionId}>
                      {o.name}: {o.count}
                    </li>
                  ))}
                  {m.pending ? <li>Por escoger: {m.pending}</li> : null}
                </ul>
              ) : null}
            </div>
          ))}
          {production.items.length ? (
            <>
              <h3>Ítems</h3>
              <ul>
                {production.items.map((i) => (
                  <li key={i.itemId}>
                    {i.name}: {i.units}
                  </li>
                ))}
              </ul>
            </>
          ) : null}
          {production.rooms.length ? (
            <>
              <h3>Habitaciones</h3>
              <ul>
                {production.rooms.map((r) => (
                  <li key={r.type}>
                    {r.label}: {r.count}
                  </li>
                ))}
              </ul>
            </>
          ) : null}
          {production.restrictions.length ? (
            <>
              <h3>Restricciones</h3>
              <ul>
                {production.restrictions.map((r, i) => (
                  <li key={i}>
                    {r.name}: {r.restrictions}
                  </li>
                ))}
              </ul>
            </>
          ) : null}
        </section>
      ) : null}

      {notices ? (
        <section className="tarjeta">
          <h2>Avisos a los viajeros</h2>
          <p className="suave">
            Lo ven en su reserva todos los viajeros con el pago confirmado: cambios de hora, punto
            de encuentro, clima.
          </p>
          <ActionForm action={publishNotice.bind(null, providerId, departureId)} submit="Publicar">
            <label className="fd-field">
              <span>Aviso</span>
              <textarea name="body" maxLength={1000} rows={3} required />
            </label>
          </ActionForm>
          {notices.items.map((n) => (
            <article key={n.id} className="bloque">
              <p>{n.body}</p>
              <p className="suave">
                {n.author ?? 'La agencia'} ·{' '}
                {new Date(n.createdAt).toLocaleString('es-VE', { timeZone: 'America/Caracas' })}
              </p>
            </article>
          ))}
        </section>
      ) : null}

      <p className="fd-links">
        <Link href={`/agencia/${providerId}/${can('departures') ? 'salidas' : 'hoy'}`}>Volver</Link>
      </p>
    </>
  );
}
