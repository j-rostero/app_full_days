import {
  inclusions,
  PRODUCT_STATUS_LABELS,
  PRODUCT_TYPE_LABELS,
  type ProductSheet,
} from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { curate, decideProduct } from '../actions';

const Reason = () => (
  <label className="fd-field">
    <span>Motivo (lo verá la agencia)</span>
    <textarea name="reason" required minLength={10} />
  </label>
);

export default async function ProductReview({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const [review, themes] = await Promise.all([
    read((api) => api.GET('/v1/central/productos/{id}', { params: { path: { id } } })),
    read((api) => api.GET('/v1/tematicas')),
  ]);
  const p = review.product;
  const sheet = p.sheet as ProductSheet;
  const groups = inclusions(sheet);
  return (
    <>
      <section className="tarjeta">
        <h2>
          {PRODUCT_TYPE_LABELS[p.type]}: {sheet.general.title || 'Sin título'}
        </h2>
        <p>
          <span className="fd-pill">{PRODUCT_STATUS_LABELS[p.status]}</span> · {review.providerName}{' '}
          · {review.providerHasRtn ? 'Con RTN' : 'Sin RTN'} · {p.completeness.percent} % completo
        </p>
        {review.contacts.length ? (
          <p className="fd-form-error">Contactos en los textos: {review.contacts.join(', ')}</p>
        ) : null}
        {p.statusReason ? <p className="suave">Último motivo: {p.statusReason}</p> : null}
        <div className="fotos">
          {p.photos.map((photo) => (
            <img key={photo.id} src={photo.urls.sm} alt="" />
          ))}
        </div>
        <p>
          <strong>{sheet.general.summary}</strong>
        </p>
        <p className="texto-largo">{sheet.general.description}</p>
        <h3>Itinerario</h3>
        <ol>
          {sheet.itinerary.map((step, i) => (
            <li key={i}>
              {sheet.duration.days > 1 ? `Día ${step.day} · ` : ''}
              {step.time ? `${step.time} · ` : ''}
              {step.title} {step.description ? `— ${step.description}` : ''}
            </li>
          ))}
        </ol>
        <div className="rejilla">
          {(
            [
              ['Incluye', groups.included],
              ['Opcional', groups.optional],
              ['Se paga en destino', groups.payAtDestination],
              ['No incluye', groups.notIncluded],
            ] as const
          ).map(([title, list]) => (
            <div key={title}>
              <h3>{title}</h3>
              <ul>
                {list.map((x) => (
                  <li key={x}>{x}</li>
                ))}
              </ul>
            </div>
          ))}
        </div>
        <p>
          Adulto: {sheet.pricing.fares.adult} USD · Abono:{' '}
          {sheet.pricing.deposit
            ? sheet.pricing.deposit.kind === 'percent'
              ? `${sheet.pricing.deposit.value} %`
              : `${sheet.pricing.deposit.value} USD`
            : '—'}
        </p>
      </section>
      <section className="tarjeta">
        <h2>Decisión</h2>
        {p.status === 'in_review' ? (
          <>
            <ActionForm
              action={decideProduct.bind(null, id, 'aprobar')}
              submit="Aprobar y publicar"
            />
            <ActionForm
              action={decideProduct.bind(null, id, 'devolver')}
              submit="Devolver a la agencia"
            >
              <Reason />
            </ActionForm>
          </>
        ) : null}
        {p.status === 'published' ? (
          <ActionForm
            action={decideProduct.bind(null, id, 'despublicar')}
            submit="Despublicar"
            confirm="Saldrá de la venta. ¿Seguir?"
          >
            <Reason />
          </ActionForm>
        ) : null}
      </section>
      <section className="tarjeta">
        <h2>Portada y temáticas</h2>
        <ActionForm action={curate.bind(null, id)} submit="Guardar portada">
          <label className="fd-check">
            <input type="checkbox" name="featured" defaultChecked={review.featured} /> Destacado en
            portada
          </label>
          <div className="fd-inline">
            {themes.items.map((t) => (
              <label key={t.id} className="fd-check">
                <input
                  type="checkbox"
                  name="themeIds"
                  value={t.id}
                  defaultChecked={review.themeIds.includes(t.id)}
                />{' '}
                {t.name}
              </label>
            ))}
          </div>
        </ActionForm>
      </section>
    </>
  );
}
