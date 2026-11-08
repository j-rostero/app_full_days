import Link from 'next/link';
import { requireMe } from '@fulldays/web-session';
import { ActionForm } from '@fulldays/web-session/action-form';
import { read } from '../../lib/api';
import { markAllRead } from '../reservas/[id]/actions';

export const metadata = { title: 'Avisos', robots: { index: false } };

/** `reserva:<id>` → la página de esa reserva; lo demás, a su sección. */
function hrefOf(link: string | null): string | null {
  if (!link) return null;
  const [kind, id] = link.split(':');
  if (kind === 'reserva') return `/reservas/${id}`;
  if (kind === 'reclamo') return '/reclamos';
  return null;
}

export default async function InboxPage() {
  await requireMe('/avisos');
  const inbox = await read((api) => api.GET('/v1/yo/notificaciones'));
  return (
    <main>
      <div className="barra">
        <h1>Avisos</h1>
        {inbox.unread ? (
          <ActionForm
            action={markAllRead}
            submit="Marcar todo como leído"
            submitClassName="fd-button fd-button-secundario"
          />
        ) : null}
      </div>
      {inbox.items.length === 0 ? <p className="suave">No tienes avisos.</p> : null}
      <ul className="bandeja">
        {inbox.items.map((n) => {
          const href = hrefOf(n.link);
          return (
            <li key={n.id} className={n.read ? undefined : 'sin-leer'}>
              <strong>{n.title}</strong>{' '}
              <span className="suave">{new Date(n.createdAt).toLocaleString('es-VE')}</span>
              <br />
              {href ? <Link href={href}>{n.body}</Link> : n.body}
            </li>
          );
        })}
      </ul>
    </main>
  );
}
