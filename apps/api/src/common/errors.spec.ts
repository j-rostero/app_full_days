import { test } from 'node:test';
import assert from 'node:assert/strict';
import { z } from 'zod';
import { ApiErrorSchema } from '@fulldays/shared';
import { toApiError } from './api-error.filter.ts';
import { ApiException } from './api-exception.ts';
import { ZodPipe } from './zod.pipe.ts';

test('ZodPipe responde 422 con los problemas por campo', () => {
  const pipe = new ZodPipe(z.object({ email: z.email(), edad: z.number().min(18) }));
  assert.deepEqual(pipe.transform({ email: 'ana@x.com', edad: 30 }), {
    email: 'ana@x.com',
    edad: 30,
  });
  try {
    pipe.transform({ email: 'no', edad: 3 });
    assert.fail('debía fallar');
  } catch (error) {
    const body = toApiError(error);
    assert.equal(body.statusCode, 422);
    assert.equal(body.code, 'validation_failed');
    assert.deepEqual(
      body.issues?.map((i) => i.path.join('.')),
      ['email', 'edad'],
    );
    assert.ok(ApiErrorSchema.safeParse(body).success);
  }
});

test('un error inesperado no filtra detalles internos', () => {
  const body = toApiError(new Error('contraseña de la base: secreta'));
  assert.deepEqual(body, {
    statusCode: 500,
    code: 'internal_error',
    message: 'Algo salió mal. Inténtalo de nuevo.',
  });
});

test('ApiException conserva su código', () => {
  assert.equal(toApiError(new ApiException(409, 'conflict', 'Ya existe.')).code, 'conflict');
});
