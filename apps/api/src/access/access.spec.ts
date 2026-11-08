import { after, before, test } from 'node:test';
import assert from 'node:assert/strict';
import { type Api, type Session, startApi, uniqueEmail } from '../testing/harness.ts';

let api: Api;
before(async () => {
  api = await startApi();
});
after(() => api.close());

/** Agencia nueva con `owner` como dueño. (El alta de agencias llega en la Fase 2.) */
async function agency(owner: Session): Promise<string> {
  const provider = await api.db.provider.create({ data: { name: 'Viajes Prueba' } });
  await api.db.providerMember.create({
    data: { providerId: provider.id, userId: owner.user.id, role: 'owner' },
  });
  return provider.id;
}

test('el dueño gestiona el equipo; cada cambio queda auditado', async () => {
  const owner = await api.signUp();
  const providerId = await agency(owner);
  const guideEmail = uniqueEmail('guia');

  const added = await api.call('POST', `/v1/pro/${providerId}/equipo`, {
    token: owner.accessToken,
    body: { email: guideEmail, role: 'guide' },
  });
  assert.equal(added.status, 201);
  const memberId = String(added.body.id);

  const dup = await api.call('POST', `/v1/pro/${providerId}/equipo`, {
    token: owner.accessToken,
    body: { email: guideEmail, role: 'finance' },
  });
  assert.equal(dup.status, 409);

  const changed = await api.call('PATCH', `/v1/pro/${providerId}/equipo/${memberId}`, {
    token: owner.accessToken,
    body: { role: 'operations' },
  });
  assert.equal(changed.status, 200);
  assert.equal(changed.body.role, 'operations');

  const audit = await api.call<{ items: { action: string; before: unknown }[] }>(
    'GET',
    `/v1/pro/${providerId}/auditoria`,
    { token: owner.accessToken },
  );
  assert.deepEqual(
    audit.body.items.map((i) => i.action),
    ['PATCH /v1/pro/:providerId/equipo/:memberId', 'POST /v1/pro/:providerId/equipo'],
  );
  assert.equal((audit.body.items[0]?.before as { role: string }).role, 'guide');
});

test('la persona sumada sin cuenta ve la agencia al registrarse con ese correo', async () => {
  const owner = await api.signUp();
  const providerId = await agency(owner);
  const email = uniqueEmail('nuevo');
  await api.call('POST', `/v1/pro/${providerId}/equipo`, {
    token: owner.accessToken,
    body: { email, role: 'finance' },
  });
  const newcomer = await api.signUp(email);
  const me = await api.call<{
    memberships: { providerId: string; role: string; permissions: string[] }[];
  }>('GET', '/v1/yo', { token: newcomer.accessToken });
  assert.equal(me.body.memberships[0]?.providerId, providerId);
  assert.deepEqual(me.body.memberships[0]?.permissions, ['payments', 'settlements', 'reports']);
});

test('una agencia ajena responde 404 y un rol sin permiso, 403', async () => {
  const owner = await api.signUp();
  const providerId = await agency(owner);
  const stranger = await api.signUp();
  assert.equal(
    (await api.call('GET', `/v1/pro/${providerId}/equipo`, { token: stranger.accessToken })).status,
    404,
  );
  assert.equal(
    (await api.call('GET', '/v1/pro/no-es-uuid/equipo', { token: owner.accessToken })).status,
    404,
  );

  const guide = await api.signUp();
  await api.db.providerMember.create({
    data: { providerId, userId: guide.user.id, role: 'guide' },
  });
  assert.equal(
    (await api.call('GET', `/v1/pro/${providerId}/equipo`, { token: guide.accessToken })).status,
    403,
  );
});

test('un miembro de otra agencia no alcanza los miembros de esta', async () => {
  const ownerA = await api.signUp();
  const agencyA = await agency(ownerA);
  const ownerB = await api.signUp();
  const agencyB = await agency(ownerB);
  const listB = await api.call<{ items: { id: string }[] }>('GET', `/v1/pro/${agencyB}/equipo`, {
    token: ownerB.accessToken,
  });
  const memberOfB = listB.body.items[0]?.id;
  // A intenta cambiar un miembro de B usando su propia agencia en la URL.
  const res = await api.call('PATCH', `/v1/pro/${agencyA}/equipo/${memberOfB}`, {
    token: ownerA.accessToken,
    body: { role: 'guide' },
  });
  assert.equal(res.status, 404);
});

test('la agencia no se queda sin dueño', async () => {
  const owner = await api.signUp();
  const providerId = await agency(owner);
  const list = await api.call<{ items: { id: string }[] }>('GET', `/v1/pro/${providerId}/equipo`, {
    token: owner.accessToken,
  });
  const self = String(list.body.items[0]?.id);
  const demote = await api.call('PATCH', `/v1/pro/${providerId}/equipo/${self}`, {
    token: owner.accessToken,
    body: { role: 'guide' },
  });
  assert.equal(demote.status, 409);
  assert.equal(
    (await api.call('DELETE', `/v1/pro/${providerId}/equipo/${self}`, { token: owner.accessToken }))
      .status,
    409,
  );

  // Un fallo no deja fila de auditoría: la acción y su registro se deshacen juntos.
  const audit = await api.db.auditLog.count({ where: { providerId } });
  assert.equal(audit, 0);
});

test('Central: solo super gestiona el equipo y nunca queda sin super', async () => {
  const boss = await api.signUp();
  await api.db.staffMember.create({ data: { userId: boss.user.id, role: 'super' } });
  // Si quedaron supers de otras corridas, el último super es otro: se limpia para la prueba.
  await api.db.staffMember.deleteMany({ where: { role: 'super', userId: { not: boss.user.id } } });

  const support = await api.signUp();
  const set = await api.call('PUT', '/v1/central/equipo', {
    token: boss.accessToken,
    body: { email: support.user.email, roles: ['support', 'finance'] },
  });
  assert.equal(set.status, 200);
  assert.deepEqual(set.body.roles, ['support', 'finance']);

  assert.equal(
    (await api.call('GET', '/v1/central/equipo', { token: support.accessToken })).status,
    403,
  );
  assert.equal(
    (await api.call('GET', '/v1/central/auditoria', { token: support.accessToken })).status,
    403,
  );

  const selfDemote = await api.call('PUT', '/v1/central/equipo', {
    token: boss.accessToken,
    body: { email: boss.user.email, roles: ['support'] },
  });
  assert.equal(selfDemote.status, 409);

  const audit = await api.call<{ items: { action: string }[] }>('GET', '/v1/central/auditoria', {
    token: boss.accessToken,
  });
  assert.equal(audit.status, 200);
  assert.equal(audit.body.items[0]?.action, 'PUT /v1/central/equipo');
});

test('una persona sin roles de Central no entra a /v1/central', async () => {
  const someone = await api.signUp();
  assert.equal(
    (await api.call('GET', '/v1/central/equipo', { token: someone.accessToken })).status,
    403,
  );
});
