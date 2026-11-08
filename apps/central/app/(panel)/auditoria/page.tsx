import Link from 'next/link';
import { read } from '../../../lib/api';

const show = (value: unknown) =>
  value === null || value === undefined ? '' : JSON.stringify(value, null, 2);

export default async function Audit({
  searchParams,
}: {
  searchParams: Promise<{ desde?: string; agencia?: string }>;
}) {
  const { desde, agencia } = await searchParams;
  const page = await read((api) =>
    api.GET('/v1/central/auditoria', {
      params: {
        query: {
          limit: 50,
          ...(desde ? { cursor: desde } : {}),
          ...(agencia ? { providerId: agencia } : {}),
        },
      },
    }),
  );
  return (
    <section className="tarjeta">
      <h2>Auditoría</h2>
      <p className="suave">
        Cada cambio hecho por Central o por las agencias, del más reciente al más antiguo.
      </p>
      {page.items.length === 0 ? <p className="suave">Sin registros.</p> : null}
      {page.items.map((entry) => (
        <details key={entry.id} className="bloque">
          <summary>
            {new Date(entry.createdAt).toLocaleString('es-VE')} ·{' '}
            {entry.actor.name ?? entry.actor.email} · <code>{entry.action}</code>
            {entry.providerId ? (
              <>
                {' '}
                · <Link href={`/auditoria?agencia=${entry.providerId}`}>agencia</Link>
              </>
            ) : null}
          </summary>
          <div className="rejilla">
            {(
              [
                ['Datos enviados', entry.input],
                ['Antes', entry.before],
                ['Después', entry.after],
              ] as const
            ).map(([title, value]) => (
              <div key={title}>
                <h4>{title}</h4>
                <pre>{show(value)}</pre>
              </div>
            ))}
          </div>
        </details>
      ))}
      {page.nextCursor ? (
        <p>
          <Link href={`/auditoria?desde=${page.nextCursor}${agencia ? `&agencia=${agencia}` : ''}`}>
            Más antiguos
          </Link>
        </p>
      ) : null}
    </section>
  );
}
