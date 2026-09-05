#!/usr/bin/env bash
# SessionStart hook — runs `scripts/git-preflight.sh` before the agent does anything.
#
# A scheduled ingest's container starts on a detached HEAD with a stale local `main`. Left to
# itself, each run rediscovers that at the *end* of the pass and improvises a recovery; the
# improvisations have differed run to run, and one of them (`git checkout -B main origin/main`
# after committing) would silently discard the ingest. This makes the recovery happen once,
# the same way every time, before any work is built on top of the wrong base.
#
# The preflight refuses to act on anything ambiguous and exits 1 to say so. That is a message
# for the agent, not a reason to stop the session starting — so its output is passed through
# (SessionStart stdout becomes session context) and the hook always exits 0.

set -uo pipefail

"${CLAUDE_PROJECT_DIR:-.}/scripts/git-preflight.sh" || true
exit 0
