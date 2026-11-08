import { AsyncLocalStorage } from 'node:async_hooks';
import type { Prisma, PrismaClient } from '@fulldays/db';

/** Cliente de una transacción interactiva. */
export type Tx = Prisma.TransactionClient;

const current = new AsyncLocalStorage<Tx>();

/**
 * Cliente que la API inyecta como `DB`. Dentro de `runInTransaction` todas las consultas
 * van a esa transacción; fuera, al cliente normal. Así la auditoría (y cualquier escritura
 * de un mismo pedido) se confirma o se deshace junta, sin que cada servicio pase la
 * transacción a mano.
 *
 * `db.$transaction(fn)` dentro de una transacción en curso se une a ella.
 */
export function transactionalDb(root: PrismaClient): PrismaClient {
  return new Proxy(root, {
    get(target, prop, receiver) {
      const tx = current.getStore();
      if (prop === '$transaction') {
        return (arg: unknown, options?: unknown) => {
          if (typeof arg !== 'function') return target.$transaction(arg as never, options as never);
          const fn = arg as (tx: Tx) => Promise<unknown>;
          if (tx) return fn(tx);
          return target.$transaction((t) => current.run(t, () => fn(t)), {
            timeout: 15_000,
            ...(options as object),
          });
        };
      }
      if (tx && prop in tx) return (tx as unknown as Record<string | symbol, unknown>)[prop];
      const value = Reflect.get(target, prop, receiver) as unknown;
      return typeof value === 'function'
        ? (value as (...a: unknown[]) => unknown).bind(target)
        : value;
    },
  });
}

/** Corre `fn` en una transacción; las consultas por el cliente `DB` dentro de `fn` van a ella. */
export function runInTransaction<T>(db: PrismaClient, fn: () => Promise<T>): Promise<T> {
  return db.$transaction(() => fn()) as Promise<T>;
}

/** ¿Es un UUID? Los ids de la URL que no lo son responden 404 sin llegar a la base. */
export function isUuid(value: string): boolean {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i.test(value);
}
