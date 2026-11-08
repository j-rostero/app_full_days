// Generadores de los archivos que consumen los tokens: CSS para las webs y Dart para la app.

export interface Tokens {
  color: Record<string, string>;
  productos: Record<string, Record<string, string>>;
  tipografia: {
    familia: string;
    respaldo: string;
    escala: Record<string, { tamano: number; interlineado: number; peso: number }>;
  };
  radio: Record<string, number>;
  espacio: Record<string, number>;
}

const HEADER = 'Generado desde packages/tokens/tokens.json con `pnpm tokens`. No editar.';

const kebab = (name: string) => name.replace(/[A-Z]/g, (c) => `-${c.toLowerCase()}`);
const pascal = (name: string) => name.charAt(0).toUpperCase() + name.slice(1);

export function toCss(tokens: Tokens): string {
  const lines = [`/* ${HEADER} */`, ':root {'];
  for (const [name, value] of Object.entries(tokens.color))
    lines.push(`  --fd-color-${kebab(name)}: ${value};`);
  lines.push(`  --fd-font-family: '${tokens.tipografia.familia}', ${tokens.tipografia.respaldo};`);
  for (const [name, step] of Object.entries(tokens.tipografia.escala)) {
    lines.push(`  --fd-text-${kebab(name)}-size: ${step.tamano / 16}rem;`);
    lines.push(`  --fd-text-${kebab(name)}-line: ${step.interlineado / 16}rem;`);
    lines.push(`  --fd-text-${kebab(name)}-weight: ${step.peso};`);
  }
  for (const [name, value] of Object.entries(tokens.radio))
    lines.push(`  --fd-radius-${kebab(name)}: ${value}px;`);
  for (const [name, value] of Object.entries(tokens.espacio))
    lines.push(`  --fd-space-${kebab(name)}: ${value}px;`);
  lines.push('}');
  for (const [product, overrides] of Object.entries(tokens.productos)) {
    lines.push('', `[data-product='${product}'] {`);
    for (const [name, value] of Object.entries(overrides))
      lines.push(`  --fd-color-${kebab(name)}: ${value};`);
    lines.push('}');
  }
  return lines.join('\n') + '\n';
}

const dartColor = (hex: string) => `Color(0xFF${hex.replace('#', '').toUpperCase()})`;

export function toDart(tokens: Tokens): string {
  const lines = [
    `// ${HEADER}`,
    '// ignore_for_file: constant_identifier_names',
    '',
    "import 'dart:ui';",
    '',
  ];
  lines.push('/// Colores base (producto de viajeros).', 'abstract final class FdColors {');
  for (const [name, value] of Object.entries(tokens.color))
    lines.push(`  static const ${name} = ${dartColor(value)};`);
  lines.push('}', '');
  for (const [product, overrides] of Object.entries(tokens.productos)) {
    lines.push(
      `/// Colores que cambian en el producto \`${product}\`.`,
      `abstract final class Fd${pascal(product)}Colors {`,
    );
    for (const [name, value] of Object.entries(overrides))
      lines.push(`  static const ${name} = ${dartColor(value)};`);
    lines.push('}', '');
  }
  lines.push('/// Un paso de la escala tipográfica.', 'final class FdTextStep {');
  lines.push('  const FdTextStep(this.size, this.lineHeight, this.weight);');
  lines.push('  final double size;', '  final double lineHeight;', '  final int weight;', '}', '');
  lines.push('abstract final class FdType {');
  lines.push(`  static const family = '${tokens.tipografia.familia}';`);
  for (const [name, step] of Object.entries(tokens.tipografia.escala)) {
    lines.push(
      `  static const ${name} = FdTextStep(${step.tamano}, ${step.interlineado}, ${step.peso});`,
    );
  }
  lines.push('}', '');
  lines.push('abstract final class FdRadius {');
  for (const [name, value] of Object.entries(tokens.radio))
    lines.push(`  static const double ${name} = ${value};`);
  lines.push('}', '');
  lines.push('abstract final class FdSpace {');
  for (const [name, value] of Object.entries(tokens.espacio))
    lines.push(`  static const double ${name} = ${value};`);
  lines.push('}');
  return lines.join('\n') + '\n';
}
