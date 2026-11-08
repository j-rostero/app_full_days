import { notFound } from 'next/navigation';
import QRCode from 'qrcode';
import { PASSENGER_TYPES } from '@fulldays/shared';
import { requireMe, sessionApi } from '@fulldays/web-session';
import { longDate } from '../../../../lib/format';

export const metadata = { title: 'Vouchers', robots: { index: false } };

export default async function VouchersPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  await requireMe(`/reservas/${id}/vouchers`);
  const { data, response } = await (
    await sessionApi()
  ).GET('/v1/reservas/{id}/vouchers', { params: { path: { id } } });
  if (response.status === 404) notFound();
  if (!data)
    return (
      <main>
        <h1>Vouchers</h1>
        <p>Los vouchers aparecen cuando la agencia confirma tu pago.</p>
      </main>
    );
  const codes = await Promise.all(
    data.items.map((v) =>
      QRCode.toString(v.qr, { type: 'svg', errorCorrectionLevel: 'M', margin: 1 }),
    ),
  );
  return (
    <main>
      <h1>{data.title}</h1>
      <p className="suave">
        {longDate(data.date)} · Reserva {data.bookingCode}. Muestra un código por pasajero al
        abordar; funciona sin señal.
      </p>
      <div className="vouchers">
        {data.items.map((v, i) => (
          <figure key={v.passengerId} className="voucher">
            <div className="qr" dangerouslySetInnerHTML={{ __html: codes[i]! }} />
            <figcaption>
              <strong>{v.name ?? `Pasajero ${v.position + 1}`}</strong>
              <br />
              {PASSENGER_TYPES[v.type]}
            </figcaption>
          </figure>
        ))}
      </div>
    </main>
  );
}
