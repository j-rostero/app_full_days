import { sessionProxy } from '@fulldays/web-session/proxy';
import type { NextRequest } from 'next/server';

/** Renueva la sesión antes de renderizar (ver `@fulldays/web-session/proxy`). */
export function proxy(request: NextRequest) {
  return sessionProxy(request);
}

export const config = { matcher: ['/((?!_next/static|_next/image|favicon.ico).*)'] };
