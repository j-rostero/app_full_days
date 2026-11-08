import { after, before, test } from 'node:test';
import assert from 'node:assert/strict';
import { exampleSheet, todayInVenezuela, type ProductSheet } from '@fulldays/shared';
import { MemoryStorage, STORAGE } from '../files/storage.ts';
import { type Api, createProvider, randomRif, type Session, startApi } from '../testing/harness.ts';

let api: Api;
let boss: Session;
let storage: MemoryStorage;

before(async () => {
  api = await startApi();
  storage = api.app.get(STORAGE);
  boss = await api.signUp();
  await api.db.staffMember.create({ data: { userId: boss.user.id, role: 'super' } });
});
after(() => api.close());

type Json = Record<string, any>; // eslint-disable-line @typescript-eslint/no-explicit-any

/** Declara, "sube" y confirma un archivo. */
async function upload(
  token: string,
  kind: 'image' | 'document',
  contentType = kind === 'image' ? 'image/jpeg' : 'application/pdf',
): Promise<string> {
  const declared = await api.call<Json>('POST', '/v1/archivos', {
    token,
    body: { kind, contentType, size: 1234 },
  });
  assert.equal(declared.status, 201, JSON.stringify(declared.body));
  const key = String(declared.body.upload.url).split('/').pop()!;
  storage.put(kind === 'image' ? 'images' : 'documents', key, { size: 1234, contentType });
  const confirmed = await api.call<Json>(
    'POST',
    `/v1/archivos/${declared.body.file.id}/confirmar`,
    { token },
  );
  assert.equal(confirmed.status, 200);
  return String(declared.body.file.id);
}

async function destination(): Promise<string> {
  const slug = `destino-${crypto.randomUUID().slice(0, 8)}`;
  const res = await api.call<Json>('POST', '/v1/central/catalogos/destinos', {
    token: boss.accessToken,
    body: { slug, name: 'Morrocoy' },
  });
  assert.equal(res.status, 201, JSON.stringify(res.body));
  return String(res.body.id);
}

async function sheet(token: string, type: 'fullday' | 'tour' | 'excursion'): Promise<ProductSheet> {
  const photoIds: string[] = [];
  for (let i = 0; i < 5; i++) photoIds.push(await upload(token, 'image'));
  return exampleSheet(type, { destinationId: await destination(), photoIds });
}

const future = (days: number) =>
  new Date(Date.parse(`${todayInVenezuela()}T00:00:00Z`) + days * 86_400_000)
    .toISOString()
    .slice(0, 10);

