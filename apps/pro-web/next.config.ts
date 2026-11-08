import type { NextConfig } from 'next';

const config: NextConfig = {
  // Los paquetes del workspace se publican como fuente TypeScript.
  transpilePackages: ['@fulldays/api-client', '@fulldays/tokens'],
  poweredByHeader: false,
};

export default config;
