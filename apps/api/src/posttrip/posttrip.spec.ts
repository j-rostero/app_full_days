import { after, before, test } from 'node:test';
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import { exampleSheet, todayInVenezuela } from '@fulldays/shared';
import { BookingsService } from '../bookings/bookings.service.ts';
import { STORAGE, type Storage } from '../files/storage.ts';
import { JobsService } from '../jobs/jobs.service.ts';
import { NotificationsService } from '../notifications/notifications.service.ts';
import { EMAIL_SENDER, type LogEmailSender } from '../notifications/senders.ts';
import { type Api, createProvider, type Session, startApi } from '../testing/harness.ts';

type Json = Record<string, any>; // eslint-disable-line @typescript-eslint/no-explicit-any

let api: Api;
let other: Api;
before(async () => {
  api = await startApi();
  other = await startApi();
});
after(async () => {
  await api.close();
  await other.close();
});

const dayFrom = (days: number) =>
  new Date(Date.parse(`${todayInVenezuela()}T00:00:00Z`) + days * 86_400_000);

/** Agencia con un viaje (política moderada, 40 USD por adulto) y una salida en `days` días. */
async function trip(days: number) {
  const owner = await api.signUp();
  const providerId = await createProvider(api.db, owner.user.id, { status: 'approved' });
  const sheet = exampleSheet('fullday', { destinationId: randomUUID(), photoIds: [] });
  sheet.general.destinationId = null;
  sheet.general.title = `Viaje ${randomUUID().slice(0, 6)}`;
  sheet.pricing.fares = { adult: 40, child: null, senior: null, infant: null };
  sheet.pricing.deposit = null;
  const product = await api.db.product.create({
    data: { providerId, type: 'fullday', status: 'published', sheet: sheet as never },
  });
  const departure = await api.db.departure.create({
    data: {
      providerId,
      productId: product.id,
      date: dayFrom(days),
      capacity: 10,
      sheet: sheet as never,
      productType: 'fullday',
      priceUsd: 40,
      cities: ['caracas'],
    },
  });
  return { owner, providerId, product, departure, sheet };
}

/** Reserva de 2 adultos en la salida, llevada directo al estado pedido con lo pagado. */
async function booked(
  t: Awaited<ReturnType<typeof trip>>,
  traveler: Session,
  status: 'paid' | 'deposit_paid' | 'completed' = 'paid',
  paidUsd = 80,
) {
  // Una salida pasada ya no se vende: se reserva como si fuera futura y se devuelve su fecha.
  const real = t.departure.date;
  if (real < dayFrom(1))
    await api.db.departure.update({ where: { id: t.departure.id }, data: { date: dayFrom(5) } });
  const held = await api.call<Json>('POST', '/v1/reservas', {
    token: traveler.accessToken,
    body: {
      departureId: t.departure.id,
      selection: { boardingId: t.sheet.transfer.boardingPoints[0]!.id, travelers: { adult: 2 } },
    },
  });
  assert.equal(held.status, 201, JSON.stringify(held.body));
  await api.db.departure.update({ where: { id: t.departure.id }, data: { date: real } });
  await api.db.booking.update({
    where: { id: held.body.id },
    data: { status, paidUsd, heldUntil: null },
  });
  return held.body.id as string;
}

async function staff(): Promise<Session> {
  const s = await api.signUp();
  await api.db.staffMember.createMany({
    data: (['support', 'moderation', 'finance'] as const).map((role) => ({
      userId: s.user.id,
      role,
    })),
  });
  return s;
}