test('una agencia se registra, envía sus documentos y Central la aprueba', async () => {
  const owner = await api.signUp();
  const rif = randomRif();
  const created = await api.call<Json>('POST', '/v1/proveedores', {
    token: owner.accessToken,
    body: {
      kind: 'company',
      name: 'Sol y Playa',
      legalName: 'Sol y Playa C.A.',
      rif: rif.toLowerCase().replaceAll('-', ''),
      baseCity: 'Caracas',
      phone: '0414 1234567',
      instagram: '@solyplaya',
    },
  });
  assert.equal(created.status, 201, JSON.stringify(created.body));
  assert.equal(created.body.rif, rif);
  assert.equal(created.body.instagram, 'solyplaya');
  assert.deepEqual(created.body.missingDocuments, ['rif', 'representative_id']);
  const id = String(created.body.id);

  const dup = await api.call('POST', '/v1/proveedores', {
    token: owner.accessToken,
    body: {
      kind: 'person',
      name: 'Otra',
      legalName: 'Otra',
      rif,
      baseCity: 'Caracas',
      phone: '04141234567',
    },
  });
  assert.equal(dup.status, 409);

  const early = await api.call<Json>('POST', `/v1/pro/${id}/empresa/enviar`, {
    token: owner.accessToken,
  });
  assert.equal(early.status, 409);
  assert.match(early.body.message, /Faltan documentos: RIF, Cédula del representante/);

  for (const type of ['rif', 'representative_id']) {
    const fileId = await upload(owner.accessToken, 'document');
    const doc = await api.call('POST', `/v1/pro/${id}/documentos`, {
      token: owner.accessToken,
      body: { type, fileId },
    });
    assert.equal(doc.status, 201);
  }
  const docs = await api.call<Json>('GET', `/v1/pro/${id}/documentos`, {
    token: owner.accessToken,
  });
  assert.equal(docs.body.items.length, 2);

  const sent = await api.call<Json>('POST', `/v1/pro/${id}/empresa/enviar`, {
    token: owner.accessToken,
  });
  assert.equal(sent.body.status, 'in_review');
  const locked = await api.call('PATCH', `/v1/pro/${id}/empresa`, {
    token: owner.accessToken,
    body: { name: 'Cambio' },
  });
  assert.equal(locked.status, 409);

  const queue = await api.call<Json>('GET', '/v1/central/proveedores', { token: boss.accessToken });
  assert.ok(queue.body.items.some((p: Json) => p.id === id));
  const review = await api.call<Json>('GET', `/v1/central/proveedores/${id}`, {
    token: boss.accessToken,
  });
  assert.equal(review.body.owners[0].id, owner.user.id);

  const approved = await api.call<Json>('POST', `/v1/central/proveedores/${id}/aprobar`, {
    token: boss.accessToken,
  });
  assert.equal(approved.body.status, 'approved');
  assert.equal(approved.body.badge, 'new');
  const twice = await api.call('POST', `/v1/central/proveedores/${id}/rechazar`, {
    token: boss.accessToken,
    body: { reason: 'Documentos ilegibles' },
  });
  assert.equal(twice.status, 409);

  const me = await api.call<Json>('GET', '/v1/yo', { token: owner.accessToken });
  assert.equal(me.body.memberships[0].providerStatus, 'approved');
});

test('un archivo que no coincide con lo declarado se descarta', async () => {
  const someone = await api.signUp();
  const declared = await api.call<Json>('POST', '/v1/archivos', {
    token: someone.accessToken,
    body: { kind: 'image', contentType: 'image/png', size: 500 },
  });
  const key = String(declared.body.upload.url).split('/').pop()!;
  storage.put('images', key, { size: 9999, contentType: 'image/png' });
  const res = await api.call('POST', `/v1/archivos/${declared.body.file.id}/confirmar`, {
    token: someone.accessToken,
  });
  assert.equal(res.status, 409);
  assert.equal(
    (await api.call('GET', `/v1/archivos/${declared.body.file.id}`, { token: someone.accessToken }))
      .status,
    404,
  );
  const svg = await api.call('POST', '/v1/archivos', {
    token: someone.accessToken,
    body: { kind: 'image', contentType: 'image/svg+xml', size: 10 },
  });
  assert.equal(svg.status, 400);
});

