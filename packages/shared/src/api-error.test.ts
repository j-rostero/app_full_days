import { test } from 'node:test';
import assert from 'node:assert/strict';
import { ApiErrorSchema, codeForStatus } from './api-error.ts';

test('cada estado HTTP tiene un código estable', () => {
  assert.equal(codeForStatus(404), 'not_found');
  assert.equal(codeForStatus(429), 'rate_limited');
  assert.equal(codeForStatus(503), 'internal_error');
  assert.equal(codeForStatus(418), 'bad_request');
});

test('el error de validación lleva problemas por campo', () => {
  const parsed = ApiErrorSchema.parse({
    statusCode: 400,
    code: 'validation_error',
    message: 'Revisa los datos.',
    issues: [{ path: ['email'], message: 'Correo inválido' }],
  });
  assert.equal(parsed.issues?.[0]?.path[0], 'email');
});

test('un código desconocido no pasa el esquema', () => {
  assert.equal(
    ApiErrorSchema.safeParse({ statusCode: 400, code: 'otro', message: 'x' }).success,
    false,
  );
});
