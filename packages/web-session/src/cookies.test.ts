import { test } from 'node:test';
import assert from 'node:assert/strict';
import { ACCESS_COOKIE, REFRESH_COOKIE, safeNext, sessionCookies } from './cookies.ts';

test('las cookies de sesión son httpOnly y el acceso vence antes que su token', () => {
  const [access, refresh] = sessionCookies(
    { accessToken: 'a', refreshToken: 'r', expiresIn: 900 },
    true,
  );
  assert.equal(access?.name, ACCESS_COOKIE);
  assert.equal(access?.maxAge, 870);
  assert.equal(access?.httpOnly, true);
  assert.equal(access?.secure, true);
  assert.equal(refresh?.name, REFRESH_COOKIE);
  assert.equal(refresh?.sameSite, 'lax');
});

test('siguiente solo admite rutas internas', () => {
  assert.equal(safeNext('/reservas?x=1'), '/reservas?x=1');
  assert.equal(safeNext('https://otro.sitio'), '/');
  assert.equal(safeNext('//otro.sitio'), '/');
  assert.equal(safeNext('/\\otro.sitio'), '/');
  assert.equal(safeNext(undefined, '/inicio'), '/inicio');
});
