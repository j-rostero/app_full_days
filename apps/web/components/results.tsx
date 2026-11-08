import Link from 'next/link';
import type { Schemas } from '../lib/api';
import { DepartureCard } from './departure-card';

/** Resultados con paginación que conserva los filtros. */
export function Results({
  result,
  base,
  params,
}: {
  result: Schemas['SearchResult'];
  base: string;
  params: Record<string, string>;
}) {
  const page = (n: number) => `${base}?${new URLSearchParams({ ...params, pagina: String(n) })}`;
  return (
    <>
      {result.items.length === 0 ? (
        <p className="suave">No encontramos salidas con esos filtros. Prueba con menos.</p>
      ) : null}
      <div className="rejilla-viajes">
        {result.items.map((card) => (
          <DepartureCard key={card.departureId} card={card} />
        ))}
      </div>
      <p className="paginas">
        {result.page > 1 ? <Link href={page(result.page - 1)}>Anteriores</Link> : null}
        {result.hasMore ? <Link href={page(result.page + 1)}>Siguientes</Link> : null}
      </p>
    </>
  );
}
