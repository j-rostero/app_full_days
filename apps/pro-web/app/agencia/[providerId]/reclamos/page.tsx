import Link from 'next/link';
import { CLAIM_STATUS_LABELS, type ClaimStatus } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../../lib/api';
import { answerClaim } from '../posttrip-actions';

const WHO = { traveler: 'Viajero', agency: 'Agencia', central: 'FullDays' } as const;

export default async function ClaimsPage({
  params,
  searchParams,
}: {
  params: Promise<{ providerId: string }>;
  searchParams: Promise<{ estado?: string }>;
}) {
  const { providerId } = await params;
  const raw = (await searchParams).estado;
  const estado = raw && raw in CLAIM_STATUS_LABELS ? (raw as ClaimStatus) : undefined;
  const { items } = await read((api) =>
    api.GET('/v1/pro/{providerId}/reclamos', {
      params: { path: { providerId }, query: estado ? { estado } : {} },
    }),
  );
  return (
    <section className="tarjeta">
      <h2>Reclamos</h2>
      <p className="suave">
        Responde aquí a los viajeros. Si el viajero lo escala, FullDays entra en la conversación y
        decide la resolución.
      </p>
      <nav className="fd-links">
        <Link href="?" aria-current={!estado ? 'page' : undefined}>
          Todos
        </Link>
        {Object.entries(CLAIM_STATUS_LABELS).map(([key, label]) => (
          <Link
            key={key}
            href={`?estado=${key}`}
            aria-current={key === estado ? 'page' : undefined}
          >
            {label}
          </Link>
        ))}
      </nav>
      {items.length === 0 ? <p className="suave">No hay reclamos.</p> : null}
      {items.map((c) => (
        <article key={c.id} className="bloque">
          <h3>
            {c.subject} <span className="fd-pill">{CLAIM_STATUS_LABELS[c.status]}</span>
          </h3>
          <p className="suave">
            <Link href={`/agencia/${providerId}/reservas/${c.bookingId}`}>{c.bookingCode}</Link> ·{' '}
            {c.title} · {c.traveler}
          </p>
          <ol className="mensajes">
            {c.messages.map((m) => (
              <li key={m.id}>
                <strong>{WHO[m.role]}</strong>{' '}
                <span className="suave">{new Date(m.createdAt).toLocaleString('es-VE')}</span>
                <br />
                {m.body}
              </li>
            ))}
          </ol>
          {c.resolution ? <p>Resolución: {c.resolution}</p> : null}
          {c.status !== 'resolved' ? (
            <ActionForm action={answerClaim.bind(null, providerId, c.id)} submit="Responder">
              <label className="fd-field">
                <span>Tu respuesta</span>
                <textarea name="body" required maxLength={3000} rows={2} />
              </label>
            </ActionForm>
          ) : null}
        </article>
      ))}
    </section>
  );
}
