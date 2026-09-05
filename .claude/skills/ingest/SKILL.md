---
name: ingest
description: Ingest the next pericope into the wiki. Prefix the argument with `auto` for an unattended run (no discussion, no questions).
argument-hint: "[auto] [Book [chapter]]"
disable-model-invocation: true
---

# Ingest the next pericope

`AGENTS.md` holds the schema and the numbered ingest workflow — it is the authority on what a
pericope ingest produces. This skill only resolves **which** pericope is next and gets its text
in front of you.

## 0. Resolve the mode

If the argument begins with the keyword **`auto`** (`/ingest auto`, `/ingest auto John 3`), this
is an **unattended** run — a scheduled routine with nobody at the terminal. Strip the keyword and
treat whatever follows as the target. In unattended mode:

- **Skip step 2 of the `AGENTS.md` ingest workflow — the discussion.** There is no one to discuss
  with. Everything you would have said aloud goes into the passage page instead: what is
  happening, who and where and what is notable, how it connects to what is already in the wiki.
  The page absorbs the discussion; it is not dropped.
- **Never ask a question.** Every judgment call the workflow allows — where a pericope boundary
  falls, whether a minor figure earns a page, which of two titles to use — is yours to make. Make
  it, and record it in the log entry so the user can review it later.
- **Never stop mid-pericope for input.** If something genuinely blocks the ingest (the raw text
  won't fetch, the book page is malformed), commit whatever is safely complete, write what
  blocked you into `wiki/log.md`, and stop there. Do not leave a half-ingested pericope
  uncommitted.

Without the keyword, run interactively: the discussion in step 2 happens as written, and a real
ambiguity is worth a question.

Everything else — steps 0.5 through 5 below, and the whole `AGENTS.md` workflow — is identical in
both modes.

## 0.5 Get onto `main` before anything else

```
scripts/git-preflight.sh
```

Run this **first, before reading anything or writing a single page.** A scheduled run's container
checks the repo out on a **detached HEAD** rather than on `main`, and its cached clone carries a
local `main` ref frozen many commits back. On a detached HEAD there is no current branch, so both
of the git commands this skill used to end on fail outright:

```
git push          → fatal: You are not currently on a branch.
git pull --rebase → You are not currently on a branch.
```

The script puts the session on `main` tracking `origin/main`, and it is safe in every state: it
moves `main` only to a commit git has confirmed loses nothing, touches the working tree only when
it is clean, and leaves a feature branch alone entirely. It prints one line saying what it did.
The `SessionStart` hook in `.claude/hooks/` already runs it, so in a normal session this step is a
confirming no-op — run it anyway, because the ingest must not be built on a base you have not
checked.

**If it exits non-zero, stop and report.** It exits non-zero only for the two states it must not
resolve on its own — a tree dirty in a way that blocks the checkout, and a HEAD that has diverged
from `origin/main` — and in both it has changed nothing. Resolving a divergence unattended is
worse than leaving it for the user.

**Never run `git checkout -B main origin/main` yourself after committing.** On a detached HEAD
that command discards the commit you just made, silently and unrecoverably from the log alone.
Moving the branch is the preflight's job, it happens before the work, and it never happens twice.

## 1. Resolve the target

With an argument (`/ingest Genesis 12`, `/ingest John`), take it as the target — read the named
book's page and pick the first unchecked pericope at or after that point.

Without one, resolve the book mechanically. `wiki/books/index.md` lists all 66 books in canonical
order, so scanning it top to bottom is reading the Bible in order. Take the **first `in-progress`
book in that file**, then the **first unchecked box on its page**:

```
grep -n -m1 "^- .*in-progress" wiki/books/index.md   # → the target book
grep -n -m1 "^- \[ \]" "wiki/books/<Book>.md"        # → the target pericope
```

Anchor the pattern to `^- ` as above. An unanchored `grep "in-progress"` matches the status legend
near the top of the file instead of a book.

**More than one book can be `in-progress` at once, and the earliest always wins.** The user may
start a book out of canonical order, and a book stays `in-progress` for dozens of ingests, so
"the book currently being worked" is often not a single book. Never resolve that by asking, by
which book was ingested most recently, or by what the last log entry mentions — take the one that
comes first in `wiki/books/index.md`. Genesis before Job, always. This is what makes an unattended
run deterministic: `/ingest auto` must never have a fork here.

**An `in-progress` book outranks an earlier `not-started` one.** If Genesis is complete and Job is
`in-progress`, the next target is Job and not Exodus — open books get finished before new ones are
opened. Only when nothing is `in-progress` does the scan fall through to the first `not-started`
book in the file, whose page and pericope plan you then create per step 3.

When every box in a book is checked, mark it `complete` in `wiki/books/index.md`. The next run's
scan then moves on by itself, with no other bookkeeping needed.

## 2. Make sure the raw text is there

```
scripts/fetch-book.sh "<Book>"
```

Fetches the whole book's WEB text from bible-api.com into `raw/bible/<Book>.md` (~2s per
chapter, so run it in the background for long books). It refuses to overwrite, so running it on
a book already fetched is a safe no-op.

