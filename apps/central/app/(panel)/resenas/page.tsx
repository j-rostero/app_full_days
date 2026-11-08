import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../lib/api';
import { hideReview, showReview } from '../posttrip-actions';

const stars = (n: number) => '★'.repeat(n) + '☆'.repeat(5 - n);

export default async function ModerationPage() {
  const { items } = await read((api) => api.GET('/v1/central/resenas'));
  return (
    <section className="tarjeta">
      <h2>Moderación de reseñas</h2>
      <p className="suave">
        Reseñas reportadas por una agencia o por la revisión automática (teléfonos, correos o
        WhatsApp), y las ocultas. Mostrar u ocultar cierra el reporte.
      </p>
      {items.length === 0 ? <p className="suave">No hay reseñas por revisar.</p> : null}
      {items.map((r) => (
        <article key={r.id} className="bloque">
          <p>
            <strong>{stars(r.rating)}</strong> · {r.title} · {r.moderation?.providerName} ·{' '}
            {r.author} ·{' '}
            <span className="fd-pill">
              {r.moderation?.status === 'hidden' ? 'Oculta' : 'Visible'}
            </span>
          </p>
          {r.comment ? <blockquote>{r.comment}</blockquote> : null}
          {r.moderation?.reported ? (
            <p className="fd-form-error">Reporte: {r.moderation.reportReason}</p>
          ) : null}
          {r.moderation?.hiddenReason ? (
            <p className="suave">Oculta por: {r.moderation.hiddenReason}</p>
          ) : null}
          <div className="fd-inline">
            <ActionForm action={showReview.bind(null, r.id)} submit="Mostrar" />
            <ActionForm action={hideReview.bind(null, r.id)} submit="Ocultar" className="fd-inline">
              <label className="fd-field">
                <span>Motivo</span>
                <input name="reason" required minLength={3} maxLength={500} />
              </label>
            </ActionForm>
          </div>
        </article>
      ))}
    </section>
  );
}
