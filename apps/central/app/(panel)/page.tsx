import { STAFF_ROLE_LABELS } from '@fulldays/shared';
import { requireMe } from '@fulldays/web-session';
import { HealthCard } from '../health-card';

export const dynamic = 'force-dynamic';

export default async function Home() {
  const me = await requireMe('/');
  const roles = me.staff.roles;
  return (
    <>
      <p className="suave">{me.email}</p>
      <section className="tarjeta" role={roles.length ? undefined : 'alert'}>
        {roles.length ? (
          <>
            <h2>Tus roles</h2>
            <p>{roles.map((r) => STAFF_ROLE_LABELS[r]).join(' · ')}</p>
          </>
        ) : (
          <>
            <h2>Sin acceso</h2>
            <p className="suave">
              Tu cuenta no tiene roles de Central. Pide a una persona super que te los asigne.
            </p>
          </>
        )}
      </section>
      <HealthCard />
    </>
  );
}
