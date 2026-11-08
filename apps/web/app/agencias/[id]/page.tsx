import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { sessionApi } from '@fulldays/web-session';
import { ProductCard } from '../../../components/departure-card';
import { Reviews } from '../../../components/reviews';

type Props = { params: Promise<{ id: string }> };

async function load(id: string) {
  const { data } = await (
    await sessionApi()
  ).GET('/v1/agencias/{id}', { params: { path: { id } } });
  return data ?? null;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const a = await load((await params).id);
  return a
    ? {
        title: a.provider.name,
        description: `Viajes de ${a.provider.name}, desde ${a.provider.baseCity}.`,
      }
    : {};
}

export default async function AgencyPage({ params }: Props) {
  const { id } = await params;
  const [agency, reviews] = await Promise.all([
    load(id),
    sessionApi().then((api) =>
      api.GET('/v1/agencias/{id}/reputacion', { params: { path: { id } } }).then((r) => r.data),
    ),
  ]);
  if (!agency) notFound();
  const p = agency.provider;
  return (
    <main className="ancho">
      <h1>{p.name}</h1>
      <p className="suave">
        {p.badge === 'verified'
          ? 'Agencia verificada (RTN) · '
          : 'Agencia revisada por FullDays · '}
        {p.baseCity}
        {p.instagram ? ` · @${p.instagram}` : ''}
      </p>
      <div className="rejilla-viajes">
        {agency.products.map((card) => (
          <ProductCard key={card.id} card={card} />
        ))}
      </div>
      {reviews ? <Reviews list={reviews} /> : null}
    </main>
  );
}
