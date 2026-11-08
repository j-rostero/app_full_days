import Link from 'next/link';
import { PRODUCT_STATUS_LABELS, PRODUCT_TYPE_LABELS, type ProductStatus } from '@fulldays/shared';
import { read } from '../../../lib/api';

export default async function ProductQueue({
  searchParams,
}: {
  searchParams: Promise<{ estado?: string }>;
}) {
  const status = ((await searchParams).estado ?? 'in_review') as ProductStatus;
  const { items } = await read((api) =>
    api.GET('/v1/central/productos', { params: { query: { status } } }),
  );
  return (
    <section className="tarjeta">
      <h2>Productos</h2>
      <nav className="fd-links">
        {Object.entries(PRODUCT_STATUS_LABELS).map(([key, label]) => (
          <Link
            key={key}
            href={`/productos?estado=${key}`}
            aria-current={key === status ? 'page' : undefined}
          >
            {label}
          </Link>
        ))}
      </nav>
      {items.length === 0 ? (
        <p className="suave">Nada en «{PRODUCT_STATUS_LABELS[status]}».</p>
      ) : null}
      <table className="fd-table">
        <tbody>
          {items.map((p) => (
            <tr key={p.id}>
              <td>
                <Link href={`/productos/${p.id}`}>{p.title}</Link>
              </td>
              <td>{PRODUCT_TYPE_LABELS[p.type]}</td>
              <td>{p.providerName}</td>
              <td>{new Date(p.statusAt).toLocaleString('es-VE')}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </section>
  );
}
