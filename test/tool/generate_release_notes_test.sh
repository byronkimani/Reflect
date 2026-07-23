#!/usr/bin/env bash
# Smoke test for tool/generate_release_notes.sh (run from repo root in CI or locally).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"

chmod +x tool/generate_release_notes.sh

HEAD="$(git rev-parse HEAD)"
PARENT="$(git rev-parse HEAD~1 2>/dev/null || echo 0000000000000000000000000000000000000000)"
OUT="$(mktemp)"

tool/generate_release_notes.sh qa-develop "$HEAD" "$PARENT" 999 "$OUT"

grep -q 'Reflect ' "$OUT"
grep -q 'Commits' "$OUT"
grep -q '\[QA develop\]' "$OUT"

rm -f "$OUT"
echo 'generate_release_notes.sh smoke test passed'
