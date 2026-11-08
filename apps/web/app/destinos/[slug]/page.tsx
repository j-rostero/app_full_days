import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { sessionApi } from '@fulldays/web-session';
import { Results } from '../../../components/results';
import { searchDepartures } from '../../../lib/search';

type Props = { params: Promise<{ slug: string }>; searchParams: Promise<{ pagina?: string }> };

async function destination(slug: string) {
  const { data } = await (await sessionApi()).GET('/v1/catalogos/destinos');
  for (const d of data?.items ?? []) {
    if (d.slug === slug) return d;
    const site = d.sites.find((s) => s.slug === slug);
    if (site) return site;
  }
  return null;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const d = await destination((await params).slug);
  return d
    ? {
        title: `Fulldays y tours a ${d.name}`,
        description: `Salidas a ${d.name}${d.state ? `, ${d.state}` : ''} con agencias revisadas.`,
      }
    : {};
}

export default async function DestinationPage({ params, searchParams }: Props) {
  const { slug } = await params;
  const d = await destination(slug);
  if (!d) notFound();
  const { pagina } = await searchParams;
  const result = await searchDepartures({ destino: slug, ...(pagina ? { pagina } : {}) });
  return (
    <main className="ancho">
      <h1>{d.name}</h1>
      <p className="suave">{[d.state, d.region].filter(Boolean).join(' · ')}</p>
      {d.fees.length ? (
        <p className="suave">
          Tasas que se pagan en el lugar:{' '}
          {d.fees.map((f) => `${f.name} (${f.amountUsd} USD)`).join(', ')}.
        </p>
      ) : null}
      <Results result={result} base={`/destinos/${slug}`} params={{}} />
    </main>
  );
}
