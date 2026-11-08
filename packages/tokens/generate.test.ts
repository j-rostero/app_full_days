import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
import { toCss, toDart, type Tokens } from './generate.ts';
import { OUTPUTS } from './outputs.ts';

const tokens = JSON.parse(
  readFileSync(new URL('./tokens.json', import.meta.url), 'utf8'),
) as Tokens;

test('tokens.css está al día (si falla: pnpm tokens)', () => {
  assert.equal(readFileSync(OUTPUTS.css, 'utf8'), toCss(tokens));
});

test('tokens.g.dart está al día (si falla: pnpm tokens)', () => {
  assert.equal(readFileSync(OUTPUTS.dart, 'utf8'), toDart(tokens));
});

test('cada color es una variable CSS y una constante Dart', () => {
  const css = toCss(tokens);
  const dart = toDart(tokens);
  assert.match(css, /--fd-color-texto-suave: #55615C;/);
  assert.match(dart, /static const textoSuave = Color\(0xFF55615C\);/);
});

test('cada producto redefine sus colores', () => {
  assert.match(toCss(tokens), /\[data-product='pro'\] \{\n {2}--fd-color-primario: #1F4E8C;/);
});
