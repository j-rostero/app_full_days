/**
 * Modelos con `providerId` que pertenecen a una agencia, por su nombre de acceso en el
 * cliente (`db.providerMember`). Un modelo nuevo con `providerId` que no se agregue aquí
 * queda sin aislar: esta lista es la defensa.
 */
export const PROVIDER_OWNED_MODELS = new Set<string>(['providerMember', 'auditLog']);

const FILTERED = new Set([
  'findUnique',
  'findUniqueOrThrow',
  'findFirst',
  'findFirstOrThrow',
  'findMany',
  'count',
  'aggregate',
  'groupBy',
  'update',
  'updateMany',
  'updateManyAndReturn',
  'delete',
  'deleteMany',
]);

type Args = Record<string, unknown> & {
  where?: Record<string, unknown>;
  data?: unknown;
  create?: Record<string, unknown>;
  update?: Record<string, unknown>;
};

/**
 * Cliente limitado a una agencia: en los modelos de `PROVIDER_OWNED_MODELS` agrega
 * `providerId = <agencia>` a toda lectura, actualización y borrado, fija `providerId` en
 * toda fila creada e ignora cualquier intento de cambiarlo.
 *
 * Funciona igual sobre el cliente completo y sobre el de una transacción interactiva, por
 * eso envuelve los accesos en lugar de usar `$extends`.
 *
 * Límite conocido: no filtra lo que se alcanza a través de una relación (`include`) desde
 * otro modelo. Los endpoints de agencia parten siempre de un modelo propio.
 */
export function scopeToProvider<T extends object>(client: T, providerId: string): T {
  return new Proxy(client, {
    get(target, prop, receiver) {
      const value = Reflect.get(target, prop, receiver) as unknown;
      if (typeof prop !== 'string' || !PROVIDER_OWNED_MODELS.has(prop)) return value;
      return scopeDelegate(value as Record<string, (args?: unknown) => unknown>, providerId);
    },
  });
}

function scopeDelegate(delegate: Record<string, (args?: unknown) => unknown>, providerId: string) {
  return new Proxy(delegate, {
    get(target, operation) {
      const fn = target[operation as string];
      if (typeof operation !== 'string' || typeof fn !== 'function') return fn;
      return (args?: unknown) =>
        fn.call(target, scopeArgs(operation, (args ?? {}) as Args, providerId));
    },
  });
}

function scopeArgs(operation: string, args: Args, providerId: string): Args {
  const a = { ...args };
  if (FILTERED.has(operation)) a.where = { ...(a.where ?? {}), providerId };
  if (operation.startsWith('update')) a.data = withoutProvider(a.data);
  if (operation === 'create') a.data = { ...withoutRelation(a.data), providerId };
  if (operation === 'createMany' || operation === 'createManyAndReturn') {
    const rows = Array.isArray(a.data) ? a.data : [a.data];
    a.data = rows.map((row) => ({ ...withoutRelation(row), providerId }));
  }
  if (operation === 'upsert') {
    a.where = { ...(a.where ?? {}), providerId };
    a.create = { ...withoutRelation(a.create), providerId };
    a.update = withoutProvider(a.update) as Record<string, unknown>;
  }
  return a;
}

function withoutRelation(data: unknown): Record<string, unknown> {
  const { provider: _relation, ...rest } = (data ?? {}) as Record<string, unknown>;
  return rest;
}

function withoutProvider(data: unknown): unknown {
  if (!data || typeof data !== 'object') return data;
  const { providerId: _ignored, provider: _relation, ...rest } = data as Record<string, unknown>;
  return rest;
}
