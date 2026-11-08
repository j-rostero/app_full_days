import { defineConfig, devices } from '@playwright/test';
import { E2E } from './entorno.ts';

const apiEnv = {
  NODE_ENV: 'test',
  PORT: '4100',
  DATABASE_URL: E2E.databaseUrl,
  REDIS_URL: E2E.redisUrl,
  STORAGE_DRIVER: 'memory',
  OTP_FIXED_CODE: E2E.code,
  OTP_MAX_SENDS: '1000',
  RATE_LIMIT_PER_MINUTE: '100000',
  AUTH_RATE_LIMIT_PER_MINUTE: '100000',
  WEB_SERVER_KEY: E2E.webKey,
  CORS_ORIGINS: [E2E.web, E2E.pro, E2E.central].join(','),
};
const webEnv = { API_URL: E2E.api, WEB_SERVER_KEY: E2E.webKey, SITE_URL: E2E.web };
const web = (pkg: string, url: string) => ({
  command: `pnpm --filter ${pkg} exec next start --port ${new URL(url).port}`,
  url,
  env: webEnv,
  reuseExistingServer: false,
  timeout: 60_000,
});

/** Recorridos entre las tres webs y la API. Antes: `pnpm build` y PostgreSQL y Redis encendidos. */
export default defineConfig({
  testDir: './tests',
  fullyParallel: false,
  workers: 1,
  retries: process.env.CI ? 1 : 0,
  reporter: process.env.CI ? [['list'], ['html', { open: 'never' }]] : 'list',
  timeout: 90_000,
  expect: { timeout: 15_000 },
  use: {
    trace: 'off',
    screenshot: 'only-on-failure',
    locale: 'es-VE',
    timezoneId: 'America/Caracas',
  },
  projects: [
    { name: 'datos', testMatch: /datos\.setup\.ts/ },
    { name: 'chromium', use: { ...devices['Desktop Chrome'] }, dependencies: ['datos'] },
  ],
  webServer: [
    {
      // Base propia de la suite, migrada antes de arrancar. Cada corrida crea su agencia, su
      // viaje y sus cuentas, así que no hace falta vaciarla.
      command: 'pnpm --filter @fulldays/db migrate:deploy && node ../apps/api/dist/main.js',
      url: `${E2E.api}/salud`,
      env: apiEnv,
      reuseExistingServer: false,
      timeout: 120_000,
    },
    web('@fulldays/web', E2E.web),
    web('@fulldays/pro-web', E2E.pro),
    web('@fulldays/central', E2E.central),
  ],
});
