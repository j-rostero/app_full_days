import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { createApp } from './app.setup.ts';
import { buildOpenApi } from './openapi.ts';

const SAVED = new URL('../../../packages/api-client/openapi.json', import.meta.url);

test('el contrato guardado coincide con el código (si falla: pnpm api:client)', async () => {
  const app = await createApp({ logger: false });
  await app.init();
  try {
    const current = JSON.stringify(buildOpenApi(app), null, 2) + '\n';
    assert.equal(readFileSync(SAVED, 'utf8'), current);
  } finally {
    await app.close();
  }
});
