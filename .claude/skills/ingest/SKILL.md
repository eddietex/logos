---
name: ingest
description: Ingest the next pericope into the wiki. Prefix the argument with `auto` for an unattended run (no discussion, no questions).
argument-hint: "[auto] [Book [chapter]]"
disable-model-invocation: true
---

# Ingest the next pericope

`CLAUDE.md` holds the schema and the numbered ingest workflow — it is the authority on what a
pericope ingest produces. This skill only resolves **which** pericope is next and gets its text
in front of you.

## 0. Resolve the mode

If the argument begins with the keyword **`auto`** (`/ingest auto`, `/ingest auto John 3`), this
is an **unattended** run — a scheduled routine with nobody at the terminal. Strip the keyword and
treat whatever follows as the target. In unattended mode:

- **Skip step 2 of the `CLAUDE.md` ingest workflow — the discussion.** There is no one to discuss
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

Everything else — steps 1 through 5 below, and the whole `CLAUDE.md` workflow — is identical in
both modes.

## 1. Resolve the target

With an argument (`/ingest Genesis 12`, `/ingest John`), take it as the target — read the named
book's page and pick the first unchecked pericope at or after that point.

Without one, take the next pericope in the book currently being worked:

```
grep -n "in-progress" wiki/books/index.md
grep -n -m1 "^- \[ \]" "wiki/books/<Book>.md"
```

That first unchecked box is the target. When every box in the book is checked, mark the book
`complete` in `wiki/books/index.md` and move to the next `not-started` book in canonical order.

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
`CLAUDE.md` end to end — all nine steps interactively, or steps 1 and 3–9 in unattended mode,
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

Co-Authored-By: Claude Opus 5 <noreply@anthropic.com>
EOF
)"
git push
```

Subject line follows the existing history: `Genesis 1.1-2.3 ingested`. Commit and push on the
current branch.

If `git status` is dirty *before* you start — uncommitted work from a previous run or from the
user editing in Obsidian — commit it separately first with its own message, so the ingest commit
stays just the ingest.

**If the push is rejected** because the remote has moved ahead — the user pushing Obsidian edits
from another machine is the usual cause — run `git pull --rebase` and push again. If that also
fails, stop and report it. The commit is safe on the local branch, and a scheduled run resolving a
merge conflict unattended is worse than one that leaves the conflict for the user.

Then report the pericope, the pages created or revised, and the commit and push, and stop. One
pericope per invocation — the next run of `/ingest` takes the next.
