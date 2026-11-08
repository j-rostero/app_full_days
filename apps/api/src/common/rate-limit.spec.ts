import { after, before, test } from 'node:test';
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import { type Api, startApi, uniqueEmail } from '../testing/harness.ts';

const KEY = 'clave-de-los-servidores-web-0123456789';
let api: Api;
before(async () => {
  api = await startApi({
    AUTH_RATE_LIMIT_PER_MINUTE: '3',
    RATE_LIMIT_BLOCK_SECONDS: '0',
    WEB_SERVER_KEY: KEY,
  });
});
after(() => api.close());

const recover = (headers: Record<string, string>) =>
  api.call('POST', '/v1/auth/recuperar', { body: { email: uniqueEmail() }, headers });

test('el límite de acceso cuenta por la IP que informa la web con su clave', async () => {
  const ip = `10.9.${Math.floor(Math.random() * 250)}.${Math.floor(Math.random() * 250)}-${randomUUID()}`;
  const web = { 'x-fulldays-web-key': KEY, 'x-fulldays-client-ip': ip };
  for (let i = 0; i < 3; i++) assert.equal((await recover(web)).status, 204);
  assert.equal((await recover(web)).status, 429);
  // Otra persona detrás del mismo servidor web no queda frenada.
  assert.equal((await recover({ ...web, 'x-fulldays-client-ip': `${ip}-otra` })).status, 204);
});

test('sin la clave correcta la cabecera de IP se ignora', async () => {
  const forged = {
    'x-fulldays-web-key': 'x'.repeat(KEY.length),
    'x-fulldays-client-ip': randomUUID(),
  };
  const statuses: number[] = [];
  for (let i = 0; i < 5; i++) statuses.push((await recover(forged)).status);
  // Todas cuentan contra la IP real de la conexión, que ya agotó su ventana o lo hará.
  assert.ok(statuses.includes(429));
});
