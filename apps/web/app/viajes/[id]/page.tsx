import type { Metadata } from 'next';
import Link from 'next/link';
import { notFound } from 'next/navigation';
import {
  CANCELLATION_TEMPLATES,
  LODGING_REGIMES,
  PASSENGER_TYPES,
  PRODUCT_TYPE_LABELS,
  VEHICLES,
} from '@fulldays/shared';
import { getMe, sessionApi } from '@fulldays/web-session';
import { longDate, SITE_URL, usd } from '../../../lib/format';
import { toggleFavorite } from './actions';

type Props = { params: Promise<{ id: string }>; searchParams: Promise<{ salida?: string }> };

async function load(id: string) {
  const { data } = await (
    await sessionApi()
  ).GET('/v1/productos/{id}', { params: { path: { id } } });
  return data ?? null;
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const p = await load((await params).id);
  if (!p) return {};
  const g = p.sheet.general;
  return {
    title: g.title,
    description: g.summary,
    alternates: { canonical: `/viajes/${p.id}` },
    openGraph: {
      title: g.title,
      description: g.summary,
      images: p.photos[0] ? [p.photos[0].urls.lg] : [],
    },
  };
}

export default async function ProductPage({ params, searchParams }: Props) {
  const { id } = await params;
  const [p, me] = await Promise.all([load(id), getMe()]);
  if (!p) notFound();
  const { salida } = await searchParams;
  const saved = me
    ? ((await (await sessionApi()).GET('/v1/yo/favoritos')).data?.items ?? []).some(
        (f) => f.id === p.id,
      )
    : false;
  const s = p.sheet;
  const g = s.general;
  const many = s.duration.days > 1;
  const nextOpen = p.departures.find((d) => d.status === 'open' && d.seatsLeft > 0);
  const jsonLd = {
    '@context': 'https://schema.org',
    '@type': 'TouristTrip',
    name: g.title,
    description: g.summary,
    image: p.photos.map((ph) => ph.urls.lg),
    url: `${SITE_URL}/viajes/${p.id}`,
    provider: { '@type': 'TravelAgency', name: p.provider.name },
    offers: p.departures.map((d) => ({
      '@type': 'Offer',
      price: d.priceUsd,
      priceCurrency: 'USD',
      availability:
        d.status === 'open' && d.seatsLeft > 0
          ? 'https://schema.org/InStock'
          : 'https://schema.org/SoldOut',
      validFrom: d.date,
      url: `${SITE_URL}/reservar/${d.id}`,
    })),
  };
  return (
    <main className="ancho ficha">
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd).replace(/</g, '\\u003c') }}
      />
      <p className="etiquetas">
        <span>{PRODUCT_TYPE_LABELS[p.type]}</span>
        {p.destination ? (
          <Link href={`/destinos/${p.destination.slug}`}>{p.destination.name}</Link>
        ) : null}
        {p.themes.map((t) => (
          <Link key={t.slug} href={`/tematicas/${t.slug}`}>
            {t.name}
          </Link>
        ))}
      </p>
      <div className="barra">
        <h1>{g.title}</h1>
        <form action={toggleFavorite.bind(null, p.id, saved)}>
          <button type="submit" className="fd-button fd-button-secundario">
            {saved ? '★ Guardado' : '☆ Guardar'}
          </button>
        </form>
      </div>
      <p>
        Organiza <Link href={`/agencias/${p.provider.id}`}>{p.provider.name}</Link>
        {p.provider.badge === 'verified'
          ? ' · Agencia verificada (RTN)'
          : ' · Agencia revisada por FullDays'}
      </p>
      <div className="galeria">
        {p.photos.map((ph, i) => (
          <img
            key={ph.id}
            src={i === 0 ? ph.urls.lg : ph.urls.md}
            alt=""
            loading={i < 2 ? 'eager' : 'lazy'}
          />
        ))}
      </div>
      <div className="ficha-columnas">
        <div>
          <p className="resumen">{g.summary}</p>
          <p className="texto-largo">{g.description}</p>
          <h2>Itinerario</h2>
          <ol className="itinerario">
            {s.itinerary.map((step, i) => (
              <li key={i}>
                <strong>
                  {many ? `Día ${step.day} · ` : ''}
                  {step.time ? `${step.time} · ` : ''}
                  {step.title}
                </strong>
                {step.description ? <p>{step.description}</p> : null}
              </li>
            ))}
          </ol>
          <div className="rejilla">
            {(
              [
                ['Incluye', p.inclusions.included],
                ['Opcional', p.inclusions.optional],
                ['Se paga en el destino', p.inclusions.payAtDestination],
                ['No incluye', p.inclusions.notIncluded],
              ] as const
            ).map(([title, list]) =>
              list.length ? (
                <section key={title}>
                  <h3>{title}</h3>
                  <ul>
                    {list.map((x) => (
                      <li key={x}>{x}</li>
                    ))}
                  </ul>
                </section>
              ) : null,
            )}
          </div>
          {p.cashAtDestination.totalUsd > 0 ? (
            <p className="aviso">
              Lleva {usd(p.cashAtDestination.totalUsd)} en efectivo para pagar en el destino.
            </p>
          ) : null}
          <h2>Traslado y embarque</h2>
          <p>
            {s.transfer.vehicle ? VEHICLES[s.transfer.vehicle] : 'Por cuenta propia'}
            {s.transfer.notes ? ` · ${s.transfer.notes}` : ''}
          </p>
          <ul>
            {s.transfer.boardingPoints.map((b) => (
              <li key={b.id}>
                <strong>{b.name || b.city}</strong> {b.address ? `· ${b.address}` : ''}{' '}
                {b.departureTime ? `· sale ${b.departureTime}` : ''}
                {b.returnTime ? ` · regresa ${b.returnTime}` : ''}{' '}
                {b.priceDeltaUsd
                  ? `· ${b.priceDeltaUsd > 0 ? '+' : ''}${usd(b.priceDeltaUsd)}`
                  : ''}
              </li>
            ))}
          </ul>
          {s.lodging && s.duration.nights > 0 ? (
            <>
              <h2>Alojamiento</h2>
              <p>
                {s.lodging.name}
                {s.lodging.regime ? ` · ${LODGING_REGIMES[s.lodging.regime]}` : ''} ·{' '}
                {s.duration.nights} noches
              </p>
            </>
          ) : null}
          {s.whatToBring.length ? (
            <>
              <h2>Qué llevar</h2>
              <ul>
                {s.whatToBring.map((x) => (
                  <li key={x}>{x}</li>
                ))}
              </ul>
            </>
          ) : null}
          <h2>Cancelación</h2>
          <p>
            {s.pricing.cancellation.template
              ? CANCELLATION_TEMPLATES[s.pricing.cancellation.template]
              : 'Se acuerda con la agencia.'}
          </p>
          {s.pricing.cancellation.text ? (
            <p className="suave">{s.pricing.cancellation.text}</p>
          ) : null}
        </div>
        <aside className="tarjeta reservar">
          <h2>Fechas</h2>
          <p className="suave">
            {Object.entries(s.pricing.fares)
              .filter(([, v]) => v !== null)
              .map(
                ([k, v]) =>
                  `${PASSENGER_TYPES[k as keyof typeof PASSENGER_TYPES]}: ${usd(v as number)}`,
              )
              .join(' · ')}
          </p>
          {s.pricing.deposit ? (
            <p className="suave">
              Reservas con{' '}
              {s.pricing.deposit.kind === 'percent'
                ? `${s.pricing.deposit.value} %`
                : `${usd(s.pricing.deposit.value)} por puesto`}{' '}
              de abono.
            </p>
          ) : null}
          {p.departures.length === 0 ? <p>No hay fechas en venta por ahora.</p> : null}
          <ul className="fechas">
            {p.departures.map((d) => {
              const open = d.status === 'open' && d.seatsLeft > 0;
              return (
                <li
                  key={d.id}
                  className={d.id === (salida ?? nextOpen?.id) ? 'elegida' : undefined}
                >
                  <span>
                    <strong>{longDate(d.date)}</strong>
                    <br />
                    <span className="suave">
                      {usd(d.priceUsd)} · {open ? `${d.seatsLeft} puestos` : 'Agotado'}
                    </span>
                  </span>
                  {open ? (
                    <Link className="fd-button" href={`/reservar/${d.id}`}>
                      Reservar
                    </Link>
                  ) : null}
                </li>
              );
            })}
          </ul>
        </aside>
      </div>
    </main>
  );
}
