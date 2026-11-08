import { Logger } from '@nestjs/common';
import { createApp } from './app.setup.ts';
import { CONFIG } from './common/tokens.ts';
import type { Config } from './config.ts';

const app = await createApp();
const { PORT } = app.get<Config>(CONFIG);
await app.listen(PORT);
new Logger('Main').log(`API escuchando en http://localhost:${PORT}`);
