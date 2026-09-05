#!/usr/bin/env bash
# Put the session on a real `main` branch tracking `origin/main`, before any work starts.
#
#   scripts/git-preflight.sh                # respects whatever branch the session is on
#   scripts/git-preflight.sh --force-main   # a non-main branch is moved onto main too
#
# A scheduled run's container does not put the session on `main`. Depending on the routine's
# outcome-branch setting it starts either on a *detached HEAD* or on a throwaway branch, and its
# cached clone carries a stale local `main` ref. On a detached HEAD there is no current branch, so
# `git push` and `git pull --rebase` both fail outright; on a throwaway branch they succeed and
# strand the ingest somewhere nobody merges. Either way the ingest must end up on `main`, and this
# script is what gets it there — once, at the start, instead of being improvised at the end.
#
# Every branch below is non-destructive by construction: `main` is only moved to a commit that git
# itself has confirmed loses nothing, and the working tree is only touched when it is clean.
# Anything ambiguous is reported and left exactly as it was found.
#
# Exit 0 — the session is on `main` and safe to work on (or on a feature branch, deliberately).
# Exit 1 — it is not, and the agent or the user has to decide what to do.

set -uo pipefail

say() { printf 'git-preflight: %s\n' "$*"; }

force_main=false
for arg in "$@"; do
  case "$arg" in
    --force-main) force_main=true ;;
    *) say "unknown argument: $arg"; exit 1 ;;
  esac
done

cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || echo .)}" || {
  say "not a git repository; nothing to do"
  exit 1
}

# Network flakiness is retried; an unreachable origin is not a reason to guess.
fetch_origin() {
  local delay=2 attempt
  for attempt in 1 2 3 4; do
    git fetch --quiet origin main && return 0
    say "fetch of origin/main failed (attempt $attempt of 4); retrying in ${delay}s"
    sleep "$delay"
    delay=$((delay * 2))
  done
  return 1
}

if ! fetch_origin; then
  say "could not reach origin; leaving the working tree exactly as it is"
  exit 1
fi

remote="$(git rev-parse origin/main)"
head="$(git rev-parse HEAD)"
branch="$(git symbolic-ref --quiet --short HEAD || true)"
dirty="$(git status --porcelain)"
whence="detached HEAD"

# A deliberate feature branch is a legitimate state — an interactive session working on `claude/…`
# must never be yanked onto `main` by a session-start hook. An unattended ingest is the exception,
# and says so explicitly with --force-main: a scheduled run's branch is a container artifact, not
# somebody's work in progress, and the wiki only ever lives on `main`.
if [[ -n "$branch" && "$branch" != "main" ]]; then
  if [[ "$force_main" != true ]]; then
    say "on branch '$branch', not main — leaving it alone"
    exit 0
  fi
  say "on branch '$branch' with --force-main; moving to main, keeping every commit"
  whence="branch '$branch'"
  branch=""   # fall through to the same lossless logic the detached case uses
fi

if [[ -n "$branch" ]]; then
  # Already on main. Fast-forward it if the remote has moved ahead; never rewind or merge.
  if [[ "$head" == "$remote" ]]; then
    say "on main, already at origin/main ($(git rev-parse --short HEAD))"
  elif git merge-base --is-ancestor "$head" "$remote"; then
    if [[ -n "$dirty" ]]; then
      say "on main, behind origin/main, but the working tree is dirty — commit or stash first"
      exit 1
    fi
    git merge --ff-only origin/main >/dev/null || { say "fast-forward of main failed"; exit 1; }
    say "on main, fast-forwarded to origin/main ($(git rev-parse --short HEAD))"
  elif git merge-base --is-ancestor "$remote" "$head"; then
    say "on main, $(git rev-list --count "$remote".."$head") commit(s) ahead of origin/main — unpushed work, left as is"
  else
    say "on main, but it has diverged from origin/main — resolve this by hand, nothing was touched"
    exit 1
  fi
else
  # No usable branch (detached, or forced off one): create `main` at whichever commit keeps
  # every existing commit.
  if git merge-base --is-ancestor "$remote" "$head"; then
    # HEAD is at or ahead of origin/main. Pointing main at HEAD is a pure ref operation —
    # the working tree is never touched, so this is safe even with uncommitted changes.
    git checkout -B main "$head" >/dev/null 2>&1 || { say "could not create main at HEAD"; exit 1; }
    if [[ "$head" == "$remote" ]]; then
      say "was $whence at origin/main; now on main ($(git rev-parse --short HEAD))"
    else
      say "was $whence, $(git rev-list --count "$remote".."$head") commit(s) ahead of origin/main; main now carries them ($(git rev-parse --short HEAD))"
    fi
  elif git merge-base --is-ancestor "$head" "$remote"; then
    # origin/main has moved ahead. Moving there rewrites the working tree.
    if [[ -n "$dirty" ]]; then
      say "was $whence behind origin/main with a dirty tree — commit or stash first, nothing was touched"
      exit 1
    fi
    git checkout -B main origin/main >/dev/null 2>&1 || { say "could not move main to origin/main"; exit 1; }
    say "was $whence behind origin/main; now on main at origin/main ($(git rev-parse --short HEAD))"
  else
    say "$whence has diverged from origin/main — resolve this by hand, nothing was touched"
    exit 1
  fi
fi

git branch --quiet --set-upstream-to=origin/main main >/dev/null 2>&1 || true
[[ -n "$dirty" ]] && say "note: the working tree is dirty; commit that separately before the ingest commit"
exit 0
