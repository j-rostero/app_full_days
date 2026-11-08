import { writeFileSync } from 'node:fs';
import { createApp } from './app.setup.ts';
import { buildOpenApi } from './openapi.ts';

/** Escribe el contrato OpenAPI: `node dist/write-openapi.js <archivo>`. No escucha ni toca servicios. */
const target = process.argv[2];
if (!target) throw new Error('Uso: node dist/write-openapi.js <archivo>');
const app = await createApp({ logger: false });
await app.init();
writeFileSync(target, JSON.stringify(buildOpenApi(app), null, 2) + '\n');
await app.close();
