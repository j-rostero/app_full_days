import { read } from '../../../lib/api';

export default async function SettlementsPage({
  searchParams,
}: {
  searchParams: Promise<{ mes?: string }>;
}) {
  const raw = (await searchParams).mes;
  const mes = raw && /^\d{4}-(0[1-9]|1[0-2])$/.test(raw) ? raw : undefined;
  const s = await read((api) =>
    api.GET('/v1/central/liquidaciones', { params: { query: mes ? { mes } : {} } }),
  );
  const money = (n: number) => n.toFixed(2);
  const total = s.items.reduce(
    (t, i) => ({
      paymentsUsd: t.paymentsUsd + i.paymentsUsd,
      refundsUsd: t.refundsUsd + i.refundsUsd,
      commissionUsd: t.commissionUsd + i.commissionUsd,
      netUsd: t.netUsd + i.netUsd,
    }),
    { paymentsUsd: 0, refundsUsd: 0, commissionUsd: 0, netUsd: 0 },
  );
  return (
    <section className="tarjeta">
      <h2>Liquidaciones de {s.month}</h2>
      <form className="fd-inline" method="get">
        <label className="fd-field">
          <span>Mes</span>
          <input type="month" name="mes" defaultValue={s.month} />
        </label>
        <button className="fd-button fd-button-secundario" type="submit">
          Ver
        </button>
      </form>
      {s.items.length === 0 ? (
        <p className="suave">Sin movimientos este mes.</p>
      ) : (
        <table className="fd-table">
          <thead>
            <tr>
              <th>Agencia</th>
              <th>Cobrado</th>
              <th>Devuelto</th>
              <th>Comisión</th>
              <th>Neto agencia</th>
            </tr>
          </thead>
          <tbody>
            {s.items.map((i) => (
              <tr key={i.providerId}>
                <td>{i.providerName}</td>
                <td>{money(i.paymentsUsd)}</td>
                <td>{money(i.refundsUsd)}</td>
                <td>{money(i.commissionUsd)}</td>
                <td>{money(i.netUsd)}</td>
              </tr>
            ))}
            <tr>
              <th>Total USD</th>
              <th>{money(total.paymentsUsd)}</th>
              <th>{money(total.refundsUsd)}</th>
              <th>{money(total.commissionUsd)}</th>
              <th>{money(total.netUsd)}</th>
            </tr>
          </tbody>
        </table>
      )}
    </section>
  );
}
