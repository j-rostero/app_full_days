import { after, before, test } from 'node:test';
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import { exampleSheet, todayInVenezuela } from '@fulldays/shared';
import { type Api, createProvider, startApi } from '../testing/harness.ts';

type Json = Record<string, any>; // eslint-disable-line @typescript-eslint/no-explicit-any

let api: Api;
before(async () => {
  api = await startApi();
});
after(() => api.close());

const at = (minutesAgo: number) => new Date(Date.now() - minutesAgo * 60_000).toISOString();

/** Agencia con una salida de hoy, dos guías asignados, uno sin asignar y una reserva pagada de 2 adultos. */
async function tripToday() {
  const owner = await api.signUp();
  const providerId = await createProvider(api.db, owner.user.id, { status: 'approved' });
  const sheet = exampleSheet('fullday', { destinationId: randomUUID(), photoIds: [] });
  sheet.general.destinationId = null;
  sheet.general.title = `Salida de hoy ${randomUUID().slice(0, 4)}`;
  sheet.pricing.fares = { adult: 40, child: null, senior: null, infant: null };
  sheet.pricing.deposit = null;
  const product = await api.db.product.create({
    data: { providerId, type: 'fullday', status: 'published', sheet: sheet as never },
  });
  const departure = await api.db.departure.create({
    data: {
      providerId,
      productId: product.id,
      date: new Date(`${todayInVenezuela()}T00:00:00Z`),
      capacity: 10,
      sheet: sheet as never,
      productType: 'fullday',
      priceUsd: 40,
      cities: ['caracas'],
    },
  });
  const guides = await Promise.all([api.signUp(), api.signUp(), api.signUp()]);
  await api.db.providerMember.createMany({
    data: guides.map((g) => ({ providerId, userId: g.user.id, role: 'guide' as const })),
  });
  const assign = await api.call('PATCH', `/v1/pro/${providerId}/salidas/${departure.id}`, {
    token: owner.accessToken,
    body: { guideIds: [guides[0]!.user.id, guides[1]!.user.id] },
  });
  assert.equal(assign.status, 200, JSON.stringify(assign.body));

  const traveler = await api.signUp();
  const held = await api.call<Json>('POST', '/v1/reservas', {
    token: traveler.accessToken,
    body: {
      departureId: departure.id,
      selection: { boardingId: sheet.transfer.boardingPoints[0]!.id, travelers: { adult: 2 } },
    },
  });
  assert.equal(held.status, 201, JSON.stringify(held.body));
  const meal = sheet.meals.find((m) => m.mode === 'choice')!;
  const fish = meal.options.find((o) => !o.isDefault)!;
  const named = await api.call<Json>('PUT', `/v1/reservas/${held.body.id}/pasajeros`, {
    token: traveler.accessToken,
    body: {
      passengers: [
        {
          name: '=Ana Pérez',
          birthDate: '1990-05-01',
          restrictions: 'Sin gluten',
          mealPicks: { [meal.id]: [fish.id] },
        },
        { name: 'Luis Pérez', birthDate: '1988-02-11' },
      ],
    },
  });
  assert.equal(named.status, 200, JSON.stringify(named.body));
  assert.equal(named.body.mealChoices[0].mealId, meal.id);
  const bad = await api.call<Json>('PUT', `/v1/reservas/${held.body.id}/pasajeros`, {
    token: traveler.accessToken,
    body: {
      passengers: [
        { name: 'Ana', birthDate: '1990-05-01', mealPicks: { [meal.id]: [randomUUID()] } },
        { name: 'Luis', birthDate: '1988-02-11' },
      ],
    },
  });
  assert.equal(bad.status, 400);
  // El pago se concilia en la fase anterior; aquí basta con dejarla pagada.
  await api.db.booking.update({
    where: { id: held.body.id },
    data: { status: 'paid', paidUsd: held.body.totalUsd },
  });
  return {
    owner,
    providerId,
    departureId: departure.id,
    guides,
    traveler,
    booking: held.body,
    meal,
    fish,
  };
}

const pro = (t: Awaited<ReturnType<typeof tripToday>>, path: string) =>
  `/v1/pro/${t.providerId}/salidas${path}`;

test('el guía ve solo sus salidas de hoy y descarga la lista con las llaves', async () => {
  const t = await tripToday();
  const [g1, , stranger] = t.guides;
  const today = await api.call<Json>('GET', pro(t, '/hoy'), { token: g1!.accessToken });
  assert.equal(today.status, 200, JSON.stringify(today.body));
  assert.deepEqual(
    today.body.items.map((d: Json) => [d.id, d.passengers, d.boarded]),
    [[t.departureId, 2, 0]],
  );
  const none = await api.call<Json>('GET', pro(t, '/hoy'), { token: stranger!.accessToken });
  assert.deepEqual(none.body.items, []);
  assert.equal(
    (await api.call('GET', pro(t, `/${t.departureId}/pasajeros`), { token: stranger!.accessToken }))
      .status,
    403,
  );
  const list = await api.call<Json>('GET', pro(t, `/${t.departureId}/pasajeros`), {
    token: g1!.accessToken,
  });
  assert.equal(list.status, 200);
  assert.equal(list.body.passengers.length, 2);
  assert.ok(list.body.keys.length >= 1);
  assert.match(list.body.passengers[0].meals[0], new RegExp(t.fish.name));
  assert.equal(list.body.passengers[0].balanceUsd, 0);
});

