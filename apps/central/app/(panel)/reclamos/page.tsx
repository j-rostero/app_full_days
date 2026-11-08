import Link from 'next/link';
import { CLAIM_STATUS_LABELS, type ClaimStatus } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../lib/api';
import { answerClaim, resolveClaim } from '../posttrip-actions';

const WHO = { traveler: 'Viajero', agency: 'Agencia', central: 'FullDays' } as const;

export default async function ClaimsPage({
  searchParams,
}: {
  searchParams: Promise<{ estado?: string }>;
}) {
  const raw = (await searchParams).estado;
  const estado = raw && raw in CLAIM_STATUS_LABELS ? (raw as ClaimStatus) : undefined;
  const { items } = await read((api) =>
    api.GET('/v1/central/reclamos', { params: { query: estado ? { estado } : {} } }),
  );
  return (
    <section className="tarjeta">
      <h2>Reclamos</h2>
      <p className="suave">
        Sin filtro se ven los que no están resueltos, el que más espera primero. Los escalados
        esperan tu decisión.
      </p>
      <nav className="fd-links">
        <Link href="?" aria-current={!estado ? 'page' : undefined}>
          Pendientes
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
      {items.length === 0 ? <p className="suave">No hay reclamos aquí.</p> : null}
      {items.map((c) => (
        <article key={c.id} className="bloque">
          <h3>
            {c.subject} <span className="fd-pill">{CLAIM_STATUS_LABELS[c.status]}</span>
          </h3>
          <p className="suave">
            {c.bookingCode} · {c.title} · {c.providerName} · {c.traveler} · abierto{' '}
            {new Date(c.createdAt).toLocaleDateString('es-VE')}
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
            <div className="fd-inline">
              <ActionForm action={answerClaim.bind(null, c.id)} submit="Enviar mensaje">
                <label className="fd-field">
                  <span>Mensaje a ambas partes</span>
                  <textarea name="body" required maxLength={3000} rows={2} />
                </label>
              </ActionForm>
              <ActionForm
                action={resolveClaim.bind(null, c.id)}
                submit="Resolver"
                confirm="¿Cerrar el reclamo con esta resolución?"
              >
                <label className="fd-field">
                  <span>Resolución</span>
                  <textarea name="resolution" required minLength={3} maxLength={2000} rows={2} />
                </label>
              </ActionForm>
            </div>
          ) : null}
        </article>
      ))}
    </section>
  );
}
