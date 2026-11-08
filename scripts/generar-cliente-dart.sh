#!/usr/bin/env bash
# Genera el cliente Dart de la API (packages/api_dart) desde packages/api-client/openapi.json.
# Uso: scripts/generar-cliente-dart.sh [--check]
#   --check  genera en un directorio temporal y falla si difiere del versionado.
set -euo pipefail

VERSION=7.27.0
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CACHE="${XDG_CACHE_HOME:-$HOME/.cache}/fulldays"
JAR="$CACHE/openapi-generator-cli-$VERSION.jar"
SPEC="$ROOT/packages/api-client/openapi.json"
OUT="$ROOT/packages/api_dart"

if [[ ! -f "$JAR" ]]; then
  mkdir -p "$CACHE"
  curl -fsSL -o "$JAR.tmp" \
    "https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/$VERSION/openapi-generator-cli-$VERSION.jar"
  mv "$JAR.tmp" "$JAR"
fi

generate() {
  java -jar "$JAR" generate --skip-validate-spec -g dart -i "$SPEC" -o "$1" \
    --additional-properties pubName=fulldays_api,pubDescription="Cliente Dart de la API de FullDays (generado)",pubAuthor=FullDays,pubVersion=1.0.0 \
    > /dev/null
  # Solo el código del cliente: sin documentación, pruebas de ejemplo ni archivos del generador.
  rm -rf "$1/.openapi-generator" "$1/.openapi-generator-ignore" "$1/.travis.yml" "$1/git_push.sh" \
    "$1/.gitignore" "$1/README.md" "$1/doc" "$1/test"
}

if [[ "${1:-}" == "--check" ]]; then
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  generate "$TMP"
  if ! diff -r -q -x pubspec.lock -x .dart_tool "$OUT" "$TMP" > /dev/null; then
    diff -r -x pubspec.lock -x .dart_tool "$OUT" "$TMP" | head -40 || true
    echo "El cliente Dart no coincide con openapi.json. Ejecuta: pnpm api:client" >&2
    exit 1
  fi
  echo "Cliente Dart al día."
else
  rm -rf "$OUT/lib"
  generate "$OUT"
  echo "Cliente Dart generado en packages/api_dart"
fi
