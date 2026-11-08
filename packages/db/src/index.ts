import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from './generated/client.ts';

export { Prisma, PrismaClient } from './generated/client.ts';
export type * from './generated/client.ts';
export { PROVIDER_OWNED_MODELS, scopeToProvider } from './scope.ts';

/** Crea el cliente de la base. Solo la API lo usa: ninguna web ni app toca la base. */
export function createDb(databaseUrl: string): PrismaClient {
  return new PrismaClient({ adapter: new PrismaPg({ connectionString: databaseUrl }) });
}
