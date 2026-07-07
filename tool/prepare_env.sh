#!/usr/bin/env bash
set -euo pipefail

FLAVOR="${1:-testing}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE="$ROOT/.env.$FLAVOR"
TARGET="$ROOT/env/active.env"
EXAMPLE="$ROOT/env/active.env.example"

mkdir -p "$ROOT/env"

if [[ -f "$SOURCE" ]]; then
  cp "$SOURCE" "$TARGET"
  echo "Prepared env/active.env from .env.$FLAVOR"
elif [[ -f "$TARGET" ]]; then
  echo "env/active.env already exists and .env.$FLAVOR not found. Leaving it intact to preserve custom keys!"
elif [[ -f "$EXAMPLE" ]]; then
  cp "$EXAMPLE" "$TARGET"
  echo "Prepared env/active.env from env/active.env.example (.env.$FLAVOR not found)"
else
  echo "Error: no .env.$FLAVOR, env/active.env, or env/active.env.example found" >&2
  exit 1
fi
