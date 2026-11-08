import Link from 'next/link';
import { PRODUCT_STATUS_LABELS, PRODUCT_TYPE_HINTS, PRODUCT_TYPE_LABELS } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { createProduct } from './actions';

export default async function ProductsPage({
  params,
}: {
  params: Promise<{ providerId: string }>;
}) {
  const { providerId } = await params;
  const { items } = await read((api) =>
    api.GET('/v1/pro/{providerId}/productos', { params: { path: { providerId } } }),
  );
  return (
    <>
      <section className="tarjeta">
        <h2>Nuevo producto</h2>
        <ActionForm
          action={createProduct.bind(null, providerId)}
          submit="Crear borrador"
          className="fd-inline"
        >
          <label className="fd-field">
            <span>Tipo</span>
            <select name="type" defaultValue="fullday">
              {Object.entries(PRODUCT_TYPE_LABELS).map(([value, label]) => (
                <option key={value} value={value}>
                  {label}: {PRODUCT_TYPE_HINTS[value as keyof typeof PRODUCT_TYPE_HINTS]}
                </option>
              ))}
            </select>
          </label>
        </ActionForm>
      </section>
      <section className="tarjeta">
        <h2>Tus productos</h2>
        {items.length === 0 ? <p className="suave">Todavía no hay productos.</p> : null}
        <table className="fd-table">
          <thead>
            <tr>
              <th>Producto</th>
              <th>Tipo</th>
              <th>Estado</th>
              <th>Completo</th>
            </tr>
          </thead>
          <tbody>
            {items.map((p) => (
              <tr key={p.id}>
                <td>
                  <Link href={`/agencia/${providerId}/productos/${p.id}`}>{p.title}</Link>
                  {p.statusReason ? <div className="suave">Central: {p.statusReason}</div> : null}
                </td>
                <td>{PRODUCT_TYPE_LABELS[p.type]}</td>
                <td>
                  <span className="fd-pill">{PRODUCT_STATUS_LABELS[p.status]}</span>
                </td>
                <td>{p.percent} %</td>
              </tr>
            ))}
          </tbody>
        </table>
      </section>
    </>
  );
}
