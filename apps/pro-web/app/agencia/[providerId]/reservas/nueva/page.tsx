import Link from 'next/link';
import { PASSENGER_TYPES, PAYMENT_METHODS, ROOM_TYPES, todayInVenezuela } from '@fulldays/shared';
import { sessionApi } from '@fulldays/web-session';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../../lib/api';
import { createManualBooking } from './actions';

/** Venta por WhatsApp u oficina: toma puestos de la salida sin temporizador. */
export default async function ManualSale({
  params,
  searchParams,
}: {
  params: Promise<{ providerId: string }>;
  searchParams: Promise<{ salida?: string }>;
}) {
  const { providerId } = await params;
  const { salida } = await searchParams;
  const departures = await read((api) =>
    api.GET('/v1/pro/{providerId}/salidas', {
      params: { path: { providerId }, query: { desde: todayInVenezuela() } },
    }),
  );
  const open = departures.items.filter((d) => d.status === 'open' && d.seatsLeft > 0);
  const chosen = salida
    ? (await (await sessionApi()).GET('/v1/salidas/{id}', { params: { path: { id: salida } } }))
        .data
    : undefined;
  return (
    <section className="tarjeta">
      <p>
        <Link href={`/agencia/${providerId}/reservas`}>← Reservas</Link>
      </p>
      <h2>Venta propia</h2>
      <form className="fd-inline">
        <label className="fd-field">
          <span>Salida</span>
          <select name="salida" defaultValue={salida ?? ''} required>
            <option value="" disabled>
              Escoge una salida en venta
            </option>
            {open.map((d) => (
              <option key={d.id} value={d.id}>
                {d.date} · {d.title} · quedan {d.seatsLeft}
              </option>
            ))}
          </select>
        </label>
        <button className="fd-button fd-button-secundario" type="submit">
          Elegir
        </button>
      </form>
      {salida && !chosen ? <p className="fd-form-error">Esa salida no está en venta.</p> : null}
      {chosen ? (
        <ActionForm
          action={createManualBooking.bind(
            null,
            providerId,
            salida!,
            chosen.sheet.lodging?.rooms.map((r) => r.id) ?? [],
          )}
          submit="Registrar venta"
        >
          <label className="fd-field">
            <span>Embarque</span>
            <select name="boardingId">
              {chosen.sheet.transfer.boardingPoints.map((b) => (
                <option key={b.id} value={b.id}>
                  {b.name || b.city}
                </option>
              ))}
            </select>
          </label>
          <div className="fd-inline">
            {Object.entries(PASSENGER_TYPES).map(([k, label]) => (
              <label key={k} className="fd-field">
                <span>{label}</span>
                <input
                  type="number"
                  name={k}
                  min={0}
                  max={20}
                  defaultValue={k === 'adult' ? 1 : 0}
                />
              </label>
            ))}
          </div>
          {chosen.sheet.lodging && chosen.sheet.duration.nights > 0 ? (
            <div className="fd-inline">
              {chosen.sheet.lodging.rooms.map((r) => (
                <label key={r.id} className="fd-field">
                  <span>Habitaciones {ROOM_TYPES[r.type]}</span>
                  <input type="number" name={`room.${r.id}`} min={0} max={20} defaultValue={0} />
                </label>
              ))}
            </div>
          ) : null}
          <label className="fd-field">
            <span>Nombre del cliente</span>
            <input name="name" required minLength={2} />
          </label>
          <div className="fd-inline">
            <label className="fd-field">
              <span>Teléfono</span>
              <input name="phone" />
            </label>
            <label className="fd-field">
              <span>Correo</span>
              <input type="email" name="email" />
            </label>
          </div>
          <fieldset className="fd-field">
            <legend>Dinero recibido (opcional)</legend>
            <div className="fd-inline">
              <label className="fd-field">
                <span>Método</span>
                <select name="method" defaultValue="cash_usd">
                  {Object.entries(PAYMENT_METHODS).map(([k, v]) => (
                    <option key={k} value={k}>
                      {v}
                    </option>
                  ))}
                </select>
              </label>
              <label className="fd-field">
                <span>Monto USD</span>
                <input name="amountUsd" inputMode="decimal" />
              </label>
              <label className="fd-field">
                <span>Referencia</span>
                <input name="reference" />
              </label>
            </div>
          </fieldset>
        </ActionForm>
      ) : null}
    </section>
  );
}
