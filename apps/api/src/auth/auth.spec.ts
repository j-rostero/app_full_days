import { after, before, test } from 'node:test';
import assert from 'node:assert/strict';
import { exportJWK, generateKeyPair, SignJWT, createLocalJWKSet } from 'jose';
import {
  type Api,
  CODE,
  PASSWORD,
  type Session,
  startApi,
  uniqueEmail,
} from '../testing/harness.ts';
import { GoogleVerifier } from './google.ts';

const GOOGLE_CLIENT = 'cliente-de-prueba.apps.googleusercontent.com';
let api: Api;
let signGoogle: (claims: Record<string, unknown>) => Promise<string>;

before(async () => {
  api = await startApi({ GOOGLE_CLIENT_IDS: GOOGLE_CLIENT });
  // Claves propias en lugar de las de Google.
  const { publicKey, privateKey } = await generateKeyPair('RS256');
  const jwk = { ...(await exportJWK(publicKey)), kid: 'prueba', alg: 'RS256' };
  Object.assign(api.app.get(GoogleVerifier), { keys: createLocalJWKSet({ keys: [jwk] }) });
  signGoogle = (claims) =>
    new SignJWT(claims)
      .setProtectedHeader({ alg: 'RS256', kid: 'prueba' })
      .setIssuer('https://accounts.google.com')
      .setAudience(GOOGLE_CLIENT)
      .setIssuedAt()
      .setExpirationTime('5m')
      .sign(privateKey);
});

after(() => api.close());

test('registrar, confirmar con el código y usar la sesión', async () => {
  const email = uniqueEmail();
  const reg = await api.call('POST', '/v1/auth/registrar', {
    body: { email: email.toUpperCase(), password: PASSWORD },
  });
  assert.equal(reg.status, 204);

  const wrong = await api.call('POST', '/v1/auth/verificar', { body: { email, code: '000000' } });
  assert.equal(wrong.status, 401);

  const ok = await api.call<Session>('POST', '/v1/auth/verificar', { body: { email, code: CODE } });
  assert.equal(ok.status, 200);
  assert.equal(ok.body.user.email, email);

  const me = await api.call('GET', '/v1/yo', { token: ok.body.accessToken });
  assert.equal(me.status, 200);
  assert.equal(me.body.email, email);
  assert.equal(me.body.hasPassword, true);
});

test('el correo ya confirmado no se puede registrar de nuevo', async () => {
  const session = await api.signUp();
  const again = await api.call('POST', '/v1/auth/registrar', {
    body: { email: session.user.email, password: PASSWORD },
  });
  assert.equal(again.status, 409);
});

test('una cuenta sin confirmar no entra y recibe un código nuevo', async () => {
  const email = uniqueEmail();
  await api.call('POST', '/v1/auth/registrar', { body: { email, password: PASSWORD } });
  const res = await api.call('POST', '/v1/auth/entrar', { body: { email, password: PASSWORD } });
  assert.equal(res.status, 403);
  assert.equal(res.body.code, 'email_not_verified');
});

test('entrar con contraseña; la equivocada responde 401 sin decir cuál falló', async () => {
  const { user } = await api.signUp();
  const bad = await api.call('POST', '/v1/auth/entrar', {
    body: { email: user.email, password: 'otra-clave-1' },
  });
  assert.equal(bad.status, 401);
  const unknown = await api.call('POST', '/v1/auth/entrar', {
    body: { email: uniqueEmail(), password: PASSWORD },
  });
  assert.equal(unknown.status, 401);
  assert.equal(unknown.body.message, bad.body.message);
  const ok = await api.call<Session>('POST', '/v1/auth/entrar', {
    body: { email: user.email, password: PASSWORD },
  });
  assert.equal(ok.status, 200);
});

test('tras 10 contraseñas equivocadas el correo queda frenado', async () => {
  const { user } = await api.signUp();
  for (let i = 0; i < 10; i++) {
    await api.call('POST', '/v1/auth/entrar', {
      body: { email: user.email, password: 'otra-clave-1' },
    });
  }
  const res = await api.call('POST', '/v1/auth/entrar', {
    body: { email: user.email, password: PASSWORD },
  });
  assert.equal(res.status, 429);
});

test('sin token, un endpoint con sesión responde 401', async () => {
  assert.equal((await api.call('GET', '/v1/yo')).status, 401);
  assert.equal((await api.call('GET', '/v1/yo', { token: 'basura' })).status, 401);
});

