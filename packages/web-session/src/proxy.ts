import { type NextRequest, NextResponse } from 'next/server';
import { clientIpFrom, serverApi } from './api.ts';
import { ACCESS_COOKIE, REFRESH_COOKIE, sessionCookies } from './cookies.ts';

/**
 * Renueva la sesión antes de que se renderice la página: si la cookie de acceso venció y
 * queda la de renovación, pide un par nuevo, lo pasa a la petición en curso y lo guarda en
 * el navegador. Si la renovación falla, borra las cookies (la sesión terminó).
 *
 * Cada web lo usa en su `proxy.ts`: `export { sessionProxy as proxy } from '@fulldays/web-session/proxy'`.
 */
export async function sessionProxy(request: NextRequest): Promise<NextResponse> {
  const refreshToken = request.cookies.get(REFRESH_COOKIE)?.value;
  if (request.cookies.get(ACCESS_COOKIE) || !refreshToken) return NextResponse.next();

  let tokens;
  try {
    const { data } = await serverApi({
      clientIp: clientIpFrom(request.headers),
      userAgent: request.headers.get('user-agent'),
    }).POST('/v1/auth/renovar', { body: { refreshToken } });
    tokens = data;
  } catch {
    // La API no responde: se sigue sin sesión esta vez, sin borrar nada.
    return NextResponse.next();
  }
  if (!tokens) {
    const response = NextResponse.next();
    response.cookies.delete(ACCESS_COOKIE);
    response.cookies.delete(REFRESH_COOKIE);
    return response;
  }
  const fresh = sessionCookies(tokens);
  for (const cookie of fresh) request.cookies.set(cookie.name, cookie.value);
  const response = NextResponse.next({ request: { headers: request.headers } });
  for (const cookie of fresh) response.cookies.set(cookie);
  return response;
}

/** Rutas en las que corre el proxy: todo menos archivos estáticos. */
export const sessionProxyMatcher = ['/((?!_next/static|_next/image|favicon.ico).*)'];