test('dos guías marcan sin señal y sincronizan en cualquier orden: quedan con la misma lista', async () => {
  const results: string[][] = [];
  for (const order of [
    [0, 1],
    [1, 0],
  ]) {
    const t = await tripToday();
    const list = await api.call<Json>('GET', pro(t, `/${t.departureId}/pasajeros`), {
      token: t.owner.accessToken,
    });
    const [ana, luis] = list.body.passengers.map((p: Json) => p.id as string);
    const batches = [
      [
        { passengerId: ana, checkin: 'boarded', at: at(30) },
        { passengerId: luis, checkin: 'no_show', at: at(20) },
      ],
      [
        { passengerId: ana, checkin: null, at: at(25) },
        { passengerId: luis, checkin: 'boarded', at: at(10) },
        {
          passengerId: luis,
          checkin: 'no_show',
          at: new Date(Date.now() + 3_600_000).toISOString(),
        },
      ],
    ];
    let last: Json = {};
    for (const i of order) {
      const r = await api.call<Json>('POST', pro(t, `/${t.departureId}/checkins`), {
        token: t.guides[i]!.accessToken,
        body: { events: batches[i] },
      });
      assert.equal(r.status, 200, JSON.stringify(r.body));
      assert.ok(
        i !== 1 || r.body.discarded.some((d: Json) => d.reason === 'clock'),
        'avisa la marca con el reloj adelantado',
      );
      last = r.body;
    }
    results.push(last.passengers.map((p: Json) => `${p.name}:${p.checkin}`));
  }
  assert.deepEqual(results[0], results[1]);
  assert.deepEqual(results[0], ['=Ana Pérez:null', 'Luis Pérez:boarded']);
});

test('producción, CSV, avisos y cierre de la salida', async () => {
  const t = await tripToday();
  const prod = await api.call<Json>('GET', pro(t, `/${t.departureId}/produccion`), {
    token: t.owner.accessToken,
  });
  assert.equal(prod.status, 200, JSON.stringify(prod.body));
  const meal = prod.body.meals.find((m: Json) => m.mealId === t.meal.id);
  assert.equal(meal.servings, 2);
  assert.equal(meal.options.find((o: Json) => o.optionId === t.fish.id).count, 1);
  assert.deepEqual(prod.body.restrictions, [{ name: '=Ana Pérez', restrictions: 'Sin gluten' }]);
  assert.equal(
    (
      await api.call('GET', pro(t, `/${t.departureId}/produccion`), {
        token: t.guides[0]!.accessToken,
      })
    ).status,
    403,
    'el guía no tiene el permiso de reservas',
  );

  const csv = await fetch(`${api.base}${pro(t, `/${t.departureId}/pasajeros.csv`)}`, {
    headers: { authorization: `Bearer ${t.owner.accessToken}` },
  });
  assert.equal(csv.status, 200);
  assert.match(csv.headers.get('content-type') ?? '', /text\/csv/);
  const bytes = Buffer.from(await csv.arrayBuffer());
  assert.deepEqual([...bytes.subarray(0, 3)], [0xef, 0xbb, 0xbf], 'BOM para Excel');
  const text = bytes.toString('utf8');
  assert.ok(text.includes(`${t.booking.code};'=Ana Pérez;Adulto`), text);

  const posted = await api.call<Json>('POST', pro(t, `/${t.departureId}/avisos`), {
    token: t.guides[0]!.accessToken,
    body: { body: 'Salimos 15 minutos más tarde.' },
  });
  assert.equal(posted.status, 201, JSON.stringify(posted.body));
  const seen = await api.call<Json>('GET', `/v1/reservas/${t.booking.id}/avisos`, {
    token: t.traveler.accessToken,
  });
  assert.deepEqual(
    seen.body.items.map((n: Json) => n.body),
    ['Salimos 15 minutos más tarde.'],
  );
  const other = await api.signUp();
  assert.equal(
    (await api.call('GET', `/v1/reservas/${t.booking.id}/avisos`, { token: other.accessToken }))
      .status,
    404,
  );

  const list = await api.call<Json>('GET', pro(t, `/${t.departureId}/pasajeros`), {
    token: t.owner.accessToken,
  });
  await api.call('POST', pro(t, `/${t.departureId}/checkins`), {
    token: t.owner.accessToken,
    body: { events: [{ passengerId: list.body.passengers[1].id, checkin: 'boarded', at: at(1) }] },
  });
  for (const status of ['in_progress', 'finished'])
    assert.equal(
      (
        await api.call('PATCH', pro(t, `/${t.departureId}`), {
          token: t.owner.accessToken,
          body: { status },
        })
      ).status,
      200,
    );
  const done = await api.db.booking.findUniqueOrThrow({ where: { id: t.booking.id } });
  assert.equal(done.status, 'completed');
});
