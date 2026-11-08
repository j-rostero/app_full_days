import { after, before, test } from 'node:test';
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import { exampleSheet, type ProductSheet, todayInVenezuela } from '@fulldays/shared';
import { BookingsService } from './bookings.service.ts';
import { VOUCHER_SIGNER } from '../payments/payments.module.tokens.ts';
import type { VoucherSigner } from '../payments/vouchers.ts';
import { type Api, createProvider, startApi } from '../testing/harness.ts';

type Json = Record<string, any>; // eslint-disable-line @typescript-eslint/no-explicit-any

let api: Api;
before(async () => {
  api = await startApi();
  const central = await api.signUp();
  const date = new Date('2026-01-01T00:00:00Z');
  await api.db.exchangeRate.upsert({
    where: { date },
    create: { date, bsPerUsd: 100, setById: central.user.id },
    update: {},
  });
});
after(() => api.close());

const future = (days: number) =>
  new Date(Date.parse(`${todayInVenezuela()}T00:00:00Z`) + days * 86_400_000);

/** Agencia aprobada con un fullday publicado y una salida en venta. */
async function departure(
  opts: { capacity?: number; title?: string; sheet?: (s: ProductSheet) => ProductSheet } = {},
) {
  const owner = await api.signUp();
  const providerId = await createProvider(api.db, owner.user.id, {
    status: 'approved',
    name: 'Rutas Prueba',
  });
  const base = exampleSheet('fullday', { destinationId: randomUUID(), photoIds: [] });
  base.general.destinationId = null;
  base.general.title = opts.title ?? `Cayo ${randomUUID().slice(0, 6)}`;
  base.pricing.fares = { adult: 40, child: 30, senior: null, infant: null };
  base.pricing.deposit = { kind: 'percent', value: 50 };
  const sheet = opts.sheet ? opts.sheet(base) : base;
  const product = await api.db.product.create({
    data: { providerId, type: 'fullday', status: 'published', sheet: sheet as never },
  });
  const d = await api.db.departure.create({
    data: {
      providerId,
      productId: product.id,
      date: future(10),
      capacity: opts.capacity ?? 10,
      sheet: sheet as never,
      productType: 'fullday',
      priceUsd: 40,
      cities: ['caracas'],
      searchText: sheet.general.title.toLowerCase(),
    },
  });
  return { owner, providerId, productId: product.id, departureId: d.id, sheet };
}

const selection = (sheet: ProductSheet, adult = 2, child = 0) => ({
  boardingId: sheet.transfer.boardingPoints[0]!.id,
  travelers: { adult, child },
});

async function hold(token: string, departureId: string, sel: object) {
  return api.call<Json>('POST', '/v1/reservas', { token, body: { departureId, selection: sel } });
}

test('la búsqueda encuentra la salida por texto aproximado y la ficha pública la muestra', async () => {
  const title = `Morrocoy Escondido ${randomUUID().slice(0, 4)}`;
  const { productId, departureId } = await departure({ title });
  const found = await api.call<Json>(
    'GET',
    `/v1/salidas?q=${encodeURIComponent('morrocoi escondido')}&orden=cupos`,
  );
  assert.equal(found.status, 200, JSON.stringify(found.body));
  assert.ok(found.body.items.some((i: Json) => i.departureId === departureId));
  const page = await api.call<Json>('GET', `/v1/productos/${productId}`);
  assert.equal(page.status, 200);
  assert.equal(page.body.departures[0].id, departureId);
  assert.equal(page.body.provider.badge, 'new');
  assert.equal((await api.call('GET', `/v1/productos/${randomUUID()}`)).status, 404);
});

test('cotizar coincide con el apartado y los favoritos son idempotentes', async () => {
  const { productId, departureId, sheet } = await departure();
  const traveler = await api.signUp();
  const q = await api.call<Json>('POST', '/v1/reservas/cotizar', {
    body: { departureId, selection: selection(sheet, 2, 1) },
  });
  assert.equal(q.status, 200, JSON.stringify(q.body));
  assert.equal(q.body.totalUsd, 110);
  assert.equal(q.body.depositUsd, 55);
  const held = await hold(traveler.accessToken, departureId, selection(sheet, 2, 1));
  assert.equal(held.status, 201, JSON.stringify(held.body));
  assert.equal(held.body.totalUsd, q.body.totalUsd);
  assert.match(held.body.code, /^FD-/);
  assert.equal(held.body.passengers.length, 3);

  for (let i = 0; i < 2; i++)
    assert.equal(
      (await api.call('PUT', `/v1/yo/favoritos/${productId}`, { token: traveler.accessToken }))
        .status,
      204,
    );
  const favs = await api.call<Json>('GET', '/v1/yo/favoritos', { token: traveler.accessToken });
  assert.deepEqual(
    favs.body.items.map((f: Json) => f.id),
    [productId],
  );
});

