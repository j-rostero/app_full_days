import { read } from '../../../../lib/api';

export default async function SettlementPage({
  params,
  searchParams,
}: {
  params: Promise<{ providerId: string }>;
  searchParams: Promise<{ mes?: string }>;
}) {
  const { providerId } = await params;
  const raw = (await searchParams).mes;
  const mes = raw && /^\d{4}-(0[1-9]|1[0-2])$/.test(raw) ? raw : undefined;
  const s = await read((api) =>
    api.GET('/v1/pro/{providerId}/liquidaciones', {
      params: { path: { providerId }, query: mes ? { mes } : {} },
    }),
  );
  const money = (n: number) => `${n.toFixed(2)} USD`;
  return (
    <section className="tarjeta">
      <h2>Liquidación de {s.month}</h2>
      <form className="fd-inline" method="get">
        <label className="fd-field">
          <span>Mes</span>
          <input type="month" name="mes" defaultValue={s.month} />
        </label>
        <button className="fd-button fd-button-secundario" type="submit">
          Ver
        </button>
        <a
          className="fd-link"
          href={`/agencia/${providerId}/liquidaciones/liquidacion.csv?mes=${s.month}`}
        >
          Descargar CSV
        </a>
      </form>
      <table className="fd-table">
        <tbody>
          <tr>
            <td>Cobrado</td>
            <td>{money(s.paymentsUsd)}</td>
          </tr>
          <tr>
            <td>Devuelto</td>
            <td>{money(s.refundsUsd)}</td>
          </tr>
          <tr>
            <td>Comisión FullDays</td>
            <td>{money(s.commissionUsd)}</td>
          </tr>
          <tr>
            <th>Neto</th>
            <th>{money(s.netUsd)}</th>
          </tr>
        </tbody>
      </table>
      <h3>Movimientos</h3>
      {s.lines.length === 0 ? <p className="suave">Sin movimientos este mes.</p> : null}
      {s.lines.length ? (
        <table className="fd-table">
          <thead>
            <tr>
              <th>Fecha</th>
              <th>Movimiento</th>
              <th>Reserva</th>
              <th>Monto</th>
              <th>Comisión</th>
            </tr>
          </thead>
          <tbody>
            {s.lines.map((l, i) => (
              <tr key={i}>
                <td>{new Date(l.at).toLocaleDateString('es-VE')}</td>
                <td>{l.kind === 'payment' ? 'Pago' : 'Reembolso'}</td>
                <td>{l.bookingCode ?? '—'}</td>
                <td>{money(l.amountUsd)}</td>
                <td>{money(l.commissionUsd)}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : null}
    </section>
  );
}
