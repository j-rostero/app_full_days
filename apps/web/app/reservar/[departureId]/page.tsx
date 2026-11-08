import { notFound } from 'next/navigation';
import { requireMe, sessionApi } from '@fulldays/web-session';
import { longDate, usd } from '../../../lib/format';
import { BookingForm } from './booking-form';

export const metadata = { title: 'Reservar', robots: { index: false } };

export default async function ReservePage({
  params,
}: {
  params: Promise<{ departureId: string }>;
}) {
  const { departureId } = await params;
  await requireMe(`/reservar/${departureId}`);
  const { data } = await (
    await sessionApi()
  ).GET('/v1/salidas/{id}', { params: { path: { id: departureId } } });
  if (!data) notFound();
  return (
    <main>
      <h1>{data.title}</h1>
      <p className="suave">
        {longDate(data.departure.date)} · {data.provider.name} · desde{' '}
        {usd(data.departure.priceUsd)} · {data.departure.seatsLeft} puestos libres
      </p>
      {data.departure.status !== 'open' || data.departure.seatsLeft === 0 ? (
        <p className="fd-form-error">Esta salida ya no tiene puestos a la venta.</p>
      ) : (
        <BookingForm departureId={departureId} sheet={data.sheet} roomsLeft={data.roomsLeft} />
      )}
    </main>
  );
}
