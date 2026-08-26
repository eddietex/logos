# Log

Append-only. Newest entry last. Format: `## [YYYY-MM-DD] ingest|query|lint|schema | Title`.

`grep "^## \[" wiki/log.md | tail -5` for the last 5 entries.

## [2026-08-24] setup | Wiki skeleton created

## [2026-08-24] ingest | Genesis 1.1-2.3 — The Creation of the World

First ingest. Fetched the full WEB text of Genesis (50 chapters, 1533 verses) into
`raw/bible/Genesis.md` via the new `scripts/fetch-book.sh`, which pulls a book chapter-by-chapter
from bible-api.com.

Created:
- `wiki/books/Genesis.md` — book page with a proposed 58-pericope breakdown
  (`pericopes_confirmed: false` pending the user's sign-off)
- `wiki/passages/Genesis/Genesis 1.1-2.3 - The Creation of the World.md`
- `wiki/people/God.md`
- `wiki/themes/Creation.md`, `Image of God.md`, `Blessing.md`, `Sabbath.md`
- `wiki/connections/In the Beginning - Genesis 1 and John 1.md`
- `wiki/connections/Creation as the Ground of the Sabbath Command.md`

Updated: `wiki/index.md` counts, `wiki/books/index.md` (Genesis → in-progress), and the people,
themes, and connections indexes.

Schema changes made in the same pass: `templates/book.md` gained a `## Pericopes` checklist (the
ingestion queue) and a `pericopes_confirmed` frontmatter flag, replacing the old separate
outline/passage lists; `CLAUDE.md` documents the queue, the fetch script, and the new
`/ingest` skill.

Deliberately-unresolved links left for later pericopes: `[[Adam]]`, `[[Eve]]`, `[[Eden]]`.

Open question flagged on `[[Creation as the Ground of the Sabbath Command]]`: Exodus 20 grounds
the Sabbath in creation, Deuteronomy 5 in the exodus — two rationales for one command, held side
by side rather than harmonized.

## [2026-08-24] schema | Pericope breakdowns no longer need the user's sign-off

Reverses the confirmation gate introduced with the entry above, before it ever fired a second
time. The agent now draws each book's pericope breakdown on its own authority and keeps
ingesting in the same invocation; unchecked boxes in a book page's `## Pericopes` list are
provisional and may be revised by either the user (in Obsidian) or the agent (when the text
divides differently than the plan assumed). Checked boxes are settled, since a passage page
exists behind each.

Rationale: at one stop per book the gate would have interrupted 66 times over the canon to
approve boundaries that are cheap to fix after the fact.

Changes: `pericopes_confirmed` dropped from `templates/book.md` and `wiki/books/Genesis.md`;
step 3 of the `/ingest` skill no longer stops; `CLAUDE.md`'s "Ingestion unit: pericope" section
and the README's ingesting section rewritten to match. Genesis's 58-pericope breakdown, which
was awaiting sign-off, is now simply live.

## [2026-08-24] schema | Passage pages named by title alone

Passage filenames drop the book and verse reference: `Genesis 1.1-2.3 - The Creation of the
World.md` → `The Creation of the World.md`. The folder supplies the book, the `ref:` frontmatter
supplies the verses, and links now read as prose — `[[The Creation of the World]]`. The passage
page's H1 is the bare title too (the `**Reference:**` line under it already carries the ref), and
`templates/passage.md` matches.

Uniqueness, which the old prefix guaranteed for free, is now handled on collision: when a second
book wants a title that is already taken, both pages become `<Title> (<Book>).md` — e.g. `The
Transfiguration (Matthew)` and `The Transfiguration (Mark)` — with the existing page renamed and
its inbound links fixed in the same pass. Genesis has no internal collisions; the Gospels and
Kings/Chronicles will hit this often. `/lint` now checks for unqualified duplicate titles, since
an ambiguous `[[Title]]` resolves silently to just one page.

Ordering note: the file explorer sorts alphabetically, and creation time is filesystem metadata
that git does not carry, so neither gives canonical order. The book page's `## Pericopes`
checklist is the ordered table of contents — its entries are now uniformly `<Title> — <Ref>`,
title first, matching the filenames.

Changes: the one existing passage page renamed and all 11 inbound wikilinks updated (this log's
earlier entry keeps the old path, being a record of what happened then); naming conventions and
the lint checklist in `CLAUDE.md`; step 4 of the `/ingest` skill; `templates/passage.md` and
`templates/book.md`; all 58 queue entries in `wiki/books/Genesis.md`.

## [2026-08-24] ingest | Genesis 2.4-25 — The Garden of Eden

Second pericope of Genesis. Boundary held as planned (2:4 opens the first *toledot*; 2:25's
"naked, and they were not ashamed" is the setup for the serpent's "crafty" in 3:1 — the same
Hebrew root, so the chapter break cuts a pun in half).

Created:
- `wiki/passages/Genesis/The Garden of Eden.md`
- `wiki/people/Adam.md`, `wiki/people/Eve.md`
- `wiki/places/Eden.md` — the wiki's first place page
- `wiki/themes/Work.md`, `Marriage.md`, `Life and Death.md`
- `wiki/connections/Two Creation Accounts - Genesis 1 and Genesis 2.md`
- `wiki/connections/One Flesh - Genesis 2 and the New Testament on Marriage.md`
- `wiki/connections/The Tree of Life - Eden and the New Jerusalem.md`

Updated: `wiki/people/God.md` (new "Yahweh God, from Genesis 2:4" section — the craftsman
portrait alongside chapter 1's sovereign speaker), `wiki/themes/Creation.md` (the Genesis 2
entry rewritten now that the pericope is ingested), `Image of God.md` (naming the animals as the
functional reading's first demonstration), `Sabbath.md` (linked to the new `Work` page),
`wiki/passages/Genesis/The Creation of the World.md` (its Genesis 2 cross-reference now links to
a real page), `wiki/connections/In the Beginning - Genesis 1 and John 1.md` (the breath link it
was holding open — Genesis 2:7 and John 20:22 share the Septuagint's verb *enephysēsen*), the
Genesis book page and index, all four category indexes, and `wiki/index.md` counts.

Resolved three links the first ingest deliberately left dangling: `[[Adam]]`, `[[Eve]]`,
`[[Eden]]`.

Tensions written out rather than smoothed:
- Chapter 1 and chapter 2 differ in divine name, starting state, order of creation, and idiom.
  Recorded as a table plus the three standard readings (two sources; two complementary
  perspectives; deliberate juxtaposition) on the new connection page, with no verdict taken.
- "In the day that you eat of it, you will surely die" (2:17) versus the fact that they do not
  die that day. Three readings noted on the passage page; the text is left holding the tension.
- "A helper comparable to him" (*ʿēzer kenegdô*) — noted that *ʿēzer* elsewhere describes God
  helping Israel and carries no subordination, against the common reading of "helpmeet".
- "Rib" (*ṣēlāʿ*) — flagged that the word means "side" in all ~40 other occurrences, and that
  2:22's verb is "built".

Deliberately left for later pericopes: the four rivers and the lands they run through (Pishon,
Gihon, Havilah, Cush, Assyria) are described on `[[Eden]]` as plain text rather than links, since
their pages belong with Genesis 10. Revisit notes filed on the tree-of-life and one-flesh
connection pages for Genesis 3, Revelation 22, Matthew 19, Mark 10, 1 Corinthians 6, and
Ephesians 5.

## [2026-08-24] schema | Wikilinks must not be split across a line wrap

Caught by the user immediately after the Genesis 2:4–25 ingest: `[[The Creation of the World]]`
on the new passage page rendered as literal text, because the ~100-column hard wrap had broken it
mid-link —

```
Where [[The Creation of the World|Genesis
1]] moved across six days …
```

Obsidian parses `[[...]]` only when the whole link sits on one line. Fixed by breaking before the
`[[` and letting that line run short.

Why the ingest's own verification missed it: the end-of-pass check searched for `[[...]]` and
tested whether each target existed. A wrapped link is not a malformed link — it is *not a link*,
so it never appeared in that search at all. The check could not have found it, no matter how
carefully it was run. One page-by-page reading would have caught it and the mechanical check
never would, which is the opposite of the usual failure mode and the reason this needed a
convention rather than more care.

Changes:
- `CLAUDE.md` naming conventions: a wikilink must never be split across a line break, with the
  bad/good example. This is the one case where the wrap width yields.
- `CLAUDE.md` gains a `## Link checks` section holding both mechanical checks as runnable
  commands — the unbalanced-bracket check for wrapped links, and the corrected dangling-target
  check — with an explicit note that the second cannot find what the first finds.
- The dangling-target check also had a false positive, now fixed: it tested only the shortest-path
  link form, so the path-style links in `wiki/index.md` (`[[books/index|Books]]`) reported as
  dangling. It now accepts either form.
- `CLAUDE.md` lint checklist: both link failures added, pointing at the commands.
- `/ingest` "Done means": the vague "every wikilink resolves" bullet replaced with a requirement
  to actually run both checks, and not to skip the wrapped-link check because the dangling-link
  check came back clean.

Both checks now run clean across the wiki, against a known baseline of the 65 not-yet-started
book pages and the `{{Title}}` placeholder in `templates/connection.md`.

## [2026-08-24] schema | Link text is the page title, not a piped scripture reference

User preference, on seeing `[[The Creation of the World|Genesis 1]]` render as just "Genesis 1":
where the two compete, the visible text should name the page being linked to. A reference tells
the reader where the passage sits in the canon but not where the link goes, and the title is the
more useful of the two because it says what they will find on arrival. The verses are never lost —
the passage page's `ref:` frontmatter and `**Reference:**` line carry them, one click away.

This reverses a convention `CLAUDE.md` had stated positively ("Pipe a display form where the
location matters in running text: `[[The Binding of Isaac|Genesis 22]]`"), which is what produced
both instances in the wiki. Where the reference genuinely matters in a sentence it now goes in the
prose beside the link instead of on top of it.

Piping survives for its real use — a target filename that is not the words you want on the page —
with the path-style category links in `wiki/index.md` (`[[people/index|People]]`) as the standing
example. Those are the only piped links left in the wiki.

Changes: the naming convention in `CLAUDE.md` rewritten with bad/good examples;
`wiki/passages/Genesis/The Garden of Eden.md` and
`wiki/connections/One Flesh - Genesis 2 and the New Testament on Marriage.md` unpiped, the second
rephrased so "Genesis 2:2–3" still appears in the sentence.

Also hardened the wrapped-link check added earlier today. It read Markdown as plain text, so the
bad example quoted in this log's own previous entry — inside a code fence, plus an inline `` `[[` ``
span — reported as three findings. A check that fires on the log entry describing a bug is a check
that will be ignored, so it now skips fenced blocks and inline code. Both link checks clean.

Follow-up in the same pass: check 2 turned out to have the identical blind spot and needed the
same fix. It reported `[[The Binding of Isaac]]` and `[[Title]]` as dangling, both of them quoted
inside code spans in this log rather than written as links anywhere. Its extraction is now
fence- and code-span-aware too, matching check 1. Removing that noise also cleared the
`{{Title}}` entry from the documented baseline, which was never a template artifact as recorded —
it was an inline `` `[[Title]]` `` in an earlier log entry. The baseline is now exactly the
not-yet-started book pages in `wiki/books/index.md`, and nothing else.

## [2026-08-24] ingest | Genesis 3.1-24 — The Fall

Third pericope of Genesis, and the first that required new categories of theme page. Boundary held
as planned: 3:1 picks up the *ʿārûm* / *ʿărummîm* pun the chapter break cuts in half, and 3:24
closes the garden for good — Genesis never mentions it again.

Created:
- `wiki/passages/Genesis/The Fall.md`
- `wiki/people/The Serpent.md`
- `wiki/themes/Sin.md`, `Curse.md`, `Judgment.md`
- `wiki/connections/The Protoevangelium - Genesis 3.15 and the Seed of the Woman.md`
- `wiki/connections/The First Adam and the Last Adam.md`

Updated: `wiki/people/Adam.md` (present and silent through the conversation; the article finally
drops from his name at 3:17), `Eve.md` (her misquotation of the command, her sentence, her
naming), `God.md` (new "As judge, from Genesis 3" section — the come/seek/question/sentence/provide
sequence), `wiki/places/Eden.md` (the expulsion, and the garden closed), `wiki/themes/Life and
Death.md` (death defined as 2:7 reversed, sealed by the barred tree rather than by the eating),
`Blessing.md` (the counter-word now has its own page; 1:28 is never revoked, only made costly),
`Work.md` (the curse lands on the ground, and 2:15's commission continues outside the garden),
`Marriage.md` (the union fracturing in the same four terms it was built from), `Image of God.md`
(a given likeness supplemented by a seized one, and never said to be lost),
`wiki/connections/The Tree of Life - Eden and the New Jerusalem.md` (the revisit note it was
holding open for this pericope, now discharged), `In the Beginning - Genesis 1 and John 1.md`
(same — hiding among the trees, against John 3:19–20),
`wiki/passages/Genesis/The Garden of Eden.md` (its "next pericope" cross-reference now links to a
real page), the Genesis book page and index, all four category indexes, and `wiki/index.md`
counts.

Judgment calls made unattended, for review:
- **The serpent gets a person page**, not a theme page or a mention. It speaks, is addressed, is
  sentenced, and is identified by name in later Scripture; `person` is the only page type that
  fits. The Satan identification is handled there as its own section, with the sources dated,
  rather than as a connection page — it would have duplicated the person page almost entirely.
- **Three new theme pages, not four.** `Sin`, `Curse`, and `Judgment` each carry material the
  existing pages could not absorb. *Shame* was the fourth candidate and was folded into `Sin` and
  the passage notes instead; it is a real theme but it has one scene so far, and a page with one
  scene in it is an index entry pretending to be a synthesis. Revisit if it recurs.
- **Cherubim get no page.** They appear here as guards and next in Exodus 25–26 over the ark;
  described on the passage and `[[Eden]]` pages as plain text. A page belongs with the tabernacle,
  where there is something to say about them.
- Connection page filename uses `3.15` rather than `3:15` — colons are barred from filenames by
  `CLAUDE.md`, and the existing `In the Beginning - Genesis 1 and John 1` sets the hyphen pattern.

Tensions written out rather than smoothed:
- **The serpent's claims were largely true.** "Your eyes will be opened" and "you will be like
  God, knowing good and evil" are both confirmed, the second by God himself in 3:22. Only "You
  won't really die" is false, and even that is false about timing. Recorded on the passage page
  and on `[[The Serpent]]` rather than softened.
- **Genesis 3 identifies the serpent with nothing.** No Satan, no fallen angel, no rebellion. The
  identification is traced with its sources and dates (Wisdom 2:24, John 8:44, Revelation 12:9,
  20:2) and the question of whether it draws out or reads in is left open on both pages.
- **Neither the man nor the woman is cursed.** The `ʾārûr` formula falls on the serpent (3:14) and
  the ground (3:17) only. Flagged on the passage page, on `[[Curse]]`, and on `[[Work]]`, against
  the standing phrase "the curse on Adam and Eve".
- **3:16 — "your desire will be for your husband, and he will rule over you."** Both forks laid
  out without a verdict: *tešûqâ* read by 4:7 as an appetite to master, and the descriptive vs.
  prescriptive question about "he will rule", noting only that the sentence sits in a list beside
  thorns.
- **3:15 as protoevangelium.** The plain etiological reading and the messianic one are both given
  with what supports them — the LXX's masculine *autos*, the single verb *šûp* in both halves, the
  Vulgate's *ipsa* as a translation error with an iconographic afterlife.
- **Romans 5:12's *eph' hō*** — "because" vs. Augustine's *in quo* ("in whom"), and the
  East/West split between inherited mortality and inherited guilt, recorded on
  `[[The First Adam and the Last Adam]]` with the note that every universalizing move in the
  typology is Paul's, not Genesis's.
- **"The fall" and "sin" are both absent from the chapter.** *ḥaṭṭāʾt* first appears at 4:7. Noted
  on the passage page and on `[[Sin]]`.

Deliberately left for later pericopes: Cain and Abel (4:1–16) is referenced from four pages as
plain text, since the *tešûqâ* of 3:16 recurs at 4:7 and the death sentenced here is first carried
out there. Revisit notes filed on both new connection pages for Genesis 12, 22, and 49, Romans 5
and 16, 1 Corinthians 15, Galatians 4, Hebrews 2, and Revelation 12.

`scripts/link-check.sh` clean, against the documented baseline of 65 not-yet-started book pages.

## [2026-08-24] schema | Every ingest now pushes, not just commits

User request: `/ingest` step 5 should push after committing. Previously the skill ended at the
commit and said so explicitly — *"Commit on the current branch; do not push"* — which left every
scheduled run's work sitting on the local branch until someone pushed by hand.

The blocker was not the skill text. `.claude/settings.json` carried `Bash(git push:*)` in its
**deny** list, which is a hard block rather than a prompt, so the new instruction would have failed
on every run regardless of mode. Deny cleared and `git push` moved to the allowlist, with
`git pull` added beside it for the rejected-push path below.

Changes:
- `.claude/skills/ingest/SKILL.md` step 5 renamed "Commit and push", with `git push` in the command
  block and the closing report line now covering the push.
- A rejected-push branch added: when the remote has moved ahead (the user pushing Obsidian edits
  from another machine being the expected cause), `git pull --rebase` and push again; if that
  fails too, stop and report rather than resolve a merge conflict unattended. The commit is safe
  locally either way.
- `.claude/settings.json`: `Bash(git push:*)` moved from `deny` to `allow`; `Bash(git pull:*)`
  added; `deny` now empty.
- `CLAUDE.md` directory map: the settings.json line now reads "commit and push".

## [2026-08-25] ingest | Genesis 4.1-16 — Cain and Abel

Fourth pericope of Genesis, and the first unattended run under the new push step. Boundary held as
planned: 4:16 ends the scene with Cain leaving Yahweh's presence, and 4:17 turns into genealogy and
city-building, which is the next box.

Created:
- `wiki/passages/Genesis/Cain and Abel.md`
- `wiki/people/Cain.md`, `Abel.md`
- `wiki/places/Nod.md`
- `wiki/themes/Sacrifice and Offering.md`
- `wiki/connections/Cain and Abel in the New Testament.md`
- `wiki/connections/Desire and Rule - Genesis 3.16 and 4.7.md`

Updated: `wiki/people/Adam.md` (present only in 4:1 and still called "the man"; his trade and his
cursed ground pass to Cain), `Eve.md` (4:1 as the Bible's first human thanksgiving, spoken under
the sentence of 3:16), `God.md` (new "Outside the garden, from Genesis 4" section — warning before
the act, an unexplained refusal, a victim heard, the first human cursed, and a murderer protected),
`wiki/places/Eden.md` (now a bearing rather than a place; Nod added to related places),
`wiki/themes/Sin.md` (the word's first appearance, personified and resistible),
`Curse.md` (the *ʾārûr* formula reaching a person, and the ground going from resisting to
refusing), `Judgment.md` (a step-by-step table of the Genesis 3 template rerun and escalated),
`Life and Death.md` (the first death is a killing; blood given a voice), `Work.md` (two honest
trades, and the first vocation taken away), `Marriage.md` and
`wiki/passages/Genesis/The Fall.md` (their standing 4:7 notes now point at the new connection
page), `wiki/connections/The Protoevangelium - Genesis 3.15 and the Seed of the Woman.md` (4:1 as
the first candidate for the woman's offspring and 4:8 as the first cutting of that line), the
Genesis book page and index, all four category indexes, and `wiki/index.md` counts.

Judgment calls made unattended, for review:
- **Two theme pages were considered and one was written.** `Sacrifice and Offering` earns a page:
  it has two touchpoints already (3:21's coats of skins as a contested reading, 4:3–5 as the first
  offerings) and the entire Levitical system and Hebrews depend on how this scene is read.
  *Blood* was the other candidate and was folded into the passage notes and the new connection
  page instead — it is a major strand (4:10, 9:5–6, Leviticus 17:11, Hebrews 12:24) but it has one
  verse so far, and the `Shame` precedent from the Genesis 3 ingest applies. Revisit at Genesis 9.
- **No theme page for sibling rivalry**, despite it being the most obvious Genesis-wide motif this
  passage starts (Isaac/Ishmael, Jacob/Esau, Joseph's brothers, Ephraim/Manasseh). Same reason: one
  scene. It is written into the passage notes and into `Sacrifice and Offering` as the
  divine-freedom reading. It should get a page when Genesis 25 or 27 arrives, and by then there
  will be a synthesis to write rather than an index entry.
- **`Nod` gets a place page** even though it is a single verse and probably not a locatable
  region — because the name is the sentence of 4:12 made into geography, which is worth a page
  saying so rather than a line on `[[Eden]]`.
- **Passage title is `Cain and Abel`**, the book page's own wording, over "The First Murder" or
  "Cain and Abel and the First Murder". No collision with any other book yet; Hebrews and 1 John
  will not need passage pages by that name.
- Connection filename uses `3.16 and 4.7`, following the colon-free pattern already set by
  `The Protoevangelium - Genesis 3.15 …`.

Tensions written out rather than smoothed:
- **Genesis never says why Abel's offering was accepted.** Four readings are recorded with what
  each rests on — quality (firstborn and fat vs. an unqualified "fruit of the ground"), blood
  (which runs into *minḥâ* being used of *both* offerings and being the Levitical **grain**
  offering), the person before the gift (the verse's own word order, and Hebrews 11:4's "by
  faith"), and unexplained divine freedom. The passage supports the first and fourth; the New
  Testament supplies the third. No verdict entered.
- **Verse 8 has a hole in the Masoretic text.** *"Let's go into the field"* is supplied from the
  Samaritan Pentateuch, LXX, Peshitta, and Vulgate; WEB follows them without noting it. Recorded on
  the passage page, since the one sentence the murderer speaks to his victim is the one sentence
  the Hebrew does not have.
- **"My punishment is greater than I can bear" (4:13) is equally "my guilt is too great to be
  forgiven."** *ʿāwōn* means guilt and penalty, *nāśāʾ* means bear and forgive. Self-pity or the
  first confession in the Bible — both recorded, neither preferred, with the note that the
  ambiguity is in the Hebrew and not in the interpreters.
- **The New Testament adds motive and verdict that Genesis withholds.** Abel is "righteous" and
  offered "by faith"; Cain is "of the evil one". None of the five NT references mentions the
  warning, the sign, or God's protection of Cain — the passage's most merciful material. Flagged
  on the connection page as the same draw-out-or-read-in question already open at 3:15 and at the
  serpent's identity, and `[[Cain]]` keeps the Genesis portrait rather than the archetype.
- **The mark of Cain is protective, and its reception history is not.** Named on the passage page
  as a misreading — it has no basis in the verse and also confuses this curse with the one on
  Canaan in 9:25 — because of the use it was put to.
- **The *tešûqâ* parallel is real and is regularly over-drawn.** The new connection page states
  what it licenses (reading 3:16's "desire" as an appetite to master) and what it does not (the
  descriptive-vs-prescriptive question about "he will rule"), and notes that the third of the
  word's three occurrences, Song of Songs 7:10, points the other way.
- **Who Cain feared, and who he married**, is recorded as a question the narrative does not answer,
  with the Genesis 5:4 harmonization given and the observation that Genesis 4 is narrating the
  beginnings of civilization rather than a population.

Deliberately left for later pericopes: Genesis 4:17–26 is referenced as plain text from five pages
(Cain's city and line, Lamech's seventy-sevenfold boast against the sevenfold of 4:15, and Seth
born "instead of Abel"), as are Genesis 9:5–6, Leviticus 17:11, and Numbers 35 for the blood
strand. Revisit notes filed for Genesis 9 (a `Blood` theme page), Genesis 25/27 (sibling rivalry),
Genesis 22 (`Sacrifice and Offering`), and Song of Songs 7 (`Desire and Rule`).

`scripts/link-check.sh` clean, against the documented baseline of 65 not-yet-started book pages.

## [2026-08-25] ingest | Genesis 4.17-26 — The Line of Cain and the Birth of Seth

Fifth pericope of Genesis, run unattended. Boundary held as planned: 4:17 picks up from Cain
leaving Yahweh's presence and 4:26 closes the chapter, with 5:1's *toledot* formula starting the
next box cleanly. The pericope is really two unequal halves — eight verses of Cain's line and two of
Seth's — and the whole point of the unit is that they are set against each other, so it was kept as
one box rather than split.

Created:
- `wiki/passages/Genesis/The Line of Cain and the Birth of Seth.md`
- `wiki/people/Seth.md`, `Enosh.md`, `Lamech (son of Methushael).md`, `Enoch (son of Cain).md`,
  `Jabal.md`, `Jubal.md`, `Tubal Cain.md`
- `wiki/places/Enoch (city).md`
- `wiki/themes/Vengeance.md`, `City and Civilization.md`
- `wiki/connections/Two Lines from Adam - Cain's Genealogy and Seth's.md`
- `wiki/connections/Seventy-Sevenfold - Lamech's Boast and Jesus on Forgiveness.md`
- `wiki/connections/Calling on the Name of Yahweh.md`

Updated: `wiki/people/Cain.md` (the city, the line, and Lamech's inflation of his sevenfold
protection — the part of his story the wiki had only as a forward reference), `Adam.md` (4:25 as the
first narrative sentence using *ʾādām* as a plain name without the article), `Eve.md` (her last
recorded sentence in Scripture, and *zeraʿ ʾaḥēr*), `Abel.md` (Genesis's last mention of him is as
the vacancy Seth fills), `God.md` (new "His first silence" section — the first passage in the Bible
he is absent from, and his return in the last two verses as the one credited and the one called
on), `wiki/places/Nod.md` (the city resolved from a forward reference, with the note that Genesis
never actually says the city stood in Nod), `wiki/themes/Sin.md` (the first stretch with no divine
word in it), `Judgment.md` (the template withheld, and why that is legible as withholding),
`Curse.md`, `Work.md` (the first specialized and inherited trades), `Life and Death.md` (a
genealogy as a way of narrating death), `Marriage.md` (4:19, with the Torah's regulation-not-
prohibition of polygamy noted against the structural reading),
`wiki/passages/Genesis/Cain and Abel.md` (its forward reference to 4:17–26 is now a link),
`wiki/connections/The Protoevangelium - Genesis 3.15 and the Seed of the Woman.md` (4:25's *another
seed*, with both the load-bearing and the ordinary reading of the word), the Genesis book page and
index, all four category indexes, and `wiki/index.md` counts.

Judgment calls made unattended, for review:
- **Seven of the passage's fourteen named people got pages; six did not.** Pages went to Seth,
  Enosh, Lamech, Cain's Enoch, and the three culture-founders — everyone the text gives an act, a
  vocation, or a downstream role. **Adah and Zillah** were the closest call and were declined: they
  are the first women named after Eve and the addressees of the Bible's first poem, but Genesis
  gives them no words and no story, so what there is to say about them is really about the marriage,
  and it is said on `Lamech (son of Methushael)` and `Marriage`. **Naamah** likewise — her page would
  be entirely reception history (Genesis Rabbah making her Noah's wife, the singer tradition), which
  is on `Tubal Cain` and in the passage notes instead. **Irad, Mehujael, Methushael** are chain-links
  with no attached material at all. Revisit Adah and Zillah if a later passage gives them anything.
- **Both reused names were disambiguated pre-emptively**, as `Enoch (son of Cain)` and
  `Lamech (son of Methushael)`, rather than waiting for the collision. Genesis 5 is the very next
  pericope and will bring the Sethite Enoch and Lamech, so qualifying now avoids renaming and
  relinking two pages next run. Their namesakes get `(son of Jared)` and `(father of Noah)` then.
  Note that the person page `Enoch (son of Cain)` and the place page `Enoch (city)` are distinct
  files with distinct names, so neither shadows the other in Obsidian.
- **Two theme pages written, one declined.** `Vengeance` and `City and Civilization` both have two
  or more touchpoints already and large downstream strands, which is the bar the `Sacrifice and
  Offering` decision set at the last ingest. **`Worship` was the declined one**: 4:26 is a single
  half-verse, and the *Blood*/*Shame* precedent says a one-verse theme waits. Its material went into
  the new `Calling on the Name of Yahweh` connection page instead. Revisit at Genesis 12:8, where
  Abram starts building altars and the phrase becomes a practice.
- **`subtype: thread`** is a new value in connection frontmatter, alongside the existing allusion,
  quotation, parallel, typology, and prophecy → fulfillment. `Calling on the Name of Yahweh` traces
  one phrase across six books rather than pairing two passages, and none of the existing subtypes
  fits. `CLAUDE.md` does not enumerate subtypes, so no schema change was needed.
- **Passage title kept as the book page had it.** "The Line of Cain and the Birth of Seth" names
  both halves, which is the point of the unit; a shorter title would have hidden one of them.

Tensions written out rather than smoothed:
- **A man sentenced to wander builds a city, and Genesis does not reconcile it.** Three readings
  recorded — defiance, a sentence being lived in, two traditions set side by side — with Augustine's
  earthly-city reading named as the most influential *and* as inference rather than text.
- **The origins of herding, music, and metalwork are placed in the cursed line with no evaluation
  attached.** Both standard over-readings are named as over-readings: that the passage taints
  culture (which cannot survive the patriarchs living Jabal's life and David playing Jubal's
  instrument), and that it celebrates progress (which cannot survive where it is placed).
- **"Then men began to call on Yahweh's name" (4:26) has three problems, all kept.** *Huḥal* as
  "began" (nearly all moderns) against *huḥal* as "profaned" (Genesis Rabbah 23:7, Rashi, Maimonides
  — making the verse the origin of idolatry); the breadth of *qārāʾ bešēm*; and the clash with
  Exodus 6:2–3, recorded with both the source-critical and the semantic resolution and with the note
  that the semantic one is old and the critical observation is about a real feature of the text.
- **The Genesis 4 / Genesis 5 name overlap.** Three accounts given — two versions of one list
  (with the J/P attribution), deliberate literary counterpoint, and a small ancient name-pool — and
  they are noted as not mutually exclusive. The tidy "line of the serpent / line of the promise"
  scheme is flagged as getting more from the text than it says, since Genesis labels neither line
  and the flood account makes the corruption universal.
- **The Matthew 18:22 link rests on a Septuagint phrase, not on a citation.** The connection page
  states that Matthew never names Lamech, gives the counter-argument (that "seventy-seven" is just
  an idiom for an uncountable number), and gives the reply (that the idiom's one attestation *is*
  Genesis 4:24). The seventy-seven vs. seventy-times-seven translation split is recorded as the
  smaller question.
- **Whether *zeraʿ ʾaḥēr* at 4:25 is quoting 3:15** is left open on the Protoevangelium page, with
  the ordinary-word reading given equal room and Eve's shift from *Yahweh* to *ʾĕlōhîm* noted.
- **Bronze and iron in the same verse (4:22)** does not line up with an archaeological chronology;
  recorded as a place where readers who take these chapters as a differently-shaped kind of history
  and readers who take them strictly both have to say something, following the handling `Cain and
  Abel` already gave to "who was there to kill him".
- **Genesis says nothing about the bigamy of 4:19**, and the Torah regulates polygamy rather than
  forbidding it. `Marriage` now says so, rather than letting the structural argument stand as if it
  were an explicit one.

Deliberately left for later pericopes: the Sethite Enoch and Lamech (Genesis 5, next run), the end
of Cain's line at the flood (Genesis 6–7), Nimrod's cities (Genesis 10) and Babel (Genesis 11), the
`Worship` theme and Abram's altars (Genesis 12:8), and Genesis 9:5–6 for `Vengeance`. All of these
are plain-text references, not links, so nothing dangles.

`scripts/link-check.sh` clean, against the documented baseline of 65 not-yet-started book pages. All
ten verses of the pericope were checked mechanically against `raw/bible/Genesis.md` and quote it
verbatim.

## [2026-08-25] ingest | Genesis 5.1-32 — From Adam to Noah

Sixth pericope of Genesis, run unattended. Boundary held as planned: 5:1's *toledot* formula opens
the unit and 5:32 closes it on Noah's three sons, with 6:1's *"when men began to multiply"* starting
the next box cleanly. The chapter was kept whole rather than split at Enoch — the register's force
comes from the repetition, and the two entries that break the form (Enoch at 5:24, Lamech at 5:29)
only read as breaks against the eight that do not.

Created:
- `wiki/passages/Genesis/From Adam to Noah.md`
- `wiki/people/Kenan.md`, `Mahalalel.md`, `Jared.md`, `Enoch (son of Jared).md`, `Methuselah.md`,
  `Lamech (father of Noah).md`, `Noah.md`
- `wiki/themes/Walking with God.md`
- `wiki/connections/The Taking of Enoch - Genesis 5.24 in Hebrews and Jude.md`
- `wiki/connections/Comfort from the Cursed Ground - Naming Noah.md`
- `wiki/connections/From Adam to Jesus - The Genealogy of Genesis 5 in Chronicles and Luke.md`

Updated: `wiki/people/Adam.md` (5:1–3 finishing the word's passage into a name, and the image
transmitted to Seth), `Seth.md` (5:3, and Genesis 5 treating him as Adam's first son), `Enosh.md`
(the formal entry Genesis 4:26 withheld), `Eve.md` (present only as the plural of 5:2; the register
names ten fathers and no mothers), `God.md` (new "He is named but not quoted" section — silent
across thirty verses, acting once, at 5:24), `Cain.md` (his omission from the book of Adam's
generations, with the three readings of it), `Enoch (son of Cain).md` and
`Lamech (son of Methushael).md` (their Sethite namesakes now exist and are linked),
`wiki/themes/Life and Death.md` (the refrain, and the two entries that omit it), `Image of God.md`
(5:3 as the one verse where the image passes father to son, with the Augustinian reading marked as
resting on Romans 5:12 rather than on this verse), `Curse.md` (5:29 as the only place anyone is
shown hoping the curse will lift), `Blessing.md` (the register as 1:28 being carried out),
`Creation.md` (5:1–2 as the Bible's first self-quotation of its creation account),
`wiki/connections/Two Lines from Adam - Cain's Genealogy and Seth's.md` (its Genesis 5 forward
reference is now a link, plus the two Lamech speeches as the lines' opposite endings),
`wiki/passages/Genesis/The Line of Cain and the Birth of Seth.md` (same forward reference), the
Genesis book page and index, `wiki/people/index.md`, `themes/index.md`, `connections/index.md`, and
`wiki/index.md` counts.

Judgment calls made unattended, for review:
- **The Sethite Lamech's page is titled `Lamech (father of Noah)`, not `Lamech (son of
  Methuselah)`.** Every other disambiguation in the wiki is by parentage, and the parentage form
  here would sit two letters away from `Lamech (son of Methushael)` — a pair no reader will keep
  apart inside a link. Clarity was preferred to consistency, and the departure is written onto the
  page itself so it does not look like an oversight. The Enochs keep the parentage form
  (`Enoch (son of Cain)` / `Enoch (son of Jared)`), which is unambiguous.
- **Seven of the chapter's fourteen named people got pages; Shem, Ham, and Japheth did not.** The
  ten generations of the register each got one, on the grounds that a genealogy's whole content is
  its names and a name with no page cannot be linked from the theme and connection pages that need
  it. Noah's three sons are named once, at 5:32, and do nothing; they are referred to in plain text
  and get pages when the flood narrative makes them people. Nothing dangles as a result.
- **A chronology table was put on the passage page.** Genesis never does the arithmetic, so the
  table is labelled as not part of what the text asserts, and every figure in it was computed from
  the raw verses rather than recalled. It earns its place because three of the chapter's most
  discussed features — Methuselah dying in the flood year, Lamech dying five years short of it, and
  every generation from Adam to Lamech being alive at once — are invisible without it.
- **A new theme page, `Walking with God`,** rather than folding 5:22–24 into `Life and Death`. The
  idiom is used of exactly two men, is picked up by Micah and Hebrews, and becomes the New
  Testament's ordinary metaphor for the Christian life; it needed somewhere to live before Genesis
  6:9 arrives.

Contested points recorded rather than resolved:
- **What Genesis 5:3 transmits.** That the *image* passes is stated by the verse and confirmed
  independently at 9:6 and James 3:9. That *fallenness* passes with it is the standard Augustinian
  and Reformed reading, and the page says plainly that its load-bearing text is Romans 5:12, not
  this one — what invites the darker reading here is the placement, not the wording.
- **The lifespans.** Four readings given — literal, symbolic/numerological, a different unit, and
  honorific — with the "months" harmonization marked as failing immediately (Enoch fathering at 65
  months would make him five). The Sumerian King List is named as the standard comparison, with
  both inferences that get drawn from it (a shared demythologized tradition; a sober record beside
  an inflated one) left standing.
- **The Masoretic, Septuagint, and Samaritan numbers do not agree**, and the passage page says so
  before presenting the table — so the Methuselah-and-the-flood coincidence is flagged as a feature
  of one textual tradition rather than of "the Bible's numbers". Ussher's 4004 BC is named as
  resting on the same figures.
- **Methuselah's name.** The popular gloss *"when he dies, it shall be sent"* is recorded as a
  homiletic reconstruction requiring a verb form the name does not have, with the defensible
  parsings given. The date coincidence is kept; the etymology is not used to support it.
- **Enoch 5:24.** The minority reading — that *"God took him"* is a delicate way of reporting an
  early death — is stated as grammatically available and then given its actual standing: essentially
  no support in the reception history, and the deciding argument is structural, since the chapter
  has a formula for dying and declines to use it.
- **Hebrews 11:5 depends on the Septuagint.** The connection page states that the Hebrew does not
  say Enoch had faith, that the Greek renders *"walked with God"* as *"pleased God"*, and that
  Hebrews reads the second as evidence of the first — a legitimate inference, and an inference. Jude
  quoting *1 Enoch* 1:9 is recorded with the canon question left open and the Ethiopian Orthodox
  canon noted.
- **Whether Genesis 5 has gaps.** Both sides given, and the usual gaps argument is noted as working
  much better on Genesis 11 and Matthew 1 than on this list, because Genesis 5's ages are what make
  it additive at all. Matthew 1:17's own openly stated omissions are the evidence that biblical
  genealogies can be selective by design.
- **Whether Lamech's hope at 5:29 is answered.** Three partial answers kept side by side — 8:21
  (the curse capped, not lifted), 9:20 (comfort arriving as a vineyard, in the same paragraph that
  ends with a drunk man and a curse), and not-yet (Romans 8:20–21, Revelation 22:3). The
  typological reading of 5:29 as proto-messianic is named and flagged as more than Genesis says.
- **777 against seventy-seven.** The two Lamechs' numbers are recorded as very likely design, given
  how much else in Genesis 4–5 is paired, and explicitly as undemonstrable.

Deliberately left for later pericopes, all as plain-text references rather than links, so nothing
dangles: Shem, Ham, and Japheth (Genesis 6–10), Noah's righteousness and *"walked with God"* at 6:9,
the hundred and twenty years of 6:3, God's promise at 8:21 and the vineyard at 9:20, the second
ten-generation register at 11:10–26, Elijah at 2 Kings 2, and Hebrews 11:5, Jude 14–15, Matthew 1:1
and Luke 3:36–38 in the New Testament.

`scripts/link-check.sh` clean, against the documented baseline of 65 not-yet-started book pages.
All thirteen verses quoted on the passage page were checked mechanically against
`raw/bible/Genesis.md` and match it verbatim, and every figure in the chronology table was recomputed
from the raw verses.

## [2026-08-25] ingest | Genesis 6.1-8 — The Sons of God and the Corruption of the Earth

Seventh pericope of Genesis, run unattended. Boundary held as planned. 6:1's *"when men began to
multiply"* opens the unit, and 6:8's *"But Noah found favor in Yahweh's eyes"* closes it one verse
before the *toledot* heading at 6:9 starts the next box — which is the cleanest seam in the chapter
and the one the traditional section divisions and the source critics both agree on, for different
reasons.

Created:
- `wiki/passages/Genesis/The Sons of God and the Corruption of the Earth.md`
- `wiki/people/The Sons of God.md`, `The Nephilim.md`
- `wiki/themes/Favor and Grace.md`, `Divine Grief and Relenting.md`
- `wiki/connections/The Sons of God and the Angels That Sinned.md`
- `wiki/connections/The Nephilim and the Giants of Canaan.md`
- `wiki/connections/As It Was in the Days of Noah.md`

Updated: `wiki/people/Noah.md` (6:8 as the Bible's first *ḥēn*, the *nōaḥ*/*ḥēn* consonantal play,
and the point that favor is recorded before any statement of his character), `God.md` (new "He
grieves" section — the seeing-verb of Genesis 1 turned around, the two hearts examined in one
paragraph, and the judgment pattern running with the interrogation removed), `Adam.md` (*ʾādām* in
6:1–7 swinging back from the individual to the species, six verses after Genesis 5 closed it onto
one man), `Lamech (father of Noah).md` (his *nāḥam* at 5:29 reused of God at 6:6 in its other
sense), `wiki/themes/Sin.md` (6:5, *yēṣer*, and what the verse does and does not assert about
transmission), `Judgment.md` (the template with the questioning removed), `Life and Death.md` (6:3's
limit, and 6:7 widening the sentence from persons to all flesh), `Blessing.md` (6:1 as 1:28
succeeding, and the care needed not to make the multiplying the fault), `Marriage.md` (6:2 as the
second departure from 2:24, in the grammar of 3:6), `Creation.md` (6:5–7 as un-creation),
`wiki/passages/Genesis/From Adam to Noah.md` and `The Line of Cain and the Birth of Seth.md` (their
forward references to Genesis 6:1–8 are now links), the Genesis book page and
`wiki/books/index.md` (7 / 58), `wiki/people/index.md`, `themes/index.md`, `connections/index.md`,
and `wiki/index.md` counts (7 passages · 22 people · 3 places · 16 themes · 18 connections).

Judgment calls made unattended, for review:
- **`The Sons of God` and `The Nephilim` were given person pages**, on the precedent of
  `The Serpent` — collective or non-human entities whose identity the text withholds and later
  Scripture argues about. The alternative was to keep both entirely inside the passage's Notes, but
  each recurs outside Genesis (Job 1:6, 2:1, 38:7; Numbers 13:33) and each has a reception history
  that will be linked to repeatedly. If they read as over-splitting, they merge back cleanly.
- **The identity of the sons of God is left unresolved, deliberately, in all three places it comes
  up.** The passage page, the person page, and the connection page each give the three readings —
  divine beings, the Sethite line, dynastic kings — with the strongest argument and the hardest
  problem for each, and none of them picks a winner. Recorded here because a reader may expect the
  wiki to have a house position and it does not: the lexical evidence favours one reading, the
  narrative context favours another, and the description of the offspring favours the third.
- **The angelic reading is stated to be the older one.** This cuts against the majority view in most
  conservative commentary, so the basis is given explicitly on the connection page: every surviving
  pre-Christian Jewish treatment takes it that way, as do the earliest church fathers, and the
  Sethite reading is first attested in Julius Africanus and becomes standard only through Augustine.
  That is a claim about attestation dates, not about which reading is correct, and the page says so.
- **`Divine Grief and Relenting` was created as a theme rather than folded into `Judgment`.** The
  *nāḥam* problem — Genesis 6:6 against Numbers 23:19 and 1 Samuel 15:29, with 1 Samuel 15 holding
  both sides — recurs across Exodus 32, Jeremiah 18, Jonah, Joel, Amos, and Hosea 11, and needed
  somewhere to accumulate. All four approaches (anthropomorphism, the announced-intention
  distinction, relational responsiveness, open theism) are given with what each costs; the wiki does
  not adopt one.
- **`Favor and Grace` was created rather than treated under `Blessing`.** *Ḥēn* first occurs at 6:8
  and becomes *charis*; blessing and favor behave differently enough — one comes with a command
  attached, the other with nothing — that merging them would have flattened both.
- **The 6:8 / 6:9 question is left open on every page that touches it.** Whether Noah is spared
  because he was righteous or described as righteous because he was spared is not decided; the
  narrative order (favor first, character reference second, with a section heading between them) is
  reported and the two readings of that order are given. Hebrews 11:7 is noted as the New Testament
  resolving it in one direction.
- **The hundred and twenty years of 6:3 is not decided either** — cap on lifespan or countdown to
  the flood — with the arithmetic problem for the countdown reading (5:32 plus 7:6 yields 100, not
  120) stated alongside the Noah-lives-950 problem for the cap reading.
- **The source-critical seam at 6:8/6:9 is noted on the passage page**, because the abrupt heading,
  the second introduction of Noah, and the shift in divine name are features any reader notices and
  it is better to name the standard explanation than to leave the reader puzzling. The wiki takes no
  position on the documentary hypothesis, and the note says so.
- **Numbers 13:33 is flagged as coming from unreliable narrators.** The connection page points out
  that the Bible's only bridge between Genesis 6:4 and the giants of Canaan is a clause inside the
  *"evil report"* the next chapter condemns, and that Caleb and Joshua say nothing about Nephilim.
  This is a real observation about the text, not a dismissal of the identification, and the page is
  careful to keep the separate and better-attested Anakim/Rephaim tradition distinct from it.
- **No place page was created.** Genesis 6:1–8 names no location — only *"the surface of the
  ground"* and *"the earth"* — which is now the second consecutive pericope with no geography, and
  the passage page treats that as a change of scale rather than an omission.

Deliberately left for later pericopes, all as plain-text references so nothing dangles: Noah's
righteousness and *"walked with God"* at 6:9, the ark and the flood (6:9–8:22), God's promise and
the restated verdict at 8:21, Babel's *"let's make ourselves a name"* at 11:1–9, Numbers 13:33 and
the conquest giants, the Job and Deuteronomy 32:8 occurrences of *sons of God*, the 1 Samuel 15 and
Numbers 23:19 counter-texts, and Matthew 24, Jude, and 1–2 Peter in the New Testament.

`scripts/link-check.sh` clean, exit 0, against the documented baseline of 65 not-yet-started book
pages. All eight verses quoted on the passage page were checked mechanically against
`raw/bible/Genesis.md` — each one reassembled from the page's block quotes and compared character
for character — and every one matches verbatim.

## [2026-08-25] ingest | Genesis 6.9-7.24 — Noah and the Flood

Unattended run (`/ingest auto`, no target). Eighth pericope of Genesis; step 2's discussion is
written into the passage page rather than spoken.

The unit: the *tôlədōt* of Noah, the commission and specifications of the ark, the Bible's first
covenant, the two animal instructions, the boarding, the shutting of the door, and the flood as far
as its high-water mark. It ends at 7:24 — one verse short of *"God remembered Noah"* — because the
narrative is built as a chiasm with 8:1 at its exact centre, and the plan's boundary lands the
reader at the bottom of it. The boundary was inherited from the book plan and is kept unchanged.

Created:
- `wiki/passages/Genesis/Noah and the Flood.md`
- `wiki/people/Shem.md`, `Ham.md`, `Japheth.md`
- `wiki/themes/Righteousness.md`, `Covenant.md`, `Clean and Unclean.md`
- `wiki/connections/The Flood as Un-Creation.md`, `The Flood and Baptism.md`

Revised: `wiki/people/Noah.md` (new section — righteous, blameless, and silent), `God.md` (new
section — he destroys, and binds himself), `wiki/themes/Walking with God.md`, `Favor and Grace.md`,
`Judgment.md`, `Sin.md`, `Creation.md`, `Life and Death.md`, `Blessing.md`,
`wiki/connections/As It Was in the Days of Noah.md`, `wiki/books/Genesis.md` (box checked, three
themes and three people added), `wiki/books/index.md` (8 / 58), `wiki/people/index.md`,
`themes/index.md`, `connections/index.md`, and `wiki/index.md` counts (8 passages · 25 people ·
3 places · 19 themes · 20 connections).

Judgment calls made unattended, for review:
- **Shem, Ham, and Japheth were given person pages now**, which reverses a note left on
  `wiki/people/Noah.md` after the last ingest saying they would get none "until the flood narrative
  makes them people rather than a list". They are still a list here — named at 6:10 and 7:13 with no
  act and no words — but this *is* the flood narrative, they are named twice in it, and every
  remaining pericope of Genesis 9–11 leans on them. Each page says plainly how little the text has
  given so far and marks the rest as not yet ingested. If they read as premature, they lose nothing
  by having been started early.
- **No page for the four women in the ark.** Noah's wife and his sons' wives are in every boarding
  list (6:18, 7:7, 7:13) and are unnamed in Scripture from beginning to end. The passage page records
  that fact, and the later traditions that supply names (Emzara in *Jubilees*, Bitenosh in the
  Genesis Apocryphon), rather than creating four pages with nothing on them. Revisit at 9:18–29.
- **Three new theme pages, each justified by a first occurrence in Scripture.** `Righteousness`
  (*ṣaddîq*, 6:9), `Covenant` (*bərît*, 6:18), and `Clean and Unclean` (7:2). Each is a term the rest
  of the canon builds on heavily and each needed somewhere to accumulate from its first verse rather
  than from the book that later defines it.
- **The 6:8 / 6:9 question is still left open**, now on both sides of it. The passage page, `Noah`,
  `Favor and Grace`, and `Righteousness` all record that 6:9 supplies the righteousness without
  supplying a connective, and that the righteousness is declared before any act is narrated. No page
  decides whether the favour grounds the righteousness or the reverse.
- **"Blameless among the people of his time" is not resolved either.** Both readings of *bədōrōtāyw*
  — intensive (*even in* that generation) and restrictive (*by the standards of* it) — are given,
  with the Talmudic dispute between Rabbi Yohanan and Resh Lakish (*Sanhedrin* 108a) cited as
  evidence that the restrictive reading is ancient rather than modern skepticism.
- **The two animal counts (6:19–20 against 7:2–3) are given three readings and no verdict** —
  refinement, sources, and deliberate composition. The source-critical note is expanded here because
  the flood account is the documentary hypothesis's strongest demonstration case anywhere in the
  Pentateuch, and the verse-level division is recorded so a reader can check it. The wiki continues
  to take no position, and reads the account as the single narrative it now is.
- **The flood's extent is not adjudicated.** Universal, local/regional, and literary-theological
  readings are set out with what each costs. The observation offered instead is that no later text
  in Scripture ever argues from the flood's physical extent — Isaiah 54, Matthew 24, 1 Peter 3, and
  2 Peter 3 all argue from its completeness as a judgment and from the eight who came through.
- **The Mesopotamian parallels are stated plainly rather than hedged.** Gilgamesh XI, Atrahasis, and
  the Ziusudra tradition share too many specifics with Genesis for coincidence; the page says so, and
  puts the weight on the four differences that carry the theology (cause, agency, the sacrifice, the
  survivor's end). No direction of borrowing is claimed, because none is establishable.
- **The "curse of Ham" reading is addressed on `wiki/people/Ham.md`, before Genesis 9 is ingested.**
  It is placed there rather than only on the future passage page because the association attaches to
  the name, and a reader arriving at his page from the flood should not find the wiki silent about
  it. Four checkable textual points are given: the curse falls on Canaan, it is spoken by Noah and
  not by God, its content concerns Shem and Japheth, and Genesis 10 assigns Egypt and Canaan to Ham.
- **`The Flood as Un-Creation` was made a connection page rather than folded into `Creation`.** The
  correspondences are lexical and run in order, they need a table, and Jeremiah 4:23–26 reuses the
  whole pattern — enough material that the theme page would have been swallowed by it.
- **No place page. Third consecutive pericope with no named location**, and the passage page treats
  that as the primeval history's frame reaching its maximum rather than as an omission. Ararat
  arrives at 8:4, in the next pericope.

Deliberately left for later pericopes, all as plain-text references so nothing dangles: *"God
remembered Noah"* and the raven and the dove (8:1–12), the altar and the promise at 8:20–22, the
covenant actually established with the rainbow (9:8–17), Noah's first recorded words and the curse
on Canaan (9:18–29), the Table of Nations (10), Babel (11:1–9), the *tēbâ* of Exodus 2, Leviticus 11,
and the New Testament's Noah texts in Matthew 24, Hebrews 11, and 1–2 Peter. `The Waters Recede` was
written as a plain reference rather than a wikilink for the same reason.

`scripts/link-check.sh` clean, exit 0, against the documented baseline of 65 not-yet-started book
pages. All sixteen verses block-quoted on the passage page were checked mechanically against
`raw/bible/Genesis.md` — each reassembled from the page's block quotes and compared character for
character — and every one matches verbatim. The page's inline quotations were checked the same way:
thirty resolve against the raw Genesis text, and the remainder are citations of other books
(Hebrews 11:7, 2 Peter 2:5, Psalm 29:10, Romans 11:5, Isaiah 54:9, Ezekiel 14:14, Matthew 24:39,
1 Peter 3:20, Romans 1:8) or of Gilgamesh XI. Two inline quotations were corrected during the check:
Genesis 1:6 had been paraphrased as *"to divide the waters from the waters"* and now reads *"let it
divide the waters from the waters"*, and a fragment of 7:11 that had been silently capitalized is
now marked as elided.

## [2026-08-25] schema | Book/person name collisions — the person page takes `(person)`

Job is the first book whose title is also a person's name, and it will not be the last: Ruth,
Samuel, Ezra, Nehemiah, Esther, Daniel, the twelve Minor Prophets, and several New Testament
letters all do the same. `wiki/books/Job.md` and a `wiki/people/Job.md` would both answer to
`[[Job]]`, and Obsidian resolves that by an unstated rule.

Worse, **`scripts/link-check.sh` cannot see the problem**: check 2 indexes existing pages by
basename as well as by path, so two files called `Job.md` both register as the target `Job` and the
check passes. The failure is silent at both ends, which is why the rule added to `CLAUDE.md` under
`## Naming conventions` is mandatory rather than stylistic.

The rule: **the book page keeps the bare name; the person page takes `(person)`.** The book side is
fixed by the directory map and by the 66 links in `wiki/books/index.md`, so the person is the side
that moves. It is category-style disambiguation, exactly parallel to the existing
`Enoch (city)` / `Enoch (son of Cain)` pair, and it is deliberately mechanical rather than
descriptive so that it can be applied without a judgment call each time. Names that already need
disambiguating for another reason — `John the Baptist`, `James (son of Zebedee)` — never produce a
bare collision and so never take `(person)`. The qualifier is written out in links and never piped
away.

## [2026-08-25] ingest | Job 15.1-17.16 — Eliphaz's Second Speech; Miserable Comforters and the Witness in Heaven

First touch on Job, run interactively against the argument `Job 15,16, and 17`. Three chapters were
asked for and three were ingested, which is **two pericopes rather than the usual one** — Job 15 is
Eliphaz's second speech and Job 16:1–17:16 is Job's reply to it, and they do not belong in one
passage page because they have different speakers. Both were done in the same pass because the
request named all three chapters; the ordinary one-pericope-per-invocation rule is otherwise
unchanged.

`scripts/fetch-book.sh "Job"` pulled all 42 chapters into `raw/bible/Job.md`.

Created:
- `wiki/books/Job.md` — with the full 32-pericope plan for the book (see below)
- `wiki/passages/Job/Eliphaz's Second Speech.md`
- `wiki/passages/Job/Miserable Comforters and the Witness in Heaven.md`
- `wiki/people/Job (person).md`, `Eliphaz the Temanite.md`, `Bildad the Shuhite.md`,
  `Zophar the Naamathite.md`
- `wiki/places/Teman.md`, `Sheol.md`
- `wiki/themes/Retribution.md`, `Suffering.md`, `Wisdom.md`, `Hope.md`,
  `Mediation and Advocacy.md`
- `wiki/connections/What Is Man That He Should Be Clean.md`,
  `The First Man and Wisdom Before the Hills.md`, `Do Not Cover My Blood.md`,
  `The Witness in Heaven.md`

Updated: `wiki/people/God.md` (new section — in Job's poetry he does not speak, and the two
passages give him three incompatible roles in forty verses: the moral accountant the friends
defend, the assailant of 16:7–14, and the witness and guarantor of 16:19 and 17:3; plus the note
that the poetry drops *Yahweh* for *ʾĒl*, *ʾĔlôah*, and *Šadday*), `Adam.md` (Job 15:7's *"the
first man who was born"*), `Abel.md` (Job 16:18 as the measure of his reach), `Noah.md` (the other
two men Ezekiel 14:14 names beside him are Daniel and Job),
`wiki/passages/Genesis/Cain and Abel.md` (Job 16:18 among its cross-references),
`wiki/connections/Cain and Abel in the New Testament.md` (Job 16:18 as the middle term in the
*what blood says* strand), `The Sons of God and the Angels That Sinned.md` (Job 4:18 and 15:15 now
linked, and its Job references resolved), `wiki/themes/Sin.md`, `Judgment.md`, `Righteousness.md`,
`Life and Death.md`, all five category indexes, `wiki/books/index.md`, and `wiki/index.md` counts.
`CLAUDE.md` gained the book/person naming rule — logged separately above.

Judgment calls made, for review:
- **The pericope plan divides Job into 32 units** on the book's own architecture — prologue,
  opening lament, three speech cycles, the wisdom hymn, Job's defense, Elihu, the whirlwind, and
  the epilogue — rather than by chapter. **Titling convention, stated on the book page: the
  friends' speeches are numbered plainly (*Eliphaz's Second Speech*) and Job's replies take a
  phrase from the speech (*There Is No Umpire Between Us*, *I Know That My Redeemer Lives*).** In a
  book of three cycles of three, the reader's first need from a friend's speech is to know where in
  the pattern it falls; Job's replies are where the memorable lines are. The third cycle is planned
  as four boxes (22, 23–24, 25, 26–27) on the assumption that the pattern's breakdown there is part
  of the text; if the dislocation reading is preferred later, those boxes are unchecked and free to
  redraw.
- **`Sheol` is filed under places, not themes.** The Hebrew Bible speaks of it as somewhere people
  *go* — down to it, through its gates — and a reader following a passage's geography should find
  it beside the other locations. The page says outright that it is a realm and that nothing in
  Scripture locates it.
- **All three friends got pages, though only Eliphaz speaks in these chapters.** Bildad and Zophar
  are inside Eliphaz's *"we"* and *"with us"* (15:9–10) and inside Job's plurals (*"You are all
  miserable comforters"*, 16:2; *"as for you all"*, 17:10). The friends argue as a bloc and Job
  answers the bloc, so leaving two of the three unlinked would have misrepresented the passage.
- **Five new themes at once**, which is more than any previous ingest. Job introduces a set of
  concepts Genesis had no occasion for, and `Retribution`, `Suffering`, `Wisdom`, `Hope`, and
  `Mediation and Advocacy` were all needed by these two chapters rather than anticipated for later
  ones.
- **Prologue and epilogue material is used freely as background but never linked**, since Job 1–2
  and 42 are not ingested. All such references are plain scripture citations, so nothing dangles.

Contested points recorded rather than resolved:
- **The identity of the witness in heaven (16:19).** Three readings kept side by side — God himself
  (the majority modern view, and the one 17:3 supports since Job there asks God to stand surety
  with God), a distinct heavenly advocate (which suits the legal language and Elihu's 33:23–24 but
  is never confirmed by the book), and Job's own cry personified (which follows the verse order
  from 16:18 exactly and is the least popular). The observation offered instead of a choice: the
  heavenly court in this book does contain a figure interested in Job's case, and he is the
  prosecution.
- **The Christian reading of the thread is given with three limits stated.** Job asks for an
  advocate *against* God, where 1 John 2:1 has an advocate *with the Father* on a guilty party's
  side — a different configuration; the book never endorses the figure; and the Hebrew of 19:25–27
  is badly damaged, so the thread's most quoted verse is its weakest link. The page also notes the
  book's own resolution, which is that the advocate never arrives and Job becomes one (42:8).
- **What is actually wrong with the friends' anthropology.** Stated as three separate claims rather
  than a blanket dismissal: the propositions of 15:14–16 are largely defensible and Job says much
  the same at 9:2 and 14:4; the *inference* from universal guilt to a particular verdict is invalid;
  and 42:7 locates the fault in the picture of God the argument produces, not in the anthropology.
  1 Corinthians 3:19 quoting Eliphaz (Job 5:13) as authority is recorded as the evidence that 42:7
  cannot mean *everything the friends said was false*.
- **Whether 16:9–14 describes God or the accuser.** The minority reading is noted (16:9's *ṣārî*,
  *my adversary*, shares a root with *śāṭān*) and then rejected on the text's grounds: 16:7
  addresses God in the second person, and the prologue makes the accuser act only by permission.
  The violence is taken as intended.
- **Job 17:9** (*"Yet shall the righteous hold on his way"*), which sounds like the friends in Job's
  mouth. Three readings given — irony, a genuine upward flash, textual disturbance — with the second
  preferred, on the ground that 16:19 has already made one unprepared upward turn.
- **Whether Job was historical.** Three positions given (historical figure, historical core with
  poetic elaboration, parable), with Ezekiel 14:14 and James 5:11 on one side and *Bava Batra* 15a
  on the other, and the note that the book's argument survives all three.
- **The third cycle's collapse** (Bildad's six verses, Zophar's silence) is recorded on Bildad's
  page as either textual dislocation or deliberate design, with no position taken and the point
  flagged that the second cycle — where these chapters sit — is the last one intact.
- **Sheol is kept at its own date.** The undifferentiated realm of the dead is distinguished from
  Hades, Gehenna, and hell, and the page declines to answer Job 17:15–16 out of Daniel 12:2 or the
  New Testament, since the resource is not yet available to him and importing it removes the problem
  the chapter poses.
- **Job 13:15 was corrected during the verification pass.** The page had reported the famous
  *"Though he slay me, yet will I wait for him"* as the WEB's reading with *"I have no hope"* as the
  margin. The WEB in fact reads *"Behold, he will kill me. I have no hope. Nevertheless, I will
  maintain my ways before him."* — it adopts the opposite textual decision from the KJV. `Hope.md`
  now says so.

Deliberately left for later pericopes, all as plain-text references so nothing dangles: the whole
prologue and epilogue (Job 1–2, 42), Elihu, Job's wife, Uz, Edom, Abaddon, and every Job chapter
outside 15–17. `Eliphaz son of Esau` and `Teman` in Genesis 36 are referenced in plain text and get
pages when Genesis 36 is ingested.

`scripts/link-check.sh` clean, exit 0, against a baseline now down to 64 not-yet-started book
pages. No passage title is duplicated across books, and no two pages in the vault share a basename.
All thirty verses block-quoted on the two passage pages were reassembled from the pages and
compared character for character against `raw/bible/Job.md`: all thirty match verbatim. Inline
quotations were checked the same way — 69 quotations explicitly attributed to a Job or Genesis
reference all resolve against the raw text, and the remainder are citations of books this repo has
not fetched. **Eleven inline quotations were corrected during that check**: Job 42:5 read *"I have
heard"* for *"I had heard"*; 3:11 *"Why did I not die"* for *"Why didn't I die"*; 9:2 *"But in truth
I know"* for *"Truly I know"*; 19:25 was conflated into one clause; 33:23 read *"messenger"* where
the WEB has *"an angel"*; 8:10 added an *"and"*; 4:15 used a semicolon for a full stop; 14:13
dropped two commas; 17:14's two inner quotations had been merged into one; 42:7 was quoted in a
reconstructed form; and Job 28:28 had been cited for Proverbs 9:10's wording. 14:7 was re-elided
rather than silently re-cased.

## [2026-08-25] ingest | Genesis 8.1-22 — The Waters Recede

Interactive run (`/ingest`, no target). Ninth pericope of Genesis, and the descending half of the
flood chiasm whose ascent was ingested as [[Noah and the Flood]].

One resolution question was put to the user before starting: two books are marked `in-progress`
(Genesis at 8/58, Job at 2/32), so "the book currently being worked" was ambiguous. The user chose
Genesis. Job's first unchecked box remains `Job of Uz — Job 1:1–5`, which is where a Job-targeted
run picks up.

The unit: *"God remembered Noah"* and the wind over the water, the fountains stopped, the ark
resting on Ararat's mountains, the dated recession, the raven and the dove, the command to
disembark, the first altar in Scripture, and God's resolve at 8:21–22. The plan's boundary
(8:1–22) was kept unchanged — it is the chiasm's whole descending arm, and 9:1 starts the blessing
and covenant material.

Created:
- `wiki/passages/Genesis/The Waters Recede.md`
- `wiki/places/Ararat.md`
- `wiki/themes/Remembrance.md`
- `wiki/connections/The Dove and the Spirit.md`, `A Pleasing Aroma.md`

Revised: `wiki/people/Noah.md` (new section — the birds, the altar, and the silence unbroken),
`God.md` (new section — he remembers, and changes his mind about nothing except what he will do),
`Shem.md`, `Ham.md`, `Japheth.md`, `Lamech (father of Noah).md`; `wiki/themes/Curse.md`,
`Judgment.md`, `Hope.md`, `Divine Grief and Relenting.md`, `Sin.md`, `Clean and Unclean.md`,
`Sacrifice and Offering.md`, `Covenant.md`, `Creation.md`, `Blessing.md`, `Life and Death.md`,
`Favor and Grace.md`, `Sabbath.md`; `wiki/connections/The Flood as Un-Creation.md`,
`Comfort from the Cursed Ground - Naming Noah.md`, `The Flood and Baptism.md`,
`As It Was in the Days of Noah.md`; `wiki/passages/Genesis/Noah and the Flood.md` (its two forward
references to Genesis 8 now resolve); `wiki/books/Genesis.md` (box checked),
`wiki/books/index.md` (9 / 58), `wiki/places/index.md`, `themes/index.md`, `connections/index.md`,
and `wiki/index.md` counts (11 passages · 29 people · 6 places · 25 themes · 26 connections).

Twelve forward references left by earlier ingests as *(not yet ingested)* now point at a real page:
in `Curse`, `Judgment`, `Hope`, `Divine Grief and Relenting`, `Sin`, `Clean and Unclean`,
`Sacrifice and Offering`, `Covenant`, `The Flood as Un-Creation`,
`Comfort from the Cursed Ground - Naming Noah`, `The Flood and Baptism`, and `Noah and the Flood`.

Judgment calls, for review:
- **`Remembrance` was made a theme page rather than a connection page.** *Zākar* is a word-motif
  running the length of the canon with no single pair of passages at its centre, which is
  theme-shaped rather than connection-shaped. Put to the user before writing and approved.
- **The Gilgamesh XI comparison lives in the passage page's Notes, not on a connection page.**
  Connection pages are for scripture-internal links; a comparative-literature note belongs in the
  passage's apparatus. Put to the user before writing and approved. The note states the two points
  of near-identity (the bird-sending and *"the gods smelled the sweet savour"*) and the difference
  Genesis makes of the second, without adjudicating literary dependence.
- **`Ararat` got a place page though only one verse names it.** The justification is that it is the
  first named location in Genesis since Nod (4:16), that the Hebrew plural (*"the mountains of
  Ararat"*, a region) is routinely lost in English and worth recording once, and that Ararat recurs
  in 2 Kings 19:37 and Jeremiah 51:27 as an ordinary kingdom. The page says plainly that the
  single-peak identification is medieval and not biblical.
- **No new person pages.** Genesis 8 names no one Genesis 7 did not. The four women in the ark
  remain without pages, per the decision recorded at the previous ingest; the small change here —
  God's command at 8:16 pairs husbands with wives (*"you, your wife, your sons, and your sons'
  wives"*) where every boarding list separated them — is recorded on the passage page, along with
  the honest qualification that the narration two verses later (8:18) reverts to the old order.
- **`kî` at 8:21 is read causally, and the alternative is stated.** The page argues for *"because
  the imagination of man's heart is evil"* over the concessive *"even though"* on three grounds
  (the dominant use of *kî*, the near-quotation of 6:5 where the same construction is causal, and
  the fact that the concessive reading makes the sentence unremarkable), while recording that the
  Hebrew permits the concessive.
- **8:21 is described as answering 5:29 partially, not fully**, consistent with what
  `Comfort from the Cursed Ground - Naming Noah` already said. The new material is the philological
  reason: 8:21's verb is *qālal*, not the *ʾārar* of 3:17, so no further curse is added and the
  standing one is not lifted.
- **`The Dove and the Spirit` is explicit that no biblical writer links the two doves.** The page
  says so twice and rests the connection on 1 Peter 3:20–21's flood/baptism typology plus an
  audible echo, rather than claiming a citation. It also notes the rabbinic gloss on Genesis 1:2
  (*Ḥagigah* 15a) that had the Spirit hovering *"like a dove"* independently of any Christian
  reading.
- **`As It Was in the Days of Noah` gained a section it was not obviously owed** — on why 2 Peter
  3:5–7 has to change the element from water to fire, given 8:21 and Isaiah 54:9. Judged worth
  adding because the typology's mechanics depend on the promise this pericope contains.

`scripts/link-check.sh` exits 0: no wrapped links, no dangling targets, 64 not-yet-started book
pages as the expected baseline. No links were deliberately left dangling this pass; forward
references to Genesis 9–11 are written as plain scripture references marked *(not yet ingested)*.

Noted for a future schema pass, not changed here: `CLAUDE.md`'s `## Link checks` section says the
baseline is "65 of them at present". It has been 64 since Job was started, and the script computes
it, so the number in prose is already stale.
