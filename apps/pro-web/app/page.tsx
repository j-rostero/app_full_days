import { PROVIDER_ROLE_LABELS } from '@fulldays/shared';
import { requireMe } from '@fulldays/web-session';
import { SignOutButton } from '@fulldays/web-session/sign-out';
import { HealthCard } from './health-card';

export const dynamic = 'force-dynamic';

export default async function Home() {
  const me = await requireMe('/');
  return (
    <main>
      <h1>FullDays · Agencias</h1>
      <div className="barra">
        <p className="suave">{me.email}</p>
        <SignOutButton />
      </div>
      <section className="tarjeta">
        <h2>Tus agencias</h2>
        {me.memberships.length === 0 ? (
          <p className="suave">
            Aún no eres parte de ninguna agencia. Pide al dueño que te sume con este correo.
          </p>
        ) : (
          <ul>
            {me.memberships.map((m) => (
              <li key={m.providerId}>
                {m.providerName} · {PROVIDER_ROLE_LABELS[m.role]}
              </li>
            ))}
          </ul>
        )}
      </section>
      <HealthCard />
    </main>
  );
}
