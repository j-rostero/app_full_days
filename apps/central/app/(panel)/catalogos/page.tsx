import { DESTINATION_PAYMENTS } from '@fulldays/shared';
import { requireMe } from '@fulldays/web-session';
import type { ActionState } from '@fulldays/web-session/act';
import { ActionForm } from '@fulldays/web-session/action-form';
import { notFound } from 'next/navigation';
import type { ReactNode } from 'react';
import { read, type Schemas } from '../../../lib/api';
import {
  addFee,
  createBoardingPoint,
  createDestination,
  createTheme,
  deleteBoardingPoint,
  deleteDestination,
  deleteFee,
  deleteTheme,
} from './actions';

const Field = ({ label, children }: { label: string; children: ReactNode }) => (
  <label className="fd-field">
    <span>{label}</span>
    {children}
  </label>
);

const Remove = ({
  action,
  what,
}: {
  action: (state: ActionState, form: FormData) => Promise<ActionState>;
  what: string;
}) => (
  <ActionForm
    action={action}
    submit="Borrar"
    className="fd-quiet"
    submitClassName="fd-link-button"
    confirm={`¿Borrar ${what}?`}
  />
);

function Fees({ place }: { place: Schemas['Site'] }) {
  return (
    <>
      {place.fees.length ? (
        <ul>
          {place.fees.map((fee) => (
            <li key={fee.id}>
              {fee.name}: {fee.amountUsd} USD (
              {DESTINATION_PAYMENTS[fee.payment as keyof typeof DESTINATION_PAYMENTS] ??
                fee.payment}
              )
              <Remove action={deleteFee.bind(null, fee.id)} what={`la tasa «${fee.name}»`} />
            </li>
          ))}
        </ul>
      ) : null}
      <details>
        <summary>Añadir tasa de acceso</summary>
        <ActionForm action={addFee.bind(null, place.id)} submit="Añadir tasa">
          <Field label="Nombre">
            <input name="name" required />
          </Field>
          <Field label="Monto (USD)">
            <input name="amountUsd" inputMode="decimal" required />
          </Field>
          <Field label="Se paga en">
            <select name="payment">
              {Object.entries(DESTINATION_PAYMENTS).map(([key, label]) => (
                <option key={key} value={key}>
                  {label}
                </option>
              ))}
            </select>
          </Field>
        </ActionForm>
      </details>
    </>
  );
}

function PlaceFields() {
  return (
    <>
      <Field label="Nombre">
        <input name="name" required />
      </Field>
      <Field label="Identificador (los-roques)">
        <input name="slug" required pattern="[a-z0-9]+(-[a-z0-9]+)*" />
      </Field>
      <Field label="Estado">
        <input name="state" />
      </Field>
      <Field label="Región">
        <input name="region" />
      </Field>
      <Field label="Latitud">
        <input name="lat" inputMode="decimal" />
      </Field>
      <Field label="Longitud">
        <input name="lng" inputMode="decimal" />
      </Field>
    </>
  );
}

export default async function Catalogs() {
  const me = await requireMe('/');
  const canCatalogs = me.staff.permissions.includes('catalogs');
  const canThemes = me.staff.permissions.includes('themes');
  if (!canCatalogs && !canThemes) notFound();
  const [destinations, points, themes] = await Promise.all([
    read((api) => api.GET('/v1/catalogos/destinos')),
    read((api) => api.GET('/v1/catalogos/puntos-de-embarque', { params: { query: {} } })),
    read((api) => api.GET('/v1/tematicas')),
  ]);
  return (
    <>
      {canCatalogs ? (
        <>
          <section className="tarjeta">
            <h2>Destinos y sitios</h2>
            <p className="suave">
              Un destino agrupa sitios (por ejemplo, Mochima y sus playas). Las tasas conocidas se
              sugieren al armar una ficha.
            </p>
            {destinations.items.map((d) => (
              <article key={d.id} className="bloque">
                <h3>
                  {d.name}{' '}
                  <span className="suave">{[d.state, d.region].filter(Boolean).join(' · ')}</span>
                </h3>
                {d.sites.length === 0 ? (
                  <Remove
                    action={deleteDestination.bind(null, d.id)}
                    what={`el destino «${d.name}»`}
                  />
                ) : null}
                <Fees place={d} />
                {d.sites.length ? <h4>Sitios</h4> : null}
                <ul>
                  {d.sites.map((s) => (
                    <li key={s.id}>
                      <strong>{s.name}</strong>
                      <Remove
                        action={deleteDestination.bind(null, s.id)}
                        what={`el sitio «${s.name}»`}
                      />
                      <Fees place={s} />
                    </li>
                  ))}
                </ul>
                <details>
                  <summary>Añadir sitio en {d.name}</summary>
                  <ActionForm action={createDestination.bind(null, d.id)} submit="Crear sitio">
                    <PlaceFields />
                  </ActionForm>
                </details>
              </article>
            ))}
            <details>
              <summary>Nuevo destino</summary>
              <ActionForm action={createDestination.bind(null, null)} submit="Crear destino">
                <PlaceFields />
              </ActionForm>
            </details>
          </section>
          <section className="tarjeta">
            <h2>Puntos de embarque</h2>
            <table className="fd-table">
              <tbody>
                {points.items.map((p) => (
                  <tr key={p.id}>
                    <td>{p.city}</td>
                    <td>{p.name}</td>
                    <td>{p.address}</td>
                    <td>
                      <Remove action={deleteBoardingPoint.bind(null, p.id)} what={`«${p.name}»`} />
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
            <details>
              <summary>Nuevo punto de embarque</summary>
              <ActionForm action={createBoardingPoint} submit="Crear punto">
                <Field label="Ciudad">
                  <input name="city" required />
                </Field>
                <Field label="Nombre">
                  <input name="name" required />
                </Field>
                <Field label="Dirección">
                  <input name="address" />
                </Field>
                <Field label="Latitud">
                  <input name="lat" inputMode="decimal" />
                </Field>
                <Field label="Longitud">
                  <input name="lng" inputMode="decimal" />
                </Field>
              </ActionForm>
            </details>
          </section>
        </>
      ) : null}
      {canThemes ? (
        <section className="tarjeta">
          <h2>Temáticas</h2>
          <ul>
            {themes.items.map((t) => (
              <li key={t.id}>
                <strong>{t.name}</strong> <span className="suave">{t.description}</span>
                <Remove action={deleteTheme.bind(null, t.id)} what={`la temática «${t.name}»`} />
              </li>
            ))}
          </ul>
          <details>
            <summary>Nueva temática</summary>
            <ActionForm action={createTheme} submit="Crear temática">
              <Field label="Nombre">
                <input name="name" required />
              </Field>
              <Field label="Identificador (playas)">
                <input name="slug" required pattern="[a-z0-9]+(-[a-z0-9]+)*" />
              </Field>
              <Field label="Descripción">
                <textarea name="description" maxLength={500} />
              </Field>
            </ActionForm>
          </details>
        </section>
      ) : null}
    </>
  );
}
