import { todayInVenezuela } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../lib/api';
import { setRate } from './actions';

const bs = new Intl.NumberFormat('es-VE', { minimumFractionDigits: 2, maximumFractionDigits: 4 });

export default async function Rates() {
  const [current, history] = await Promise.all([
    read((api) => api.GET('/v1/tasa')),
    read((api) => api.GET('/v1/central/tasas')),
  ]);
  return (
    <>
      <section className="tarjeta">
        <h2>Tasa del día</h2>
        <p>
          Vigente: <strong>{bs.format(current.bsPerUsd)} Bs por dólar</strong> desde el{' '}
          {current.date}.
        </p>
        <p className="suave">
          Los precios se fijan en dólares; la tasa solo sirve para mostrar el equivalente en
          bolívares y cobrar pagos en bolívares.
        </p>
        <ActionForm action={setRate} submit="Guardar tasa" className="fd-inline">
          <label className="fd-field">
            <span>Fecha</span>
            <input type="date" name="date" defaultValue={todayInVenezuela()} required />
          </label>
          <label className="fd-field">
            <span>Bs por dólar</span>
            <input name="bsPerUsd" inputMode="decimal" required />
          </label>
        </ActionForm>
      </section>
      <section className="tarjeta">
        <h2>Historial</h2>
        <table className="fd-table">
          <tbody>
            {history.items.map((r) => (
              <tr key={r.date}>
                <td>{r.date}</td>
                <td>{bs.format(r.bsPerUsd)} Bs</td>
              </tr>
            ))}
          </tbody>
        </table>
      </section>
    </>
  );
}
