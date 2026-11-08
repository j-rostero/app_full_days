#!/usr/bin/env bash
# Punto único de verificación: lo que pasa aquí es lo que pasa en CI.
# Uso: scripts/verificar.sh            (todos los pasos)
#      VERIFICAR_PASOS="lint test" scripts/verificar.sh
# Necesita PostgreSQL y Redis encendidos para las pruebas de la API (pnpm infra:up).
set -euo pipefail
cd "$(dirname "$0")/.."

PASOS="${VERIFICAR_PASOS:-formato lint tipos build pruebas contrato flutter}"
FLUTTER="${FLUTTER:-flutter}"

paso() { printf '\n▶ %s\n' "$1"; }

for p in $PASOS; do
  case "$p" in
    formato) paso 'Formato (prettier)'; pnpm format:check ;;
    lint) paso 'Lint (eslint)'; pnpm lint ;;
    tipos) paso 'Tipos (tsc)'; pnpm typecheck ;;
    build) paso 'Build'; pnpm build ;;
    pruebas) paso 'Pruebas (API contra servicios reales, shared, tokens, contrato TypeScript)'; pnpm test ;;
    contrato) paso 'Cliente Dart al día con openapi.json'; ./scripts/generar-cliente-dart.sh --check ;;
    flutter)
      paso 'Flutter: análisis y pruebas'
      for dir in packages/ui_flutter apps/mobile; do
        (cd "$dir" && "$FLUTTER" pub get > /dev/null && "$FLUTTER" analyze && "$FLUTTER" test)
      done
      ;;
    *) echo "Paso desconocido: $p" >&2; exit 2 ;;
  esac
done

printf '\n✔ Verificación completa: %s\n' "$PASOS"
