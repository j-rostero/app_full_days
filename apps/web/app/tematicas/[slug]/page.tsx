import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { sessionApi } from '@fulldays/web-session';
import { Results } from '../../../components/results';
import { searchDepartures } from '../../../lib/search';

type Props = { params: Promise<{ slug: string }>; searchParams: Promise<{ pagina?: string }> };

async function theme(slug: string) {
  const { data } = await (await sessionApi()).GET('/v1/tematicas');
  return data?.items.find((t) => t.slug === slug) ?? null;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const t = await theme((await params).slug);
  return t ? { title: t.name, description: t.description || undefined } : {};
}

export default async function ThemePage({ params, searchParams }: Props) {
  const { slug } = await params;
  const t = await theme(slug);
  if (!t) notFound();
  const { pagina } = await searchParams;
  const result = await searchDepartures({ tematica: slug, ...(pagina ? { pagina } : {}) });
  return (
    <main className="ancho">
      <h1>{t.name}</h1>
      {t.description ? <p className="suave">{t.description}</p> : null}
      <Results result={result} base={`/tematicas/${slug}`} params={{}} />
    </main>
  );
}
