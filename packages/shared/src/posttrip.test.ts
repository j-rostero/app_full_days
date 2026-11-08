import { test } from 'node:test';
import assert from 'node:assert/strict';
import {
  hasContactInfo,
  monthRange,
  publicAuthor,
  reputation,
  reviewWindowOpen,
  settlementTotals,
} from './posttrip.ts';
import { paymentPostings, refundPostings } from './payment.ts';

test('detecta teléfonos, WhatsApp y correos en textos públicos', () => {
  for (const t of [
    'Escríbeme al 0414-123.45.67',
    'wa.me/584141234567',
    'por whats app',
    'ana@correo.com',
  ])
    assert.ok(hasContactInfo(t), t);
  for (const t of ['Excelente viaje, 10 de 10', 'Salimos a las 5:30 desde Altamira'])
    assert.ok(!hasContactInfo(t), t);
});

test('reputación: media con un decimal, porcentaje de ficha cumplida y aspectos', () => {
  const r = reputation([
    { rating: 5, asDescribed: true, aspects: { guide: 5 } },
    { rating: 4, asDescribed: true, aspects: { guide: 4, food: 3 } },
    { rating: 4, asDescribed: false, aspects: {} },
  ]);
  assert.deepEqual(r, {
    average: 4.3,
    count: 3,
    asDescribedPercent: 67,
    aspects: { food: 3, guide: 4.5 },
  });
  assert.equal(reputation([]).average, null);
  assert.equal(publicAuthor('  Ana María Pérez '), 'Ana');
});

test('la ventana de reseña dura 30 días desde el viaje', () => {
  assert.ok(reviewWindowOpen('2026-11-01', '2026-11-01'));
  assert.ok(reviewWindowOpen('2026-11-01', '2026-12-01'));
  assert.ok(!reviewWindowOpen('2026-11-01', '2026-12-02'));
  assert.ok(!reviewWindowOpen('2026-11-10', '2026-11-09'));
});

test('el mes se cuenta en hora de Venezuela', () => {
  const { from, to } = monthRange('2026-12');
  assert.equal(from.toISOString(), '2026-12-01T04:00:00.000Z');
  assert.equal(to.toISOString(), '2027-01-01T04:00:00.000Z');
});

test('liquidación: cobrado, devuelto, comisión y neto salen del libro en ambos modelos', () => {
  for (const model of ['direct', 'retained'] as const) {
    const pay = paymentPostings(100, 10, model);
    const refund = refundPostings(40, 10, model);
    const entries = [...pay, ...refund].map((p) => ({ ...p, paymentId: null, refundId: null }));
    assert.deepEqual(settlementTotals(entries), {
      paymentsUsd: 100,
      refundsUsd: 40,
      commissionUsd: 6,
      netUsd: 54,
    });
  }
});
