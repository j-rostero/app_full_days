import Link from 'next/link';
import { PAYMENT_METHODS, PAYMENT_STATUS_LABELS, type PaymentStatus } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { confirmPayment, rejectPayment } from './actions';

const money = (n: number) => `${n.toFixed(2)} USD`;

export default async function PaymentsPage({
  params,
  searchParams,
}: {
  params: Promise<{ providerId: string }>;
  searchParams: Promise<{ estado?: string }>;
}) {
  const { providerId } = await params;
  const status = ((await searchParams).estado ?? 'pending') as PaymentStatus;
  const { items } = await read((api) =>
    api.GET('/v1/pro/{providerId}/pagos', { params: { path: { providerId }, query: { status } } }),
  );
  return (
    <section className="tarjeta">
      <h2>Pagos</h2>
      <p className="suave">
        Revisa en tu banco cada pago reportado antes de confirmarlo. Confirmar aplica el dinero a la
        reserva y libera los vouchers.
      </p>
      <nav className="fd-links">
        {Object.entries(PAYMENT_STATUS_LABELS).map(([key, label]) => (
          <Link
            key={key}
            href={`?estado=${key}`}
            aria-current={key === status ? 'page' : undefined}
          >
            {label}
          </Link>
        ))}
      </nav>
      {items.length === 0 ? (
        <p className="suave">No hay pagos en «{PAYMENT_STATUS_LABELS[status]}».</p>
      ) : null}
      {items.map((p) => (
        <article key={p.id} className="bloque">
          <p>
            <strong>{money(p.amountUsd)}</strong>
            {p.amountBs
              ? ` · ${p.amountBs.toLocaleString('es-VE', { minimumFractionDigits: 2 })} Bs a ${p.bsPerUsd}`
              : ''}{' '}
            · {PAYMENT_METHODS[p.method]} · ref. <code>{p.reference}</code>
          </p>
          <p className="suave">
            <Link href={`/agencia/${providerId}/reservas/${p.bookingId}`}>{p.bookingCode}</Link> ·{' '}
            {p.title} · salida {p.departureDate} · reportado{' '}
            {new Date(p.createdAt).toLocaleString('es-VE')}
            {p.proofUrl ? (
              <>
                {' '}
                · <a href={p.proofUrl}>Ver comprobante</a>
              </>
            ) : null}
          </p>
          {p.reason ? <p className="fd-form-error">Motivo: {p.reason}</p> : null}
          {p.status === 'pending' ? (
            <div className="fd-inline">
              <ActionForm
                action={confirmPayment.bind(null, providerId, p.id)}
                submit="Confirmar"
                confirm={`¿Recibiste ${money(p.amountUsd)} con la referencia ${p.reference}?`}
              />
              <ActionForm
                action={rejectPayment.bind(null, providerId, p.id)}
                submit="Rechazar"
                className="fd-inline"
              >
                <label className="fd-field">
                  <span>Motivo para el viajero</span>
                  <input
                    name="reason"
                    required
                    minLength={5}
                    placeholder="No aparece en la cuenta"
                  />
                </label>
              </ActionForm>
            </div>
          ) : null}
        </article>
      ))}
    </section>
  );
}
