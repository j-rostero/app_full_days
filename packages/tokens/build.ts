import { readFileSync, writeFileSync } from 'node:fs';
import { toCss, toDart, type Tokens } from './generate.ts';
import { OUTPUTS } from './outputs.ts';

const tokens = JSON.parse(
  readFileSync(new URL('./tokens.json', import.meta.url), 'utf8'),
) as Tokens;
writeFileSync(OUTPUTS.css, toCss(tokens));
writeFileSync(OUTPUTS.dart, toDart(tokens));
console.log('Tokens generados: tokens.css y packages/ui_flutter/lib/src/tokens.g.dart');