test('sin RTN la ficha pasa por Central; con RTN se publica directo', async () => {
  const owner = await api.signUp();
  const providerId = await createProvider(api.db, owner.user.id, { status: 'approved' });
  const base = `/v1/pro/${providerId}/productos`;

  const draft = await api.call<Json>('POST', base, {
    token: owner.accessToken,
    body: { type: 'fullday' },
  });
  assert.equal(draft.status, 201);
  assert.equal(draft.body.completeness.publishable, false);
  const blocked = await api.call<Json>('POST', `${base}/${draft.body.id}/publicar`, {
    token: owner.accessToken,
  });
  assert.equal(blocked.status, 409);
  assert.match(blocked.body.message, /^Faltan datos para publicar/);

  const full = await sheet(owner.accessToken, 'fullday');
  const saved = await api.call<Json>('PUT', `${base}/${draft.body.id}`, {
    token: owner.accessToken,
    body: { version: 1, sheet: full },
  });
  assert.equal(saved.status, 200, JSON.stringify(saved.body));
  assert.equal(saved.body.version, 2);
  assert.equal(saved.body.completeness.percent, 100);
  assert.equal(saved.body.photos.length, 5);

  const stale = await api.call('PUT', `${base}/${draft.body.id}`, {
    token: owner.accessToken,
    body: { version: 1, sheet: full },
  });
  assert.equal(stale.status, 409);

  const published = await api.call<Json>('POST', `${base}/${draft.body.id}/publicar`, {
    token: owner.accessToken,
  });
  assert.equal(published.body.status, 'in_review');
  const queue = await api.call<Json>('GET', '/v1/central/productos', { token: boss.accessToken });
  assert.ok(queue.body.items.some((p: Json) => p.id === draft.body.id));
  const approved = await api.call<Json>('POST', `/v1/central/productos/${draft.body.id}/aprobar`, {
    token: boss.accessToken,
  });
  assert.equal(approved.body.status, 'published');

  await api.db.provider.update({ where: { id: providerId }, data: { rtn: 'RTN-123' } });
  const tour = await api.call<Json>('POST', base, {
    token: owner.accessToken,
    body: { type: 'tour', sheet: await sheet(owner.accessToken, 'tour') },
  });
  assert.equal(tour.status, 201, JSON.stringify(tour.body));
  const direct = await api.call<Json>('POST', `${base}/${tour.body.id}/publicar`, {
    token: owner.accessToken,
  });
  assert.equal(direct.body.status, 'published');

  // Publicado, no admite contactos ni quedar incompleto.
  const withPhone = structuredClone(tour.body.sheet);
  withPhone.general.description += ' Reserva por el 0414-1234567.';
  const phone = await api.call('PUT', `${base}/${tour.body.id}`, {
    token: owner.accessToken,
    body: { version: tour.body.version, sheet: withPhone },
  });
  assert.equal(phone.status, 409);
});

test('Central devuelve una ficha con contactos; la próxima publicación vuelve a revisión', async () => {
  const owner = await api.signUp();
  const providerId = await createProvider(api.db, owner.user.id, {
    status: 'approved',
    rtn: 'RTN-9',
  });
  const full = await sheet(owner.accessToken, 'excursion');
  full.general.description += ' Escríbenos a wa.me/584141234567';
  const created = await api.call<Json>('POST', `/v1/pro/${providerId}/productos`, {
    token: owner.accessToken,
    body: { type: 'excursion', sheet: full },
  });
  const id = String(created.body.id);
  const sent = await api.call<Json>('POST', `/v1/pro/${providerId}/productos/${id}/publicar`, {
    token: owner.accessToken,
  });
  assert.equal(sent.body.status, 'in_review');

  const review = await api.call<Json>('GET', `/v1/central/productos/${id}`, {
    token: boss.accessToken,
  });
  assert.deepEqual(review.body.contacts, ['wa.me/584141234567']);
  const returned = await api.call<Json>('POST', `/v1/central/productos/${id}/devolver`, {
    token: boss.accessToken,
    body: { reason: 'Quita el enlace de WhatsApp.' },
  });
  assert.equal(returned.body.status, 'draft');
  assert.equal(returned.body.statusReason, 'Quita el enlace de WhatsApp.');

  const clean = structuredClone(returned.body.sheet);
  clean.general.description = clean.general.description.replace(/ Escríbenos.*$/, '');
  await api.call('PUT', `/v1/pro/${providerId}/productos/${id}`, {
    token: owner.accessToken,
    body: { version: returned.body.version, sheet: clean },
  });
  const again = await api.call<Json>('POST', `/v1/pro/${providerId}/productos/${id}/publicar`, {
    token: owner.accessToken,
  });
  assert.equal(again.body.status, 'in_review');
});

