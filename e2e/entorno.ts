/**
 * Entorno aislado de la suite: su propia base, su propio Redis lógico y puertos que no chocan
 * con `pnpm dev`. Todo se compila antes (`pnpm build`); aquí solo se arranca.
 */
export const E2E = {
  databaseUrl:
    process.env.E2E_DATABASE_URL ?? 'postgresql://fulldays:fulldays@localhost:5432/fulldays_e2e',
  redisUrl: process.env.E2E_REDIS_URL ?? 'redis://localhost:6379/5',
  api: 'http://localhost:4100',
  web: 'http://localhost:3200',
  pro: 'http://localhost:3201',
  central: 'http://localhost:3202',
  /** Código fijo de confirmación (solo fuera de producción). */
  code: '123456',
  password: 'clave-segura-e2e',
  webKey: 'clave-web-servidor-de-pruebas-e2e-0123456789',
};
