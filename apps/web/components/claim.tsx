import { CLAIM_STATUS_LABELS } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { escalateClaim, writeClaim } from '../app/reservas/[id]/actions';
import type { Schemas } from '../lib/api';

const WHO = { traveler: 'Tú', agency: 'La agencia', central: 'FullDays' } as const;

/** Conversación de un reclamo, con respuesta y escalada. `back` es la página a refrescar. */
export function ClaimThread({ claim: c, back }: { claim: Schemas['Claim']; back: string }) {
  return (
    <article className="tarjeta reclamo">
      <h3>
        {c.subject} <span className="fd-pill">{CLAIM_STATUS_LABELS[c.status]}</span>
      </h3>
      <p className="suave">
        {c.bookingCode} · {c.title} · {c.providerName}
      </p>
      <ol className="mensajes">
        {c.messages.map((m) => (
          <li key={m.id} className={`de-${m.role}`}>
            <strong>{WHO[m.role]}</strong>{' '}
            <span className="suave">{new Date(m.createdAt).toLocaleString('es-VE')}</span>
            <br />
            {m.body}
          </li>
        ))}
      </ol>
      {c.resolution ? (
        <p>
          <strong>Resolución de FullDays:</strong> {c.resolution}
        </p>
      ) : null}
      {c.status !== 'resolved' ? (
        <>
          <ActionForm action={writeClaim.bind(null, c.id, back)} submit="Enviar">
            <label className="fd-field">
              <span>Escribe un mensaje</span>
              <textarea name="body" required maxLength={3000} rows={2} />
            </label>
          </ActionForm>
          {c.status === 'open' ? (
            <ActionForm
              action={escalateClaim.bind(null, c.id, back)}
              submit="Pedir que FullDays intervenga"
              submitClassName="fd-button fd-button-secundario"
              confirm="FullDays leerá la conversación y decidirá. ¿Continuar?"
            />
          ) : null}
        </>
      ) : null}
    </article>
  );
}
