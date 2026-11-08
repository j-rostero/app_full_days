import Link from 'next/link';
import { notFound } from 'next/navigation';
import type { ReactNode } from 'react';
import { PROVIDER_STATUS_LABELS } from '@fulldays/shared';
import { requireMe } from '@fulldays/web-session';
import { SignOutButton } from '@fulldays/web-session/sign-out';

export default async function ProviderLayout({
  children,
  params,
}: {
  children: ReactNode;
  params: Promise<{ providerId: string }>;
}) {
  const { providerId } = await params;
  const me = await requireMe(`/agencia/${providerId}`);
  const membership = me.memberships.find((m) => m.providerId === providerId);
  if (!membership) notFound();
  const can = (p: string) => membership.permissions.includes(p as never);
  const base = `/agencia/${providerId}`;
  return (
    <main className="ancho">
      <div className="barra">
        <h1>{membership.providerName}</h1>
        <SignOutButton />
      </div>
      <p className="suave">
        Estado: <span className="fd-pill">{PROVIDER_STATUS_LABELS[membership.providerStatus]}</span>{' '}
        · <Link href="/">Mis agencias</Link>
      </p>
      <nav className="fd-nav" aria-label="Secciones de la agencia">
        {can('company') ? <Link href={`${base}/empresa`}>Empresa</Link> : null}
        {can('fulldays') ? <Link href={`${base}/productos`}>Productos</Link> : null}
        {can('departures') ? <Link href={`${base}/salidas`}>Salidas</Link> : null}
        {can('bookings') ? <Link href={`${base}/reservas`}>Reservas</Link> : null}
        {can('payments') ? <Link href={`${base}/pagos`}>Pagos</Link> : null}
        {can('team') ? <Link href={`${base}/equipo`}>Equipo</Link> : null}
      </nav>
      {children}
    </main>
  );
}