test('salidas: programar, reglas de cupo y estado, guías y ficha al día', async () => {
  const owner = await api.signUp();
  const providerId = await createProvider(api.db, owner.user.id, {
    status: 'approved',
    rtn: 'RTN-1',
  });
  const pro = `/v1/pro/${providerId}`;
  const product = await api.call<Json>('POST', `${pro}/productos`, {
    token: owner.accessToken,
    body: { type: 'fullday', sheet: await sheet(owner.accessToken, 'fullday') },
  });
  const productId = String(product.body.id);

  const notYet = await api.call('POST', `${pro}/salidas`, {
    token: owner.accessToken,
    body: { productId, dates: [future(7)], capacity: 20 },
  });
  assert.equal(notYet.status, 409);
  await api.call('POST', `${pro}/productos/${productId}/publicar`, { token: owner.accessToken });

  const scheduled = await api.call<Json>('POST', `${pro}/salidas`, {
    token: owner.accessToken,
    body: { productId, dates: [future(7), future(14)], capacity: 20, minCapacity: 8 },
  });
  assert.equal(scheduled.status, 201, JSON.stringify(scheduled.body));
  assert.equal(scheduled.body.items.length, 2);
  assert.equal(scheduled.body.items[0].priceUsd, 45);
  const departureId = String(scheduled.body.items[0].id);

  assert.equal(
    (
      await api.call('POST', `${pro}/salidas`, {
        token: owner.accessToken,
        body: { productId, dates: [future(7)], capacity: 20 },
      })
    ).status,
    409,
  );
  assert.equal(
    (
      await api.call('POST', `${pro}/salidas`, {
        token: owner.accessToken,
        body: { productId, dates: [future(-2)], capacity: 20 },
      })
    ).status,
    409,
  );

  const row = await api.db.departure.findUniqueOrThrow({ where: { id: departureId } });
  assert.deepEqual(row.cities, ['caracas', 'maracay']);
  assert.ok(row.includes.includes('transfer'));
  assert.match(row.searchText, /morrocoy/);

  await api.db.departure.update({ where: { id: departureId }, data: { reserved: 12 } });
  const tooSmall = await api.call('PATCH', `${pro}/salidas/${departureId}`, {
    token: owner.accessToken,
    body: { capacity: 10 },
  });
  assert.equal(tooSmall.status, 409);
  const finished = await api.call('PATCH', `${pro}/salidas/${departureId}`, {
    token: owner.accessToken,
    body: { status: 'finished' },
  });
  assert.equal(finished.status, 409);
  const stranger = await api.signUp();
  const badGuide = await api.call('PATCH', `${pro}/salidas/${departureId}`, {
    token: owner.accessToken,
    body: { guideIds: [stranger.user.id] },
  });
  assert.equal(badGuide.status, 400);
  const ok = await api.call<Json>('PATCH', `${pro}/salidas/${departureId}`, {
    token: owner.accessToken,
    body: { capacity: 30, adultPriceUsd: 50, status: 'closed', guideIds: [owner.user.id] },
  });
  assert.equal(ok.status, 200, JSON.stringify(ok.body));
  assert.equal(ok.body.seatsLeft, 18);
  assert.equal(ok.body.priceUsd, 50);
  assert.equal(ok.body.guides[0].id, owner.user.id);

  // Cambiar la ficha actualiza solo la salida sin reservas.
  const current = await api.call<Json>('GET', `${pro}/productos/${productId}`, {
    token: owner.accessToken,
  });
  const changed = structuredClone(current.body.sheet);
  changed.general.title = 'Fullday a Cayo Sombrero renovado';
  changed.pricing.fares.adult = 60;
  await api.call('PUT', `${pro}/productos/${productId}`, {
    token: owner.accessToken,
    body: { version: current.body.version, sheet: changed },
  });
  const list = await api.call<Json>('GET', `${pro}/salidas?productId=${productId}`, {
    token: owner.accessToken,
  });
  const [sold, unsold] = list.body.items;
  assert.equal(sold.title, 'Fullday a Cayo Sombrero');
  assert.equal(unsold.title, 'Fullday a Cayo Sombrero renovado');
  assert.equal(unsold.priceUsd, 60);

  // Otra agencia no alcanza ni el producto ni la salida.
  const otherOwner = await api.signUp();
  const other = await createProvider(api.db, otherOwner.user.id, { status: 'approved' });
  assert.equal(
    (
      await api.call('GET', `/v1/pro/${other}/productos/${productId}`, {
        token: otherOwner.accessToken,
      })
    ).status,
    404,
  );
  assert.equal(
    (
      await api.call('PATCH', `/v1/pro/${other}/salidas/${departureId}`, {
        token: otherOwner.accessToken,
        body: { capacity: 99 },
      })
    ).status,
    404,
  );
});

