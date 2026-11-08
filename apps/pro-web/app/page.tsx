import Link from 'next/link';
import { PROVIDER_ROLE_LABELS, PROVIDER_STATUS_LABELS } from '@fulldays/shared';
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
            Aún no eres parte de ninguna agencia. Regístrala o pide al dueño que te sume con este
            correo.
          </p>
        ) : (
          <ul>
            {me.memberships.map((m) => (
              <li key={m.providerId}>
                <Link href={`/agencia/${m.providerId}`}>{m.providerName}</Link> ·{' '}
                {PROVIDER_ROLE_LABELS[m.role]} ·{' '}
                <span className="fd-pill">{PROVIDER_STATUS_LABELS[m.providerStatus]}</span>
              </li>
            ))}
          </ul>
        )}
        <p className="fd-links">
          <Link href="/agencias/nueva">Registrar una agencia</Link>
        </p>
      </section>
      <HealthCard />
    </main>
  );
}
