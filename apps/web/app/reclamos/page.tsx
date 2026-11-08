import Link from 'next/link';
import { requireMe } from '@fulldays/web-session';
import { ClaimThread } from '../../components/claim';
import { read } from '../../lib/api';

export const metadata = { title: 'Mis reclamos', robots: { index: false } };

export default async function ClaimsPage() {
  await requireMe('/reclamos');
  const { items } = await read((api) => api.GET('/v1/reclamos'));
  return (
    <main>
      <h1>Mis reclamos</h1>
      <p className="suave">
        Abre un reclamo desde la reserva. Primero responde la agencia; si no se resuelve, pide que
        FullDays intervenga.
      </p>
      {items.length === 0 ? (
        <p>
          No tienes reclamos. <Link href="/reservas">Ver mis viajes</Link>
        </p>
      ) : null}
      {items.map((c) => (
        <ClaimThread key={c.id} claim={c} back="/reclamos" />
      ))}
    </main>
  );
}
