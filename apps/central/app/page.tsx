import { HealthCard } from './health-card';

// Se renderiza en cada petición: el estado de la API debe ser el del momento.
export const dynamic = 'force-dynamic';

export default function Home() {
  return (
    <main>
      <h1>FullDays · Central</h1>
      <p className="suave">Equipo interno: aprobaciones, reclamos y ajustes.</p>
      <HealthCard />
    </main>
  );
}
