import { type INestApplication, RequestMethod } from '@nestjs/common';
import { METHOD_METADATA, PATH_METADATA } from '@nestjs/common/constants.js';
import { DiscoveryService, MetadataScanner } from '@nestjs/core';
import { ApiErrorSchema } from '@fulldays/shared';
import { z } from 'zod';
import { API_PREFIX, UNPREFIXED } from './app.setup.ts';
import { ENDPOINT_METADATA, type EndpointSpec, PUBLIC_METADATA } from './common/endpoint.ts';

type JsonSchema = Record<string, unknown>;

const NamedApiError = ApiErrorSchema.meta({ id: 'ApiError', description: 'Forma única de error.' });

const METHODS: Partial<Record<RequestMethod, string>> = {
  [RequestMethod.GET]: 'get',
  [RequestMethod.POST]: 'post',
  [RequestMethod.PUT]: 'put',
  [RequestMethod.PATCH]: 'patch',
  [RequestMethod.DELETE]: 'delete',
};

/**
 * Construye el contrato OpenAPI a partir de los controladores y sus `@Endpoint`.
 * El resultado es determinista (rutas y esquemas ordenados) para poder versionarlo
 * y compararlo en las pruebas.
 */
export function buildOpenApi(app: INestApplication): JsonSchema {
  const discovery = app.get(DiscoveryService);
  const scanner = new MetadataScanner();
  const paths: Record<string, Record<string, JsonSchema>> = {};
  const operationIds = new Set<string>();

  const ref = (schema: z.ZodType): JsonSchema => {
    const id = z.globalRegistry.get(schema)?.id;
    if (typeof id !== 'string')
      throw new Error('Un esquema de respuesta o cuerpo necesita .meta({ id }).');
    return { $ref: `#/components/schemas/${id}` };
  };

  for (const wrapper of discovery.getControllers()) {
    const { instance, metatype } = wrapper;
    if (!instance || !metatype) continue;
    const base = String(Reflect.getMetadata(PATH_METADATA, metatype) ?? '');
    const prototype = Object.getPrototypeOf(instance) as object;

    for (const name of scanner.getAllMethodNames(prototype)) {
      const handler = (prototype as Record<string, unknown>)[name] as object;
      const method = Reflect.getMetadata(METHOD_METADATA, handler) as RequestMethod | undefined;
      if (method === undefined) continue;
      const spec = Reflect.getMetadata(ENDPOINT_METADATA, handler) as EndpointSpec | undefined;
      const route = join(base, String(Reflect.getMetadata(PATH_METADATA, handler) ?? ''));
      if (!spec) throw new Error(`${metatype.name}.${name} (${route}) no declara @Endpoint.`);
      if (operationIds.has(spec.operationId))
        throw new Error(`operationId repetido: ${spec.operationId}`);
      operationIds.add(spec.operationId);

      const verb = METHODS[method];
      if (!verb) throw new Error(`Método HTTP no admitido en ${route}`);
      const prefixed = UNPREFIXED.some((u) => u.path === base) ? route : join(API_PREFIX, route);
      const path = '/' + prefixed.replace(/:(\w+)/g, '{$1}');

      const responses: Record<string, JsonSchema> = {};
      for (const [status, schema] of Object.entries(spec.responses)) {
        const description = Number(status) < 400 ? 'Éxito' : 'Error';
        const type =
          Number(status) < 400 ? (spec.contentType ?? 'application/json') : 'application/json';
        responses[status] = schema
          ? { description, content: { [type]: { schema: ref(schema) } } }
          : { description };
      }
      const isPublic = Reflect.getMetadata(PUBLIC_METADATA, handler) === true;
      responses.default = {
        description: 'Error',
        content: { 'application/json': { schema: ref(NamedApiError) } },
      };

      const parameters = [
        ...[...prefixed.matchAll(/:(\w+)/g)].map((m) => ({
          name: m[1],
          in: 'path',
          required: true,
          schema: { type: 'string' },
        })),
        ...Object.entries(spec.query?.shape ?? {}).map(([key, value]) => ({
          name: key,
          in: 'query',
          required: !(value as z.ZodType).safeParse(undefined).success,
          schema: toJsonSchema(value as z.ZodType),
        })),
      ];

      paths[path] ??= {};
      paths[path][verb] = {
        operationId: spec.operationId,
        summary: spec.summary,
        tags: spec.tags,
        ...(isPublic ? { security: [] } : {}),
        ...(parameters.length ? { parameters } : {}),
        ...(spec.body
          ? {
              requestBody: {
                required: true,
                content: { 'application/json': { schema: ref(spec.body) } },
              },
            }
          : {}),
        responses,
      };
    }
  }

  // Todos los esquemas con id se emiten juntos para que las referencias entre ellos se resuelvan.
  const registry = z.toJSONSchema(z.globalRegistry, {
    target: 'openapi-3.0',
    io: 'output',
    unrepresentable: 'any',
    uri: (id) => `#/components/schemas/${id}`,
  }) as { schemas: Record<string, JsonSchema> };
  const schemas = Object.fromEntries(
    Object.entries(registry.schemas).map(([id, json]) => {
      const { $schema: _s, $id: _$id, id: _id, ...rest } = json;
      return [id, rest];
    }),
  );

  return {
    openapi: '3.0.3',
    info: { title: 'FullDays API', version: '1.0.0' },
    paths: sortKeys(paths),
    // Todo exige sesión salvo lo que declara `security: []`.
    security: [{ bearer: [] }],
    components: {
      securitySchemes: { bearer: { type: 'http', scheme: 'bearer', bearerFormat: 'JWT' } },
      schemas: sortKeys(schemas),
    },
  };
}

function toJsonSchema(schema: z.ZodType): JsonSchema {
  const json = z.toJSONSchema(schema, {
    target: 'openapi-3.0',
    io: 'output',
    unrepresentable: 'any',
  }) as JsonSchema;
  delete json.$schema;
  delete json.id;
  return json;
}

function join(...parts: string[]): string {
  return parts
    .flatMap((p) => p.split('/'))
    .filter(Boolean)
    .join('/');
}

function sortKeys<T>(record: Record<string, T>): Record<string, T> {
  return Object.fromEntries(Object.entries(record).sort(([a], [b]) => a.localeCompare(b)));
}
