import {
  canMoveDeparture,
  DEPARTURE_STATUS_LABELS,
  type DepartureStatus,
  todayInVenezuela,
} from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { scheduleDepartures, updateDeparture } from './actions';

export default async function DeparturesPage({
  params,
}: {
  params: Promise<{ providerId: string }>;
}) {
  const { providerId } = await params;
  const path = { params: { path: { providerId } } };
  const [departures, products, team] = await Promise.all([
    read((api) =>
      api.GET('/v1/pro/{providerId}/salidas', { params: { path: { providerId }, query: {} } }),
    ),
    read((api) => api.GET('/v1/pro/{providerId}/productos', path)).catch(() => ({ items: [] })),
    read((api) => api.GET('/v1/pro/{providerId}/equipo', path)).catch(() => ({ items: [] })),
  ]);
  const published = products.items.filter((p) => p.status === 'published');
  const guides = team.items.filter(
    (m) => m.role === 'guide' || m.role === 'owner' || m.role === 'operations',
  );
  const today = todayInVenezuela();
  return (
    <>
      <section className="tarjeta">
        <h2>Programar salidas</h2>
        {published.length === 0 ? (
          <p className="suave">Publica un producto para programar sus fechas.</p>
        ) : (
          <ActionForm action={scheduleDepartures.bind(null, providerId)} submit="Programar">
            <label className="fd-field">
              <span>Producto</span>
              <select name="productId" required>
                {published.map((p) => (
                  <option key={p.id} value={p.id}>
                    {p.title}
                  </option>
                ))}
              </select>
            </label>
            <div className="fd-inline">
              <label className="fd-field">
                <span>Fecha</span>
                <input type="date" name="desde" min={today} required />
              </label>
              <label className="fd-field">
                <span>Repetir</span>
                <select name="repetir" defaultValue="no">
                  <option value="no">Solo esa fecha</option>
                  <option value="semanal">Cada semana hasta…</option>
                </select>
              </label>
              <label className="fd-field">
                <span>Hasta (si se repite)</span>
                <input type="date" name="hasta" min={today} />
              </label>
            </div>
            <div className="fd-inline">
              <label className="fd-field">
                <span>Cupo</span>
                <input name="capacity" inputMode="numeric" required defaultValue="20" />
              </label>
              <label className="fd-field">
                <span>Mínimo para salir</span>
                <input name="minCapacity" inputMode="numeric" defaultValue="1" />
              </label>
              <label className="fd-field">
                <span>Precio de adulto USD (vacío: el de la ficha)</span>
                <input name="adultPriceUsd" inputMode="decimal" />
              </label>
            </div>
          </ActionForm>
        )}
      </section>
      <section className="tarjeta">
        <h2>Próximas salidas</h2>
        {departures.items.length === 0 ? (
          <p className="suave">No hay salidas programadas.</p>
        ) : null}
        {departures.items.map((d) => (
          <details key={d.id} className="fila-bloque">
            <summary>
              {d.date} · {d.title} ·{' '}
              <span className="fd-pill">{DEPARTURE_STATUS_LABELS[d.status]}</span> · {d.reserved}/
              {d.capacity} puestos · {d.priceUsd} USD
            </summary>
            <ActionForm
              action={updateDeparture.bind(null, providerId, d.id)}
              submit="Guardar salida"
            >
              <div className="fd-inline">
                <label className="fd-field">
                  <span>Estado</span>
                  <select name="status" defaultValue={d.status}>
                    {(Object.keys(DEPARTURE_STATUS_LABELS) as DepartureStatus[])
                      .filter((s) => canMoveDeparture(d.status, s))
                      .map((s) => (
                        <option key={s} value={s}>
                          {DEPARTURE_STATUS_LABELS[s]}
                        </option>
                      ))}
                  </select>
                </label>
                <label className="fd-field">
                  <span>Cupo</span>
                  <input name="capacity" inputMode="numeric" defaultValue={d.capacity} />
                </label>
                <label className="fd-field">
                  <span>Mínimo</span>
                  <input name="minCapacity" inputMode="numeric" defaultValue={d.minCapacity} />
                </label>
                <label className="fd-field">
                  <span>Precio propio USD</span>
                  <input
                    name="adultPriceUsd"
                    inputMode="decimal"
                    defaultValue={d.adultPriceUsd ?? ''}
                  />
                </label>
              </div>
              {guides.length ? (
                <fieldset className="fd-inline">
                  <legend className="fd-etiqueta">Guías</legend>
                  {guides.map((g) => (
                    <label key={g.user.id} className="fd-check">
                      <input
                        type="checkbox"
                        name="guideIds"
                        value={g.user.id}
                        defaultChecked={d.guides.some((x) => x.id === g.user.id)}
                      />
                      {g.user.name ?? g.user.email}
                    </label>
                  ))}
                </fieldset>
              ) : null}
            </ActionForm>
          </details>
        ))}
      </section>
    </>
  );
}
