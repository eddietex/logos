---
name: ingest
description: Ingest the next pericope into the wiki.
disable-model-invocation: true
---

# Ingest the next pericope

`CLAUDE.md` holds the schema and the numbered ingest workflow — it is the authority on what a
pericope ingest produces. This skill only resolves **which** pericope is next and gets its text
in front of you.

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
`CLAUDE.md` end to end. Quote the WEB text verbatim from the raw file — never from memory.

Done means every one of these is true:

- The passage page exists at `wiki/passages/<Book>/<Title>.md` — title alone, no reference in the
  filename — and every wikilink in it resolves to a page that exists, or is one you deliberately
  left for a later pericope.
- No other book already has a passage page by that title. One that does means both pages take the
  `<Title> (<Book>).md` form, the existing one renamed and its inbound links fixed in this pass.
- Every person, place, theme, and connection the pericope touches has a page that names this
  passage, and whose synthesis accounts for it — with any contradiction against an existing page
  written out explicitly, both claims and their sources, rather than overwritten.
- The book page's box for this pericope is checked and links to the passage page.
- `wiki/books/index.md`, the touched category indexes, and `wiki/index.md`'s counts all match
  what is now on disk.
- `wiki/log.md` has the new `ingest` entry appended.

Then report the pericope and the pages created or revised, and stop. One pericope per
invocation — the user re-runs `/ingest` for the next.