test('cancelar con la política deja el reembolso pendiente y pagarlo lo asienta en el libro', async () => {
  const t = await trip(4);
  const traveler = await api.signUp();
  const id = await booked(t, traveler);

  const quote = await api.call<Json>('GET', `/v1/reservas/${id}/cancelacion`, {
    token: traveler.accessToken,
  });
  assert.equal(quote.status, 200, JSON.stringify(quote.body));
  assert.deepEqual([quote.body.allowed, quote.body.amountUsd], [true, 40]);

  const cancelled = await api.call<Json>('POST', `/v1/reservas/${id}/cancelar`, {
    token: traveler.accessToken,
  });
  assert.equal(cancelled.status, 200, JSON.stringify(cancelled.body));
  assert.equal(cancelled.body.status, 'cancelled');
  assert.equal(cancelled.body.cancelledBy, 'traveler');
  assert.equal(cancelled.body.refund.amountUsd, 40);
  assert.equal(cancelled.body.refund.status, 'pending');
  const again = await api.call('POST', `/v1/reservas/${id}/cancelar`, {
    token: traveler.accessToken,
  });
  assert.equal(again.status, 409);
  const seats = await api.db.departure.findUniqueOrThrow({ where: { id: t.departure.id } });
  assert.equal(seats.reserved, 0);

  const refunds = await api.call<Json>('GET', `/v1/pro/${t.providerId}/reembolsos`, {
    token: t.owner.accessToken,
  });
  assert.equal(refunds.status, 200);
  const refund = refunds.body.items.find((r: Json) => r.bookingId === id);
  assert.ok(refund);
  const paid = await api.call<Json>(
    'POST',
    `/v1/pro/${t.providerId}/reembolsos/${refund.id}/pagar`,
    { token: t.owner.accessToken, body: { reference: 'TRF-123' } },
  );
  assert.equal(paid.status, 204, JSON.stringify(paid.body));
  const stored = await api.db.refund.findUniqueOrThrow({ where: { id: refund.id } });
  assert.deepEqual([stored.status, stored.reference], ['paid', 'TRF-123']);
  const twice = await api.call('POST', `/v1/pro/${t.providerId}/reembolsos/${refund.id}/pagar`, {
    token: t.owner.accessToken,
    body: { reference: 'TRF-123' },
  });
  assert.equal(twice.status, 409);

  const entries = await api.db.ledgerEntry.findMany({ where: { refundId: refund.id } });
  const debit = entries.reduce((s, e) => s + Number(e.debitUsd), 0);
  const credit = entries.reduce((s, e) => s + Number(e.creditUsd), 0);
  assert.ok(entries.length > 0);
  assert.equal(debit.toFixed(2), credit.toFixed(2));

  const settlement = await api.call<Json>('GET', `/v1/pro/${t.providerId}/liquidaciones`, {
    token: t.owner.accessToken,
  });
  assert.equal(settlement.status, 200, JSON.stringify(settlement.body));
  assert.equal(settlement.body.refundsUsd, 40);
  const csv = await fetch(`${api.base}/v1/pro/${t.providerId}/liquidaciones.csv`, {
    headers: { authorization: `Bearer ${t.owner.accessToken}` },
  });
  assert.equal(csv.status, 200);
  assert.match(await csv.text(), /Reembolso/);

  const inbox = await api.call<Json>('GET', '/v1/yo/notificaciones', {
    token: traveler.accessToken,
  });
  const events = inbox.body.items.map((n: Json) => n.event);
  assert.ok(events.includes('booking_cancelled') && events.includes('refund_paid'), events);
});

test('si la agencia cancela, se devuelve todo', async () => {
  const t = await trip(1);
  const traveler = await api.signUp();
  const id = await booked(t, traveler);
  const res = await api.call<Json>('POST', `/v1/pro/${t.providerId}/reservas/${id}/cancelar`, {
    token: t.owner.accessToken,
  });
  assert.equal(res.status, 200, JSON.stringify(res.body));
  assert.deepEqual([res.body.cancelledBy, res.body.refund.amountUsd], ['agency', 80]);
});

