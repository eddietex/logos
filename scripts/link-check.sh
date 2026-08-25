#!/usr/bin/env bash
# Check every wikilink in the wiki for the two failures that reading the page will not catch.
#
#   scripts/link-check.sh          # check wiki/
#   scripts/link-check.sh -a       # also list the expected unstarted-book baseline
#   scripts/link-check.sh -a docs  # check a different vault root
#
# Check 1 — wrapped links: a `[[` and its `]]` on different lines. Obsidian only parses a link
# that sits entirely on one line, so a link broken by the ~100-column wrap is not a broken link,
# it is not a link at all — it renders as literal text and vanishes from the graph and from
# backlinks. Nothing that searches for `[[...]]` can see it, which is why check 2 cannot replace
# this one. Any finding is a bug.
#
# Check 2 — dangling targets: links whose page does not exist. A target resolves if either
# Obsidian link form resolves: a path-style link from the vault root (`[[books/index]]`) or the
# ordinary shortest-path link (`[[David]]`). Book pages that are linked from books/index.md but
# not yet written are the expected baseline (one per not-yet-started book) and are counted, not
# reported.
#
# Both checks skip fenced code blocks and inline code spans, because wiki/log.md quotes broken
# links verbatim whenever it records a link problem, and those examples must not register as
# findings.
#
# Exits 0 when clean, 1 when either check finds something real.

set -euo pipefail

SHOW_BASELINE=0
if [[ "${1:-}" == "-a" ]]; then
  SHOW_BASELINE=1
  shift
fi

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
DIR="${1:-wiki}"

if [[ ! -d "$DIR" ]]; then
  echo "no such directory: $DIR" >&2
  exit 1
fi

status=0

# --- Check 1: wrapped links -------------------------------------------------------------------

wrapped="$(find "$DIR" -name '*.md' -print0 | xargs -0 -r awk '
  FNR==1 { fence=0 }
  /^[[:space:]]*```/ { fence=!fence; next }
  !fence { l=$0; gsub(/`[^`]*`/,"",l);
           if (gsub(/\[\[/,"",l) != gsub(/\]\]/,"",l)) print FILENAME":"FNR }')"

if [[ -n "$wrapped" ]]; then
  echo "WRAPPED LINKS — a [[ and its ]] on different lines, so Obsidian sees no link at all:"
  # Page filenames contain spaces, so read line by line rather than word-splitting.
  while IFS= read -r hit; do printf '  %s\n' "$hit"; done <<<"$wrapped"
  echo
  status=1
fi

# --- Check 2: dangling targets ----------------------------------------------------------------

# Every page that exists, indexed under both link forms.
declare -A by_path by_name
while IFS= read -r p; do
  by_path["${p%.md}"]=1
  b="${p##*/}"
  by_name["${b%.md}"]=1
done < <(find "$DIR" -name '*.md' -printf '%P\n')

# Every link target, with the pages that link to it.
declare -A sources
while IFS=$'\t' read -r src tgt; do
  [[ -n "$tgt" ]] || continue
  [[ -n "${by_path[$tgt]:-}" || -n "${by_name[$tgt]:-}" ]] && continue
  sources["$tgt"]+="${sources[$tgt]:+, }$src"
done < <(find "$DIR" -name '*.md' -print0 | xargs -0 -r awk '
  FNR==1 { fence=0 }
  /^[[:space:]]*```/ { fence=!fence; next }
  !fence { l=$0; gsub(/`[^`]*`/,"",l)
           while (match(l, /\[\[[^]]*\]\]/)) {
             t=substr(l,RSTART+2,RLENGTH-4); sub(/\|.*/,"",t); sub(/#.*/,"",t)
             gsub(/^[ \t]+|[ \t]+$/,"",t)
             if (t != "") print FILENAME"\t"t
             l=substr(l,RSTART+RLENGTH) } }' | sort -u)

# A dangling target that books/index.md links to is a book not yet ingested — the known baseline.
BOOKS_INDEX="$DIR/books/index.md"
baseline=()
unexpected=()
for tgt in "${!sources[@]}"; do
  if [[ "${sources[$tgt]}" == *"$BOOKS_INDEX"* ]]; then
    baseline+=("$tgt")
  else
    unexpected+=("$tgt")
  fi
done

if ((${#unexpected[@]})); then
  echo "DANGLING LINKS — target page does not exist:"
  while IFS= read -r tgt; do
    printf '  %s\n      linked from: %s\n' "$tgt" "${sources[$tgt]}"
  done < <(printf '%s\n' "${unexpected[@]}" | sort)
  echo
  status=1
fi

if ((${#baseline[@]})); then
  if ((SHOW_BASELINE)); then
    echo "Not-yet-started book pages (expected baseline, ${#baseline[@]}):"
    printf '%s\n' "${baseline[@]}" | sort | sed 's/^/  /'
    echo
  else
    echo "Not-yet-started book pages (expected baseline): ${#baseline[@]}  — pass -a to list them"
    echo
  fi
fi

if ((status == 0)); then
  echo "link checks clean"
fi

exit "$status"
