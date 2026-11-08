import {
  PROVIDER_DOCUMENT_LABELS,
  PROVIDER_KIND_LABELS,
  PROVIDER_STATUS_LABELS,
} from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { decideProvider, setCommission } from '../actions';

const Reason = () => (
  <label className="fd-field">
    <span>Motivo (lo verá la agencia)</span>
    <textarea name="reason" required minLength={10} />
  </label>
);

export default async function ProviderReview({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const {
    company: c,
    documents,
    owners,
  } = await read((api) => api.GET('/v1/central/proveedores/{id}', { params: { path: { id } } }));
  return (
    <>
      <section className="tarjeta">
        <h2>{c.name}</h2>
        <p>
          <span className="fd-pill">{PROVIDER_STATUS_LABELS[c.status]}</span>{' '}
          {c.statusReason ? `· ${c.statusReason}` : ''}
        </p>
        <dl className="datos">
          <dt>Tipo</dt>
          <dd>{PROVIDER_KIND_LABELS[c.kind]}</dd>
          <dt>Razón social</dt>
          <dd>{c.legalName}</dd>
          <dt>RIF</dt>
          <dd>{c.rif}</dd>
          <dt>RTN</dt>
          <dd>{c.rtn ?? 'No tiene'}</dd>
          <dt>Ciudad</dt>
          <dd>{c.baseCity}</dd>
          <dt>Teléfono</dt>
          <dd>{c.phone}</dd>
          <dt>Instagram</dt>
          <dd>{c.instagram ?? '—'}</dd>
          <dt>Dueños</dt>
          <dd>{owners.map((o) => o.email).join(', ')}</dd>
        </dl>
      </section>
      <section className="tarjeta">
        <h2>Documentos</h2>
        {documents.length === 0 ? <p className="suave">Sin documentos.</p> : null}
        <ul>
          {documents.map((d) => (
            <li key={d.id}>
              <a href={d.downloadUrl}>{PROVIDER_DOCUMENT_LABELS[d.type]}</a> ({d.contentType})
            </li>
          ))}
        </ul>
        {c.missingDocuments.length ? (
          <p className="fd-form-error">
            Faltan: {c.missingDocuments.map((t) => PROVIDER_DOCUMENT_LABELS[t]).join(', ')}.
          </p>
        ) : null}
      </section>
      <section className="tarjeta">
        <h2>Decisión</h2>
        {c.status === 'in_review' || c.status === 'suspended' ? (
          <ActionForm action={decideProvider.bind(null, id, 'aprobar')} submit="Aprobar" />
        ) : null}
        {c.status === 'in_review' ? (
          <ActionForm action={decideProvider.bind(null, id, 'rechazar')} submit="Rechazar">
            <Reason />
          </ActionForm>
        ) : null}
        {c.status === 'approved' ? (
          <ActionForm
            action={decideProvider.bind(null, id, 'suspender')}
            submit="Suspender"
            confirm="La agencia saldrá del catálogo público. ¿Seguir?"
          >
            <Reason />
          </ActionForm>
        ) : null}
      </section>
      <section className="tarjeta">
        <h2>Comisión</h2>
        <ActionForm
          action={setCommission.bind(null, id)}
          submit="Guardar comisión"
          className="fd-inline"
        >
          <label className="fd-field">
            <span>Comisión propia % (vacío: la de la plataforma)</span>
            <input
              name="commissionPercent"
              inputMode="decimal"
              defaultValue={c.commissionPercent ?? ''}
            />
          </label>
        </ActionForm>
      </section>
    </>
  );
}
