import Link from 'next/link';
import { PROVIDER_STATUS_LABELS, type ProviderStatus } from '@fulldays/shared';
import { read } from '../../../lib/api';

export default async function ProvidersQueue({
  searchParams,
}: {
  searchParams: Promise<{ estado?: string }>;
}) {
  const status = ((await searchParams).estado ?? 'in_review') as ProviderStatus;
  const { items } = await read((api) =>
    api.GET('/v1/central/proveedores', { params: { query: { status } } }),
  );
  return (
    <section className="tarjeta">
      <h2>Agencias</h2>
      <nav className="fd-links">
        {Object.entries(PROVIDER_STATUS_LABELS).map(([key, label]) => (
          <Link
            key={key}
            href={`/agencias?estado=${key}`}
            aria-current={key === status ? 'page' : undefined}
          >
            {label}
          </Link>
        ))}
      </nav>
      {items.length === 0 ? (
        <p className="suave">No hay agencias en «{PROVIDER_STATUS_LABELS[status]}».</p>
      ) : null}
      <table className="fd-table">
        <tbody>
          {items.map((p) => (
            <tr key={p.id}>
              <td>
                <Link href={`/agencias/${p.id}`}>{p.name}</Link>
              </td>
              <td>{p.rif}</td>
              <td>{p.baseCity}</td>
              <td>{p.hasRtn ? 'Con RTN' : 'Sin RTN'}</td>
              <td>{p.submittedAt ? new Date(p.submittedAt).toLocaleString('es-VE') : '—'}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </section>
  );
}
