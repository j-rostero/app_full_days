import Link from 'next/link';
import { requireMe, sessionApi } from '@fulldays/web-session';
import { ProductCard } from '../../components/departure-card';

export const metadata = { title: 'Guardados', robots: { index: false } };

export default async function Favorites() {
  await requireMe('/favoritos');
  const { data } = await (await sessionApi()).GET('/v1/yo/favoritos');
  const items = data?.items ?? [];
  return (
    <main className="ancho">
      <h1>Guardados</h1>
      {items.length === 0 ? (
        <p>
          Guarda viajes con la estrella para verlos aquí. <Link href="/buscar">Explorar</Link>
        </p>
      ) : null}
      <div className="rejilla-viajes">
        {items.map((card) => (
          <ProductCard key={card.id} card={card} />
        ))}
      </div>
    </main>
  );
}