test('veinte compradores por los últimos tres puestos: nunca hay sobreventa', async () => {
  const { departureId, sheet } = await departure({ capacity: 3 });
  const buyers = await Promise.all(Array.from({ length: 20 }, () => api.signUp()));
  const results = await Promise.all(
    buyers.map((b) => hold(b.accessToken, departureId, selection(sheet, 1))),
  );
  assert.equal(results.filter((r) => r.status === 201).length, 3);
  assert.ok(results.filter((r) => r.status !== 201).every((r) => r.status === 409));
  const d = await api.db.departure.findUniqueOrThrow({ where: { id: departureId } });
  assert.equal(d.reserved, 3);
});

test('un apartado vencido devuelve sus puestos', async () => {
  const { departureId, sheet } = await departure({ capacity: 2 });
  const traveler = await api.signUp();
  const held = await hold(traveler.accessToken, departureId, selection(sheet, 2));
  assert.equal(held.status, 201);
  const expired = await api.app
    .get(BookingsService)
    .expireHolds(new Date(Date.now() + 2 * 3_600_000));
  assert.ok(expired >= 1);
  const again = await api.call<Json>('GET', `/v1/reservas/${held.body.id}`, {
    token: traveler.accessToken,
  });
  assert.equal(again.body.status, 'expired');
  assert.equal(
    (await api.db.departure.findUniqueOrThrow({ where: { id: departureId } })).reserved,
    0,
  );
});

test('pago reportado, conciliado por la agencia, asentado y con vouchers firmados', async () => {
  const { owner, providerId, departureId, sheet } = await departure();
  const traveler = await api.signUp();
  const held = await hold(traveler.accessToken, departureId, selection(sheet, 2));
  const id = held.body.id as string;

  const passengers = await api.call<Json>('PUT', `/v1/reservas/${id}/pasajeros`, {
    token: traveler.accessToken,
    body: {
      passengers: [
        { name: 'Ana Pérez', cedula: 'V-12345678', birthDate: '1990-05-01' },
        { name: 'Luis Pérez', cedula: null, birthDate: '1988-02-11' },
      ],
    },
  });
  assert.equal(passengers.status, 200, JSON.stringify(passengers.body));

  const tooEarly = await api.call('GET', `/v1/reservas/${id}/vouchers`, {
    token: traveler.accessToken,
  });
  assert.equal(tooEarly.status, 409);

  const key = randomUUID();
  const reference = `ref-${randomUUID().slice(0, 8)}`;
  const body = { method: 'mobile_payment', reference, amountUsd: 40, idempotencyKey: key };
  const first = await api.call<Json>('POST', `/v1/reservas/${id}/pagos`, {
    token: traveler.accessToken,
    body,
  });
  assert.equal(first.status, 201, JSON.stringify(first.body));
  assert.equal(first.body.amountBs, Math.round(40 * first.body.bsPerUsd * 100) / 100);
  const retry = await api.call<Json>('POST', `/v1/reservas/${id}/pagos`, {
    token: traveler.accessToken,
    body,
  });
  assert.equal(retry.body.id, first.body.id, 'el reintento devuelve el mismo pago');
  const dupRef = await api.call<Json>('POST', `/v1/reservas/${id}/pagos`, {
    token: traveler.accessToken,
    body: { ...body, idempotencyKey: randomUUID(), reference: reference.toUpperCase() },
  });
  assert.equal(dupRef.status, 409);
  const tooMuch = await api.call<Json>('POST', `/v1/reservas/${id}/pagos`, {
    token: traveler.accessToken,
    body: { ...body, idempotencyKey: randomUUID(), reference: `${reference}x`, amountUsd: 41 },
  });
  assert.equal(tooMuch.status, 409, 'solo faltan 40 USD sin contar lo pendiente');
  assert.equal(
    (await api.call<Json>('GET', `/v1/reservas/${id}`, { token: traveler.accessToken })).body
      .status,
    'in_review',
  );

  const inbox = await api.call<Json>('GET', `/v1/pro/${providerId}/pagos`, {
    token: owner.accessToken,
  });
  assert.deepEqual(
    inbox.body.items.map((p: Json) => p.id),
    [first.body.id],
  );
  const confirm = () =>
    api.call<Json>('POST', `/v1/pro/${providerId}/pagos/${first.body.id}/confirmar`, {
      token: owner.accessToken,
    });
  const [a, b] = await Promise.all([confirm(), confirm()]);
  assert.deepEqual(
    [a.status, b.status].sort(),
    [200, 409],
    'dos personas no aplican el mismo pago',
  );

  const booking = await api.call<Json>('GET', `/v1/reservas/${id}`, {
    token: traveler.accessToken,
  });
  assert.equal(booking.body.status, 'deposit_paid');
  assert.equal(booking.body.paidUsd, 40);
  assert.equal(booking.body.balanceUsd, 40);

  const entries = await api.db.ledgerEntry.findMany({ where: { paymentId: first.body.id } });
  const debit = entries.reduce((s, e) => s + Number(e.debitUsd), 0);
  const credit = entries.reduce((s, e) => s + Number(e.creditUsd), 0);
  assert.ok(entries.length > 0 && Math.abs(debit - credit) < 0.001);

  const vouchers = await api.call<Json>('GET', `/v1/reservas/${id}/vouchers`, {
    token: traveler.accessToken,
  });
  assert.equal(vouchers.status, 200);
  assert.equal(vouchers.body.items.length, 2);
  const signer = api.app.get<VoucherSigner>(VOUCHER_SIGNER);
  const claims = signer.verify(vouchers.body.items[0].qr);
  assert.equal(claims?.departureId, departureId);
  const keys = await api.call<Json>('GET', '/v1/vouchers/llaves');
  assert.equal(keys.body.items[0].id, claims?.keyId);

  // Otra persona no ve esta reserva ni sus vouchers.
  const stranger = await api.signUp();
  assert.equal(
    (await api.call('GET', `/v1/reservas/${id}/vouchers`, { token: stranger.accessToken })).status,
    404,
  );
});

