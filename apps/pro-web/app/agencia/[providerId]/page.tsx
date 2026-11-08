import { redirect } from 'next/navigation';
import { requireMe } from '@fulldays/web-session';

export default async function ProviderHome({
  params,
}: {
  params: Promise<{ providerId: string }>;
}) {
  const { providerId } = await params;
  const me = await requireMe(`/agencia/${providerId}`);
  const m = me.memberships.find((x) => x.providerId === providerId);
  const first = [
    ['company', 'empresa'],
    ['fulldays', 'productos'],
    ['departures', 'salidas'],
    ['bookings', 'reservas'],
    ['payments', 'pagos'],
    ['checkin', 'hoy'],
    ['team', 'equipo'],
  ].find(([p]) => m?.permissions.includes(p as never));
  redirect(`/agencia/${providerId}/${first?.[1] ?? 'productos'}`);
}
