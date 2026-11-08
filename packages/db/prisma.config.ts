import { defineConfig } from 'prisma/config';

export default defineConfig({
  schema: 'prisma/schema.prisma',
  migrations: { path: 'prisma/migrations' },
  // `prisma generate` no necesita la base; migrar sí, y para eso DATABASE_URL es obligatoria.
  datasource: { url: process.env.DATABASE_URL ?? 'postgresql://localhost:5432/fulldays' },
});
