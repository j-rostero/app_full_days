import { test } from 'node:test';
import assert from 'node:assert/strict';
import { generateKeyPairSync } from 'node:crypto';
import { FcmPushSender } from './senders.ts';

const { privateKey } = generateKeyPairSync('rsa', { modulusLength: 2048 });
const account = {
  project_id: 'fulldays-prueba',
  client_email: 'push@fulldays-prueba.iam.gserviceaccount.com',
  private_key: privateKey.export({ type: 'pkcs8', format: 'pem' }).toString(),
};

/** FCM falso: cambia el JWT por un token y responde por token según `answers`. */
function fakeFcm(answers: Record<string, number>) {
  const calls: { url: string; body: string; auth: string | null }[] = [];
  const fetcher = (async (url: string, init: RequestInit) => {
    const body = String(init.body);
    calls.push({ url, body, auth: new Headers(init.headers).get('authorization') });
    if (url.includes('oauth2'))
      return Response.json({ access_token: 'ya29.prueba', expires_in: 3600 });
    const token = (JSON.parse(body) as { message: { token: string } }).message.token;
    return new Response('{}', { status: answers[token] ?? 200 });
  }) as typeof fetch;
  return { calls, fetcher };
}

test('FCM: firma la cuenta de servicio, envía por token y aparta los tokens inválidos', async () => {
  const { calls, fetcher } = fakeFcm({ viejo: 404 });
  const push = new FcmPushSender(Buffer.from(JSON.stringify(account)).toString('base64'), fetcher);
  const result = await push.send(['android', 'ios', 'viejo'], {
    title: 'Pago confirmado',
    body: 'Tu reserva está lista.',
    link: 'reserva:1',
  });
  assert.deepEqual(result, { delivered: 2, invalidTokens: ['viejo'] });
  const [oauth, ...sends] = calls;
  assert.match(oauth!.url, /oauth2\.googleapis\.com\/token/);
  assert.match(oauth!.body, /assertion=ey/);
  assert.equal(sends.length, 3);
  assert.ok(sends.every((c) => c.url.endsWith('/projects/fulldays-prueba/messages:send')));
  assert.ok(sends.every((c) => c.auth === 'Bearer ya29.prueba'));
  const message = JSON.parse(sends[0]!.body).message;
  assert.deepEqual(message.data, { link: 'reserva:1' });
  assert.equal(message.notification.title, 'Pago confirmado');

  // El token de acceso se reutiliza mientras no venza.
  await push.send(['android'], { title: 'a', body: 'b', link: null });
  assert.equal(calls.filter((c) => c.url.includes('oauth2')).length, 1);
});

test('FCM caído: falla para que la cola reintente', async () => {
  const { fetcher } = fakeFcm({ uno: 503 });
  const push = new FcmPushSender(JSON.stringify(account), fetcher);
  await assert.rejects(push.send(['uno'], { title: 'a', body: 'b', link: null }), /503/);
});
