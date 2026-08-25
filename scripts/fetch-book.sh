#!/usr/bin/env bash
# Fetch one Bible book's WEB (World English Bible, public domain) text from bible-api.com
# into raw/bible/<Book>.md, one heading per chapter, one verse per line.
#
#   scripts/fetch-book.sh "Genesis"
#   scripts/fetch-book.sh "1 Samuel"
#
# Idempotent: refuses to overwrite an existing raw file (raw/ is immutable by convention).
# Walks chapters upward until the API reports the chapter does not exist, so no chapter-count
# table is needed. Sleeps between requests to stay under bible-api.com's rate limit
# (~15 requests / 30s).

set -euo pipefail

BOOK="${1:?usage: fetch-book.sh \"<Book Name>\"}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT="$ROOT/raw/bible/$BOOK.md"
QUERY="$(printf '%s' "$BOOK" | sed 's/ /+/g')"

if [[ -e "$OUT" ]]; then
  echo "refusing to overwrite existing raw file: $OUT" >&2
  exit 1
fi

mkdir -p "$ROOT/raw/bible"
TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

{
  printf '# %s\n\n' "$BOOK"
  printf '*World English Bible (WEB) — public domain. Fetched from bible-api.com.*\n'
} >"$TMP"

chapter=1
while :; do
  # Past the last chapter the API answers 404 with a JSON error body; that is the loop's
  # stop signal, so a non-zero curl must not abort the script.
  json="$(curl -sS "https://bible-api.com/${QUERY}+${chapter}?translation=web" || true)"

  if ! printf '%s' "$json" | jq -e '.verses | length > 0' >/dev/null 2>&1; then
    break
  fi

  {
    printf '\n## Chapter %d\n\n' "$chapter"
    printf '%s' "$json" | jq -r '.verses[] | "**\(.verse)** " + (.text | gsub("\\s+"; " ") | sub("^ "; "") | sub(" $"; ""))'
  } >>"$TMP"

  echo "  $BOOK $chapter" >&2
  chapter=$((chapter + 1))
  sleep 2
done

if [[ $chapter -eq 1 ]]; then
  echo "no chapters returned for '$BOOK' — check the book name" >&2
  exit 1
fi

printf '\n' >>"$TMP"
mv "$TMP" "$OUT"
trap - EXIT
echo "wrote $OUT ($((chapter - 1)) chapters)" >&2
