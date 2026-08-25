# Logos — Bible Wiki: Schema & Workflows

This repo is an instance of the [LLM Wiki pattern](llm-wiki.md), applied to the Bible. You (the
agent) are the sole author of the `wiki/` layer. The human curates sources, directs ingestion,
asks questions, and reads the result in Obsidian. Read `llm-wiki.md` once for the philosophy;
this file is the concrete, load-bearing spec — follow it exactly.

## Three layers

- **`raw/`** — immutable source texts (Bible text, and later any secondary sources). Never edit
  these once added; only append new raw files.
- **`wiki/`** — everything you generate: passages, books, people, places, themes, connections,
  the indexes, and the log. You create and revise these freely.
- **This file** — the schema. Update it yourself when you and the user discover a convention
  that should change or be added.

## Directory map

```
raw/
  bible/<Book>.md          WEB (World English Bible, public domain) text, one file per book
  assets/                  downloaded images (maps, charts) if any get pulled in later
scripts/
  fetch-book.sh            pulls one book's WEB text from bible-api.com into raw/bible/
templates/                 one template per wiki page type (see below)
.claude/skills/ingest/     the `/ingest` skill — resolves the next pericope, then runs the
                           ingest workflow below
wiki/
  index.md                 top-level dashboard, links out to the five category indexes
  log.md                   append-only chronological record of every operation
  books/
    index.md                canonical 66-book list with ingestion status
    <Book>.md                one page per Bible book
  passages/
    <Book>/<Ref> - <Title>.md   one page per ingested pericope, nested under its book
  people/
    index.md
    <Name>.md
  places/
    index.md
    <Name>.md
  themes/
    index.md
    <Theme>.md
  connections/
    index.md
    <Title>.md               parallels, harmonies, and prophecy → fulfillment pairs
```

## Source text

Raw Bible text is the **World English Bible (WEB)** — public domain, so it can be stored and
quoted verbatim anywhere in the wiki without restriction. It is populated into `raw/bible/`
book-by-book as ingestion reaches that book, not all upfront, by
`scripts/fetch-book.sh "<Book>"` (bible-api.com, `?translation=web`). If the user is consulting a
different translation (ESV, NIV, etc.) during discussion, you may quote short excerpts of it
inline in a passage page's notes for comparison, but never store a full copyrighted book/chapter
in `raw/`.

## Naming conventions

- **Verse references in filenames use periods, not colons**: `Genesis 1.1-2.3 - The Creation of
  the World.md`, not `Genesis 1:1-2:3 ...`. Colons break on some filesystems and Obsidian
  discourages them. Colons are fine in page titles/headings and body text.
- Passage filename shape: `<Ref> - <Short Title>.md`, e.g. `John 11.1-44 - The Raising of
  Lazarus.md`, stored under `wiki/passages/<Book>/`.
- Book, person, place, theme, connection pages are named by their plain title:
  `wiki/people/David.md`, `wiki/themes/Covenant.md`.
- Always link with Obsidian wikilinks (`[[Page Name]]`), never raw markdown links, so the graph
  view and backlinks stay meaningful.
- If a name collides (e.g. two people named "James"), disambiguate in the filename:
  `James (son of Zebedee).md`, `James (son of Alphaeus).md`, `James (brother of Jesus).md`.

## Page types & frontmatter

Every wiki page (not raw sources) gets YAML frontmatter for Dataview compatibility, even though
Dataview isn't required to use the wiki. Concrete templates live in `templates/` — copy the
matching one whenever you create a new page of that type rather than improvising the shape.

| type | file | frontmatter `type:` |
|---|---|---|
| Passage | `templates/passage.md` | `passage` |
| Book | `templates/book.md` | `book` |
| Person | `templates/person.md` | `person` |
| Place | `templates/place.md` | `place` |
| Theme | `templates/theme.md` | `theme` |
| Connection | `templates/connection.md` | `connection` |

## Ingestion unit: pericope