test('reseña: solo viajes realizados, una vez, y con datos de contacto queda oculta', async () => {
  const t = await trip(-3);
  const traveler = await api.signUp();
  const pending = await booked(t, traveler, 'paid');
  const early = await api.call('POST', `/v1/reservas/${pending}/resena`, {
    token: traveler.accessToken,
    body: { rating: 5, asDescribed: true },
  });
  assert.equal(early.status, 409);

  const done = await booked(t, traveler, 'completed');
  const review = await api.call<Json>('POST', `/v1/reservas/${done}/resena`, {
    token: traveler.accessToken,
    body: { rating: 4, aspects: { guide: 5 }, asDescribed: true, comment: 'Muy bonito todo.' },
  });
  assert.equal(review.status, 201, JSON.stringify(review.body));
  const dup = await api.call('POST', `/v1/reservas/${done}/resena`, {
    token: traveler.accessToken,
    body: { rating: 4, asDescribed: true },
  });
  assert.equal(dup.status, 409);

  const second = await api.signUp();
  const sneaky = await booked(t, second, 'completed');
  const hidden = await api.call<Json>('POST', `/v1/reservas/${sneaky}/resena`, {
    token: second.accessToken,
    body: { rating: 1, asDescribed: false, comment: 'Escríbeme al 0414 123 4567 y te cobro menos' },
  });
  assert.equal(hidden.status, 201, JSON.stringify(hidden.body));

  const pub = await api.call<Json>('GET', `/v1/productos/${t.product.id}/resenas`);
  assert.equal(pub.status, 200);
  assert.deepEqual(
    pub.body.items.map((r: Json) => r.id),
    [review.body.id],
  );
  assert.equal(pub.body.reputation.count, 1);

  const reply = await api.call<Json>(
    'POST',
    `/v1/pro/${t.providerId}/resenas/${review.body.id}/responder`,
    { token: t.owner.accessToken, body: { reply: 'Gracias por venir.' } },
  );
  assert.equal(reply.status, 200, JSON.stringify(reply.body));
  const reply2 = await api.call(
    'POST',
    `/v1/pro/${t.providerId}/resenas/${review.body.id}/responder`,
    { token: t.owner.accessToken, body: { reply: 'Otra vez.' } },
  );
  assert.equal(reply2.status, 409);

  const boss = await staff();
  const queue = await api.call<Json>('GET', '/v1/central/resenas', { token: boss.accessToken });
  assert.ok(queue.body.items.some((r: Json) => r.id === hidden.body.id));
  const show = await api.call('POST', `/v1/central/resenas/${hidden.body.id}/mostrar`, {
    token: boss.accessToken,
  });
  assert.equal(show.status, 204);
  const after = await api.call<Json>('GET', `/v1/productos/${t.product.id}/resenas`);
  assert.equal(after.body.reputation.count, 2);
});

test('reclamo: el viajero abre, la agencia responde, se escala y Central lo resuelve', async () => {
  const t = await trip(-1);
  const traveler = await api.signUp();
  const id = await booked(t, traveler, 'completed');
  const opened = await api.call<Json>('POST', `/v1/reservas/${id}/reclamos`, {
    token: traveler.accessToken,
    body: { subject: 'No hubo almuerzo', message: 'Pagamos el almuerzo y no lo dieron.' },
  });
  assert.equal(opened.status, 201, JSON.stringify(opened.body));
  const claimId = opened.body.id;

  const answer = await api.call<Json>(
    'POST',
    `/v1/pro/${t.providerId}/reclamos/${claimId}/mensajes`,
    { token: t.owner.accessToken, body: { body: 'Lo sentimos, revisamos con el restaurante.' } },
  );
  assert.equal(answer.status, 201, JSON.stringify(answer.body));
  assert.deepEqual(
    answer.body.messages.map((m: Json) => m.role),
    ['traveler', 'agency'],
  );
  const stranger = await api.signUp();
  const peek = await api.call('POST', `/v1/reclamos/${claimId}/mensajes`, {
    token: stranger.accessToken,
    body: { body: 'Hola' },
  });
  assert.equal(peek.status, 404);

  const up = await api.call<Json>('POST', `/v1/reclamos/${claimId}/escalar`, {
    token: traveler.accessToken,
  });
  assert.equal(up.body.status, 'escalated');

  const boss = await staff();
  const list = await api.call<Json>('GET', '/v1/central/reclamos', { token: boss.accessToken });
  assert.ok(list.body.items.some((c: Json) => c.id === claimId));
  const resolved = await api.call<Json>('POST', `/v1/central/reclamos/${claimId}/resolver`, {
    token: boss.accessToken,
    body: { resolution: 'La agencia devuelve 10 USD.' },
  });
  assert.equal(resolved.status, 200, JSON.stringify(resolved.body));
  const late = await api.call('POST', `/v1/reclamos/${claimId}/mensajes`, {
    token: traveler.accessToken,
    body: { body: '¿Y entonces?' },
  });
  assert.equal(late.status, 409);
  const inbox = await api.call<Json>('GET', '/v1/yo/notificaciones', {
    token: traveler.accessToken,
  });
  const events = inbox.body.items.map((n: Json) => n.event);
  assert.ok(events.includes('claim_message') && events.includes('claim_resolved'), events);
});

