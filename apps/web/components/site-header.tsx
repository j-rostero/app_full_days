import Link from 'next/link';
import { getMe, sessionApi } from '@fulldays/web-session';
import { SignOutButton } from '@fulldays/web-session/sign-out';

export async function SiteHeader() {
  const me = await getMe();
  const unread = me
    ? (((await (await sessionApi()).GET('/v1/yo/notificaciones')).data?.unread ?? 0) as number)
    : 0;
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
            <Link href="/reclamos">Reclamos</Link>
            <Link href="/avisos">
              Avisos{unread ? <span className="contador-avisos">{unread}</span> : null}
            </Link>
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
