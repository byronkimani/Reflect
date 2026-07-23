#!/usr/bin/env bash
# Generates Firebase App Distribution release notes for CI deploy jobs.
#
# Usage:
#   ./tool/generate_release_notes.sh <channel> <sha> <before_sha> <run_number> [output_file]
#
# Channels: qa-develop | production-interim
#
# Commit messages are collected from <before_sha>..<sha> (exclusive..inclusive).
# When the push is a GitHub merge commit, the PR title and body are included when
# the GitHub CLI is available (GITHUB_TOKEN).

set -euo pipefail

CHANNEL="${1:?channel required (qa-develop | production-interim)}"
SHA="${2:?sha required}"
BEFORE_SHA="${3:?before_sha required}"
RUN_NUMBER="${4:?run_number required}"
OUTPUT="${5:-release-notes.txt}"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

VERSION_LINE="$(grep '^version:' pubspec.yaml | awk '{print $2}')"
VERSION_NAME="${VERSION_LINE%%+*}"
SHORT_SHA="$(printf '%.7s' "$SHA")"

channel_header() {
  case "$CHANNEL" in
    production-interim)
      echo "[Production interim — App Tester]"
      echo "Reflect $VERSION_NAME (build $RUN_NUMBER) · main · $SHORT_SHA"
      echo ""
      echo "Temporary App Tester delivery from the production branch. Google Play upload will replace this path in a future workflow update."
      ;;
    qa-develop)
      echo "[QA develop]"
      echo "Reflect $VERSION_NAME (build $RUN_NUMBER) · develop · $SHORT_SHA"
      echo ""
      echo "Integration build for qa-team after merge to develop."
      ;;
    *)
      echo "Unknown channel: $CHANNEL" >&2
      exit 1
      ;;
  esac
}

merge_subject="$(git log -1 --pretty=format:%s "$SHA" 2>/dev/null || true)"
pr_number=""
if [[ "$merge_subject" =~ Merge\ pull\ request\ #([0-9]+) ]]; then
  pr_number="${BASH_REMATCH[1]}"
fi

{
  channel_header
  echo ""

  if [[ -n "$pr_number" ]] && command -v gh >/dev/null 2>&1; then
    pr_title="$(gh pr view "$pr_number" --json title --jq .title 2>/dev/null || true)"
    pr_body="$(gh pr view "$pr_number" --json body --jq .body 2>/dev/null || true)"
    if [[ -n "$pr_title" ]]; then
      echo "What's in this build"
      echo "-------------------"
      echo "$pr_title"
      if [[ -n "$pr_body" && "$pr_body" != "null" ]]; then
        echo ""
        printf '%s\n' "$pr_body" | sed '/^<!--/d' | head -c 3500
        echo ""
      fi
      echo ""
    fi
  fi

  echo "Commits"
  echo "-------"
  zero_sha="0000000000000000000000000000000000000000"
  if [[ -z "$BEFORE_SHA" || "$BEFORE_SHA" == "$zero_sha" ]]; then
    git log -15 --no-merges --pretty=format:'- %s' "$SHA" || true
  else
    count="$(git rev-list --count --no-merges "${BEFORE_SHA}..${SHA}" 2>/dev/null || echo 0)"
    if [[ "$count" -eq 0 ]]; then
      echo "- (no new commits; rebuild of $SHORT_SHA)"
    else
      git log --no-merges --pretty=format:'- %s' "${BEFORE_SHA}..${SHA}" || true
    fi
  fi
  echo ""
} >"$OUTPUT"

echo "Wrote $OUTPUT ($(wc -l <"$OUTPUT" | tr -d ' ') lines)"
