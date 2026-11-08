import Link from 'next/link';
import { sessionApi } from '@fulldays/web-session';
import { DepartureCard } from '../components/departure-card';
import { SearchForm } from '../components/search-form';
import { searchDepartures } from '../lib/search';

export const dynamic = 'force-dynamic';

export default async function Home() {
  const api = await sessionApi();
  const [next, themes, destinations] = await Promise.all([
    searchDepartures({ orden: 'recomendados' }),
    api.GET('/v1/tematicas').then((r) => r.data?.items ?? []),
    api.GET('/v1/catalogos/destinos').then((r) => r.data?.items ?? []),
  ]);
  return (
    <main className="ancho">
      <section className="portada">
        <h1>Tu próximo fullday empieza aquí</h1>
        <p>
          Fulldays, tours y excursiones de agencias revisadas por nuestro equipo, con precios claros
          y cupos en tiempo real.
        </p>
        <SearchForm />
      </section>
      {themes.length ? (
        <section>
          <h2>Por temática</h2>
          <p className="chips">
            {themes.map((t) => (
              <Link key={t.id} href={`/tematicas/${t.slug}`} className="chip">
                {t.name}
              </Link>
            ))}
          </p>
        </section>
      ) : null}
      <section>
        <h2>Próximas salidas</h2>
        {next.items.length === 0 ? <p className="suave">Pronto habrá salidas publicadas.</p> : null}
        <div className="rejilla-viajes">
          {next.items.slice(0, 12).map((card) => (
            <DepartureCard key={card.departureId} card={card} />
          ))}
        </div>
        {next.items.length > 12 ? (
          <p>
            <Link href="/buscar">Ver todas</Link>
          </p>
        ) : null}
      </section>
      {destinations.length ? (
        <section>
          <h2>Destinos</h2>
          <p className="chips">
            {destinations.map((d) => (
              <Link key={d.id} href={`/destinos/${d.slug}`} className="chip">
                {d.name}
              </Link>
            ))}
          </p>
        </section>
      ) : null}
    </main>
  );
}