## 3. Make sure the book has a pericope plan

A book with no page has no plan yet. Create the page from `templates/book.md` and draw the full
pericope breakdown for the book — natural narrative, discourse, and thematic units, not chapter
boundaries — into its `## Pericopes` checklist, then keep going in the same invocation. The
breakdown is yours to make; the user revises unchecked boxes whenever they want, so a boundary
you get wrong costs an edit, not a stop.

The same freedom applies mid-book: if the text divides differently than the plan assumed, redraw
the unchecked boxes and say so in your report.

## 4. Ingest

Read the pericope's verses from `raw/bible/<Book>.md`, then work the numbered ingest workflow in
`AGENTS.md` end to end — all nine steps interactively, or steps 1 and 3–9 in unattended mode,
with step 2's discussion written into the passage page instead. Quote the WEB text verbatim from
the raw file — never from memory.

Done means every one of these is true:

- The passage page exists at `wiki/passages/<Book>/<Title>.md` — title alone, no reference in the
  filename.
- **`scripts/link-check.sh` has been run and exits 0** — every wikilink is intact (none split
  across a line wrap) and resolves to a page that exists. Run the script; do not substitute
  reading the pages. A finding is either a link to fix now or one you deliberately left for a
  later pericope, which goes in the log entry. The not-yet-started book pages are the expected
  baseline and the script already excludes them from its findings.
- No other book already has a passage page by that title. One that does means both pages take the
  `<Title> (<Book>).md` form, the existing one renamed and its inbound links fixed in this pass.
- Every person, place, theme, and connection the pericope touches has a page that names this
  passage, and whose synthesis accounts for it — with any contradiction against an existing page
  written out explicitly, both claims and their sources, rather than overwritten.
- The book page's box for this pericope is checked and links to the passage page.
- `wiki/books/index.md`, the touched category indexes, and `wiki/index.md`'s counts all match
  what is now on disk.
- `wiki/log.md` has the new `ingest` entry appended.

## 5. Commit and push

Every ingest ends in a commit **and a push**, in both modes — a scheduled run must leave nothing
uncommitted and nothing unpushed for the next run to trip over. Stage everything the pass touched,
including the raw book text if step 2 fetched it:

```
git add -A
git commit -m "$(cat <<'EOF'
<Book> <ref> ingested

<one or two lines: the pericope, and the pages created or revised>

Co-Authored-By: <the agent running this skill>
EOF
)"
git push origin main
```

Subject line follows the existing history: `Genesis 1.1-2.3 ingested`. Fill the
`Co-Authored-By:` trailer with your own agent identity — name and contact address — not a
hardcoded one; drop the line entirely if your harness already appends its own trailer.

**Push to `origin main` by name, never a bare `git push`.** The wiki lives on `main` and nowhere
else. A bare push follows whatever branch the container happens to have created, and when that was
a per-run throwaway branch it silently landed three separate ingests on three branches nobody ever
merged — `61a0c63`, `02b94e3` and `11a71f6`, all of them `Genesis 9.1-17 ingested`. Naming the
refspec is what makes that impossible rather than unlikely.

If `git status` is dirty *before* you start — uncommitted work from a previous run or from the
user editing in Obsidian — commit it separately first with its own message, so the ingest commit
stays just the ingest.

**If the push is rejected** because the remote has moved ahead — the user pushing Obsidian edits
from another machine is the usual cause — run `git pull --rebase origin main` and push again.
Name the remote and branch here too: bare `git pull --rebase` needs an upstream, and the whole
point of step 0.5 is that you cannot assume the session started with one. If the rebase also
fails, stop and report it. The commit is safe on the local branch, and a scheduled run resolving a
merge conflict unattended is worse than one that leaves the conflict for the user.

Then report the pericope, the pages created or revised, and the commit and push, and stop. One
pericope per invocation — the next run of `/ingest` takes the next.
