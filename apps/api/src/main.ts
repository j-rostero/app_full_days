import { Logger } from '@nestjs/common';
import { createApp } from './app.setup.ts';
import { CONFIG } from './common/tokens.ts';
import type { Config } from './config.ts';
import { STORAGE, type Storage } from './files/storage.ts';

const app = await createApp();
const config = app.get<Config>(CONFIG);
const { PORT } = config;
if (config.NODE_ENV === 'development' && config.STORAGE_DRIVER === 's3') {
  // En local los depósitos se crean solos; en la nube los crea la infraestructura.
  await app
    .get<Storage>(STORAGE)
    .ensureBuckets(config.CORS_ORIGINS)
    .catch((error: unknown) =>
      new Logger('Main').warn(`No se pudieron preparar los depósitos: ${String(error)}`),
    );
}
await app.listen(PORT);
new Logger('Main').log(`API escuchando en http://localhost:${PORT}`);
