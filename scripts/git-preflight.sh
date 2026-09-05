#!/usr/bin/env bash
# Put the session on a real `main` branch tracking `origin/main`, before any work starts.
#
#   scripts/git-preflight.sh
#
# A scheduled run's container checks the repo out on a *detached HEAD* rather than on `main`,
# and its cached clone carries a stale local `main` ref. On a detached HEAD there is no current
# branch, so `git push` and `git pull --rebase` both fail outright — which left every unattended
# ingest improvising its own recovery at the end of the pass, after all the work was already
# built. This script does that recovery once, deterministically, at the start.
#
# Every branch below is non-destructive by construction: `main` is only moved to a commit that
# git itself has confirmed loses nothing, and the working tree is only touched when it is clean.
# Anything ambiguous is reported and left exactly as it was found.
#
# Exit 0 — the session is on `main` and safe to work on (or on a feature branch, deliberately).
# Exit 1 — it is not, and the agent or the user has to decide what to do.

set -uo pipefail

say() { printf 'git-preflight: %s\n' "$*"; }

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

# A deliberate feature branch is a legitimate state — an interactive session working on
# `claude/…` must never be yanked onto `main` by a session-start hook.
if [[ -n "$branch" && "$branch" != "main" ]]; then
  say "on branch '$branch', not main — leaving it alone"
  exit 0
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
  # Detached HEAD: create `main` at whichever commit keeps every existing commit.
  if git merge-base --is-ancestor "$remote" "$head"; then
    # HEAD is at or ahead of origin/main. Pointing main at HEAD is a pure ref operation —
    # the working tree is never touched, so this is safe even with uncommitted changes.
    git checkout -B main "$head" >/dev/null 2>&1 || { say "could not create main at HEAD"; exit 1; }
    if [[ "$head" == "$remote" ]]; then
      say "was detached at origin/main; now on main ($(git rev-parse --short HEAD))"
    else
      say "was detached $(git rev-list --count "$remote".."$head") commit(s) ahead of origin/main; main now carries them ($(git rev-parse --short HEAD))"
    fi
  elif git merge-base --is-ancestor "$head" "$remote"; then
    # origin/main has moved ahead since the checkout. Moving there rewrites the working tree.
    if [[ -n "$dirty" ]]; then
      say "detached behind origin/main with a dirty tree — commit or stash first, nothing was touched"
      exit 1
    fi
    git checkout -B main origin/main >/dev/null 2>&1 || { say "could not move main to origin/main"; exit 1; }
    say "was detached behind origin/main; now on main at origin/main ($(git rev-parse --short HEAD))"
  else
    say "detached HEAD has diverged from origin/main — resolve this by hand, nothing was touched"
    exit 1
  fi
fi

git branch --quiet --set-upstream-to=origin/main main >/dev/null 2>&1 || true
[[ -n "$dirty" ]] && say "note: the working tree is dirty; commit that separately before the ingest commit"
exit 0
