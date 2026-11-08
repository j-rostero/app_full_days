import { test } from 'node:test';
import assert from 'node:assert/strict';
import { generateKeyPairSync, sign, verify } from 'node:crypto';
import { randomUUID } from 'node:crypto';
import {
  BookingSelectionSchema,
  bookingCode,
  checkSelection,
  nextBookingStatus,
  quote,
  refundFor,
} from './booking.ts';
import { exampleSheet } from './example.ts';
import { balances, normalizeReference, paymentPostings, refundPostings } from './payment.ts';
import { parseVoucher, voucherPayload } from './voucher.ts';

const sheet = exampleSheet('fullday', { destinationId: randomUUID(), photoIds: [] });
const boardingId = sheet.transfer.boardingPoints[0]!.id;
const selection = (over: object = {}) =>
  BookingSelectionSchema.parse({
    boardingId,
    travelers: { adult: 2, child: 1, infant: 1 },
    ...over,
  });

test('cotiza por tipo de pasajero: el niño sin tarifa paga como adulto y el infante no paga ni ocupa puesto', () => {
  const s = {
    ...sheet,
    pricing: {
      ...sheet.pricing,
      fares: { adult: 50, child: null, senior: null, infant: null },
      deposit: null,
    },
  };
  const q = quote(s, { date: '2026-12-20', adultPriceUsd: null }, selection(), {
    minDepositPercent: 0,
  });
  assert.equal(q.seats, 3);
  assert.equal(q.totalUsd, 150);
  assert.equal(q.depositUsd, 150, 'sin abono en la ficha se paga todo');
});

test('el precio de la salida reemplaza el de adulto y el abono toma el mayor sin pasar del total', () => {
  const s = {
    ...sheet,
    pricing: {
      ...sheet.pricing,
      fares: { adult: 50, child: 30, senior: null, infant: null },
      deposit: { kind: 'percent' as const, value: 20 },
      balanceDueDaysBefore: 3,
    },
  };
  const q = quote(s, { date: '2026-12-20', adultPriceUsd: 60 }, selection(), {
    minDepositPercent: 30,
  });
  assert.equal(q.totalUsd, 150);
  assert.equal(q.depositUsd, 45);
  assert.equal(q.balanceDueDate, '2026-12-17');
});

test('la selección se valida contra la ficha', () => {
  const issues = checkSelection(
    sheet,
    selection({ boardingId: randomUUID(), travelers: { child: 1 }, mealIds: [randomUUID()] }),
  );
  assert.deepEqual(
    issues.map((i) => i.path.join('.')),
    ['boardingId', 'travelers.adult', 'mealIds.0'],
  );
  assert.deepEqual(checkSelection(sheet, selection()), []);
});

test('máquina de estados de la reserva', () => {
  const money = { depositUsd: 30, totalUsd: 100 };
  assert.equal(nextBookingStatus('held', 'submit_proof'), 'in_review');
  assert.equal(
    nextBookingStatus('in_review', 'confirm_payment', { ...money, paidUsd: 10 }),
    'held',
  );
  assert.equal(
    nextBookingStatus('in_review', 'confirm_payment', { ...money, paidUsd: 30 }),
    'deposit_paid',
  );
  assert.equal(
    nextBookingStatus('deposit_paid', 'confirm_payment', { ...money, paidUsd: 100 }),
    'paid',
  );
  assert.equal(nextBookingStatus('paid', 'finish', { boarded: false }), 'no_show');
  assert.equal(nextBookingStatus('expired', 'confirm_payment', money), null);
  assert.equal(nextBookingStatus('paid', 'expire'), null);
});

test('códigos legibles y reembolsos por plantilla', () => {
  const code = bookingCode();
  assert.match(code, /^FD-[A-HJ-NP-Z2-9]{8}$/);
  assert.equal(refundFor('moderate', 3, 80).amountUsd, 40);
  assert.equal(refundFor('strict', 3, 80).amountUsd, 0);
  assert.equal(refundFor(null, 30, 80, true).amountUsd, 80);
});

test('el libro cuadra y el reembolso deja todo en cero', () => {
  for (const model of ['direct', 'retained'] as const) {
    const pay = paymentPostings(33.33, 10, model);
    assert.ok(balances(pay).balanced);
    const all = balances([...pay, ...refundPostings(33.33, 10, model)]);
    assert.ok(Object.values(all.byAccount).every((v) => v === 0));
  }
  assert.equal(normalizeReference(' 0102-33 44 aa '), '01023344AA');
});

test('un voucher firmado se valida sin red y uno alterado no', () => {
  const { publicKey, privateKey } = generateKeyPairSync('ed25519');
  const claims = {
    keyId: 'abcd1234',
    code: 'FD-ABCDEFGH',
    passengerId: randomUUID(),
    departureId: randomUUID(),
    date: '2026-12-20',
  };
  const payload = voucherPayload(claims);
  const signature = sign(null, Buffer.from(payload), privateKey).toString('base64url');
  const text = `${payload}.${signature}`;
  assert.ok(text.length <= 170, `QR corto (${text.length})`);
  const parsed = parseVoucher(text)!;
  assert.deepEqual(parsed.claims, claims);
  assert.ok(verify(null, Buffer.from(parsed.payload), publicKey, parsed.signature));
  const tampered = parseVoucher(text.replace('FD-ABCDEFGH', 'FD-ABCDEFGJ'))!;
  assert.equal(verify(null, Buffer.from(tampered.payload), publicKey, tampered.signature), false);
  assert.equal(parseVoucher('basura'), null);
});
