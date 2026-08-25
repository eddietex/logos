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
  link-check.sh            both wikilink checks (see `## Link checks` below)
templates/                 one template per wiki page type (see below)
.claude/skills/ingest/     the `/ingest` skill — resolves the next pericope, then runs the
                           ingest workflow below; `/ingest auto` runs it unattended
.claude/settings.json      permission allowlist that lets an unattended run commit and push on
                           its own
wiki/
  index.md                 top-level dashboard, links out to the five category indexes
  log.md                   append-only chronological record of every operation
  books/
    index.md                canonical 66-book list with ingestion status
    <Book>.md                one page per Bible book
  passages/
    <Book>/<Title>.md        one page per ingested pericope, nested under its book
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

- **Passage pages are named by title alone** — `The Raising of Lazarus.md`, not
  `John 11.1-44 - The Raising of Lazarus.md`. The folder (`wiki/passages/<Book>/`) supplies the
  book and the `ref:` frontmatter supplies the verses, so the filename carries neither, and links
  read as prose: `[[The Raising of Lazarus]]`.
- **A link's visible text is the page title.** Do not pipe a scripture reference over it —
  `[[The Binding of Isaac|Genesis 22]]` tells the reader where the passage is but not where the
  link goes, and the title is the more useful of the two because it says what they will find. When
  the reference also matters in that sentence, give it in the prose beside the link rather than in
  place of it:

  ```
  bad:   Where [[The Creation of the World|Genesis 1]] moved across six days …
  good:  Where [[The Creation of the World]] moved across six days …
  good:  … reaches back to the seventh day of [[The Creation of the World]], Genesis 2:2–3.
  ```

  The passage page's `ref:` frontmatter and `**Reference:**` line always carry the verses, so a
  reader who follows the link lands on them immediately. Piping is still correct where the target
  filename is genuinely not the words you want on the page — the path-style category links in
  `wiki/index.md` (`[[people/index|People]]`) are the standing example.
- **On a title collision between books, qualify both pages with the book** — the Gospels and
  Kings/Chronicles will do this often. `The Transfiguration (Matthew).md`,
  `The Transfiguration (Mark).md`. A collision only surfaces when the second book arrives, so
  when it does, rename the page that already exists as well and fix its inbound links in the same
  pass. An unqualified duplicate title is a lint finding.
- Colons never appear in filenames (they break on some filesystems and Obsidian discourages
  them); they are fine in page titles, headings, and body text.
- Book, person, place, theme, connection pages are named by their plain title:
  `wiki/people/David.md`, `wiki/themes/Covenant.md`.
- Always link with Obsidian wikilinks (`[[Page Name]]`), never raw markdown links, so the graph
  view and backlinks stay meaningful.
- **A wikilink must never be split across a line break.** Obsidian only parses `[[...]]` when the
  whole link — brackets, target, pipe, and display text — sits on one line; a link broken by the
  ~100-column wrap used throughout the wiki renders as literal `[[` text and silently disappears
  from the graph and from backlinks. When a link would straddle the wrap, break the line *before*
  the `[[` and let that line run short:

  ```
  bad:   Where [[The Creation of the World|Genesis
         1]] moved across six days …

  good:  Where
         [[The Creation of the World|Genesis 1]] moved across six days …
  ```

  This is the one case where the wrap width yields. Long link targets in prose make it easy to hit
  and easy to miss, because the result is not a broken link — it is not a link at all, so nothing
  that searches for `[[...]]` will ever report it.
- If a name collides (e.g. two people named "James"), disambiguate in the filename:
  `James (son of Zebedee).md`, `James (son of Alphaeus).md`, `James (brother of Jesus).md`.
- **When a person shares a name with a book, the person page takes `(person)`.** The book page keeps
  the bare name, because `wiki/books/<Book>.md` is fixed by the directory map above and by the 66
  links in `wiki/books/index.md`; the person becomes `wiki/people/Job (person).md`, linked as
  `[[Job (person)]]`. This will recur for roughly two dozen books — Ruth, Samuel, Ezra, Nehemiah,
  Esther, Daniel, the twelve Minor Prophets, and several of the New Testament letters — so the rule
  is mechanical on purpose rather than descriptive: a name that already needs disambiguating for
  another reason (`John the Baptist`, `James (son of Zebedee)`) never produces a bare collision and
  so never needs `(person)`.

  This collision is invisible to `scripts/link-check.sh`, which resolves targets by basename and
  will happily pass two files called `Job.md`. Obsidian, meanwhile, picks one of them by an
  unstated rule. That is the whole reason the convention is mandatory rather than stylistic — the
  failure is silent at both ends.

  The qualifier is written out in links, like `[[Enoch (city)]]`, and never piped away.

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
- Passage titles duplicated across books without the `(Book)` qualifier — an ambiguous
  `[[Title]]` link silently resolves to just one of them.
- Missing cross-references (parallel Gospel accounts, OT quotes in the NT) not yet captured as
  connection pages.
- Wikilinks broken by a line wrap, and wikilinks pointing at pages that do not exist. Both are
  mechanical; run `scripts/link-check.sh` (see `## Link checks` below) rather than eyeballing
  them.

Log a `lint` entry in `wiki/log.md` summarizing what was found and fixed.

## Link checks

```bash
scripts/link-check.sh        # add -a to also list the expected baseline
```

Run it after any pass that writes wiki pages — the end of every ingest, and every lint. It is
fast, it exits 0 when clean and 1 on a finding, and it catches the two link failures that reading
the page will not.

**1. Wrapped links** — a `[[` and its `]]` on different lines. Any finding is a bug: Obsidian only
parses a link that sits entirely on one line, so a link broken by the ~100-column wrap is not a
broken link, it is not a link at all. It renders as literal `[[` text and vanishes from the graph
and from backlinks.

**2. Dangling targets** — links whose page does not exist, each reported with the pages that link
to it. A target resolves if either Obsidian link form resolves: a path-style link written from the
vault root (`[[books/index|Books]]`) or the ordinary shortest-path link (`[[David]]`).

Both checks skip fenced code blocks and inline code spans, because `wiki/log.md` quotes broken
links verbatim whenever it records a link problem, and those examples must not register as
findings.

Check 2's expected baseline is exactly the not-yet-started book pages linked from
`wiki/books/index.md` — 65 of them at present, shrinking by one per book completed. The script
recognizes them, counts them on a single line, and keeps them out of the findings, so a dangling
link it *does* report is either a typo to fix or a link deliberately left for a later pericope,
which belongs in the ingest's log entry.

Note that check 2 cannot find what check 1 finds: a wrapped link is not a malformed link, it is
not a link at all, so nothing that searches for `[[...]]` will ever see it. That is why the script
runs both, and why a clean check 2 is never grounds for skipping check 1.

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
