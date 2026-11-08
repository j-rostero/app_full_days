import { PROVIDER_ROLE_LABELS } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { addMember, changeRole, removeMember } from './actions';

const RoleSelect = ({ value }: { value?: string }) => (
  <label className="fd-field">
    <span>Rol</span>
    <select name="role" defaultValue={value ?? 'guide'}>
      {Object.entries(PROVIDER_ROLE_LABELS).map(([key, label]) => (
        <option key={key} value={key}>
          {label}
        </option>
      ))}
    </select>
  </label>
);

export default async function TeamPage({ params }: { params: Promise<{ providerId: string }> }) {
  const { providerId } = await params;
  const team = await read((api) =>
    api.GET('/v1/pro/{providerId}/equipo', { params: { path: { providerId } } }),
  );
  return (
    <>
      <section className="tarjeta">
        <h2>Sumar a alguien</h2>
        <ActionForm action={addMember.bind(null, providerId)} submit="Sumar" className="fd-inline">
          <label className="fd-field">
            <span>Correo</span>
            <input type="email" name="email" required />
          </label>
          <RoleSelect />
        </ActionForm>
      </section>
      <section className="tarjeta">
        <h2>Equipo</h2>
        {team.items.map((m) => (
          <div key={m.id} className="fila fd-inline">
            <p>{m.user.name ?? m.user.email}</p>
            <ActionForm
              action={changeRole.bind(null, providerId, m.id)}
              submit="Cambiar rol"
              className="fd-inline"
            >
              <RoleSelect value={m.role} />
            </ActionForm>
            <ActionForm
              action={removeMember.bind(null, providerId, m.id)}
              submit="Quitar"
              confirm={`¿Quitar a ${m.user.email} del equipo?`}
              className="fd-inline"
            />
          </div>
        ))}
      </section>
    </>
  );
}
