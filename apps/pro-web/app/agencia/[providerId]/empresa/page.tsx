import { PROVIDER_DOCUMENT_LABELS, PROVIDER_KIND_LABELS } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { ProviderFields } from '../../../../lib/provider-fields';
import { updateCompany } from './actions';
import { Documents } from './documents';

export default async function CompanyPage({ params }: { params: Promise<{ providerId: string }> }) {
  const { providerId } = await params;
  const path = { params: { path: { providerId } } };
  const [company, documents] = await Promise.all([
    read((api) => api.GET('/v1/pro/{providerId}/empresa', path)),
    read((api) => api.GET('/v1/pro/{providerId}/documentos', path)),
  ]);
  const locked = company.status === 'in_review';
  return (
    <>
      {company.statusReason && company.status !== 'approved' ? (
        <p className="fd-form-error" role="alert">
          Central: {company.statusReason}
        </p>
      ) : null}
      {company.status === 'pending' || company.status === 'rejected' ? (
        <p className="suave">
          {company.missingDocuments.length
            ? `Para enviar tu agencia a verificación sube: ${company.missingDocuments.map((t) => PROVIDER_DOCUMENT_LABELS[t]).join(', ')}.`
            : 'Ya puedes enviar tu agencia a verificación.'}
        </p>
      ) : null}
      <Documents
        providerId={providerId}
        documents={documents.items}
        locked={locked}
        canSubmit={
          (company.status === 'pending' || company.status === 'rejected') &&
          company.missingDocuments.length === 0
        }
      />
      <section className="tarjeta">
        <h2>Datos de la agencia</h2>
        <p className="suave">
          RIF: {company.rif}
          {company.badge === 'verified' ? ' · Verificada (RTN)' : ''}
        </p>
        {locked ? (
          <p className="suave">En revisión: no se pueden cambiar los datos.</p>
        ) : (
          <ActionForm action={updateCompany.bind(null, providerId)} submit="Guardar datos">
            <label className="fd-field">
              <span>Tipo</span>
              <select name="kind" defaultValue={company.kind}>
                {Object.entries(PROVIDER_KIND_LABELS).map(([value, label]) => (
                  <option key={value} value={value}>
                    {label}
                  </option>
                ))}
              </select>
            </label>
            <ProviderFields values={company} />
          </ActionForm>
        )}
      </section>
    </>
  );
}