test('tareas: saldo vencido cancela, recordatorios una vez, salidas pasadas se cierran, archivos huérfanos se borran', async () => {
  const jobs = new JobsService(
    api.db,
    api.app.get(BookingsService),
    api.app.get(NotificationsService),
    api.app.get<Storage>(STORAGE),
  );
  const t = await trip(1);
  const traveler = await api.signUp();
  const overdue = await booked(t, traveler, 'deposit_paid', 20);
  await api.db.booking.update({ where: { id: overdue }, data: { balanceDueDate: dayFrom(-1) } });
  const soon = await booked(t, traveler, 'deposit_paid', 20);
  await api.db.booking.update({ where: { id: soon }, data: { balanceDueDate: dayFrom(1) } });

  assert.ok((await jobs.cancelOverdueBalances()) >= 1);
  const gone = await api.db.booking.findUniqueOrThrow({ where: { id: overdue } });
  assert.deepEqual([gone.status, gone.cancelledBy], ['cancelled', 'system']);

  await jobs.remind();
  await jobs.remind();
  const reminders = await api.db.notification.findMany({
    where: { userId: traveler.user.id, event: { in: ['trip_tomorrow', 'balance_due'] } },
  });
  // Mañana y saldo para `soon`, por push y por correo; la segunda corrida no repite.
  assert.equal(reminders.filter((n) => n.event === 'trip_tomorrow').length, 2);
  assert.equal(reminders.filter((n) => n.event === 'balance_due').length, 2);

  const past = await trip(-2);
  await jobs.closePastDepartures();
  const closed = await api.db.departure.findUniqueOrThrow({ where: { id: past.departure.id } });
  assert.equal(closed.status, 'closed');

  const file = await api.db.file.create({
    data: {
      uploaderId: traveler.user.id,
      kind: 'image',
      contentType: 'image/jpeg',
      size: 10,
      key: `huerfano/${randomUUID()}`,
      status: 'pending',
      createdAt: new Date(Date.now() - 25 * 3_600_000),
    },
  });
  await jobs.removeOrphanFiles();
  assert.equal(await api.db.file.findUnique({ where: { id: file.id } }), null);
});

test('dos instancias entregando a la vez no repiten ningún mensaje', async () => {
  const users = await Promise.all(Array.from({ length: 6 }, () => api.signUp()));
  const marker = randomUUID().slice(0, 8);
  const notes = api.app.get(NotificationsService);
  await notes.enqueue(
    users.flatMap((u, i) =>
      Array.from({ length: 10 }, (_, j) => ({
        userId: u.user.id,
        event: 'notice' as const,
        body: `${marker} aviso ${i}-${j}`,
      })),
    ),
  );
  const a = api.app.get<LogEmailSender>(EMAIL_SENDER);
  const b = other.app.get<LogEmailSender>(EMAIL_SENDER);
  assert.notEqual(a, b);
  const instances = [notes, other.app.get(NotificationsService)];
  await Promise.all(Array.from({ length: 6 }, (_, i) => instances[i % 2]!.deliverPending(7)));
  // Lo que quede, en tandas, hasta vaciar.
  for (let i = 0; i < 20; i++)
    if ((await Promise.all(instances.map((n) => n.deliverPending(25)))).every((n) => n === 0))
      break;

  const mine = [...a.sent, ...b.sent].filter((s) => s.message.body.startsWith(marker));
  assert.equal(mine.length, 60);
  assert.equal(new Set(mine.map((s) => s.message.body)).size, 60);
  assert.ok(a.sent.some((s) => s.message.body.startsWith(marker)));
  assert.ok(b.sent.some((s) => s.message.body.startsWith(marker)));
  const rows = await api.db.notification.findMany({
    where: { body: { startsWith: marker } },
    select: { channel: true, status: true },
  });
  assert.equal(rows.length, 120);
  assert.ok(rows.every((r) => r.status === (r.channel === 'email' ? 'sent' : 'skipped')));
});

test('la bandeja marca leídas y el dispositivo se registra', async () => {
  const u = await api.signUp();
  await api.app.get(NotificationsService).enqueue([
    { userId: u.user.id, event: 'notice', body: 'Uno' },
    { userId: u.user.id, event: 'notice', body: 'Dos' },
  ]);
  const inbox = await api.call<Json>('GET', '/v1/yo/notificaciones', { token: u.accessToken });
  assert.deepEqual([inbox.body.unread, inbox.body.items.length], [2, 2]);
  const read = await api.call('POST', '/v1/yo/notificaciones/leidas', {
    token: u.accessToken,
    body: {},
  });
  assert.ok(read.status < 300, String(read.status));
  const after = await api.call<Json>('GET', '/v1/yo/notificaciones', { token: u.accessToken });
  assert.equal(after.body.unread, 0);
  const device = await api.call('PUT', '/v1/yo/dispositivos', {
    token: u.accessToken,
    body: { token: `tok-${randomUUID()}`, platform: 'android' },
  });
  assert.ok(device.status < 300, String(device.status));
  assert.equal(await api.db.deviceToken.count({ where: { userId: u.user.id } }), 1);
});
