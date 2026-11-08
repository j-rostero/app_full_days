import Link from 'next/link';
import { PRODUCT_TYPE_LABELS } from '@fulldays/shared';
import type { Schemas } from '../lib/api';
import { shortDate, usd } from '../lib/format';

export function DepartureCard({ card }: { card: Schemas['DepartureCard'] }) {
  return (
    <article className="tarjeta-viaje">
      <Link href={`/viajes/${card.productId}?salida=${card.departureId}`}>
        {card.cover ? (
          <img src={card.cover.md} alt="" loading="lazy" />
        ) : (
          <div className="foto-vacia" />
        )}
        <div className="tarjeta-viaje-cuerpo">
          <p className="etiquetas">
            <span>{PRODUCT_TYPE_LABELS[card.type]}</span>
            {card.featured ? <span className="destacado">Destacado</span> : null}
            {card.provider.badge === 'verified' ? (
              <span className="verificada">Agencia verificada</span>
            ) : null}
          </p>
          <h3>{card.title}</h3>
          <p className="suave">
            {shortDate(card.date)} · {card.destination ?? card.cities.join(', ')} ·{' '}
            {card.provider.name}
          </p>
          <p className="precio">
            Desde <strong>{usd(card.priceUsd)}</strong>
            <span className={card.seatsLeft <= 5 ? 'pocos' : 'suave'}>
              {card.status === 'closed' || card.seatsLeft === 0
                ? 'Agotado'
                : `${card.seatsLeft} puestos`}
            </span>
          </p>
        </div>
      </Link>
    </article>
  );
}

export function ProductCard({ card }: { card: Schemas['PublicProductCard'] }) {
  return (
    <article className="tarjeta-viaje">
      <Link href={`/viajes/${card.id}`}>
        {card.cover ? (
          <img src={card.cover.md} alt="" loading="lazy" />
        ) : (
          <div className="foto-vacia" />
        )}
        <div className="tarjeta-viaje-cuerpo">
          <p className="etiquetas">
            <span>{PRODUCT_TYPE_LABELS[card.type]}</span>
          </p>
          <h3>{card.title}</h3>
          <p className="suave">
            {card.nextDate ? `Próxima salida: ${shortDate(card.nextDate)}` : 'Sin fechas por ahora'}
          </p>
          <p className="precio">
            Desde <strong>{usd(card.priceUsd)}</strong>
          </p>
        </div>
      </Link>
    </article>
  );
}
