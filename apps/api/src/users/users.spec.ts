import { after, before, test } from 'node:test';
import assert from 'node:assert/strict';
import { type Api, startApi } from '../testing/harness.ts';

let api: Api;
before(async () => {
  api = await startApi();
});
after(() => api.close());

test('cambiar nombre y teléfono normaliza el número', async () => {
  const { accessToken } = await api.signUp();
  const res = await api.call('PATCH', '/v1/yo', {
    token: accessToken,
    body: { name: 'Ana', phone: '0414-123.4567' },
  });
  assert.equal(res.status, 200);
  assert.equal(res.body.name, 'Ana');
  assert.equal(res.body.phone, '+584141234567');
  const bad = await api.call('PATCH', '/v1/yo', {
    token: accessToken,
    body: { phone: '0212 1234567' },
  });
  assert.equal(bad.status, 400);
});

test('pasajeros frecuentes: crear, listar, cambiar y borrar solo los propios', async () => {
  const ana = await api.signUp();
  const luis = await api.signUp();
  const created = await api.call('POST', '/v1/yo/pasajeros', {
    token: ana.accessToken,
    body: { name: 'Sofía', cedula: 'v 12.345.678', birthDate: '2015-04-02' },
  });
  assert.equal(created.status, 201);
  assert.equal(created.body.cedula, 'V-12345678');
  const id = String(created.body.id);

  const list = await api.call<{ items: unknown[] }>('GET', '/v1/yo/pasajeros', {
    token: ana.accessToken,
  });
  assert.equal(list.body.items.length, 1);

  const foreign = await api.call('PUT', `/v1/yo/pasajeros/${id}`, {
    token: luis.accessToken,
    body: { name: 'Otro', birthDate: '2010-01-01' },
  });
  assert.equal(foreign.status, 404);
  assert.equal(
    (await api.call('DELETE', `/v1/yo/pasajeros/${id}`, { token: luis.accessToken })).status,
    404,
  );

  const updated = await api.call('PUT', `/v1/yo/pasajeros/${id}`, {
    token: ana.accessToken,
    body: { name: 'Sofía R.', birthDate: '2015-04-02', restrictions: 'Alergia al maní' },
  });
  assert.equal(updated.body.restrictions, 'Alergia al maní');
  assert.equal(updated.body.cedula, null);
  assert.equal(
    (await api.call('DELETE', `/v1/yo/pasajeros/${id}`, { token: ana.accessToken })).status,
    204,
  );
});

test('una fecha de nacimiento futura no se acepta', async () => {
  const { accessToken } = await api.signUp();
  const res = await api.call('POST', '/v1/yo/pasajeros', {
    token: accessToken,
    body: { name: 'Futuro', birthDate: '2999-01-01' },
  });
  assert.equal(res.status, 400);
});
