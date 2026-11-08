import { test } from 'node:test';
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import { exampleSheet } from './example.ts';
import {
  cashAtDestination,
  completeness,
  contactInfo,
  emptySheet,
  inclusions,
  ProductSheetSchema,
} from './product.ts';
import {
  canMoveDeparture,
  ScheduleDeparturesSchema,
  todayInVenezuela,
  weeklyDates,
} from './departure.ts';
import { RifSchema, providerBadge } from './providers.ts';

const refs = () => ({
  destinationId: randomUUID(),
  photoIds: Array.from({ length: 5 }, () => randomUUID()),
});

test('las fichas de ejemplo de los tres tipos se pueden publicar', () => {
  for (const type of ['fullday', 'tour', 'excursion'] as const) {
    const result = completeness(type, exampleSheet(type, refs()));
    assert.deepEqual(result.missing, [], type);
    assert.equal(result.percent, 100);
    assert.equal(result.publishable, true);
  }
});

test('una ficha vacía se guarda pero no se publica', () => {
  const result = completeness('fullday', emptySheet('fullday'));
  assert.equal(result.publishable, false);
  assert.ok(result.percent < 20);
  assert.ok(result.missing.includes('el precio de adulto'));
});

test('un tour exige alojamiento; un fullday con noches no vale', () => {
  const sheet = exampleSheet('tour', refs());
  const noLodging = completeness('tour', { ...sheet, lodging: null });
  assert.ok(noLodging.missing.includes('el nombre del alojamiento'));
  const asFullday = completeness('fullday', sheet);
  assert.ok(asFullday.missing.includes('la duración: un fullday dura un día'));
});

test('a escoger exige una sola opción por defecto', () => {
  const sheet = exampleSheet('fullday', refs());
  sheet.meals[0]!.options.forEach((o) => (o.isDefault = true));
  assert.ok(
    completeness('fullday', sheet).missing.some((m) => m.startsWith('una opción por defecto')),
  );
});

test('más noches que días no pasa el esquema', () => {
  assert.equal(ProductSheetSchema.safeParse({ duration: { days: 1, nights: 2 } }).success, false);
});

test('detecta teléfonos venezolanos y enlaces de WhatsApp, ignorando ids', () => {
  const found = contactInfo({
    general: { description: 'Escríbenos al 0414-123.45.67 o wa.me/584141234567' },
    id: '0190f5a0-0000-7000-8000-000000000001',
    other: ['+58 424 1234567'],
  });
  assert.deepEqual(
    found.sort(),
    ['+58 424 1234567', '0414-123.45.67', 'wa.me/584141234567'].sort(),
  );
  assert.deepEqual(contactInfo({ text: 'Salimos a las 0500 y llevamos 12 personas' }), []);
});

test('lo que lee el viajero y lo que paga en destino', () => {
  const sheet = exampleSheet('fullday', refs());
  const groups = inclusions(sheet);
  assert.ok(groups.included.includes('Traslado en autobús'));
  assert.deepEqual(groups.payAtDestination, ['Tasa del parque · 5 USD (efectivo en dólares)']);
  assert.deepEqual(cashAtDestination(sheet), { totalUsd: 5, concepts: ['Tasa del parque'] });
});

test('salidas: estados, fechas y programación', () => {
  assert.equal(canMoveDeparture('open', 'paused'), true);
  assert.equal(canMoveDeparture('open', 'finished'), false);
  assert.equal(canMoveDeparture('in_progress', 'finished'), true);
  assert.equal(canMoveDeparture('cancelled', 'open'), false);
  assert.equal(todayInVenezuela(new Date('2026-11-08T03:00:00Z')), '2026-11-07');
  assert.deepEqual(weeklyDates('2026-11-07', '2026-11-28'), [
    '2026-11-07',
    '2026-11-14',
    '2026-11-21',
    '2026-11-28',
  ]);
  const bad = ScheduleDeparturesSchema.safeParse({
    productId: randomUUID(),
    dates: ['2026-12-01'],
    capacity: 10,
    minCapacity: 20,
  });
  assert.equal(bad.success, false);
});

test('RIF y distintivo', () => {
  assert.equal(RifSchema.parse('j123456789'), 'J-12345678-9');
  assert.equal(RifSchema.parse('J-12.345.678-9'), 'J-12345678-9');
  assert.equal(RifSchema.safeParse('X-1').success, false);
  assert.equal(providerBadge({ status: 'approved', rtn: '123' }), 'verified');
  assert.equal(providerBadge({ status: 'approved', rtn: null }), 'new');
  assert.equal(providerBadge({ status: 'in_review', rtn: '1' }), null);
});
