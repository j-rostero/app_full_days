import { REVIEW_ASPECTS } from '@fulldays/shared';
import { read } from '../../../../lib/api';

export default async function ReportsPage({
  params,
  searchParams,
}: {
  params: Promise<{ providerId: string }>;
  searchParams: Promise<{ mes?: string }>;
}) {
  const { providerId } = await params;
  const raw = (await searchParams).mes;
  const mes = raw && /^\d{4}-(0[1-9]|1[0-2])$/.test(raw) ? raw : undefined;
  const r = await read((api) =>
    api.GET('/v1/pro/{providerId}/reportes', {
      params: { path: { providerId }, query: mes ? { mes } : {} },
    }),
  );
  const rep = r.reputation;
  return (
    <section className="tarjeta">
      <h2>Reporte de {r.month}</h2>
      <form className="fd-inline" method="get">
        <label className="fd-field">
          <span>Mes</span>
          <input type="month" name="mes" defaultValue={r.month} />
        </label>
        <button className="fd-button fd-button-secundario" type="submit">
          Ver
        </button>
      </form>
      <table className="fd-table">
        <tbody>
          <tr>
            <td>Ventas confirmadas</td>
            <td>{r.salesUsd.toFixed(2)} USD</td>
          </tr>
          <tr>
            <td>Reservas confirmadas</td>
            <td>{r.confirmedBookings}</td>
          </tr>
          <tr>
            <td>Cancelaciones</td>
            <td>{r.cancellations}</td>
          </tr>
          <tr>
            <td>Ocupación de las salidas del mes</td>
            <td>{r.occupancyPercent === null ? '—' : `${r.occupancyPercent} %`}</td>
          </tr>
        </tbody>
      </table>
      <h3>Reputación</h3>
      {rep.count === 0 ? (
        <p className="suave">Todavía no hay reseñas visibles.</p>
      ) : (
        <p>
          <strong>{rep.average?.toFixed(1)} ★</strong> en {rep.count} reseñas
          {rep.asDescribedPercent !== null
            ? ` · ${rep.asDescribedPercent} % dice que fue como se describió`
            : ''}
          <br />
          {Object.entries(REVIEW_ASPECTS)
            .map(([k, label]) => {
              const v = rep.aspects[k as keyof typeof rep.aspects];
              return v ? `${label} ${v.toFixed(1)}` : null;
            })
            .filter(Boolean)
            .join(' · ')}
        </p>
      )}
    </section>
  );
}