test('un pago rechazado devuelve la reserva a apartada con tiempo nuevo', async () => {
  const { owner, providerId, departureId, sheet } = await departure();
  const traveler = await api.signUp();
  const held = await hold(traveler.accessToken, departureId, selection(sheet, 1));
  const pay = await api.call<Json>('POST', `/v1/reservas/${held.body.id}/pagos`, {
    token: traveler.accessToken,
    body: {
      method: 'zelle',
      reference: `z-${randomUUID().slice(0, 8)}`,
      amountUsd: 20,
      idempotencyKey: randomUUID(),
    },
  });
  assert.equal(pay.status, 201, JSON.stringify(pay.body));
  const rejected = await api.call<Json>(
    'POST',
    `/v1/pro/${providerId}/pagos/${pay.body.id}/rechazar`,
    {
      token: owner.accessToken,
      body: { reason: 'No llegó a la cuenta.' },
    },
  );
  assert.equal(rejected.status, 200);
  const booking = await api.call<Json>('GET', `/v1/reservas/${held.body.id}`, {
    token: traveler.accessToken,
  });
  assert.equal(booking.body.status, 'held');
  assert.ok(booking.body.heldUntil);
});

test('venta propia con el dinero recibido queda pagada y sin temporizador', async () => {
  const { owner, providerId, departureId, sheet } = await departure();
  const sold = await api.call<Json>('POST', `/v1/pro/${providerId}/reservas`, {
    token: owner.accessToken,
    body: {
      departureId,
      selection: selection(sheet, 1),
      contact: { name: 'Carla Gómez', phone: '0414 0000000' },
      payment: { method: 'cash_usd', reference: `caja-${randomUUID().slice(0, 6)}`, amountUsd: 40 },
    },
  });
  assert.equal(sold.status, 201, JSON.stringify(sold.body));
  assert.equal(sold.body.status, 'paid');
  assert.equal(sold.body.heldUntil, null);
  assert.equal(sold.body.contact.name, 'Carla Gómez');

  const other = await api.signUp();
  const otherAgency = await createProvider(api.db, other.user.id, { status: 'approved' });
  const foreign = await api.call('POST', `/v1/pro/${otherAgency}/reservas`, {
    token: other.accessToken,
    body: { departureId, selection: selection(sheet, 1), contact: { name: 'Nadie' } },
  });
  assert.equal(foreign.status, 404, 'no vende salidas de otra agencia');
});
