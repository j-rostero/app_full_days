import Link from 'next/link';
import type { ReactNode } from 'react';
import { requireMe } from '@fulldays/web-session';
import { SignOutButton } from '@fulldays/web-session/sign-out';

const SECTIONS = [
  ['providers', '/agencias', 'Agencias'],
  ['fulldays', '/productos', 'Productos'],
  ['catalogs', '/catalogos', 'Catálogos'],
  ['claims', '/reclamos', 'Reclamos'],
  ['reviews', '/resenas', 'Reseñas'],
  ['users', '/usuarios', 'Usuarios'],
  ['settlements', '/liquidaciones', 'Liquidaciones'],
  ['metrics', '/metricas', 'Métricas'],
  ['rates', '/tasa', 'Tasa'],
  ['settings', '/ajustes', 'Ajustes'],
  ['staff', '/equipo', 'Equipo'],
  ['audit', '/auditoria', 'Auditoría'],
] as const;

export default async function PanelLayout({ children }: { children: ReactNode }) {
  const me = await requireMe('/');
  const can = (p: string) => me.staff.permissions.includes(p as never);
  return (
    <main className="ancho">
      <div className="barra">
        <h1>FullDays · Central</h1>
        <SignOutButton />
      </div>
      <nav className="fd-nav" aria-label="Secciones">
        <Link href="/">Inicio</Link>
        {SECTIONS.filter(([p]) => can(p) || (p === 'catalogs' && can('themes'))).map(
          ([, href, label]) => (
            <Link key={href} href={href}>
              {label}
            </Link>
          ),
        )}
      </nav>
      {children}
    </main>
  );
}
