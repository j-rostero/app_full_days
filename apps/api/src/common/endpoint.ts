import { SetMetadata } from '@nestjs/common';
import type { z } from 'zod';

export const ENDPOINT_METADATA = 'fulldays:endpoint';

/** Lo que un endpoint declara para el contrato OpenAPI. */
export interface EndpointSpec {
  /** Id de la operación: nombre del método en los clientes generados (TypeScript y Dart). */
  operationId: string;
  summary: string;
  tags: string[];
  /** Respuestas por estado HTTP. Cada esquema necesita `.meta({ id })` para nombrarse en el contrato. */
  responses: Record<number, z.ZodType>;
  body?: z.ZodType;
  query?: z.ZodObject;
}

/**
 * Declara un endpoint en el contrato. Un endpoint sin `@Endpoint` hace fallar
 * la generación del contrato (ver `openapi.ts`): todo lo que se expone se documenta.
 */
export const Endpoint = (spec: EndpointSpec) => SetMetadata(ENDPOINT_METADATA, spec);
