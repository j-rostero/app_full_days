import { test, before, after } from 'node:test';
import assert from 'node:assert/strict';
import type { INestApplication } from '@nestjs/common';
import { createApp } from './app.setup.ts';

// Corre contra PostgreSQL y Redis reales (DATABASE_URL y REDIS_URL del entorno).
let app: INestApplication;
let base: string;

before(async () => {
  app = await createApp({ logger: false });
  await app.listen(0);
  base = await app.getUrl();
});

after(async () => {
  await app.close();
});

test('/salud responde ok con la base y Redis encendidos', async () => {
  const res = await fetch(`${base}/salud`);
  assert.equal(res.status, 200);
  assert.deepEqual(await res.json(), { status: 'ok', checks: { database: 'ok', redis: 'ok' } });
});

test('/salud no lleva el prefijo /v1', async () => {
  const res = await fetch(`${base}/v1/salud`);
  assert.equal(res.status, 404);
});

test('una ruta inexistente responde con la forma única de error', async () => {
  const res = await fetch(`${base}/v1/no-existe`);
  assert.equal(res.status, 404);
  assert.deepEqual(await res.json(), {
    statusCode: 404,
    code: 'not_found',
    message: 'No encontrado.',
  });
});
