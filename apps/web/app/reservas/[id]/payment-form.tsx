'use client';

import { useState, useTransition } from 'react';
import { PAYMENT_METHODS, BOLIVAR_METHODS, type PaymentMethod } from '@fulldays/shared';
import { uploadFile } from '@fulldays/web-session/upload';
import { reportPayment } from './actions';

/** Reporte de un pago hecho a la agencia, con comprobante opcional. Un reintento no paga dos veces. */
export function PaymentForm({
  bookingId,
  methods,
  suggestedUsd,
  bsPerUsd,
}: {
  bookingId: string;
  methods: PaymentMethod[];
  suggestedUsd: number;
  bsPerUsd: number | null;
}) {
  const [key, setKey] = useState(() => crypto.randomUUID());
  const [method, setMethod] = useState<PaymentMethod>(methods[0] ?? 'zelle');
  const [amount, setAmount] = useState(String(suggestedUsd));
  const [reference, setReference] = useState('');
  const [file, setFile] = useState<File | null>(null);
  const [message, setMessage] = useState<{ error?: string; ok?: string }>({});
  const [pending, start] = useTransition();
  const amountUsd = Number(amount.replace(',', '.')) || 0;
  const inBs = BOLIVAR_METHODS.includes(method);

  return (
    <form
      className="fd-form"
      onSubmit={(e) => {
        e.preventDefault();
        start(async () => {
          try {
            const proofFileId = file ? await uploadFile(file, 'document') : null;
            const result = await reportPayment(bookingId, {
              method,
              reference,
              amountUsd,
              proofFileId,
              idempotencyKey: key,
            });
            setMessage(result);
            if (result.ok) {
              setKey(crypto.randomUUID());
              setReference('');
              setFile(null);
            }
          } catch (error) {
            setMessage({ error: (error as Error).message });
          }
        });
      }}
    >
      {message.error ? (
        <p className="fd-form-error" role="alert">
          {message.error}
        </p>
      ) : null}
      {message.ok ? (
        <p className="fd-form-ok" role="status">
          {message.ok}
        </p>
      ) : null}
      <label className="fd-field">
        <span>Método</span>
        <select value={method} onChange={(e) => setMethod(e.target.value as PaymentMethod)}>
          {methods.map((m) => (
            <option key={m} value={m}>
              {PAYMENT_METHODS[m]}
            </option>
          ))}
        </select>
      </label>
      <label className="fd-field">
        <span>Monto en dólares</span>
        <input
          inputMode="decimal"
          value={amount}
          onChange={(e) => setAmount(e.target.value)}
          required
        />
      </label>
      {inBs && bsPerUsd ? (
        <p className="suave">
          Equivale a{' '}
          {(amountUsd * bsPerUsd).toLocaleString('es-VE', {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2,
          })}{' '}
          Bs a la tasa de hoy ({bsPerUsd} Bs/USD).
        </p>
      ) : null}
      <label className="fd-field">
        <span>Referencia o número de confirmación</span>
        <input
          value={reference}
          onChange={(e) => setReference(e.target.value)}
          required
          minLength={4}
        />
      </label>
      <label className="fd-field">
        <span>Comprobante (opcional: foto o PDF)</span>
        <input
          type="file"
          accept="application/pdf,image/jpeg,image/png"
          onChange={(e) => setFile(e.target.files?.[0] ?? null)}
        />
      </label>
      <button type="submit" className="fd-button" disabled={pending}>
        {pending ? 'Enviando…' : 'Reportar pago'}
      </button>
    </form>
  );
}