test('renovar rota el token; repetir enseguida devuelve el mismo; uno viejo cierra la sesión', async () => {
  const session = await api.signUp();
  const first = await api.call<Session>('POST', '/v1/auth/renovar', {
    body: { refreshToken: session.refreshToken },
  });
  assert.equal(first.status, 200);
  assert.notEqual(first.body.refreshToken, session.refreshToken);

  // Respuesta perdida: el mismo token dentro de la ventana obtiene el mismo sucesor.
  const retry = await api.call<Session>('POST', '/v1/auth/renovar', {
    body: { refreshToken: session.refreshToken },
  });
  assert.equal(retry.status, 200);
  assert.equal(retry.body.refreshToken, first.body.refreshToken);

  const second = await api.call<Session>('POST', '/v1/auth/renovar', {
    body: { refreshToken: first.body.refreshToken },
  });
  assert.equal(second.status, 200);

  // El primero ya fue reemplazado dos veces: alguien tiene una copia. Se cierra todo.
  const stolen = await api.call('POST', '/v1/auth/renovar', {
    body: { refreshToken: session.refreshToken },
  });
  assert.equal(stolen.status, 401);
  const after = await api.call('POST', '/v1/auth/renovar', {
    body: { refreshToken: second.body.refreshToken },
  });
  assert.equal(after.status, 401);
  assert.equal((await api.call('GET', '/v1/yo', { token: second.body.accessToken })).status, 401);
});

test('salir corta el token de acceso al instante', async () => {
  const session = await api.signUp();
  assert.equal(
    (await api.call('POST', '/v1/auth/salir', { token: session.accessToken })).status,
    204,
  );
  assert.equal((await api.call('GET', '/v1/yo', { token: session.accessToken })).status, 401);
  const renew = await api.call('POST', '/v1/auth/renovar', {
    body: { refreshToken: session.refreshToken },
  });
  assert.equal(renew.status, 401);
});

test('salir de todos cierra las sesiones de cada dispositivo', async () => {
  const phone = await api.signUp();
  const laptop = await api.call<Session>('POST', '/v1/auth/entrar', {
    body: { email: phone.user.email, password: PASSWORD },
  });
  assert.equal(
    (await api.call('POST', '/v1/auth/salir-de-todos', { token: laptop.body.accessToken })).status,
    204,
  );
  assert.equal((await api.call('GET', '/v1/yo', { token: phone.accessToken })).status, 401);
  assert.equal((await api.call('GET', '/v1/yo', { token: laptop.body.accessToken })).status, 401);
});

test('recuperar responde igual exista o no la cuenta; restablecer cierra las demás sesiones', async () => {
  const old = await api.signUp();
  assert.equal(
    (await api.call('POST', '/v1/auth/recuperar', { body: { email: uniqueEmail() } })).status,
    204,
  );
  assert.equal(
    (await api.call('POST', '/v1/auth/recuperar', { body: { email: old.user.email } })).status,
    204,
  );
  const reset = await api.call<Session>('POST', '/v1/auth/restablecer', {
    body: { email: old.user.email, code: CODE, password: 'clave-nueva-2' },
  });
  assert.equal(reset.status, 200);
  assert.equal((await api.call('GET', '/v1/yo', { token: old.accessToken })).status, 401);
  assert.equal((await api.call('GET', '/v1/yo', { token: reset.body.accessToken })).status, 200);
  const withNew = await api.call('POST', '/v1/auth/entrar', {
    body: { email: old.user.email, password: 'clave-nueva-2' },
  });
  assert.equal(withNew.status, 200);
});

test('Google crea la cuenta la primera vez y la reconoce después', async () => {
  const email = uniqueEmail('google');
  const token = await signGoogle({
    sub: `g-${email}`,
    email,
    email_verified: true,
    name: 'Ana Pérez',
  });
  const first = await api.call<Session>('POST', '/v1/auth/google', { body: { idToken: token } });
  assert.equal(first.status, 200);
  assert.equal(first.body.user.name, 'Ana Pérez');
  const second = await api.call<Session>('POST', '/v1/auth/google', { body: { idToken: token } });
  assert.equal(second.body.user.id, first.body.user.id);
});

test('Google sobre un correo registrado sin confirmar anula esa contraseña', async () => {
  const email = uniqueEmail('google');
  await api.call('POST', '/v1/auth/registrar', { body: { email, password: PASSWORD } });
  const token = await signGoogle({ sub: `g-${email}`, email, email_verified: true });
  assert.equal(
    (await api.call('POST', '/v1/auth/google', { body: { idToken: token } })).status,
    200,
  );
  const withPassword = await api.call('POST', '/v1/auth/entrar', {
    body: { email, password: PASSWORD },
  });
  assert.equal(withPassword.status, 401);
});

test('Google rechaza un correo sin confirmar o un token de otra aplicación', async () => {
  const email = uniqueEmail('google');
  const unverified = await signGoogle({ sub: `g-${email}`, email, email_verified: false });
  assert.equal(
    (await api.call('POST', '/v1/auth/google', { body: { idToken: unverified } })).status,
    401,
  );
  const forged = await api.call('POST', '/v1/auth/google', { body: { idToken: 'x'.repeat(40) } });
  assert.equal(forged.status, 401);
});

test('un cuerpo con campos de más responde 400 validation_error', async () => {
  const res = await api.call('POST', '/v1/auth/registrar', {
    body: { email: uniqueEmail(), password: PASSWORD, admin: true },
  });
  assert.equal(res.status, 400);
  assert.equal(res.body.code, 'validation_error');
});