Ingest by **pericope** (a natural narrative, discourse, or thematic unit — e.g. "the Sermon on
the Mount", "Joseph sold into slavery"), not by mechanical chapter breaks. This covers the whole
Bible; it just means variable-sized chunks (some pericopes are a few verses, some span multiple
chapters) instead of uniform ones. When you first touch a book:

1. Draw the breakdown for the whole book yourself, using natural discourse boundaries — you may
   lean on section headings already present in most WEB editions as a starting point, but adjust
   them where a different grouping tells the story better. This is your call; no sign-off needed.
2. Record it as the `## Pericopes` checklist on the book page. That checklist is the ingestion
   queue: the first `- [ ]` box in it is always what gets ingested next, and ingesting a pericope
   checks its box and points it at the new passage page.
3. Treat unchecked boxes as provisional — the user revises them in Obsidian whenever they like,
   and so may you, when the text turns out to divide differently than the plan assumed. Say so in
   the ingest report when you redraw a boundary. Checked boxes are settled: changing one means
   revising the passage page that already exists for it.

## Workflows

### Ingest (one pericope at a time — stay involved)

Run by `/ingest`, which resolves the next pericope and gets its text in place before this runs.

1. Read the pericope's text from `raw/bible/<Book>.md` (run `scripts/fetch-book.sh "<Book>"`
   first if the book isn't there yet — book by book, not the whole Bible at once).
2. Discuss the passage with the user: what's happening, who/where/what's notable, how it
   connects to what's already in the wiki.
3. Create the passage page from `templates/passage.md` under `wiki/passages/<Book>/`.
4. Update the book page (`wiki/books/<Book>.md`) — check this pericope's box in `## Pericopes`
   and link it to the new passage page, and revise the book-level overview if this changes it.
5. Create or update every person/place/theme page the passage touches — add this passage to
   their "Appears in" / "Key passages" list, and update their synthesis if this passage adds,
   nuances, or contradicts what's already written. **Explicitly flag contradictions** rather
   than silently overwriting — note both claims and which sources support each.
6. Create or update connection pages for any parallel passage, prophecy/fulfillment pair, or
   typological link this pericope surfaces.
7. Update `wiki/books/index.md` status for the book, and the relevant category index(es) in
   `wiki/people/index.md`, `wiki/places/index.md`, `wiki/themes/index.md`,
   `wiki/connections/index.md`.
8. Update `wiki/index.md`'s progress counts.
9. Append an entry to `wiki/log.md`.

A single pericope can easily touch 5–15 pages. That's expected — do all of it in the same pass.

### Query

1. Read `wiki/index.md` and the relevant category index(es) first to find candidate pages —
   don't grep the whole wiki blind.
2. Drill into the specific pages, follow their links as needed.
3. Synthesize an answer with citations (page links and/or scripture references).
4. If the answer is substantial — a comparison, an analysis, a connection worth keeping — offer
   to file it back into the wiki as a new page (usually a connection or theme page) rather than
   letting it evaporate into chat history. Only do this if the user wants it kept.
5. Append a `query` entry to `wiki/log.md` if anything was filed back; simple lookups that
   produced no new page don't need a log entry.

### Lint (run when asked, periodically)

Check for and report:
- Contradictions between pages that were never explicitly flagged.
- Orphan pages (no inbound links) — check via what pages exist vs. what the indexes/backlinks
  show.
- Concepts/people/places mentioned repeatedly across passages but lacking their own page.
- Category indexes that are stale relative to what actually exists in their folder.
- Missing cross-references (parallel Gospel accounts, OT quotes in the NT) not yet captured as
  connection pages.
Log a `lint` entry in `wiki/log.md` summarizing what was found and fixed.

## Log format

Append-only, most-recent last, in `wiki/log.md`. Each entry starts with a parseable header:

```
## [YYYY-MM-DD] ingest | Genesis 1.1-2.3 — The Creation of the World
## [YYYY-MM-DD] query | Question text or topic
## [YYYY-MM-DD] lint | What was checked
## [YYYY-MM-DD] schema | A convention in this file that changed, and why
```

`grep "^## \[" wiki/log.md | tail -5` gives the last 5 entries.

## Growth triggers — revisit these as the wiki grows

- **Category index too big to skim** (rule of thumb: >150 entries): split it further, e.g.
  `wiki/people/index.md` into per-testament or alphabetical sub-indexes, and update this file
  to describe the new split.
- **Index-based search stops being enough**: consider setting up
  [qmd](https://github.com/tobi/qmd) for hybrid BM25/vector search over `wiki/`. Not needed at
  small-to-moderate scale.
- **A page type not covered above becomes necessary** (e.g. a dedicated timeline page, a
  genealogy/family-tree page): add a template and a section to this file before creating the
  first instance, so the convention is documented before it's used.
