import Link from 'next/link';
import { getMe } from '@fulldays/web-session';
import { SignOutButton } from '@fulldays/web-session/sign-out';
import { HealthCard } from './health-card';

// Se renderiza en cada petición: la sesión y el estado de la API son los del momento.
export const dynamic = 'force-dynamic';

export default async function Home() {
  const me = await getMe();
  return (
    <main>
      <h1>FullDays · Clientes</h1>
      <p className="suave">Encuentra tu próximo fullday, tour o excursión.</p>
      {me ? (
        <div className="barra">
          <p>Hola, {me.name ?? me.email}.</p>
          <SignOutButton />
        </div>
      ) : (
        <p className="fd-links">
          <Link href="/entrar">Entrar</Link>
          <Link href="/registrar">Crear una cuenta</Link>
        </p>
      )}
      <HealthCard />
    </main>
  );
}
