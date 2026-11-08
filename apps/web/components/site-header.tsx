import Link from 'next/link';
import { getMe } from '@fulldays/web-session';
import { SignOutButton } from '@fulldays/web-session/sign-out';

export async function SiteHeader() {
  const me = await getMe();
  return (
    <header className="cabecera">
      <Link href="/" className="marca">
        FullDays
      </Link>
      <nav aria-label="Principal">
        <Link href="/buscar">Explorar</Link>
        {me ? (
          <>
            <Link href="/reservas">Mis viajes</Link>
            <Link href="/favoritos">Guardados</Link>
            <SignOutButton />
          </>
        ) : (
          <>
            <Link href="/entrar">Entrar</Link>
            <Link href="/registrar" className="fd-button">
              Crear cuenta
            </Link>
          </>
        )}
      </nav>
    </header>
  );
}
