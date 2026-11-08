import type { Metadata } from 'next';
import type { ReactNode } from 'react';
import './globals.css';

export const metadata: Metadata = {
  title: 'FullDays · Central',
  description: 'Equipo interno: aprobaciones, reclamos y ajustes.',
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="es" data-product="central">
      <body>{children}</body>
    </html>
  );
}
