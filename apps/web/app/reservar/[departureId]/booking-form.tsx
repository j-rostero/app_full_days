'use client';

import { useEffect, useState, useTransition } from 'react';
import {
  PASSENGER_TYPES,
  type BookingSelection,
  type ProductSheet,
  ROOM_TYPES,
} from '@fulldays/shared';
import { holdAction, quoteAction, type QuoteState } from './actions';

const usd = (n: number) => `${n.toFixed(2).replace(/\.00$/, '')} USD`;

/** Selección con precio en vivo: el total que se ve es el que cobra la API al apartar. */
export function BookingForm({
  departureId,
  sheet,
  roomsLeft,
}: {
  departureId: string;
  sheet: ProductSheet;
  roomsLeft: Record<string, number>;
}) {
  const [selection, setSelection] = useState<BookingSelection>({
    boardingId: sheet.transfer.boardingPoints[0]?.id ?? '',
    travelers: { adult: 1, child: 0, senior: 0, infant: 0 },
    rooms: [],
    mealIds: [],
    itemIds: [],
  });
  const [quote, setQuote] = useState<QuoteState>({});
  const [error, setError] = useState<string>();
  const [pending, start] = useTransition();

  useEffect(() => {
    let live = true;
    void quoteAction(departureId, selection).then((q) => live && setQuote(q));
    return () => {
      live = false;
    };
  }, [departureId, selection]);

  const set = (patch: Partial<BookingSelection>) => setSelection((s) => ({ ...s, ...patch }));
  const toggle = (list: string[], id: string) =>
    list.includes(id) ? list.filter((x) => x !== id) : [...list, id];
  const optionalMeals = sheet.meals.filter((m) => m.mode === 'optional');
  const optionalItems = sheet.items.filter((i) => i.modality === 'optional');
  const fares = sheet.pricing.fares;

  return (
    <form
      className="fd-form reserva"
      onSubmit={(e) => {
        e.preventDefault();
        setError(undefined);
        start(async () => setError((await holdAction(departureId, selection)).error));
      }}
    >
      <label className="fd-field">
        <span>Punto de embarque</span>
        <select value={selection.boardingId} onChange={(e) => set({ boardingId: e.target.value })}>
          {sheet.transfer.boardingPoints.map((b) => (
            <option key={b.id} value={b.id}>
              {b.name || b.city} {b.departureTime ? `· ${b.departureTime}` : ''}{' '}
              {b.priceDeltaUsd ? `(${b.priceDeltaUsd > 0 ? '+' : ''}${usd(b.priceDeltaUsd)})` : ''}
            </option>
          ))}
        </select>
      </label>
      <fieldset className="fd-field">
        <legend>Pasajeros</legend>
        {(Object.keys(PASSENGER_TYPES) as (keyof typeof PASSENGER_TYPES)[])
          .filter(
            (t) =>
              t === 'adult' ||
              fares[t] !== null ||
              (t !== 'senior' && sheet.general.childrenAllowed),
          )
          .map((type) => (
            <label key={type} className="contador">
              <span>{PASSENGER_TYPES[type]}</span>
              <input
                type="number"
                min={0}
                max={20}
                value={selection.travelers[type]}
                onChange={(e) =>
                  set({
                    travelers: {
                      ...selection.travelers,
                      [type]: Math.max(0, Number(e.target.value) || 0),
                    },
                  })
                }
              />
            </label>
          ))}
      </fieldset>
      {sheet.lodging && sheet.duration.nights > 0 && sheet.lodging.rooms.length ? (
        <fieldset className="fd-field">
          <legend>Habitaciones</legend>
          {sheet.lodging.rooms.map((room) => {
            const current = selection.rooms.find((r) => r.roomId === room.id)?.count ?? 0;
            const left = roomsLeft[room.id];
            return (
              <label key={room.id} className="contador">
                <span>
                  {ROOM_TYPES[room.type]} (hasta {room.occupancy}){' '}
                  {room.priceDeltaUsd ? `+${usd(room.priceDeltaUsd)}` : ''}
                  {left !== undefined ? ` · quedan ${left}` : ''}
                </span>
                <input
                  type="number"
                  min={0}
                  max={left ?? 20}
                  value={current}
                  onChange={(e) => {
                    const count = Math.max(0, Number(e.target.value) || 0);
                    const rest = selection.rooms.filter((r) => r.roomId !== room.id);
                    set({ rooms: count ? [...rest, { roomId: room.id, count }] : rest });
                  }}
                />
              </label>
            );
          })}
        </fieldset>
      ) : null}
      {optionalMeals.length || optionalItems.length ? (
        <fieldset className="fd-field">
          <legend>Extras (por persona)</legend>
          {optionalMeals.map((m) => (
            <label key={m.id} className="fd-check">
              <input
                type="checkbox"
                checked={selection.mealIds.includes(m.id)}
                onChange={() => set({ mealIds: toggle(selection.mealIds, m.id) })}
              />
              Comida día {m.day}: {m.description || m.moment} · {usd(m.priceUsd)}
            </label>
          ))}
          {optionalItems.map((it) => (
            <label key={it.id} className="fd-check">
              <input
                type="checkbox"
                checked={selection.itemIds.includes(it.id)}
                onChange={() => set({ itemIds: toggle(selection.itemIds, it.id) })}
              />
              {it.name} · {usd(it.priceUsd)}
            </label>
          ))}
        </fieldset>
      ) : null}
      <section className="tarjeta" aria-live="polite">
        {quote.error ? <p className="fd-form-error">{quote.error}</p> : null}
        {quote.quote ? (
          <>
            <table className="fd-table">
              <tbody>
                {quote.quote.lines.map((l) => (
                  <tr key={l.label}>
                    <td>{l.label}</td>
                    <td className="cifra">{usd(l.amountUsd)}</td>
                  </tr>
                ))}
                <tr>
                  <th>Total</th>
                  <th className="cifra">{usd(quote.quote.totalUsd)}</th>
                </tr>
              </tbody>
            </table>
            <p>
              Para reservar pagas <strong>{usd(quote.quote.depositUsd)}</strong>
              {quote.quote.depositUsd < quote.quote.totalUsd
                ? ` y el resto antes del ${quote.quote.balanceDueDate}`
                : ''}
              .
            </p>
          </>
        ) : null}
      </section>
      {error ? (
        <p className="fd-form-error" role="alert">
          {error}
        </p>
      ) : null}
      <button type="submit" className="fd-button" disabled={pending || !quote.quote}>
        {pending ? 'Apartando…' : 'Apartar mis puestos'}
      </button>
      <p className="suave">Apartamos tus puestos mientras reportas el pago a la agencia.</p>
    </form>
  );
}
