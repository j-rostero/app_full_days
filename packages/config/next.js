/**
 * Configuración común de las tres webs Next.
 *
 * - Paquetes del workspace publicados como fuente TypeScript.
 * - Cabeceras de seguridad en todas las respuestas (HSTS solo en producción, que va con HTTPS).
 * - `NEXT_OUTPUT=standalone` (lo fija la imagen Docker) produce un servidor autocontenido.
 */
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('../..', import.meta.url));

const securityHeaders = [
  { key: 'X-Content-Type-Options', value: 'nosniff' },
  { key: 'Referrer-Policy', value: 'strict-origin-when-cross-origin' },
  { key: 'X-Frame-Options', value: 'DENY' },
  { key: 'Permissions-Policy', value: 'camera=(), microphone=(), geolocation=(), payment=()' },
  ...(process.env.NODE_ENV === 'production'
    ? [{ key: 'Strict-Transport-Security', value: 'max-age=31536000; includeSubDomains' }]
    : []),
];

/** @param {import('next').NextConfig} [extra] */
export function nextConfig(extra = {}) {
  return {
    transpilePackages: ['@fulldays/api-client', '@fulldays/tokens', '@fulldays/web-session'],
    poweredByHeader: false,
    ...(process.env.NEXT_OUTPUT === 'standalone'
      ? { output: 'standalone', outputFileTracingRoot: root }
      : {}),
    async headers() {
      return [{ source: '/:path*', headers: securityHeaders }];
    },
    ...extra,
  };
}
