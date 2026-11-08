import type { MetadataRoute } from 'next';
import { SITE_URL } from '../lib/format';

export default function robots(): MetadataRoute.Robots {
  return {
    rules: {
      userAgent: '*',
      allow: '/',
      disallow: [
        '/reservas',
        '/reservar',
        '/favoritos',
        '/entrar',
        '/registrar',
        '/verificar',
        '/recuperar',
        '/restablecer',
      ],
    },
    sitemap: `${SITE_URL}/sitemap.xml`,
  };
}
