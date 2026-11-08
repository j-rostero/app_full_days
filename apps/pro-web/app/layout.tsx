import type { Metadata } from 'next';
import type { ReactNode } from 'react';
import './globals.css';

export const metadata: Metadata = {
  title: 'FullDays · Agencias',
  description: 'Gestiona tus fulldays, salidas y reservas.',
};

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="es" data-product="pro">
      <body>{children}</body>
    </html>
  );
}
