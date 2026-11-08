import { PROVIDER_KIND_LABELS } from '@fulldays/shared';
import { requireMe } from '@fulldays/web-session';
import { ActionForm } from '@fulldays/web-session/action-form';
import { ProviderFields } from '../../../lib/provider-fields';
import { registerProvider } from './actions';

export default async function NewProvider() {
  await requireMe('/agencias/nueva');
  return (
    <main>
      <h1>Registrar una agencia</h1>
      <p className="suave">
        Después subirás el RIF y la cédula del representante para que Central verifique la agencia.
      </p>
      <ActionForm action={registerProvider} submit="Registrar">
        <label className="fd-field">
          <span>Tipo</span>
          <select name="kind" defaultValue="company">
            {Object.entries(PROVIDER_KIND_LABELS).map(([value, label]) => (
              <option key={value} value={value}>
                {label}
              </option>
            ))}
          </select>
        </label>
        <ProviderFields />
        <label className="fd-field">
          <span>RIF</span>
          <input name="rif" required placeholder="J-12345678-9" />
        </label>
      </ActionForm>
    </main>
  );
}
