# Logos

A Bible wiki, built and maintained by an LLM agent (Claude Code), following the pattern in
[`llm-wiki.md`](llm-wiki.md). The concrete conventions for *this* instance — directory layout,
page templates, ingest/query/lint workflows — live in [`CLAUDE.md`](CLAUDE.md); that's the file
that actually drives the agent.

You rarely write the wiki yourself. Open this repo as an Obsidian vault, keep Claude Code open
alongside it, and direct the agent: feed it a book to start ingesting, ask it questions, ask it
to lint. It writes; you read, browse the graph, and steer.

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
- `CLAUDE.md` — the schema the agent follows. Evolves as conventions change.
- `llm-wiki.md` — the original, domain-agnostic pattern this repo instantiates.

## Status

Skeleton only — no books ingested yet. Next step: pick a book, get its WEB text into
`raw/bible/`, and start ingesting pericope by pericope.
