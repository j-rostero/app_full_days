import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { replyReview, reportReview } from '../posttrip-actions';

const stars = (n: number) => '★'.repeat(n) + '☆'.repeat(5 - n);

export default async function ReviewsPage({ params }: { params: Promise<{ providerId: string }> }) {
  const { providerId } = await params;
  const { reputation, items } = await read((api) =>
    api.GET('/v1/pro/{providerId}/resenas', { params: { path: { providerId } } }),
  );
  return (
    <section className="tarjeta">
      <h2>Reseñas</h2>
      <p className="suave">
        {reputation.count
          ? `${reputation.average?.toFixed(1)} ★ en ${reputation.count} reseñas visibles.`
          : 'Todavía no hay reseñas visibles.'}{' '}
        Puedes responder una vez a cada reseña, en público y sin datos de contacto. Si una reseña no
        corresponde, pide a FullDays que la revise.
      </p>
      {items.map((r) => (
        <article key={r.id} className="bloque">
          <p>
            <strong>{stars(r.rating)}</strong> · {r.title} · {r.author} · viaje del {r.tripDate}
            {r.moderation?.status === 'hidden' ? (
              <span className="fd-pill">
                Oculta{r.moderation.hiddenReason ? `: ${r.moderation.hiddenReason}` : ''}
              </span>
            ) : null}
            {r.moderation?.reported ? <span className="fd-pill">En revisión</span> : null}
          </p>
          {r.comment ? <p>{r.comment}</p> : null}
          {r.reply ? (
            <p className="suave">Tu respuesta: {r.reply}</p>
          ) : (
            <ActionForm action={replyReview.bind(null, providerId, r.id)} submit="Responder">
              <label className="fd-field">
                <span>Respuesta pública</span>
                <textarea name="reply" required minLength={2} maxLength={1500} rows={2} />
              </label>
            </ActionForm>
          )}
          {!r.moderation?.reported ? (
            <details>
              <summary>Pedir revisión</summary>
              <ActionForm
                action={reportReview.bind(null, providerId, r.id)}
                submit="Enviar a FullDays"
                className="fd-inline"
              >
                <label className="fd-field">
                  <span>Motivo</span>
                  <input name="reason" required minLength={3} maxLength={500} />
                </label>
              </ActionForm>
            </details>
          ) : null}
        </article>
      ))}
    </section>
  );
}
