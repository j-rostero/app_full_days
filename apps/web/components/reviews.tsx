import { REVIEW_ASPECTS } from '@fulldays/shared';
import type { Schemas } from '../lib/api';

const stars = (n: number) => '★'.repeat(n) + '☆'.repeat(5 - n);

/** Reputación y reseñas visibles de un viaje o una agencia. */
export function Reviews({ list }: { list: Schemas['ReviewList'] }) {
  const rep = list.reputation;
  const aspects = Object.entries(REVIEW_ASPECTS)
    .map(([k, label]) => {
      const v = rep.aspects[k as keyof typeof rep.aspects];
      return v ? `${label} ${v.toFixed(1)}` : null;
    })
    .filter(Boolean);
  return (
    <section className="resenas" aria-label="Reseñas">
      <h2>Reseñas</h2>
      {rep.count === 0 ? (
        <p className="suave">Todavía no hay reseñas de viajeros.</p>
      ) : (
        <p>
          <strong className="cifra">{rep.average?.toFixed(1)} ★</strong> · {rep.count}{' '}
          {rep.count === 1 ? 'reseña' : 'reseñas'}
          {rep.asDescribedPercent !== null
            ? ` · ${rep.asDescribedPercent} % dice que fue como se describió`
            : ''}
          {aspects.length ? (
            <>
              <br />
              <span className="suave">{aspects.join(' · ')}</span>
            </>
          ) : null}
        </p>
      )}
      {list.items.slice(0, 20).map((r) => (
        <article key={r.id} className="resena">
          <p>
            <span aria-label={`${r.rating} de 5`}>{stars(r.rating)}</span> · {r.author} · viajó el{' '}
            {r.tripDate}
          </p>
          {r.comment ? <p>{r.comment}</p> : null}
          {r.reply ? <p className="suave">Respuesta de la agencia: {r.reply}</p> : null}
        </article>
      ))}
    </section>
  );
}
