import { read } from '../../../lib/api';

const ISO = /^\d{4}-\d{2}-\d{2}$/;

export default async function MetricsPage({
  searchParams,
}: {
  searchParams: Promise<{ desde?: string; hasta?: string }>;
}) {
  const sp = await searchParams;
  const query = {
    ...(sp.desde && ISO.test(sp.desde) ? { desde: sp.desde } : {}),
    ...(sp.hasta && ISO.test(sp.hasta) ? { hasta: sp.hasta } : {}),
  };
  const m = await read((api) => api.GET('/v1/central/metricas', { params: { query } }));
  const rows: [string, string][] = [
    ['Reservas creadas', String(m.bookings)],
    ['Reservas confirmadas', String(m.confirmed)],
    ['Ventas (GMV)', `${m.gmvUsd.toFixed(2)} USD`],
    ['Comisión FullDays', `${m.commissionUsd.toFixed(2)} USD`],
    ['Ocupación de salidas', m.occupancyPercent === null ? '—' : `${m.occupancyPercent} %`],
    ['Agencias con ventas', String(m.sellingProviders)],
    ['Búsquedas', String(m.searches)],
  ];
  return (
    <section className="tarjeta">
      <h2>Métricas</h2>
      <form className="fd-inline" method="get">
        <label className="fd-field">
          <span>Desde</span>
          <input type="date" name="desde" defaultValue={m.from} />
        </label>
        <label className="fd-field">
          <span>Hasta</span>
          <input type="date" name="hasta" defaultValue={m.to} />
        </label>
        <button className="fd-button fd-button-secundario" type="submit">
          Ver
        </button>
      </form>
      <table className="fd-table">
        <tbody>
          {rows.map(([k, v]) => (
            <tr key={k}>
              <td>{k}</td>
              <td>{v}</td>
            </tr>
          ))}
        </tbody>
      </table>
      <div className="rejilla">
        <div>
          <h3>Lo más buscado</h3>
          <ol>
            {m.topSearches.map((t) => (
              <li key={t.text}>
                {t.text} ({t.count})
              </li>
            ))}
          </ol>
        </div>
        <div>
          <h3>Búsquedas sin resultados</h3>
          {m.emptySearches.length === 0 ? <p className="suave">Ninguna.</p> : null}
          <ol>
            {m.emptySearches.map((t) => (
              <li key={t.text}>
                {t.text} ({t.count})
              </li>
            ))}
          </ol>
        </div>
      </div>
    </section>
  );
}