test('tasa del día, ajustes, temáticas y portada', async () => {
  const date = '2026-01-15';
  const set = await api.call<Json>('PUT', '/v1/central/tasas', {
    token: boss.accessToken,
    body: { date, bsPerUsd: 120.5 },
  });
  assert.equal(set.status, 200);
  const rate = await api.call<Json>('GET', '/v1/tasa');
  assert.equal(rate.status, 200);
  assert.ok(rate.body.date >= date);

  const settings = await api.call<Json>('GET', '/v1/ajustes');
  assert.ok(settings.body.holdMinutes >= 5);
  const bad = await api.call('PUT', '/v1/central/ajustes', {
    token: boss.accessToken,
    body: { ...settings.body, paymentMethods: [] },
  });
  assert.equal(bad.status, 400);
  const saved = await api.call<Json>('PUT', '/v1/central/ajustes', {
    token: boss.accessToken,
    body: { ...settings.body, holdMinutes: 45 },
  });
  assert.equal(saved.body.holdMinutes, 45);

  const theme = await api.call<Json>('POST', '/v1/central/tematicas', {
    token: boss.accessToken,
    body: { slug: `playas-${crypto.randomUUID().slice(0, 6)}`, name: 'Playas' },
  });
  assert.equal(theme.status, 201);
  const dupSlug = await api.call('POST', '/v1/central/tematicas', {
    token: boss.accessToken,
    body: { slug: theme.body.slug, name: 'Otra' },
  });
  assert.equal(dupSlug.status, 409);

  const owner = await api.signUp();
  const providerId = await createProvider(api.db, owner.user.id, { status: 'approved' });
  const product = await api.call<Json>('POST', `/v1/pro/${providerId}/productos`, {
    token: owner.accessToken,
    body: { type: 'fullday' },
  });
  const curated = await api.call<Json>('PUT', `/v1/central/productos/${product.body.id}/portada`, {
    token: boss.accessToken,
    body: { featured: true, themeIds: [theme.body.id] },
  });
  assert.equal(curated.status, 200);
  assert.equal(curated.body.featured, true);
  assert.deepEqual(curated.body.themeIds, [theme.body.id]);

  const site = await api.call<Json>('POST', '/v1/central/catalogos/destinos', {
    token: boss.accessToken,
    body: {
      slug: `sitio-${crypto.randomUUID().slice(0, 6)}`,
      name: 'Sitio',
      parentId: await destination(),
    },
  });
  assert.equal(site.status, 201);
  const nested = await api.call('POST', '/v1/central/catalogos/destinos', {
    token: boss.accessToken,
    body: {
      slug: `nieto-${crypto.randomUUID().slice(0, 6)}`,
      name: 'Nieto',
      parentId: site.body.id,
    },
  });
  assert.equal(nested.status, 409);
  const destinations = await api.call<Json>('GET', '/v1/catalogos/destinos');
  assert.ok(
    destinations.body.items.some((d: Json) => d.sites.some((s: Json) => s.id === site.body.id)),
  );

  const audit = await api.call<Json>('GET', '/v1/central/auditoria', { token: boss.accessToken });
  assert.ok(
    audit.body.items.some((e: Json) => e.action === 'PUT /v1/central/productos/:id/portada'),
  );
});
