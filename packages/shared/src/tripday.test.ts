import { test } from 'node:test';
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import { BookingSelectionSchema } from './booking.ts';
import { exampleSheet } from './example.ts';
import {
  checkMealPicks,
  type CheckinEvent,
  mealsInWords,
  type PassengerMark,
  production,
  resolveCheckins,
  toCsv,
} from './tripday.ts';

const now = new Date('2026-12-20T12:00:00Z');
const at = (min: number) => new Date(now.getTime() + min * 60_000).toISOString();

test('dos guías que sincronizan en cualquier orden terminan con la misma lista', () => {
  const a = randomUUID();
  const b = randomUUID();
  const start = () =>
    new Map<string, PassengerMark>([
      [a, { checkin: null, checkinAt: null }],
      [b, { checkin: null, checkinAt: null }],
    ]);
  const guide1: CheckinEvent[] = [
    { passengerId: a, checkin: 'boarded', at: at(-30) },
    { passengerId: b, checkin: 'no_show', at: at(-20) },
  ];
  const guide2: CheckinEvent[] = [
    { passengerId: a, checkin: null, at: at(-25) },
    { passengerId: b, checkin: 'boarded', at: at(-10) },
  ];
  const run = (first: CheckinEvent[], second: CheckinEvent[]) => {
    const state = start();
    for (const batch of [first, second])
      for (const [id, mark] of resolveCheckins(state, batch, now).winners) state.set(id, mark);
    return [...state].map(([id, m]) => [id, m.checkin]);
  };
  assert.deepEqual(run(guide1, guide2), run(guide2, guide1));
  assert.deepEqual(Object.fromEntries(run(guide1, guide2)), { [a]: null, [b]: 'boarded' });
});

test('descarta marcas del futuro y de pasajeros ajenos', () => {
  const a = randomUUID();
  const state = new Map([[a, { checkin: null, checkinAt: null }]]);
  const out = resolveCheckins(
    state,
    [
      { passengerId: a, checkin: 'boarded', at: at(11) },
      { passengerId: randomUUID(), checkin: 'boarded', at: at(0) },
    ],
    now,
  );
  assert.equal(out.winners.size, 0);
  assert.deepEqual(
    out.discarded.map((d) => d.reason),
    ['clock', 'unknown'],
  );
  assert.equal(
    resolveCheckins(state, [{ passengerId: a, checkin: 'boarded', at: at(9) }], now).winners.size,
    1,
  );
});

test('producción: platos por opción, predeterminado, pendientes, ítems y habitaciones', () => {
  const sheet = exampleSheet('fullday', { destinationId: randomUUID(), photoIds: [] });
  const meal = sheet.meals.find((m) => m.mode === 'choice')!;
  const other = meal.options.find((o) => !o.isDefault)!;
  const boardingId = sheet.transfer.boardingPoints[0]!.id;
  const selection = BookingSelectionSchema.parse({
    boardingId,
    travelers: { adult: 2, infant: 1 },
  });
  const p = production(sheet, [
    {
      selection,
      passengers: [
        {
          name: 'Ana',
          type: 'adult',
          restrictions: 'Sin gluten',
          mealPicks: { [meal.id]: [other.id] },
        },
        { name: 'Luis', type: 'adult', restrictions: null, mealPicks: {} },
        { name: 'Bebé', type: 'infant', restrictions: null, mealPicks: {} },
      ],
    },
  ]);
  const m = p.meals.find((x) => x.mealId === meal.id)!;
  assert.equal(m.servings, 2, 'el infante no come del menú');
  assert.equal(m.options.find((o) => o.optionId === other.id)!.count, 1);
  assert.equal(m.options.find((o) => o.optionId !== other.id && o.count === 1) !== undefined, true);
  assert.equal(m.pending, 0);
  assert.deepEqual(p.restrictions, [{ name: 'Ana', restrictions: 'Sin gluten' }]);
  assert.ok(p.items.every((i) => i.modality !== 'included' || i.units === 2));
  assert.deepEqual(checkMealPicks(sheet, { [meal.id]: [randomUUID()] }), [
    'Ese plato no está en el menú.',
  ]);
  assert.match(mealsInWords(sheet, { [meal.id]: [other.id] })[0]!, new RegExp(other.name));
});

test('el CSV abre bien en Excel y no ejecuta fórmulas', () => {
  const csv = toCsv([
    ['Nombre', 'Nota'],
    ['=HYPERLINK("x")', 'a;b'],
    ['-2', null],
  ]);
  assert.ok(csv.startsWith('\uFEFF'));
  assert.ok(csv.includes(`"'=HYPERLINK(""x"")";"a;b"`));
  assert.ok(csv.includes(`'-2;`));
});
