import { STAFF_ROLE_LABELS, STAFF_ROLES, type StaffRole } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../lib/api';
import { setStaffRoles } from './actions';

function Roles({ selected = [] }: { selected?: readonly StaffRole[] }) {
  return (
    <fieldset className="fd-field">
      <legend>Roles</legend>
      {STAFF_ROLES.map((role) => (
        <label key={role} className="fd-check">
          <input
            type="checkbox"
            name="roles"
            value={role}
            defaultChecked={selected.includes(role)}
          />{' '}
          {STAFF_ROLE_LABELS[role]}
        </label>
      ))}
    </fieldset>
  );
}

export default async function Staff() {
  const { items } = await read((api) => api.GET('/v1/central/equipo'));
  return (
    <>
      <section className="tarjeta">
        <h2>Equipo de Central</h2>
        <p className="suave">
          Quitar todos los roles saca a la persona de Central. Siempre queda al menos un Super.
        </p>
        {items.map((person) => (
          <details key={person.user.id} className="bloque">
            <summary>
              <strong>{person.user.name ?? person.user.email}</strong> ·{' '}
              {person.roles.map((r) => STAFF_ROLE_LABELS[r]).join(', ')}
            </summary>
            <ActionForm action={setStaffRoles} submit="Guardar roles">
              <input type="hidden" name="email" value={person.user.email} />
              <Roles selected={person.roles} />
            </ActionForm>
          </details>
        ))}
      </section>
      <section className="tarjeta">
        <h2>Sumar a alguien</h2>
        <p className="suave">La persona necesita una cuenta de FullDays con ese correo.</p>
        <ActionForm action={setStaffRoles} submit="Sumar">
          <label className="fd-field">
            <span>Correo</span>
            <input type="email" name="email" required />
          </label>
          <Roles />
        </ActionForm>
      </section>
    </>
  );
}
