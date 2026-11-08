// Comprobación de tipos (pnpm typecheck): rutas inexistentes no compilan.
import { createApiClient } from './index.ts';

const api = createApiClient('http://localhost:4000');
void api.GET('/salud');
// @ts-expect-error la ruta no existe en el contrato
void api.GET('/v1/no-existe');
