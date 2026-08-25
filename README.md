# Logos

A Bible wiki, built and maintained by an LLM agent (Claude Code), following the pattern in
[`llm-wiki.md`](llm-wiki.md). The concrete conventions for *this* instance — directory layout,
page templates, ingest/query/lint workflows — live in [`CLAUDE.md`](CLAUDE.md); that's the file
that actually drives the agent.

You rarely write the wiki yourself. Open this repo as an Obsidian vault, keep Claude Code open
alongside it, and direct the agent: feed it a book to start ingesting, ask it questions, ask it
to lint. It writes; you read, browse the graph, and steer.

## Ingesting

Type **`/ingest`** in Claude Code. That's the whole loop — it works out which pericope is next
from the book pages' checklists, fetches the book's text if it isn't in `raw/` yet, and does one
pericope per invocation. `/ingest Genesis 12` or `/ingest John` jumps to a specific spot. On
reaching a new book it draws that book's pericope breakdown on its own and keeps going, no
approval step.

The breakdown lands as a checklist under `## Pericopes` on the book page. Unchecked boxes are
provisional: if you don't like where a boundary falls, edit, split, merge, or reorder them right
there in Obsidian and the next `/ingest` follows whatever the file says. Checked boxes already
have passage pages behind them, so changing one means asking the agent to redo that passage.

## Setup

1. Open this folder as a vault in Obsidian (`Open folder as vault`).
2. Recommended community plugins (install via Settings → Community plugins):
   - **Dataview** — lets the frontmatter on every page (`type`, `tags`, etc.) power dynamic
     tables/queries.
   - **Templater** (optional) — the plain templates in `templates/` already work with Obsidian's
     built-in Templates plugin; Templater is only needed if you want variable substitution when
     creating a page by hand.
3. If you plan to clip secondary sources from the web later: install the **Obsidian Web
   Clipper** browser extension, and in Settings → Files and links set the attachment folder to
   `raw/assets` (already set in this vault's config) so images download locally instead of
   linking out.

## Layout

- `raw/` — source texts, never edited once added. See `raw/README.md`.
- `wiki/` — everything the agent generates: passages, books, people, places, themes,
  connections, plus `index.md` and `log.md`.
- `templates/` — one page template per wiki page type.
- `scripts/fetch-book.sh` — pulls one book's WEB text from bible-api.com into `raw/bible/`.
- `.claude/skills/ingest/` — the `/ingest` skill.
- `CLAUDE.md` — the schema the agent follows. Evolves as conventions change.
- `llm-wiki.md` — the original, domain-agnostic pattern this repo instantiates.

## Status

Genesis in progress: 1 of 58 pericopes ingested (Genesis 1:1–2:3). See [`wiki/index.md`](wiki/index.md)
for live counts and [`wiki/log.md`](wiki/log.md) for the full history.
