import type { Metadata } from 'next';
import { Results } from '../../components/results';
import { SearchForm } from '../../components/search-form';
import { searchDepartures } from '../../lib/search';

type Params = Promise<Record<string, string | string[] | undefined>>;
const flat = (p: Record<string, string | string[] | undefined>) =>
  Object.fromEntries(
    Object.entries(p).flatMap(([k, v]) => (typeof v === 'string' && v ? [[k, v]] : [])),
  ) as Record<string, string>;

export async function generateMetadata({
  searchParams,
}: {
  searchParams: Params;
}): Promise<Metadata> {
  const { q } = flat(await searchParams);
  return { title: q ? `Viajes a ${q}` : 'Explorar viajes', alternates: { canonical: '/buscar' } };
}

export default async function SearchPage({ searchParams }: { searchParams: Params }) {
  const params = flat(await searchParams);
  const result = await searchDepartures(params);
  const { pagina: _p, ...keep } = params;
  return (
    <main className="ancho">
      <h1>Explorar</h1>
      <details className="filtros" open={Object.keys(keep).length > 0}>
        <summary>Filtros</summary>
        <SearchForm values={params} full />
      </details>
      <Results result={result} base="/buscar" params={keep} />
    </main>
  );
}
