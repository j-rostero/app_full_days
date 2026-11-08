import { BOOKING_STATUS_LABELS, type BookingStatus } from '@fulldays/shared';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../../lib/api';
import { blockUser } from '../posttrip-actions';

export default async function UsersPage({
  searchParams,
}: {
  searchParams: Promise<{ q?: string }>;
}) {
  const q = ((await searchParams).q ?? '').trim();
  const items =
    q.length >= 3
      ? (await read((api) => api.GET('/v1/central/usuarios', { params: { query: { q } } }))).items
      : null;
  return (
    <section className="tarjeta">
      <h2>Usuarios</h2>
      <form className="fd-inline" method="get">
        <label className="fd-field">
          <span>Correo, nombre, teléfono o código de reserva</span>
          <input name="q" defaultValue={q} minLength={3} required />
        </label>
        <button className="fd-button" type="submit">
          Buscar
        </button>
      </form>
      {items && items.length === 0 ? <p className="suave">Nadie coincide con «{q}».</p> : null}
      {items?.map((u) => (
        <article key={u.id} className="bloque">
          <p>
            <strong>{u.name ?? u.email}</strong> · {u.email} {u.phone ? `· ${u.phone}` : ''} · desde{' '}
            {new Date(u.createdAt).toLocaleDateString('es-VE')}
            {u.blockedAt ? <span className="fd-pill">Bloqueada</span> : null}
          </p>
          {u.bookings.length ? (
            <ul>
              {u.bookings.map((b) => (
                <li key={b.id}>
                  {b.code} · {b.title} · {b.date} ·{' '}
                  {BOOKING_STATUS_LABELS[b.status as BookingStatus] ?? b.status}
                </li>
              ))}
            </ul>
          ) : (
            <p className="suave">Sin reservas.</p>
          )}
          <ActionForm
            action={blockUser.bind(null, u.id, !u.blockedAt)}
            submit={u.blockedAt ? 'Desbloquear' : 'Bloquear'}
            submitClassName="fd-button fd-button-secundario"
            confirm={
              u.blockedAt
                ? '¿Desbloquear esta cuenta?'
                : '¿Bloquear esta cuenta? Se cierran todas sus sesiones.'
            }
            className="fd-inline"
          >
            {u.blockedAt ? null : (
              <label className="fd-field">
                <span>Motivo</span>
                <input name="reason" required minLength={3} maxLength={500} />
              </label>
            )}
          </ActionForm>
        </article>
      ))}
    </section>
  );
}
