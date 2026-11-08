import type { Metadata } from 'next';
import type { ReactNode } from 'react';
import { SiteHeader } from '../components/site-header';
import { SITE_URL } from '../lib/format';
import './globals.css';

export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: {
    default: 'FullDays · Fulldays, tours y excursiones en Venezuela',
    template: '%s · FullDays',
  },
  description:
    'Encuentra y reserva fulldays, tours y excursiones de agencias verificadas en Venezuela.',
  openGraph: { siteName: 'FullDays', locale: 'es_VE', type: 'website' },
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="es">
      <body>
        <SiteHeader />
        {children}
        <footer className="pie">
          <p className="suave">
            FullDays conecta viajeros con agencias de turismo. Los pagos se hacen directo a cada
            agencia.
          </p>
        </footer>
      </body>
    </html>
  );
}
