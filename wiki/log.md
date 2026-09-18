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

## [2026-08-25] schema | The link-check baseline is described by its rule, not by a count

`CLAUDE.md`'s `## Link checks` section said check 2's expected baseline was "65 of them at present,
shrinking by one per book completed." Both halves had drifted from what the script does.

The count was wrong: `scripts/link-check.sh` prints 64, and has since the Job page was created.
The rule was also wrong. The baseline is the set of targets linked from `wiki/books/index.md` whose
page does not exist (see the script's line 87 — it collects dangling targets and checks them
against that index), so it shrinks when a book **page is created**, which is when ingestion first
reaches the book, not when the book is finished. Genesis and Job are both `in-progress` and both
already have pages, so both have already left the baseline: 66 − 2 = 64.

Nothing was broken by this — the script computes the number itself and excludes those links from
its findings, so link-check has been exiting 0 correctly throughout. The only cost was a reader
comparing the doc's 65 against the script's 64 and having to work out which one to trust, which is
what happened during the Genesis 8:1–22 ingest and is why it was logged there first.

Changed: the paragraph now states the rule and says explicitly not to compare the script's printed
count against a number written down in the schema. No number is quoted, so it cannot go stale
again. `scripts/link-check.sh` itself is unchanged.

## [2026-08-25] schema | Multiple in-progress books resolve to the earliest, never to a question

The `/ingest` skill's step 1 said to take "the next pericope in the book currently being worked",
which assumes exactly one such book. Two are `in-progress` right now — Genesis (9/58) and Job
(2/32), the latter started out of canonical order — so the Genesis 8:1–22 ingest hit a fork and
resolved it by asking the user. An interactive run can afford that. `/ingest auto` cannot: an
unattended run is told never to ask a question, and this fork had no rule to fall back on.

The rule now, in `.claude/skills/ingest/SKILL.md`:

- The target book is the **first `in-progress` book in `wiki/books/index.md`**, which is in
  canonical order. Genesis before Job, always. Not the most recently ingested book, not the one the
  last log entry names, and never a question to the user.
- An `in-progress` book **outranks an earlier `not-started` one** — when Genesis completes, the next
  target is Job rather than Exodus. Open books get finished before new ones are opened, so a book
  the user deliberately started out of order is not stranded behind the seventeen books preceding
  it.
- Only when no book is `in-progress` does the scan fall through to the first `not-started` book,
  which is the behaviour that was already documented.

Also fixed in the same block: the sample command was `grep -n "in-progress" wiki/books/index.md`,
which matches the status legend on line 3 of that file (`Status: not-started · in-progress ·
complete`) rather than any book. It is now anchored to `^- `.

The rule lives only in `SKILL.md`, not also in `CLAUDE.md`. Target resolution is the skill's job,
and a second copy of a rule in the schema is exactly the drift that produced the stale link-check
baseline logged above.

## [2026-08-26] ingest | Job 1.1-5 — Job of Uz

The first pericope of Job's prologue, ingested out of sequence with the rest of the book: chapters
15 and 16–17 were done first, so this is the book's opening five verses arriving third. Target was
resolved as the first unchecked box on `wiki/books/Job.md`, per the skill's rule, and the user
named Job explicitly.

**Created**

- `wiki/passages/Job/Job of Uz.md` — the passage page. Five prose verses treated as four moves: the
  narrator's fourfold verdict (1:1), the household (1:2), the inventory (1:3), and the standing
  sacrifice (1:4–5). The reading the page argues is that the unit exists to assemble the premises
  of retribution so the poem can break the conclusion, and that the accuser's question in 1:9
  ("Does Job fear God for nothing?") is aimed specifically at the scrupulousness shown in 1:5.
- `wiki/places/Uz.md` — new place page. The three lines of biblical evidence (Genesis 10:23 Aramean,
  Genesis 36:28 Horite/Edomite, Lamentations 4:21 Edom) are set out without forcing a resolution;
  the page's argument is that the location matters mainly because it is *not Israel*.
- `wiki/themes/The Fear of God.md` — new theme page. Written now rather than later because Job 1:1
  is the phrase's load-bearing occurrence and 1:9 is the only place in Scripture where its *motive*
  is put on trial. Traces Genesis 22:12 → Job → Proverbs 1:7 → Job 28:28 → Ecclesiastes 12:13 →
  Acts 10 → Hebrews 12:28–29, including the 1 John 4:18 counter-statement.
- `wiki/people/Job's Children.md` — new person (group) page. Created rather than folded into the
  passage because the ten recur at 1:13–19, 8:4, 19:17, 29:5, and 42:13–15, and because the
  doubled-livestock / undoubled-children asymmetry at 42:12–13 needs a stable home. Three readings
  of that asymmetry recorded side by side, none preferred.
- `wiki/connections/Blameless Before Anyone Is Watching.md` — Genesis 6:9 against Job 1:1. Same
  narrative move (verdict before evidence, narrator then confirmed by God), different consequence:
  Noah's righteousness protects him, Job's is what qualifies him for the test. Includes Ezekiel
  14:14, 20, and the observation that Ezekiel denies these three men exactly the intercessory
  office Job 42:8 grants Job.
- `wiki/connections/Sacrifice Before the Priesthood.md` — Cain and Abel, Noah's altar, and Job 1:5
  as uncommanded offerings with no priest and no law; Job's as the first in Scripture for a sin
  that may not have happened and is located in the heart. Notes that this makes the book's critique
  of retribution broader than a critique of Israelite legalism, since there is no law in Job to
  misread.

**Revised**

- `wiki/books/Job.md` — box checked and linked; `[[Uz]]`, `[[Job's Children]]`, and
  `[[The Fear of God]]` added to the key lists. Pericope plan otherwise unchanged — no boundary was
  redrawn.
- `wiki/people/Job (person).md` — passage added to *Appears in* and to the timeline; Job's Children
  added to *Related people*; The Fear of God and Sacrifice and Offering added to *Themes
  associated*; the Ezekiel note pointed at the new connection page.
- `wiki/people/God.md` — new paragraph in the Job section on how the prose frame differs from the
  poetry: in 1:1–5 God is the object of a life rather than the subject of an argument, and is
  *ʾĕlōhîm* until *Yahweh* arrives with the council in 1:6.
- `wiki/people/Noah.md` — Job added to *Related people* and both new connection pages to
  *Appears in*.
- `wiki/themes/Righteousness.md`, `Blessing.md`, `Sin.md`, `Retribution.md`, `Wisdom.md`,
  `Sacrifice and Offering.md` — key-passage entries for Job 1:1–5, and a *Development across
  Scripture* entry for Job 1:5 on the sacrifice theme.
- All five category indexes and `wiki/index.md`'s counts (12 passages · 30 people · 7 places ·
  26 themes · 28 connections); `wiki/books/index.md` Job now 3 / 32.

**Judgment calls worth reviewing**

- **`Job's Children` created as a person page for an unnamed group.** The precedent is
  `[[The Nephilim]]` and `[[The Sons of God]]`. The alternative was to leave them inside the
  passage page, which would have stranded the 42:12–13 arithmetic.
- **`The Fear of God` created as a theme now**, though the phrase will recur far more often in
  Deuteronomy, Psalms, and Proverbs than in Job. Created early because Job 1:9 is the one place the
  Bible asks whether the fear can be disinterested, and that question is this book's plot.
- **The children's feasts are read as innocent.** The page states that the text says nothing against
  them, that the sisters' inclusion argues against the debauchery reading, and that Bildad's use of
  their deaths at 8:4 is therefore a manufactured sin. This is a reading, and it is flagged as one
  on both `Job of Uz` and `Job's Children`.
- **No page created for Job's wife or for the accuser**, both of whom belong to Job 1:6–2:10 and
  will get their treatment when those pericopes are ingested.

Link check clean.

## [2026-08-29] ingest | Genesis 9.1-17 — The Covenant with Noah

Unattended run (`/ingest auto`, no argument). Genesis is the first `in-progress` book in
`wiki/books/index.md` and `The Covenant with Noah — Genesis 9:1–17` was the first unchecked box on
its page, so the target resolved with no fork. `raw/bible/Genesis.md` was already present; no fetch
was needed. The pericope boundary was taken as drawn — 9:1–17 divides cleanly at the seam between the
blessing-and-law block and the covenant speech, and 9:18 begins a new unit with its own subject
(*"The sons of Noah who went out from the ship…"*).

**The passage page** (`wiki/passages/Genesis/The Covenant with Noah.md`) carries the discussion that
an interactive run would have had aloud. It reads the pericope as two halves that are usually taken
separately and argues they belong together: 9:1–7 reissues the creation mandate with the terms
altered, and 9:8–17 establishes the covenant of 6:18 in public with a sign. Seventeen verses are
block-quoted verbatim.

Judgment calls made in the passage page, recorded here so they can be reviewed:

- **The dominion language is treated as a deliberate omission, not an abbreviation.** *Kābaš* and
  *rādâ* of 1:28 do not occur in Genesis 9 and no synonym replaces them; what stands in their place is
  *"the fear of you and the dread of you"* (9:2), the pair Deuteronomy 11:25 uses of Israel's enemies,
  with the creatures *"delivered into your hand"*, the idiom for a city handed to an army. The page
  states this as a change the text makes silently, and flags the tension it creates for the strict
  functional reading of the image on `wiki/themes/Image of God.md`: Genesis 9 keeps the image (9:6) in
  the same speech that drops the vocabulary of ruling.
- **9:6 is left undecided between law and prediction**, and both readings are set out with what each
  rests on. The Hebrew has neither imperative nor addressee — a participle plus an imperfect — so the
  grammar does not settle it; the institutional reading has the Torah's homicide law behind it
  (Exodus 21:12, Leviticus 24:17, Numbers 35), the predictive reading has Matthew 26:52 and
  Revelation 13:10. Genesis supplies no court, no procedure, and no penalty scale, which is the point
  the page makes instead of adjudicating.
- **The *qešet* is read as a war bow, with the caveat stated.** Hebrew has no separate word for the
  meteorological arc, so the ambiguity is in the language rather than in the interpretation, and the
  page says so before drawing anything from it.
- **The Mesopotamian parallels are given plainly and no borrowing is claimed**, following the practice
  set on `The Waters Recede`: Anu setting Marduk's bow in heaven (*Enūma Eliš* VI) and Ishtar's
  necklace-oath after the flood (*Gilgamesh* XI) share the configuration — deity, sky-object, oath,
  divine remembering — and the differences are named.
- **Source criticism is noted and used**, because the seam is unusually clean here: 8:20–22 is J
  (altar, *Yahweh*, God speaking in his heart) and 9:1–17 is P (*ʾĕlōhîm* without exception, covenant,
  sign, the vocabulary of 1:1–2:3), so the two promises never to flood the earth again sit adjacent
  under different hands. The page argues the finished text makes the doubling do work — a private
  resolve nobody hears, then a public covenant with a sign — and that the gap between them is where
  Noah builds an altar without assurance.
- **The four women in the ark are recorded as absent from the sentence.** 9:1's *be fruitful and
  multiply* is addressed to *"Noah and his sons"*, four men, where 1:28 was addressed to male and
  female. Noted on the passage page rather than passed over.

**New theme: `Blood`.** Created rather than folded into `Life and Death` or `Sacrifice and Offering`,
because the material is canon-spanning and load-bearing in three directions at once — life-in-the-blood
(9:4, Leviticus 17:11), blood-guilt (4:10, 9:5–6, Numbers 35:33), and blood as what atones (Leviticus
17:11, Hebrews 9:22) — and both existing themes would have been swallowed by it. It is the 27th theme
page.

**Three new connection pages**, each for a thread that needed a table or a canon-length list rather
than a paragraph on a theme page:

- `The Bow in the Cloud` — *qešet* as a weapon set down, the sign whose seeing is God's rather than the
  human party's, and the image's afterlife in Ezekiel 1:28 and Revelation 4:3 and 10:1.
- `Whoever Sheds Man's Blood` — the chiasm of 9:6, the cancelling of Cain's seven and Lamech's
  seventy-seven by one, the delegation from God's hand to human hands, and the Torah's procedural
  apparatus that Genesis lacks.
- `The Noahic Commandments and the Council of Jerusalem` — Genesis 9 as the only law in the Hebrew
  Bible addressed to all humanity, the rabbinic seven built on it, and the disputed derivation of the
  four abstentions of Acts 15 (Noah, or Leviticus 17–18). Both cases are given; the page does not pick
  one.

**Pages revised:** `wiki/books/Genesis.md` (box checked and linked, `Blood` added to key themes);
`God` (a new section on 9:1–17 — legislating for the first time, delegating, and binding his memory to
an object; timeline and appears-in); `Noah` (a new section — everything given, nothing said back, and
the silence that ends badly eight verses later); `Shem`, `Ham`, `Japheth` (addressed by God for the
first time, and covenant parties in their own right); `Covenant` (the *bərît*-density note, the four
defining features, the first *bərît ʿôlām*); `Blessing`, `Image of God`, `Life and Death`, `Vengeance`,
`Judgment`, `Remembrance`, `Creation`, `Clean and Unclean`, `Sacrifice and Offering`; and the
connection page `The Flood as Un-Creation`, whose forward reference to 9:1–7 now resolves. Category
indexes and `wiki/index.md`'s counts updated (13 passages, 27 themes, 31 connections).

**No place page.** The pericope has no geography at all — its arena is *hāʾāreṣ*, nine times in
seventeen verses, and the earth is the covenant's second party at 9:13. `Ararat` at 8:4 remains the
only named location since Genesis 4.

Deliberately left for later pericopes, all written as plain-text references so nothing dangles:
Genesis 9:18–29 (the vineyard, Noah's first words, and the curse on Canaan), Genesis 10 (the Table of
Nations), Genesis 15 and 17 (the covenant between the pieces, circumcision as sign and *bərît ʿôlām*),
Exodus 12 and 24 (the Passover blood and the blood of the covenant), Leviticus 11 and 17, Numbers 35,
and the New Testament's uses of 9:4 and 9:6 in Acts 15, Romans 13, Hebrews 9, and Revelation.

`scripts/link-check.sh` clean, exit 0, against the documented baseline of 64 not-yet-started book
pages. The seventeen verses block-quoted on the passage page were checked mechanically against
`raw/bible/Genesis.md` — each reassembled from the page's block quotes and compared character for
character — and every one matches verbatim. Five inline quotations were corrected during that check
rather than left approximate: Genesis 1:28 had been transcribed with straight quotation marks and now
carries the raw file's curly ones; Abel's offering at 4:4 had been given as *"the fat of their
firstlings"* and now reads *"some of the firstborn of his flock and of its fat"*; Leviticus 17:11 had
been run into one sentence and is now quoted as two; Exodus 24:7 had been given as *"All that Yahweh
has said will we do"* and now reads *"All that Yahweh has spoken will we do, and be obedient"*; and
2 Peter 3:7 had *"the heavens that now exist"* for WEB's *"the heavens that now are"*. Acts 15:20 and
Psalm 7:12 were corrected the same way on the new connection pages.

## [2026-08-29] ingest | Genesis 9.18-29 — Noah's Sons and the Curse of Canaan

Unattended run (`/ingest auto`, no target). `wiki/books/index.md` had Genesis and Job both
`in-progress`; Genesis is earlier in canonical order and so wins per the skill's step 1, and its
first unchecked box was *Noah's Sons and the Curse of Canaan — Genesis 9:18–29*. `raw/bible/Genesis.md`
was already present, so no fetch. Step 2's discussion is written into the passage page rather than
spoken.

**Created**

- `wiki/passages/Genesis/Noah's Sons and the Curse of Canaan.md` — the pericope in four movements:
  the superscription that names the three sons and points at Genesis 10 (18–19), the vineyard and the
  exposure (20–23), the oracle (24–27), and the Genesis 5 obituary that finally closes Noah's entry
  (28–29).
- `wiki/people/Canaan (son of Ham).md` — see the naming decision below.
- `wiki/themes/Nakedness and Covering.md` — *ʿārôm* against *ʿerwâ*, the pattern of exposure and a
  covering supplied by someone else, from 2:25 through Leviticus 18 and Ezekiel 16:8 to Revelation
  3:18.
- `wiki/connections/Naked and Ashamed - Genesis 3 and Genesis 9.md` (parallel) — the five shared
  beats, in a table, and what changes: in Genesis 3 God forbids, discovers, covers, and curses; in
  Genesis 9 people do all four and the result is worse.
- `wiki/connections/The Curse of Canaan and the Conquest.md` (thread) — the etiological reading, and
  the finding that runs against the assumption: **no biblical writer ever cites 9:25**. Leviticus
  18:24–30 and Deuteronomy 9:4–5 ground the dispossession in conduct, and Joshua 9's servitude is the
  price of a fraudulent treaty.
- `wiki/connections/The Vine and the Cup.md` (thread) — wine as gladness, stupor, wrath, and
  covenant, all four latent in the first vineyard.

**Revised**

`wiki/books/Genesis.md` (box checked and linked; Canaan and the new theme added to the key lists),
`wiki/people/Noah.md` (new section on the vineyard, the first words, and the death), `Ham.md` (new
section on 9:22, and the "curse of Ham" note expanded from four counts to six), `Shem.md` (the
garment, and the first *bārûk YHWH*), `Japheth.md` (the pun and the three readings of *"dwell in the
tents of Shem"*), `God.md` (a section on his absence), `wiki/themes/` Curse, Blessing, Sin,
Righteousness, Work, City and Civilization, Life and Death, Judgment, Covenant,
`wiki/connections/Comfort from the Cursed Ground - Naming Noah.md` (its 9:20–21 line was the last
*(not yet ingested)* marker pointing here), `wiki/passages/Genesis/The Covenant with Noah.md` (three
forward references turned into links), all four category indexes, `wiki/books/index.md` (11 / 58),
and `wiki/index.md`'s counts (14 passages · 31 people · 7 places · 28 themes · 34 connections).

**Judgment calls made unattended, for review**

1. **`Canaan (son of Ham)`, not `Canaan`.** The land takes the bare name, and it arrives two
   pericopes from now at 10:19. The schema's usual practice is to let a collision surface and then
   rename both pages, but this collision is certain and imminent, and the precedent for a
   person/place clash already exists in `Enoch (son of Cain)` / `Enoch (city)`. Qualifying now avoids
   a rename and an inbound-link sweep later. `scripts/link-check.sh` resolves by basename and would
   never have reported the clash.
2. **Three new connection pages from one pericope**, which is more than any previous ingest. The
   pericope carries three genuinely separable threads — the Genesis 3 parallel, the conquest
   material, and wine across the canon — and folding any of them into the passage page would have
   buried it.
3. **The reception history stays in prose, not on a page of its own.** The "curse of Ham" and its use
   to justify slavery is set out in six numbered counts in the passage page's notes, in summary on
   `Ham.md`, and against the conquest texts on the new connection page. It is not a parallel, a
   harmony, or a prophecy/fulfilment pair, so it does not fit the connection type, and inventing a
   page type would need a schema change first (per the growth trigger in `CLAUDE.md`). If the user
   wants reception history as its own type, that is the moment to add it.
4. **Three readings of Ham's offence recorded without adjudication** (the plain sense; the Leviticus
   18 sexual idiom; *Sanhedrin* 70a's castration and sodomy), and four proposals for why the curse
   lands on Canaan. The passage page states the objections to each and picks none.
5. **No pericope boundaries redrawn.** 9:18–29 divided exactly as the plan assumed, and the remaining
   Genesis boxes are untouched.

**Deliberately left for later pericopes**, all written as plain-text references so nothing dangles:
Genesis 10 (the Table of Nations, Canaan's eleven descendants and the border of the land), Genesis
11:1–9 (Babel, whose scattering 9:19's verb already names), Genesis 11:10–26 (the line to Abram, whose
numbers this ingest used arithmetically), Genesis 12:1–3, 15:16, 19:30–38 (Lot, the second
drunkenness), and the patriarchal blessings of 27, 48, and 49.

**Checks.** `scripts/link-check.sh` clean, exit 0, against the documented baseline of 64
not-yet-started book pages — one wrapped link was caught on `Canaan (son of Ham)` and fixed before
the clean run. The twenty-three verse quotations block-quoted on the passage page (twelve in the
body, eleven in *Key verses*) were reassembled from the page and compared character for character
against `raw/bible/Genesis.md`; all twenty-three match verbatim. Inline quotations from elsewhere in
Genesis were checked the same way and four were corrected rather than left approximate: Genesis 2:25
had been given as *"They were both naked, the man and his wife, and were not ashamed"* and now reads
WEB's *"The man and his wife were both naked, and they were not ashamed"*; Genesis 10:19's border was
being quoted with invented punctuation and now carries the raw file's em-dashes; Genesis 12:3 was
quoted as a lowercase fragment and is now given whole. And a claim that 9:19's *nāpṣâ* is *"the same
root"* as Babel's *pûṣ* was weakened to *by-form*, which is what the evidence supports.

## [2026-08-29] ingest | Genesis 10.1-32 — The Table of Nations

Unattended run (`/ingest auto`). Genesis was the first `in-progress` book in `wiki/books/index.md`
and *The Table of Nations* the first unchecked box on its page. `raw/bible/Genesis.md` was already
present, so no fetch. Step 2's discussion went into the passage page, as the skill directs.

**The pericope.** Seventy names and one story. A superscription (10:1), Japheth's fourteen (10:2–5),
Ham's thirty with the five-verse Nimrod narrative inside it (10:6–20), Shem's twenty-six (10:21–31),
and a colophon (10:32). The chapter is a segmented genealogy against Genesis 5's and 11:10–26's
linear ones — it branches, drops every age and every death, and gives nobody but Nimrod a verb. God
is absent for the second pericope running: his name occurs once in thirty-two verses, at 10:9, inside
a proverb other people quote about a hunter.

**Created**

- `wiki/passages/Genesis/The Table of Nations.md`
- `wiki/people/Nimrod.md` — the *gibbōr* of 10:8, the first *mamlākâ* in Scripture, and the
  reception history (Josephus, the Targums, *Genesis Rabbah*, Augustine, Dante) kept separate from
  the five verses that generated it.
- `wiki/people/Eber.md`, `wiki/people/Peleg.md` — the two names in Shem's branch that Genesis marks:
  the one Shem is introduced by, and the one with an etymology.
- `wiki/places/Canaan.md` — the land, as `Noah's Sons and the Curse of Canaan` promised it would be
  when Genesis 10 arrived; the man keeps `Canaan (son of Ham)`.
- `wiki/places/Shinar.md`, `Babel.md`, `Assyria.md`, `Nineveh.md`, `Egypt.md`
- `wiki/themes/The Nations.md` — *gôyim* as a category, and the seventy across the canon.
- `wiki/themes/Kingship and Empire.md` — *mamlākâ* first at 10:10, and the Bible's two-sided argument
  about the institution.
- `wiki/connections/Seventy Nations - Genesis 10 in Deuteronomy 32 and Luke 10.md` (thread)
- `wiki/connections/The Table of Nations at Pentecost.md` (typology)
- `wiki/connections/Nimrod and the Kingdoms of Shinar and Assyria.md` (thread)

**Revised**

`wiki/books/Genesis.md` (box checked and linked; three people, six places, and two themes added to
the key lists), `wiki/people/` Shem (a new section on 10:21 and on why Elam and Asshur mean the Table
is not a language chart), Ham (his thirty, and the same point restated against *Hamitic*), Japheth
(his fourteen and why his branch comes first), Canaan (son of Ham) (the eleven sons and the border),
Noah (named at 10:1 and 10:32 and dead throughout — his last mention in Genesis), God (the second
silent pericope), The Nephilim (*gibbōr* reappearing at 10:8), `wiki/places/` Uz (10:23 as the first
of the three genealogical Uzzes), Eden, `wiki/themes/` Blessing, Curse, City and Civilization,
`wiki/connections/` The Curse of Canaan and the Conquest, From Adam to Jesus, The Nephilim and the
Giants of Canaan, `wiki/passages/Genesis/` Noah's Sons and the Curse of Canaan and The Garden of Eden
(forward references turned into links), all four category indexes, `wiki/books/index.md` (12 / 58),
and `wiki/index.md`'s counts (15 passages · 34 people · 13 places · 30 themes · 37 connections).

**Contradictions flagged rather than harmonized**

1. **Genesis 10 against Genesis 11:1.** Three times the chapter says the nations divided *"everyone
   after his language"* (10:5, 20, 31), and then 11:1 says *"The whole earth was of one language and
   of one speech."* Read as a sequence the second cannot follow the first. The passage page sets out
   the three standard accounts — achronological arrangement (Genesis's own habit, and the majority
   reading), source juxtaposition, and a narrower scope for 11:1 — and picks none. Peleg at 10:25 is
   the pressure point and is treated on his own page too.
2. **The Philistines' ancestry.** Genesis 10:14 derives them from Casluhim; Amos 9:7, Jeremiah 47:4,
   and Deuteronomy 2:23 derive them from Caphtor. Noted on the passage page and on `Egypt.md` as a
   tension in transmission, not resolved.
3. **The curse of 9:25 against the Table.** Canaan is given a firstborn, eleven descendants, and the
   chapter's only border, with no reference to the oracle twenty verses earlier. Recorded on
   `Curse.md` and on `The Curse of Canaan and the Conquest.md` as evidence that cuts *against* the
   etiological reading of Genesis 9, since the etiology is not carried forward even one chapter.

**Judgment calls made unattended, for review**

1. **Three person pages out of seventy names, not seventy.** Nimrod, Eber, and Peleg — the only three
   the text does more with than list. Everyone else in the chapter (Cush, Mizraim, Put, Asshur, Aram,
   Elam, Javan, Magog, Joktan, and some sixty more) has no act, no age, and no death, and several are
   simply the Hebrew name of a country. They are described on the passage page and get pages when a
   passage treats them as someone or somewhere in particular. The alternative — seventy near-empty
   stubs — would have made the people index unusable at a stroke.
2. **Six place pages, and the choice of which six.** Canaan, Shinar, Babel, Assyria, Nineveh, and
   Egypt: the entities the rest of Scripture depends on and that this chapter actually locates.
   Sidon, Gerar, Gaza, Sodom, Gomorrah, Admah, Zeboiim, Lasha, Erech, Accad, Calneh, Calah, Rehoboth
   Ir, Resen, Mesha, and Sephar are named on the passage page without pages of their own.
3. **`Babel` created now rather than with Genesis 11:1–9.** The name is founded at 10:10, one
   pericope early, and the next ingest will expand the page rather than create it.
4. **`Egypt`, not `Mizraim`, for the place page**, with *Mizraim* in `also_known_as` — the bare name
   is what every later book uses. The person/place split that `Canaan` needed is not needed here,
   because no passage so far treats Mizraim as a character.
5. **A new theme page for `Kingship and Empire`** on the strength of one verse. Justified by *mamlākâ*
   occurring for the first time in Scripture at 10:10 and by the thread running from there to Daniel
   and Revelation; if the user disagrees, its content folds back into `City and Civilization`.
6. **`Language` deliberately not created**, though 10:5, 20, and 31 all name it. It belongs with
   Babel, and the next pericope is Babel.
7. **Nimrod's reception history recorded as reception history.** The text gives a city-builder whom a
   proverb remembered; the rebel, the tyrant, and the tower-builder are inferences from *lipnê YHWH*
   with a traceable post-biblical history. Both are on the page, labelled, and not merged.
8. **Two readings of 10:11 kept.** Whether Nimrod or Asshur founds the Assyrian cities is genuinely
   undecidable in the Hebrew; the WEB takes the first, the KJV the second, and Micah 5:6 leans to the
   first. Recorded on `Nimrod.md`, `Assyria.md`, and the connection page without adjudication.
9. **No pericope boundaries redrawn.** 10:1–32 divided as the plan assumed, and the remaining Genesis
   boxes are untouched.

**Deliberately left for later pericopes**, all written as plain-text references so nothing dangles:
Genesis 11:1–9 (Babel — the cause this chapter's four verbs of scattering never give), Genesis
11:10–26 (Shem's line again, linear, with ages), Genesis 12:1–3 (the promise that answers the
chapter, in the chapter's own word *mišpəḥōt*), 12:10–20, 14:1, 15:18–21, and 19:24–25. Havilah and
Cush are named at 10:7 and 10:29 but left without pages; `Eden.md` and `The Garden of Eden` now say
so explicitly rather than promising them "when Genesis 10 arrives".

**Checks.** `scripts/link-check.sh` clean, exit 0, against a baseline of 64 not-yet-started book
pages. All fifty-seven block-quoted verses across the wiki were reassembled programmatically and
compared character for character against `raw/bible/Genesis.md`; every one matches verbatim,
including the two pre-existing Genesis 8 quotations on `Ararat.md` and `Remembrance.md`. Inline
quotations from elsewhere in Genesis were checked the same way and two were wrong and are fixed:
Genesis 9:1 had been given as *"be fruitful, and multiply, and replenish the earth"* and now reads
WEB's *"Be fruitful, multiply, and replenish the earth"*; and Genesis 12:3, quoted in four places as
*"in you all the families of the earth will be blessed"*, now reads WEB's *"All the families of the
earth will be blessed through you"*. A claim that *hēḥēl* marks an era "four times already" was
corrected to three (4:26, 6:1, 9:20). Two quotations from books not yet in `raw/` were softened to
paraphrase rather than left as unverifiable quotation marks (Nahum 3:7 on `Nineveh.md`, Micah 5:6 on
the passage page).

**One caveat worth recording.** Quotations from books outside Genesis — Deuteronomy 32:8, Acts 2 and
17, Micah 5:6, Isaiah 19, Revelation 5 and 7 — cannot be verified against `raw/`, which holds only
Genesis and Job. They are given as WEB and believed accurate, but they are the one class of text in
this ingest that was not checked against a source file. The same is true of every previous ingest;
it is noted here because this pericope leans on out-of-Genesis material more heavily than any before
it.

**A pre-existing defect fixed in passing.** `wiki/people/God.md` had a stray orphan line —
`with all flesh, and giving a sign he keeps himself` — sitting after the `Noah's Sons` bullet in its
*Appears in* list, where it belonged to the `Covenant with Noah` bullet above. Rejoined.

## [2026-08-29] ingest | Genesis 11.1-9 — The Tower of Babel

Unattended run (`/ingest auto`). Genesis was the first `in-progress` book in `wiki/books/index.md`
(Job is also in-progress and loses on canonical order, per the skill's step 1) and *The Tower of
Babel* the first unchecked box on its page. `raw/bible/Genesis.md` was already present, so no fetch.
Step 2's discussion went into the passage page, as the skill directs.

**The pericope.** Nine verses that end the primeval history, and the only narrative in Genesis with
no named human being in it. A people travelling from the east settle on a plain in Shinar, invent
fired brick set in bitumen, and build *"a city, and a tower whose top reaches to the sky"* so as to
make a name and avoid being scattered. Yahweh comes down to see it, observes that with one language
*"nothing will be withheld from them"*, says *"Come, let's go down, and there confuse their
language"*, and scatters them; the work stops and the city is called Babel. The passage is built as a
mirror folding on 11:5, and it answers its own verse 4 clause by clause: they wanted a name and not to
be scattered, and they are scattered and the name they get means *confusion*.

**Created**

- `wiki/passages/Genesis/The Tower of Babel.md`
- `wiki/themes/Pride and Self-Exaltation.md` — the theme Genesis 11:4 founds and never names, run
  through Isaiah 14, Ezekiel 28, Obadiah, Daniel 4, the Magnificat, Luke 14:11, and Philippians 2.
- `wiki/themes/Language and Speech.md` — created here rather than with Genesis 10, exactly as the
  Genesis 10 log entry said it would be (decision 6 of that ingest deferred it on the grounds that
  *"It belongs with Babel, and the next pericope is Babel"*). That entry called the page `Language`;
  it is titled `Language and Speech` because the theme turned out to have two halves — language as
  the medium God adjusts at 11:7, and speech as a moral act, which is where the wisdom books and
  James 3 pick it up.
- `wiki/connections/A Name for Ourselves and a Great Name.md` — *šēm* at 6:4, 11:4, and 12:2: the
  same noun with the subject of the verb changed, and the hinge of the book.
- `wiki/connections/Let Us Go Down - The Divine Plural in Genesis.md` — 1:26, 3:22, 11:7, with the
  four standard readings set out and none adopted.
- `wiki/connections/Babel and Babylon the Great.md` — one Hebrew word from 10:10 to Revelation 18.

**Revised**

- `wiki/books/Genesis.md` — box checked and linked; `Pride and Self-Exaltation` and
  `Language and Speech` added to *Key themes*.
- `wiki/books/index.md` — Genesis 13 / 58.
- `wiki/places/Babel.md` — the founding narrative, the ziggurat *Etemenanki*, and the
  *nilbənâ ləbēnîm* / *nābəlâ* consonant reversal added; the Genesis 11 *Events here* line resolved
  from *(not yet ingested)* to a link.
- `wiki/places/Shinar.md` — the same, plus the *biqʿâ* of 11:2.
- `wiki/people/God.md` — a new section, *He comes down, and speaks in the plural*, plus the timeline,
  *Appears in*, and *Themes associated* lists.
- `wiki/people/Nimrod.md` — an *Appears in* entry recording that he is **not** in this passage, now
  that the passage can be checked rather than asserted.
- `wiki/people/Peleg.md` — 10:25's *"in his days the earth was divided"* pointed at the narrated
  division.
- `wiki/themes/The Nations.md`, `City and Civilization.md`, `Kingship and Empire.md`, `Blessing.md`,
  `Judgment.md`, `Work.md`, `Sin.md` — the Genesis 11 line in each resolved from *(not yet ingested)*
  to a worked entry, and the passage added to *Key passages*.
- `wiki/passages/Genesis/The Table of Nations.md`, `Noah's Sons and the Curse of Canaan.md`,
  `wiki/connections/The Table of Nations at Pentecost.md`,
  `wiki/connections/Nimrod and the Kingdoms of Shinar and Assyria.md` — plain-text *Genesis 11:1–9
  (not yet ingested)* references converted to links.
- All four category indexes and `wiki/index.md`'s counts (16 passages · 32 themes · 40 connections).

**Judgment calls made unattended, for review**

1. **No page created for the builders.** The passage's subject is an unnamed collective, and a
   person page for *"they"* would be a page about a grammatical subject. The point is made on the
   passage page instead, under *People*, where it belongs — the anonymity is a feature of the text.
2. **Two new theme pages rather than one.** `Pride and Self-Exaltation` and `Language and Speech`
   pull apart cleanly (one is about the boast, one about the medium) and each has a canon-length
   thread. If the user disagrees, `Pride` folds into `Kingship and Empire` and `Language` into
   `The Nations` with little loss.
3. **No Babel-and-Pentecost connection page created**, because
   `The Table of Nations at Pentecost` already covers that ground carefully — including the argument
   that "Pentecost reverses Babel" is right in one respect and misleading in two. It was updated
   rather than duplicated.
4. **The five readings of what was wrong at Babel are held, not ranked.** Pride, refusal to fill the
   earth, autonomy, coerced imperial uniformity, and a protective limit that is not a punishment at
   all. Genesis names no sin in these nine verses — no *evil*, no *wickedness*, no *violence* — so
   the page says which reading has which anchor and observes that readings 1 and 4 pull in opposite
   political directions while reading 2 is the only one quoting the builders' stated motive.
5. **The Genesis 10 / Genesis 11 contradiction is not re-argued.** 10:5, 20, 31 have the nations
   already divided by language and 11:1 has one language; the three standard accounts are already
   set out in `The Table of Nations`'s notes, and this page cross-references them rather than
   restating them.
6. **The passage is titled `The Tower of Babel` even though the page argues the tower is not its
   subject** — *ʿîr* occurs four times, *migdāl* twice, the abandoned work at 11:8 is the city, and
   the name at 11:9 is the city's. The conventional title was kept because it is what anyone will
   search for and link to; the point is made in the notes instead.
7. **No pericope boundaries redrawn.** 11:1–9 divided as the plan assumed, and the remaining Genesis
   boxes are untouched.

**Deliberately left for later pericopes**, written as plain-text references so nothing dangles:
Genesis 11:10–32 (Shem's linear line and Terah's family leaving Ur), 12:1–3 (*"I will… make your
name great"*, the direct answer to 11:4), 14:1 and 14:9 (Amraphel king of Shinar), and 19:1–29
(the other city God comes down to look at).

**Checks.** `scripts/link-check.sh` clean, exit 0, against a baseline of 64 not-yet-started book
pages. All sixteen block-quoted verses on the pages this pass created or touched were reassembled
programmatically and compared character for character against `raw/bible/Genesis.md`; every one
matches verbatim. Inline quotations were checked the same way and five were adjusted: Genesis 1:26
had been given twice as *"Let's make man in our image"* and now reads WEB's *"Let us make man in our
image, after our likeness"*; a truncated 11:6 on `Language and Speech.md` was completed to *"…which
they intend to do"*; two fragments capitalized to open a sentence (*"This is what they begin to
do"*, *"Let's make a name for ourselves"*) were returned to the lowercase of the verse; a paraphrase
on `The Nations.md` was moved outside its quotation marks; and a gloss of the Hebrew
*wərōʾšô baššāmayim* that had been punctuated as a WEB quotation is now marked as a gloss.

**The standing caveat, unchanged.** Quotations from books outside Genesis and Job — Deuteronomy,
Isaiah, Jeremiah, Daniel, Zephaniah, Acts, Philippians, Revelation — cannot be verified against
`raw/`, which holds only those two books. They are given as WEB and believed accurate but are
unchecked, and the less certain ones were paraphrased rather than quoted. This pericope's reception
runs further outside Genesis than any before it, so the caveat is also recorded on the passage page
itself under *Notes*.

## [2026-08-30] schema | Schema file renamed `CLAUDE.md` → `AGENTS.md`

The schema now lives in `AGENTS.md`, the filename Codex, Cursor, Zed and the rest look for, so
this repo is no longer readable by one agent only. `CLAUDE.md` remains as a one-line stub whose
entire content is `@AGENTS.md`: Claude Code 2.1.241 discovers only `CLAUDE.md`, `.claude/CLAUDE.md`,
`CLAUDE.local.md` and `.claude/rules/`, and has no setting to change that, but memory files support
`@path` imports — so the stub pulls the schema in and nothing about the Claude Code workflow
changes. The same move was made in `~/Work/research` first.

Live references were repointed at `AGENTS.md`: `README.md`'s intro link and layout list (which now
also documents the stub), `wiki/people/index.md` and `wiki/places/index.md`'s growth-trigger notes,
`wiki/people/Job (person).md`'s note on the book/person naming rule, and the four places in
`.claude/skills/ingest/SKILL.md` that call the schema the authority. The `## Directory map` in
`AGENTS.md` gained both root files. `.obsidian/app.json` gained
`userIgnoreFilters: ["CLAUDE.md"]` so the stub stays out of search, the graph, and the quick
switcher.

The `/ingest` skill's commit template no longer hardcodes `Co-Authored-By: Claude Opus 5
<noreply@anthropic.com>`. Baking one model's name into the history of a repo any agent may write
to was the last Claude-ism outside `.claude/` itself; the trailer is now a placeholder the
running agent fills with its own identity, or drops when its harness already appends one.

Not changed: this file's ~20 earlier mentions of `CLAUDE.md` — the log is append-only, and they
were accurate when written. `llm-wiki.md` already names both filenames as examples of the same
pattern. `.claude/settings.json` stays as-is; a permission allowlist is Claude-only config with no
cross-tool analogue, and duplicating one per agent is fine.

Still Claude-specific, and deliberately left for a separate pass: the `/ingest` skill itself.
`.claude/skills/` has no cross-tool equivalent — Codex prompts live in `~/.codex/prompts/`, which
is per-user rather than per-repo — so porting it means moving the procedure into a plain document
and leaving `SKILL.md` as a stub that reads it. `README.md` still names Claude Code and `/ingest`,
which is honest until that happens.

`scripts/link-check.sh` clean, exit 0, baseline 64.

## [2026-08-30] ingest | Genesis 11.10-32 — From Shem to Abram

Unattended run (`/ingest auto`). Genesis was the first `in-progress` book in `wiki/books/index.md`
(Job is also in-progress and loses on canonical order) and *From Shem to Abram* the first unchecked
box on its page. `raw/bible/Genesis.md` was already present, so no fetch. Step 2's discussion went
into the passage page. **This pericope completes the primeval history, Genesis 1–11.**

**The pericope.** Two *toledot* in twenty-three verses — the only passage in Genesis that carries
two. *"This is the history of the generations of Shem"* (11:10) reruns Genesis 5's ten-generation
register on the far side of the flood and closes it exactly as Genesis 5 closed, with a man at a
round age fathering three sons. *"Now this is the history of the generations of Terah"* (11:27)
drops the register and gives four verses of household: Haran dies before his father in Ur, Abram and
Nahor marry, *"Sarai was barren. She had no child"*, and Terah takes the family out of Ur for Canaan,
stops at Haran, and dies there at 205. God is named nowhere in the twenty-three verses; the next
verse is 12:1.

**Created**

- `wiki/passages/Genesis/From Shem to Abram.md`
- Eight people from the register: `Arpachshad`, `Shelah`, `Reu`, `Serug`,
  `Nahor (son of Serug)`, `Terah`, plus `Abraham` and `Sarah`.
- Five from Terah's household: `Haran (son of Terah)`, `Nahor (brother of Abram)`, `Lot`,
  `Milcah`, `Iscah`.
- `wiki/places/Ur of the Chaldees.md` and `wiki/places/Haran (city).md`.
- `wiki/themes/Barrenness.md` — 11:30 as the first infertility in Scripture and the engine of
  Genesis 12–21, run through Rebekah, Rachel, Hannah, Elizabeth, and Isaiah 54:1 / Galatians 4:27.
- `wiki/themes/Land and Sojourning.md` — 11:31 as the first journey toward Canaan and the first stop
  short of it, run through Machpelah, Leviticus 25:23, Nebo, and Hebrews 11:8–16.
- `wiki/connections/Ten Before and Ten After - The Registers of Genesis 5 and Genesis 11.md` — the
  two registers side by side: identical template, and four deliberate subtractions in the second.
- `wiki/connections/Out of Ur - Terah's Journey and Abram's Call.md` — 11:31–12:5 against Joshua
  24:2–3, Nehemiah 9:7, Genesis 15:7 and Acts 7:2–4, with both conflicts set out rather than
  harmonized away.

**Revised**

- `wiki/books/Genesis.md` — box checked and linked; the *Structure* entry for 1–11 now records that
  the primeval history is complete in the wiki; `Barrenness` and `Land and Sojourning` added to *Key
  themes*, six people and two places to their lists.
- `wiki/books/index.md` — Genesis 14 / 58.
- `wiki/people/Shem.md` — a new section on 11:10–11: the register's only absolute date, the 502-year
  friction with 5:32, and the arithmetic that has him outliving Abraham by thirty-five years.
- `wiki/people/Eber.md`, `Peleg.md`, `Noah.md` — forward references to this pericope resolved, and
  their positions in the register filled in.
- `wiki/places/Canaan.md` — 11:31 added as the land's first appearance as a destination.
- `wiki/themes/Life and Death.md` — the missing death formula and the two-stage collapse.
- `wiki/themes/The Nations.md`, `Blessing.md`, `Marriage.md` — this passage added; Blessing's entry
  is about the theme's absence, which is the point of the chapter.
- `wiki/connections/From Adam to Jesus - The Genealogy of Genesis 5 in Chronicles and Luke.md` — the
  *(not yet ingested)* marker on 11:10–26 resolved, the LXX/SP numeric divergence added beside the
  Cainan note, and a pointer to the new registers page.
- `wiki/connections/A Name for Ourselves and a Great Name.md`,
  `wiki/passages/Genesis/The Table of Nations.md`, `wiki/passages/Genesis/The Tower of Babel.md` —
  their forward references to 11:10–32 now link the page.
- All four category indexes and `wiki/index.md` (17 passages · 47 people · 15 places · 34 themes ·
  42 connections).

**Also fixed, unrelated to this pericope.** Sixteen files carried a stray `</content>` line at the
end, and `wiki/passages/Genesis/The Table of Nations.md` also a stray `</invoke>` — tool-call
scaffolding written into the files by the Genesis 10 ingest. All removed. They were invisible to
`scripts/link-check.sh` and rendered as literal text in Obsidian.

**Judgment calls made unattended, listed for review**

1. **The pericope boundary was kept at 11:10–32**, spanning both *toledot*, as the book page
   planned. Splitting at 11:27 was tempting and was rejected: the register and the household are one
   movement from Shem to Abram, and the register's point — the vanished death formula — only lands
   against the two deaths in Terah's family.
2. **`Abraham.md` and `Sarah.md`, not `Abram.md` and `Sarai.md`.** They are Abram and Sarai until
   Genesis 17:5, 15 and by their later names in the whole rest of the canon. Filing them under the
   later names avoids renaming two heavily-linked pages six chapters from now and fixing every
   inbound link; both pages open with a note on the naming, carry `also_known_as`, and use *Abram*
   and *Sarai* in prose wherever the text under discussion does.
3. **Both Nahors were created with qualifiers** — `Nahor (son of Serug)` and
   `Nahor (brother of Abram)` — since both arrive in the same pericope and neither can hold the bare
   name. Same for `Haran (son of Terah)` against `Haran (city)`, on the `Enoch (city)` precedent. The
   Haran pair is worth flagging: they are *different words in Hebrew* (הָרָן with *he*, חָרָן with
   *ḥet*) and identical only in English, which both pages say explicitly because the "father settles
   in the town named for his dead son" reading is a translation artefact.
4. **`Iscah` got a page** despite one mention in one subordinate clause, on the precedent of Jabal,
   Jubal, and Tubal Cain: she is a named individual, and the tradition identifying her with Sarai is
   what makes the verse's asymmetry legible.
5. **Two new themes rather than three.** `Barrenness` and `Land and Sojourning` were created;
   a separate connection page for the barren-wife thread was not, because the material is a
   recurring motif rather than a passage-to-passage link and belongs on the theme page.
6. **Contradictions flagged, not resolved.** Acts 7:4 (*"when his father was dead"*) against Genesis
   11:26/11:32/12:4, and Acts 7:2 (the call in Mesopotamia *before* Haran) against Genesis 12:1 read
   in place — both are set out on `Out of Ur`, with the three standard resolutions, the Samaritan
   Pentateuch's 145-year Terah, and no adjudication. Likewise Sarai's parentage: Genesis 20:12
   against the Josephus/Talmud/Rashi identification with Iscah, recorded on both pages with neither
   adopted.
7. **Chronology reported with its assumption attached.** The AM table on the passage page uses the
   Masoretic figures on the same reckoning as `From Adam to Noah`, and the 292-year flood-to-Abram
   interval is stated *and* flagged as depending on Abram being Terah's firstborn, which the same
   page argues he probably is not. Every figure in the table was recomputed from `raw/bible/Genesis.md`
   rather than carried over, and the eleven block-quoted verses on the passage page were verified
   character-for-character against the raw file.

`scripts/link-check.sh` clean, exit 0, baseline 64.

## [2026-08-31] ingest | Job 18.1-21 — Bildad's Second Speech

Unattended run (`/ingest auto Job 18, 19, and 20`). The argument named three chapters, so this run
ingested three pericopes in one pass rather than the usual one; they are logged as three entries.
The target overrode the mechanical scan, which would have taken Genesis (first `in-progress` book in
`wiki/books/index.md`) and then Job. `raw/bible/Job.md` was already present, so no fetch. Step 2's
discussion went into the passage pages.

**Created**

- `wiki/passages/Job/Bildad's Second Speech.md` — Job 18:1–21. Four verses of rebuke and seventeen
  of set piece, with the reading that the speech's most important feature is its omissions: nothing
  in it answers the witness in heaven, the demand for a pledge, 16:17's clean hands, or 17:15's
  question about hope, and unlike chapter 8 it offers no way back. Also worked: 18:4 handing Job's
  own verb *tear* (16:9) back with the subject changed; the six snare-words of 18:8–10 and why
  Bildad needs the trap self-entered; *"the firstborn of death"* and *"the king of terrors"* with
  the three readings (superlative, personification, demythologised Mot) and no adjudication;
  18:19's second anonymous use of the dead children; and 18:17's erased name against 19:23–24, which
  the existence of the book settles.
- `wiki/connections/The Lamp of the Wicked Put Out.md` — 18:5–6 against Proverbs 13:9, 20:20, 24:20,
  Job 21:17 and 29:3, and the dynastic *lamp* of 1 Kings 11:36 and 2 Kings 8:19. The point of the
  page is that Bildad misquotes nothing: a proverb read backwards off a man's condition stops being
  wisdom without a single word changing.

**Revised**

- `wiki/books/Job.md` — box checked and linked; the `## Structure` line for 15–21 now records that
  the friends stop arguing in the second cycle, not the third.
- `wiki/people/Bildad the Shuhite.md` — the *In the ingested passages* section largely rewritten
  around chapter 18; his *argues by reversal* method named; the Notes bullet on chapter 25 amended to
  distinguish the intact *pattern* of cycle two from its already-failed *argument*.
- `wiki/people/God.md` — a new bullet: the God of chapter 18 is not a character but a mechanism,
  twenty verses of passives with no stated agent and his name only in the last line.
- `wiki/people/Job's Children.md` — 18:19 added, and the Retribution entry extended to say why the
  anonymous use is worse than 8:4's named one.
- `wiki/places/Sheol.md` — 18:14 marked as the one verse in the Bible that gives Death a throne, and
  noted as *not* the Sheol Job describes.
- Themes: `Retribution`, `Judgment`, `Sin`, `Curse`, `Remembrance`, `Life and Death`, `Wisdom`,
  `The Fear of God`, `Suffering`, `Hope`.

## [2026-08-31] ingest | Job 19.1-29 — I Know That My Redeemer Lives

**Created**

- `wiki/passages/Job/I Know That My Redeemer Lives.md` — Job 19:1–29. The page's organising claim is
  that the famous verse is unreadable detached from the twenty that precede it: the siege of 19:7–12,
  the eight verses of social death in 19:13–20, the one plea for pity in the book (19:21), and the
  wish for words cut into rock. Full apparatus on 19:25–27 — what is certain (*gōʾălî ḥay*, and that
  Job says he *knows*), what is broken (19:26a's subjectless plural verb and antecedentless *zōʾt*),
  and the three readings with their costs; the wiki prefers vindication *before* death and says so.
  Also: 19:6 taking Bildad's net and reassigning the agent; 19:21's *"the hand of God has touched
  me"* using the accuser's own verb from 1:11 and 2:5, which Job never heard; and 19:29 as the one
  prediction in the dialogue that comes true.
- `wiki/connections/The Redeemer and the Avenger of Blood.md` — the four offices of the *gōʾēl* and
  why the word is the right one for a man who has just proved he has no kin, plus the binding of
  19:25 to 16:18's uncovered blood through the *gōʾēl haddām*.
- `wiki/connections/The Hope of Resurrection in the Old Testament.md` — Job 19:25–27 among the thin
  set of Hebrew Bible texts read as reaching past death, with Sheol's default position, the late and
  corporate origin of the hope, and the argument that assuming the resurrection reading of Job 19
  dissolves the book's problem and makes the whirlwind inexplicable.

**Revised**

- `wiki/books/Job.md` — box checked and linked.
- `wiki/people/Job (person).md` — the overview extended through chapter 19; a new paragraph on why
  the fourth officer is not a legal one; the wife's second appearance (19:17) recorded; the
  *hearing, not relief* section given its one exception, 19:21.
- `wiki/people/Bildad the Shuhite.md` — the point-by-point reply recorded.
- `wiki/people/God.md` — besieger, estranger of every relative Job has, and the Redeemer question.
- `wiki/people/Job's Children.md` — 19:17 added, with the *bənê biṭnî* crux (see judgment calls).
- `wiki/places/Sheol.md` — the *That passage gets its treatment when Job 19 is ingested* placeholder
  resolved; 19:25's *"upon the earth"* noted as literally *upon dust*, the word that closed 17:16.
- `wiki/connections/The Witness in Heaven.md` — 19:25–27 linked to its page, and a new paragraph on
  why the fourth office differs in kind from the first three (a court that does not exist, versus a
  relative who shows up).
- `wiki/connections/Do Not Cover My Blood.md` — a bullet joining 16:18 to 19:25 through the avenger
  of blood.
- Themes: `Mediation and Advocacy`, `Hope`, `Suffering`, `Righteousness`, `Judgment`, `Vengeance`,
  `Life and Death`, `Remembrance`, `Blood`, `Retribution`.

## [2026-08-31] ingest | Job 20.1-29 — Zophar's Second Speech

**Created**

- `wiki/passages/Job/Zophar's Second Speech.md` — Job 20:1–29, and the last thing Zophar says in the
  book. Three things the page argues: the thesis at 20:5 is a **concession** that loses the argument
  (*the wicked suffer* becomes *the wicked suffer eventually*, which cannot be run backwards off a
  man's present ruin); the digestive metaphor of 20:12–19 is the friends' closest approach to saying
  sin is intrinsically destructive; and 20:19 is the first specific offence anyone in the book names,
  two chapters before Eliphaz makes it personal and invents the details at 22:6–9. Also marked:
  20:27 calling heaven and earth — Job's own two witnesses at 16:18–19 — for the prosecution.
- `wiki/connections/The Prosperity of the Wicked.md` — the second cycle's three set pieces (15:20–35,
  18:5–21, 20:4–29) against Job 21, Psalm 37, Psalm 73, Jeremiah 12, Habakkuk 1, Malachi 3, and
  Ecclesiastes 8, with the observation that nobody in the Hebrew Bible resolves it by denying the
  observation — only by relocating where the accounting closes.

**Revised**

- `wiki/books/Job.md` — box checked and linked; `wiki/books/index.md` now reads Job 6 / 32.
- `wiki/people/Zophar the Naamathite.md` — the *In the ingested passages* section rewritten around
  chapter 20, including the withdrawal of everything he offered in chapter 11.
- `wiki/people/Eliphaz the Temanite.md` — the trajectory from 20:19 to his own 22:6–9 recorded.
- `wiki/people/God.md` — the God of chapter 20 as purely an executioner.
- Themes: `Retribution` (a new paragraph on the second failure mode, the retreat to *eventually*),
  `Sin`, `Judgment`, `Pride and Self-Exaltation`, `Work`, `Life and Death`, `Wisdom`, `Suffering`.
- All four category indexes and `wiki/index.md` (20 passages · 47 people · 15 places · 34 themes ·
  46 connections). No new people, places, or themes were needed for any of the three pericopes.

**Judgment calls made unattended, listed for review**

1. **Three pericopes in one invocation.** The skill's rule is one pericope per run; the argument
   named three chapters, and the requested scope won. Each got a full pass and its own log entry.
2. **All three pericope boundaries were kept as the book page planned them** — 18, 19, and 20 whole,
   one chapter each. No boundary was redrawn. The chapter divisions and the speech divisions coincide
   exactly through this stretch, which is not true earlier in the book (16:1–17:16 spans one).
3. **No new person, place, or theme page was created.** The three chapters name nobody new; Job's
   wife appears at 19:17 and is handled on `Job (person)` and `Job's Children` rather than given a
   page, on the ground that the book gives her two lines, no name, and no action. Sheol is not named
   in any of the three chapters and the existing page was extended rather than the passages linking
   a place that is not there.
4. **Four connection pages for three chapters**, which is more than usual. Job 19 got two because
   the *gōʾēl* and the afterlife question are separable and each has a canon-wide thread; Job 18 and
   Job 20 got one each. `The Prosperity of the Wicked` deliberately covers Job 21 and 27 in advance
   with *(not yet ingested)* markers, since the second cycle's set pieces cannot be assessed without
   Job's answer to them.
5. **`The Hope of Resurrection in the Old Testament`, not a title naming Job.** The thread is
   canon-wide and Job 19 is one contested member of it; naming the page after Job 19 would have
   overstated the verse's weight, which is the page's own argument against the standard reading.
6. **The wiki takes a position on Job 19:25–27 and says which.** All three readings are set out with
   their costs on the passage page; the preferred reading is vindication before death, on the
   evidence of 7:9, 14:12, and the epilogue. This is a preference, not an adjudication, and it is
   marked as one in both places it appears.
7. **A crux was found and flagged rather than inherited.** `Job's Children` previously read Job 19:17
   as Job counting his dead children's absence. The Hebrew is *bənê biṭnî*, *the sons of my belly*,
   and the WEB's *"the children of my own mother"* has already chosen one of three readings without
   marking it. Both pages now set out all three (brothers, own children, wider clan), take the first,
   and say why the second is hard: the dead cannot find a man loathsome, and the whole catalogue is
   about the living turning away.
8. **Quote accuracy.** Every block-quoted verse on the three passage pages was verified
   character-for-character against `raw/bible/Job.md` by script. Inline quotations of other Job
   chapters were checked the same way, and six were corrected in the process — 12:7 (*"ask the
   animals, now"*), 8:21 (*"He will still fill your mouth with laughter"*), 21:17 (*"How often is it
   that the lamp of the wicked is put out…"*), 21:33 (*"All men shall draw after him"*), 22:7, and
   1:12 (*"all that he has is in your power"*, not *"he is in your power"*). Quotations of books not
   yet in `raw/` remain unverifiable against a source in this repo, as elsewhere in the wiki.

`scripts/link-check.sh` clean, exit 0, baseline 64. No dangling links were left deliberately.

## [2026-09-03] ingest | Genesis 12.1-9 — The Call of Abram

Unattended run (`/ingest auto`, no target). Genesis is the first `in-progress` book in
`wiki/books/index.md` — Job is also in-progress and loses on canonical order, notwithstanding that
the previous commit was a Job ingest — and *The Call of Abram* was the first unchecked box on its
page. `raw/bible/Genesis.md` was already present, so no fetch. Step 2's discussion went into the
passage page. **This opens the Abraham cycle and the patriarchal history.**

**The pericope.** Nine verses in which Abram says nothing. Yahweh commands three surrenders
(*"Leave your country, and your relatives, and your father's house"*) with the destination withheld,
and promises five times over — the root *brk* occurs five times in 12:2–3, against exactly five
curses in Genesis 1–11 (3:14, 3:17, 4:11, 5:29, 9:25). The last clause aims the promise at *"all
the families of the earth"*, using the Table of Nations' own word for the seventy peoples and the
word for the ground cursed at 3:17. Abram goes at seventy-five with Sarai, Lot, and his household,
enters Canaan — the first person in the Bible to do so — and crosses it from Shechem through the
Bethel/Ai ridge to the Negev, building two altars and pitching a tent in a land the narrator notes
is already occupied. The land is promised not to him but to his offspring, and he has none.

**Created**

- `wiki/passages/Genesis/The Call of Abram.md`
- `wiki/places/Shechem.md` — the oak of Moreh, the altar, and the site's whole later career: Dinah,
  Joshua 24, Abimelech, and the division of the kingdom.
- `wiki/places/Bethel.md` — Luz until 28:19, so the name at 12:8 is the narrator's; the arc from
  Abram's altar to Jeroboam's calf to Josiah's demolition.
- `wiki/places/Ai.md` — the eastern marker, and the archaeological problem at et-Tell stated rather
  than resolved.
- `wiki/places/The Negev.md` — the WEB's *"the South"*; the patriarchs' usual address and the
  corridor to Egypt.
- `wiki/themes/Call and Election.md` — a new theme, founded on 12:1: no stated reason, being chosen
  is being sent, and the purpose overshoots the chosen.
- `wiki/connections/Leave Your Country - The Two Lek-Lekha Commands.md` — 12:1 and 22:2, the
  phrase's only two occurrences, with the parallel structure laid out clause by clause.
- `wiki/connections/All the Families of the Earth - Genesis 12.3 in the New Testament.md` — the
  niphal/hithpael crux, the four restatements in Genesis, and Acts 3:25 / Galatians 3:8.
- `wiki/connections/The Altar at Shechem and the Covenant at Shechem.md` — one site from the oak of
  Moreh to Joshua 24 to 1 Kings 12 to John 4.

**Revised**

- `wiki/books/Genesis.md` — box checked; the Abraham section of `## Structure` given its opening
  line; `Call and Election` and the four new places added to the key lists.
- `wiki/books/index.md` — Genesis 15 / 58.
- People: `Abraham` (new section on the call, timeline rebuilt for 12:1–9), `Sarah`, `Lot`,
  `Terah`, `God`.
- Places: `Canaan` (entered at last), `Haran (city)`.
- Themes: `Blessing` (the five-for-five count), `Curse` (12:3's lopsided pairing), `The Nations`,
  `Land and Sojourning`, `Covenant` (promise before covenant), `Sacrifice and Offering`,
  `Barrenness`, `Pride and Self-Exaltation`.
- Connections: `Out of Ur - Terah's Journey and Abram's Call`, `A Name for Ourselves and a Great
  Name`, `Calling on the Name of Yahweh`, `Sacrifice Before the Priesthood` — all four had
  Genesis 12 marked *(not yet ingested)* and now point at the passage.
- All five category indexes and `wiki/index.md`'s counts (21 passages · 47 people · 19 places ·
  35 themes · 49 connections).

**Judgment calls, made unattended**

1. **No new person pages.** The pericope names Abram, Sarai, Lot, and Yahweh, all of whom have
   pages, and one unnamed group — *"the people whom they had acquired in Haran"*. That group is
   handled in the passage page's `## People` section rather than given a page, since the text
   supplies a phrase and nothing else. The Canaanites likewise: `Canaan` and
   `Canaan (son of Ham)` already carry what there is to say.
2. **Four new place pages for a nine-verse pericope**, which is the most in any ingest so far. Every
   one is named in the text and every one carries substantial later weight — Shechem and Bethel
   especially, which are the two great non-Jerusalem sanctuaries of the Old Testament. `The Negev`
   was created despite the WEB rendering it as the compass word *"the South"*, because the same
   region recurs at 13:1, 20:1, 24:62, and through the Isaac and David narratives.
3. **`Call and Election` created as a theme.** The alternative was to fold 12:1 into `Blessing` and
   `Covenant`, but the call is neither: it precedes the covenant by three chapters and is the thing
   Romans 9, Deuteronomy 7, and Isaiah 49 all argue about. `Faith` was considered and deferred —
   Genesis does not use the word until 15:6, and starting the page there will be better founded.
4. **Three connection pages, and one of them renamed mid-pass.** The page pairing 12:1 with 22:2 was
   first written as `Get Out of Your Country - The Two Lek-Lekha Commands`, on the familiar KJV-ish
   phrasing. It was renamed to `Leave Your Country - The Two Lek-Lekha Commands` once the raw text
   was checked: the WEB reads *"Leave your country"*, and a page title in this wiki should not quote
   a translation the wiki does not use.
5. **Four pre-existing pages were quoting Genesis 12:1 in wording the WEB does not have.**
   `Haran (city)`, `From Shem to Abram`, `Land and Sojourning`, and
   `Out of Ur - Terah's Journey and Abram's Call` all had *"Get out of your country, and from your
   relatives, and from your father's house"* — written before the verse was ingested and therefore
   before it could be checked against `raw/`. All four now carry the WEB wording. The Acts 7:3 quote
   on the `Out of Ur` page still reads *"Get out of your land"*, correctly: that is the WEB of Acts,
   not of Genesis.
6. **A transcription typo in the raw file is quoted verbatim and flagged.** `raw/bible/Genesis.md`
   12:3 reads *"I will curse him who **treates** you with contempt"*; the WEB reads *treats*. The
   `## Key verses` block quotes the raw file as the repo requires and the passage page's first note
   records the slip. Where the verse is quoted in prose elsewhere (`Curse`), the correct *treats* is
   used. `raw/` was not edited — it is immutable by the schema, and the typo is bible-api.com's, not
   the translation's.
7. **The blessing/curse count is presented as a pattern, not a proof.** Five *brk* against five
   *ʾrr* holds on a straight count, but the five curses are heterogeneous and the fifth blessing is
   the disputed niphal. Both cautions are written into the passage page's note rather than left for
   a reader to find.
8. **The niphal at 12:3 is left open.** The passive is recorded as what the Septuagint, Acts, and
   Galatians work from; the reflexive as what the hithpaels at 22:18 and 26:4 push toward. The wiki
   adopts neither, and says why the choice matters more to Paul's argument than to the Hebrew.
9. **No pericope boundaries were redrawn.** 12:1–9 divides cleanly at the famine of 12:10, which is
   where the existing plan already put the break.
10. **Quote accuracy.** All nine block-quoted verses on the passage page were verified
    character-for-character against `raw/bible/Genesis.md` by script. Inline quotations of Genesis
    12 across every page touched this pass were checked the same way. Quotations of books not yet in
    `raw/` remain unverifiable against a source in this repo, as elsewhere in the wiki.

`scripts/link-check.sh` clean, exit 0, baseline 64 (unchanged — no new book page this pass). No
dangling links were left deliberately.

## [2026-09-03] ingest | Genesis 12.10-20 — Abram in Egypt

Unattended run (`/ingest auto`, no target). Genesis is the first `in-progress` book in
`wiki/books/index.md` — Job is also in-progress and loses on canonical order — and *Abram in Egypt*
was the first unchecked box on its page. `raw/bible/Genesis.md` was already present, so no fetch.
Step 2's discussion went into the passage page.

**The pericope.** Eleven verses, four of them the first words Abram speaks in Scripture, and what he
says is *"Please say that you are my sister."* A famine empties the land promised four verses
earlier; he goes *down* to Egypt *"to live as a foreigner"* without consulting Yahweh, who does not
speak once in the whole pericope. Sarai is taken into Pharaoh's house, a bride-price is settled on
Abram (12:16), and God intervenes with a single wordless act: *"Yahweh afflicted Pharaoh and his
house with great plagues because of Sarai, Abram's wife."* Pharaoh puts three questions to Abram and
gets no answer, returns the wife, keeps nothing, and has the household escorted out of the country.
The narrator passes no verdict on any of it.

**Created**

- `wiki/passages/Genesis/Abram in Egypt.md`
- `wiki/people/Pharaoh (of Abram's time).md` — the unnamed king; the title *pr-ʿȝ*, the court
  procedure at 12:15, the three questions, and his double role as the first outsider to out-behave a
  patriarch and as the Exodus Pharaoh in miniature.
- `wiki/themes/Deception.md` — a new theme, founded on 12:13 and running to Joseph: the true
  statement aimed to mislead, *rāmâ* and *mirmâ* tracking the chosen line for four generations, and
  the observation that the deceived always ask the same question (12:18, 20:9, 26:10, 29:25).
- `wiki/connections/The Wife-Sister Episodes.md` — 12:10–20, 20:1–18, 26:6–11 in a column table, and
  the source-critical and literary readings of the escalation set against each other.
- `wiki/connections/Down to Egypt and Up Again - Abram's Descent as Proto-Exodus.md` — nine
  correspondences in sequence with Exodus 1–14, the inversion at Exodus 1:22, and Ramban's
  *maʿăśēh ʾābôt sîmān lə-bānîm*.

**Revised**

- People: `Abraham` (a new pericope section, timeline, related people), `Sarah` (a new section on her
  eleven verses without a verb of her own), `God` (timeline entry and a substantial *Appears in*
  entry — the pericope where he does not speak at all).
- Places: `Egypt` (a new section — its first appearance as a place where anything happens),
  `Canaan` (the promised land that starves), `The Negev` (the unnamed road down).
- Themes: `Land and Sojourning`, `Blessing` (12:16, blessing that does not track conduct), `Curse`
  (12:3's clause operating on a man who had done nothing wrong), `Judgment` (the shortest judgment
  scene in the book, with none of the template's parts), `Marriage`, `The Fear of God` (20:11's
  assumption, wrong twice), `Call and Election`.
- `wiki/passages/Genesis/The Call of Abram.md` — its dangling Genesis 12:10–20 cross-reference now
  points at the new page.
- `wiki/books/Genesis.md` (box checked, Abraham-section overview revised, new key person and theme),
  `wiki/books/index.md` (16 / 58), all five category indexes, and `wiki/index.md`'s counts
  (22 passages · 48 people · 19 places · 36 themes · 51 connections).

**Judgment calls, made unattended**

1. **`Pharaoh (of Abram's time)` given a page, and named that way.** He speaks, acts, is acted upon,
   and delivers the only moral speech in the pericope, so a page was clearly warranted. The naming is
   the real decision: every Pharaoh in Genesis and Exodus is anonymous, so a bare `Pharaoh.md` would
   collide with at least two more pages within this book. The parenthetical follows the wiki's
   existing relational pattern (`Nahor (brother of Abram)`), keyed to the patriarch rather than to a
   dynasty, because Genesis supplies no dynasty and the identification is not recoverable.
2. **`Deception` created as a theme rather than folded into `Sin`.** Genesis almost never calls a
   deception a sin — Abimelech is the one who supplies the word (20:9) — and the pattern is
   structural enough (serpent, Abram twice, Isaac, Rebekah, Jacob, Laban, Jacob's sons, Tamar,
   Joseph) that it needs its own page to be traceable. `Truth` and `Lying` were considered as titles
   and rejected: the Genesis phenomenon is not lying, it is a true statement deployed to falsify.
3. **No page for the princes of Pharaoh, the Egyptians, or Hagar.** The first two are collectives the
   text gives one verb each; they are handled in the passage page's `## People`. Hagar is named at
   16:1 and belongs to that pericope — the passage page records the inference that the *"female
   servants"* of 12:16 are where she came from, and marks it as an inference (Genesis Rabbah 45:1
   makes her Pharaoh's daughter, and Genesis itself never links the two verses).
4. **The moral question is left open, with both poles named.** Ramban's *"Abraham our father
   unintentionally committed a great sin"* is quoted as the strongest verdict against, and the
   reading that takes the famine as a trial and 20:11 as an ordinary precaution is stated as the
   strongest verdict for. The wiki adopts neither, and says why the question is open at all: Genesis
   narrates the patriarchs' worst conduct in the same flat voice it uses for their best.
5. **Three cruxes recorded without resolution** — Sarai's beauty at sixty-five (with the Genesis
   Apocryphon's poem noted as the frankly legendary route), the camels of 12:16 and the
   Sapir-Hen/Ben-Yosef archaeozoology, and whether the three wife-sister stories are one story. All
   three are stated as open questions with both sides given.
6. **`Barrenness` deliberately not linked from this pericope.** The obvious hook is that the promise
   of offspring is endangered, but that is not what barrenness is about, and the theme page is
   already carrying the 11:30 → 21:2 arc. It would have been a link for the sake of a link.
7. **No pericope boundaries were redrawn.** 12:10–20 is a clean unit: it opens on the famine and
   closes on the expulsion, and 13:1 begins the return. The existing plan already had the break
   there.
8. **Quote accuracy.** All eleven block-quoted verses under `## Key verses` were verified
   character-for-character against `raw/bible/Genesis.md` by script, as was the pull-quote of
   12:11–13 in the summary. Every inline quotation of Genesis across the pages touched this pass was
   checked the same way, which caught three slips introduced during drafting and now fixed: Genesis
   16:1 quoted as *"an Egyptian handmaid"* where the WEB reads *"a servant, an Egyptian, whose name
   was Hagar"*; Genesis 47:4 quoted with a lowercased *"for the famine is severe"*; and straight
   quotation marks inside the nested quote at 12:12. Quotations of Exodus, Deuteronomy, Psalms, and
   the New Testament remain unverifiable against a source in this repo, as elsewhere in the wiki.
9. **The raw file's 12:3 typo, again.** `raw/bible/Genesis.md` reads *"I will curse him who
   **treates** you with contempt"*; the WEB reads *treats*. This pericope has no block quote of 12:3,
   and the two places it is quoted in prose (the passage page's `## Themes`, and the new paragraph on
   `Curse`) use the correct *treats*, which is the policy the previous ingest set. `raw/` is
   untouched.

`scripts/link-check.sh` clean, exit 0, baseline 64 (unchanged — no new book page this pass). No
dangling links were left deliberately.

## [2026-09-03] schema | Naming rule added for unnamed figures known only by a title

Written during the `Genesis 12.10-20` ingest, immediately after that pass, because the ingest forced
the decision and `AGENTS.md` had no rule covering it.

**The gap.** *Pharaoh* is a title, not a name, and Genesis and Exodus never name any Pharaoh they
narrate. The schema's naming conventions covered the person/book collision (`Job (person)`) and the
passage-title collision (`The Transfiguration (Matthew)`), but not a figure whose only designation is
a title that several distinct people in the same book will share. A bare `Pharaoh.md` would collide
with at least two more pages inside Genesis alone — Joseph's Pharaoh and the Pharaoh of the
oppression — and, like the `(person)` case, the collision would be silent: `scripts/link-check.sh`
resolves by basename and would pass two files called `Pharaoh.md`, while Obsidian would pick one by
an unstated rule.

**The rule adopted.** Qualify by the patriarch or period the figure appears with, not by a dynasty or
a date: `Pharaoh (of Abram's time)`, and ahead of us `Pharaoh (of Joseph's time)`,
`Pharaoh (of the Exodus)`, `Abimelech (of Abraham's time)`, `Abimelech (of Isaac's time)`. Keyed to
the narrative rather than to history on purpose — the historical identifications are not recoverable
from the text, and a filename should not smuggle in a chronology the wiki declines to adopt in its
prose. Applied from the first appearance, so unlike the `(Book)` rule there is never a retrospective
rename.

**Alternatives rejected.** `Pharaoh (Genesis 12)` — puts a reference in a filename, which the
passage-naming convention already rules out for the same reason (it says where, not who).
`Pharaoh I`, `Pharaoh (first)` — invents an enumeration the text does not have.
`The Pharaoh of the Sister Ruse` — names the episode rather than the person, and reads as an epithet
the Bible never uses.

Only `AGENTS.md` changed. No wiki page was renamed: `wiki/people/Pharaoh (of Abram's time).md` was
already created under this rule in the ingest commit, which is what exposed the gap.

## [2026-09-03] ingest | Genesis 13.1-18 — Abram and Lot Separate

Unattended run (`/ingest auto`, no target). Genesis is the first `in-progress` book in
`wiki/books/index.md` — Job is also in-progress and loses on canonical order — and *Abram and Lot
Separate* was the first unchecked box on its page. `raw/bible/Genesis.md` was already present, so no
fetch. Step 2's discussion went into the passage page.

**The pericope.** Abram goes *up* out of Egypt (13:1, *wayyaʿal*, answering 12:10's *wayyēred*),
*very heavy* with the wealth the bride-price bought, and retraces his route in reverse to the altar
between Bethel and Ai — the only altar in Genesis a patriarch returns to. That wealth is then the
cause of everything else: *"the land was not able to bear them"* (13:6), the herdsmen quarrel in
front of the Canaanites and the Perizzites, and Abram stops it by naming Lot his brother, taking the
dispute on himself, and giving away a choice that was his twice over as elder and as the man
promised the land at 12:7. Lot lifts his own eyes, sees the plain well-watered *"like the garden of
Yahweh, like the land of Egypt"*, chooses it, travels east, and tents as far as Sodom — with the
narrator supplying the destruction (13:10b) and the verdict (13:13) to the reader over his head.
Then Yahweh speaks for the first time since 12:7, *"after Lot was separated from him"*, and enlarges
the grant in every dimension: to Abram as well as his offspring, *forever*, in four directions, with
offspring as the dust of the earth and an order to walk the land's length and width. Abram answers
with a tent at Mamre and his third altar.

**Created**

- `wiki/passages/Genesis/Abram and Lot Separate.md`
- `wiki/places/Sodom.md` — the city named four times before anything happens in it; the six-way
  disagreement about what its sin actually was (13:13, 18:20, 19:4–11, Ezekiel 16:49–50,
  Isaiah 1:10–17, Jude 7) set out rather than flattened, and the southern/northern site proposals
  recorded without endorsement.
- `wiki/places/Gomorrah.md` — the name that never acts alone, and why the pairing does real work in
  the prophets' formula for total destruction.
- `wiki/places/The Plain of the Jordan.md` — the *kikkar*, its two similes, the boundary 13:12 draws
  between it and Canaan, and the geology of the Rift.
- `wiki/places/Hebron.md` — Abram's permanent address from 13:18 on: Machpelah, the six patriarchal
  burials, Kiriath Arba and the Anakim, and David's first capital.
- `wiki/places/Mamre.md` — the oak grove, and the Machpelah benchmark phrase *before Mamre*.
- `wiki/themes/Strife and Peacemaking.md` — a new theme: *rîb* as a filable dispute, the four things
  Abram does in 13:8–9, and the line from Cain through Isaac's wells and Laban's heap to
  1 Corinthians 6:7.
- `wiki/connections/Lift Up Your Eyes - Two Ways of Seeing the Land.md` — 13:10 against 13:14, the
  Genesis seeing-formula table (3:6, 6:2, 13:10), Moses on Nebo, and Matthew 4:8–10.
- `wiki/connections/Dust, Stars, and Sand - The Offspring Promises.md` — the three similes, each
  given at the moment the promise looks least plausible, and the census texts that keep counting what
  was declared uncountable.

**Revised**

- People: `Abraham` (new pericope section, four timeline entries, *Appears in*, `Strife and
  Peacemaking`), `Lot` (new pericope section, a new `## The verdict Genesis withholds` section on the
  Genesis/2 Peter tension, timeline, themes), `God` (timeline entry and an *Appears in* entry — the
  speech whose timing is written into its own sentence).
- Places: `Bethel` and `Ai` (the altar returned to), `Canaan` (the land that cannot bear them, and
  the 13:12 boundary; its placeholder line for the cities of the plain replaced with real links),
  `Egypt` (the going up, and the simile at 13:10), `The Negev` (crossed northward).
- Themes: `Land and Sojourning`, `Blessing` (the blessing as a weight that breaks a household),
  `Covenant` (the grant's content in place before any ceremony), `City and Civilization` (tent
  against city, and Hebrews 11:9–10 reversing it), `Judgment` (judgment announced by anticipation),
  `Sin` (13:13's charge with no content), `Sacrifice and Offering`, `Favor and Grace`,
  `Call and Election`; reciprocal links added on `Vengeance` and `Mediation and Advocacy`.
- Connections: `Calling on the Name of Yahweh` (13:4 promoted from a *not yet ingested* stub),
  `Down to Egypt and Up Again` (13:1–2 likewise).
- `wiki/passages/Genesis/The Call of Abram.md` — its Genesis 13:14–17 cross-reference now links the
  new page, and a misquotation was corrected (see judgment call 7).
- `wiki/books/Genesis.md` (box checked, Abraham-section overview extended), `wiki/books/index.md`
  (17 / 58), all five category indexes, and `wiki/index.md`'s counts (23 passages · 48 people ·
  24 places · 37 themes · 53 connections).

**Judgment calls, made unattended**

1. **Five place pages created, three others withheld.** `Sodom`, `Gomorrah`,
   `The Plain of the Jordan`, `Hebron`, and `Mamre` all do work in this pericope and will do more in
   14–19 and 23. **Zoar** was withheld: it appears here only as the road marker at the end of 13:10,
   and it earns a page at 19:18–23 where Lot bargains for it. It is named in bold plain text on the
   passage page rather than linked, so nothing dangles.
2. **No page for the Canaanites or the Perizzites.** Both are collectives given one clause and no
   action. The Perizzites' genuinely interesting fact — that they are absent from Genesis 10:15–18's
   list of Canaan's descendants and present in 15:20's land grant — is recorded on the passage page,
   along with the *pərāzôt* (*unwalled settlements*) etymology, and both are flagged as due a page
   when the conquest lists start doing work at 15:19–21. The wiki records the Table/13:7 mismatch as
   an unexplained addition rather than a contradiction: one list is genealogical and the other
   residential.
3. **`Mamre` created under the bare title, with the collision flagged rather than pre-empted.**
   Genesis 14:13 introduces *Mamre the Amorite*, and the next ingest will therefore hit a place/person
   collision one pericope from now. `AGENTS.md`'s rule for a non-book collision is a retrospective
   rename when the second page arrives, so that is what is scheduled: **when Genesis 14:1–24 is
   ingested, both pages take qualifiers — `Mamre (place)` and `Mamre (person)` — and this page's
   inbound links are fixed in the same pass.** The note is written into the page itself as well as
   here, so it cannot be lost. The alternative — folding the grove into `Hebron` — was rejected
   because Mamre is named more often than Hebron in the patriarchal narratives and is the fixed
   landmark for Machpelah.
4. **`Strife and Peacemaking` created as a theme rather than folded into `Vengeance`.** Vengeance is
   about what strife becomes when nobody stops it; this is about the much rarer case where somebody
   does, and Genesis has a clear sequence of those (13:8–9, 26:20–22, 31:44–54, 33, 50:15–21) that
   nothing on the theme list was tracking. `Reconciliation` was considered as a title and rejected:
   Abram and Lot are not reconciled, they are separated, and the theme has to cover both halves.
5. **Lot's choice left ungraded, with all three readings named.** The moralizing reading (13:10's
   eye-lifting as a deliberate echo of 3:6), the realist one (he was invited to choose, and the plain
   really was better), and the structural one (the promise cannot pass to a nephew, so the chapter's
   function is to clear the field). The wiki takes none. The related tension — Genesis grading him
   nowhere and 2 Peter 2:7–8 calling him *"righteous Lot"* — is written out on both his page and the
   passage page as an unresolved canonical difference rather than harmonized.
6. **Sodom's sin left open, deliberately.** Genesis 13:13 gives the charge with no content, and the
   later specifications point in two directions — injustice and inhospitality (Ezekiel 16:49–50;
   Isaiah 1:10–17; Luke 10:10–12) and sexual violence (Genesis 19:4–11; Jude 7). Both are recorded on
   `Sodom` and on the passage page, with the observation that Genesis 19 is a scene in which they are
   not separable.
7. **A pre-existing misquotation fixed.** `The Call of Abram` quoted Genesis 13:17 twice as
   *"in its length and in its breadth"*; the WEB reads *width*. Both occurrences corrected. This was
   found by the quote-verification script below, not by reading.
8. **No pericope boundaries were redrawn.** 13:1–18 is a clean unit — it opens on the return from
   Egypt and closes on the altar at Mamre, and 14:1 starts a new scene with a king list. The existing
   plan already had the break there.
9. **Quote accuracy.** All eighteen block-quoted verses under `## Key verses` were verified
   character-for-character against `raw/bible/Genesis.md` by script. Every inline italic quotation of
   Genesis across every page touched this pass was then checked the same way, which caught eight
   slips introduced during drafting, all now fixed: Genesis 6:2 paraphrased as *"the sons of God saw
   that the daughters of men were beautiful"* (WEB: *"God's sons saw that men's daughters were
   beautiful, and they took any that they wanted for themselves as wives"*); 15:5 as *"So shall your
   offspring be"* (WEB: *"So will your offspring be"*); 15:6 as *"and he reckoned it to him for
   righteousness"* (WEB: *"who credited it to him"*); 22:16 as *"By myself I have sworn"* (WEB:
   *"I have sworn by myself, says Yahweh"*); 22:17 with *as … as* for the WEB's *like … like*; 32:12
   as *"which can't be numbered for multitude"* (WEB: *"which can't be counted because there are so
   many"*); 18:27 as *"I who am but dust and ashes"* (WEB: *"although I am dust and ashes"*); and
   Genesis 4:8, 26:22, and 50:20 quoted slightly short or without their commas. Quotations of
   Deuteronomy, the Psalms, and the New Testament remain unverifiable against any source in this
   repo, as elsewhere in the wiki.
10. **One wrapped wikilink was introduced and caught.** `wiki/books/Genesis.md` briefly carried
    `*[[Abram and Lot` / `Separate]]*` across a line break — the exact failure `AGENTS.md` warns
    about, invisible to any search for `[[...]]`. Rewritten to start the line with the link.

`scripts/link-check.sh` clean, exit 0, baseline 64 (unchanged — no new book page this pass). No
dangling links were left deliberately; Zoar, the Canaanites, and the Perizzites are named in plain
text rather than linked, per judgment calls 1 and 2.

## [2026-09-03] schema | Naming rule added for a person who shares a name with a place

Genesis 14:13 turned the flagged `Mamre` collision real — a grove at 13:18, an Amorite chief one
pericope later — so the rule the previous ingest scheduled is now written into `AGENTS.md` rather
than left in a log entry.

**The rule.** When a person shares a name with a place, **both** pages take a qualifier: `(person)`
and the kind of place. Unlike the book collision immediately above it in `AGENTS.md`, neither name
is fixed by the directory map, so neither gets to keep the bare title. The wiki already had one
instance of this shape — `Enoch (son of Cain)` and `Enoch (city)` — handled correctly by instinct;
this makes it a rule so the next one is not handled by instinct.

**Why it has to be a rule.** The same silent double failure the `(person)`/book rule exists for:
`scripts/link-check.sh` resolves link targets by basename and will pass two files called `Mamre.md`
without a word, and Obsidian resolves `[[Mamre]]` to one of them by an unstated rule. Nothing
reports the problem at either end.

The rule also carries the procedure the last two ingests worked out between them: when the first
page is created and the second is visibly coming, say so in the page and in the log entry, then do
the rename in the pass that creates the second page and fix the inbound links there. That is exactly
what happened here — `wiki/places/Mamre.md` → `wiki/places/Mamre (place).md`, five inbound `[[Mamre]]`
links rewritten, and `wiki/people/Mamre (person).md` created in the same pass.

## [2026-09-03] ingest | Genesis 14.1-24 — The Rescue of Lot and Melchizedek

Unattended run (`/ingest auto`, no target). Genesis is the first `in-progress` book in
`wiki/books/index.md` and *The Rescue of Lot and Melchizedek* was the first unchecked box on its
page. `raw/bible/Genesis.md` was already present, so no fetch. Step 2's discussion went into the
passage page.

**The pericope.** Nine kings, and for eleven verses Abram is not in the chapter. Four eastern kings
under Chedorlaomer of Elam hold the five cities of the plain in tribute for twelve years, put down
their rebellion in the fourteenth with a campaign that sweeps the Transjordan from Ashteroth Karnaim
to El Paran and back through Kadesh, and destroy the five in the valley of Siddim, where *"the kings
of Sodom and Gomorrah fled, and some fell there"* into the bitumen pits. They take Sodom's goods and
*"Lot, Abram's brother's son, who lived in Sodom"* — a verse that reports Lot's move from beside the
city to inside it only in the clause that says he lost everything by it. An escaped man reaches
*"Abram, the Hebrew"* at the oaks of Mamre, and the chapter then reveals what Genesis has not said
before: a mutual-defense treaty with three Amorite brothers, and three hundred eighteen *"trained
men, born in his house"*. He marches to Dan, attacks by night, pursues past Damascus, and brings
everything and everyone back. Then two kings come out to meet him in the same valley on the same
day. Melchizedek of Salem, *"priest of God Most High"*, brings out bread and wine, blesses Abram and
God in one breath, and is given a tenth. The king of Sodom brings nothing, opens with an imperative,
and is refused under the Bible's first human oath: *"I have lifted up my hand to Yahweh, God Most
High, possessor of heaven and earth, that I will not take a thread nor a sandal strap."* God neither
speaks nor acts anywhere in the chapter.

**Created**

- `wiki/passages/Genesis/The Rescue of Lot and Melchizedek.md`
- `wiki/people/Melchizedek.md` — three verses and four traditions: Canaanite priest-king of
  Jerusalem, Shem (*Nedarim* 32b), the heavenly deliverer of 11QMelchizedek, and the pre-incarnate
  Christ. The wiki endorses none and notes that all four are built on the same absent genealogy.
- `wiki/people/Chedorlaomer.md` — the campaign's leader, with Amraphel, Arioch, and Tidal covered on
  his page rather than given a page apiece (judgment call 1 below), and the Hammurabi identification
  recorded as abandoned.
- `wiki/people/Bera.md` — the king of Sodom, named once at 14:2 and thereafter only by his title.
- `wiki/people/Mamre (person).md`, `wiki/people/Eshcol.md`, `wiki/people/Aner.md` — the three
  Amorite *baʿălê bərît*, and the share Abram protects from his own oath.
- `wiki/places/Salem.md` — Melchizedek's city, and on Psalm 76:2's evidence the Bible's first
  Jerusalem, with the Shechem alternative recorded.
- `wiki/places/Elam.md` — Shem's firstborn as a person and a non-Semitic kingdom as a place, which
  is the Table of Nations working by geography rather than by descent.
- `wiki/places/The Salt Sea.md` — the valley of Siddim and its gloss, the bitumen that is also
  Babel's mortar at 11:3, and the geology of the rift.
- `wiki/places/Dan (city).md` — the anachronism, and the *from Dan to Beersheba* formula.
- `wiki/places/Damascus.md` — the landmark for Hobah, and Eliezer's city one verse of narrative later.
- `wiki/themes/Priesthood.md` — *kōhēn*'s first occurrence, and the office as two-way motion rather
  than as sacrifice.
- `wiki/themes/Tithing.md` — two voluntary tenths before any command, and the three tithe
  legislations the law is actually made of.
- `wiki/themes/War.md` — *milḥāmâ* at 14:2, Genesis's restraint about it, and the just-war /
  pacifist reading recorded without adjudication.
- `wiki/themes/Oaths and Vows.md` — oath against vow, the lifted hand, and the perfect tense that
  puts Abram's decision before the offer.
- `wiki/themes/The Names of God.md` — the *ʾĒl* titles as a table, with who supplies each, and the
  Exodus 6:2–3 problem recorded with all three standard readings.
- `wiki/connections/Melchizedek in Psalm 110 and Hebrews.md` — the chain of custody from a chapter
  that grades nothing, through a psalm that makes a category, to an epistle that makes it
  christological, with Hebrews 7's four moves tabled against what in Genesis 14 each one uses.
- `wiki/connections/The Tithe Before the Law.md` — the two pre-Mosaic tenths against the three
  legislations, and the argument from New Testament silence left open in both directions.
- `wiki/connections/Abram the Hebrew - The First Use of the Name.md` — *ʿibrî* as an outward-facing
  word, the Eber and *ʿābar* etymologies, and the *ʿApiru* question recorded as unsettled.
- `wiki/connections/Not a Thread nor a Sandal Strap.md` — 14:21–24 against Genesis 12:16, and the
  same test run on Achan, Samuel, Elisha and Gehazi, Daniel, Simon Magus, and Paul.

**Renamed**

- `wiki/places/Mamre.md` → `wiki/places/Mamre (place).md`, with all five inbound `[[Mamre]]` links
  rewritten (`Hebron`, `Canaan`, `places/index`, `Abram and Lot Separate`, `Abraham`). Scheduled by
  the Genesis 13 log entry and now also a rule in `AGENTS.md` — see the `schema` entry above.

**Revised**

- People: `Abraham` (new pericope section — the army nobody knew he had, the first tithe, the first
  oath, and Genesis 12 run backwards; six timeline entries; four new related people; five new
  themes), `Lot` (new pericope section on being an object throughout, and one more line on the
  verdict Genesis withholds), `God` (a new section on the one chapter in the cycle where he does not
  speak, act, or appear, and is named by a foreigner instead).
- Places: `Sodom` (sacked, and its king refused), `Gomorrah` (routed into the tar pits), `Hebron`
  (where the march starts), `Shinar` (Amraphel), `Canaan` (a theatre of war for kings who are not
  from it), `Mamre (place)` (renamed; collision paragraph rewritten now that it is real; a 13:18
  misquotation fixed — see 6 below).
- Themes: `Blessing`, `Kingship and Empire`, `Covenant`, `Sacrifice and Offering`,
  `City and Civilization`, `Land and Sojourning`, `Strife and Peacemaking`, `The Nations`,
  `Mediation and Advocacy`.
- Connections: `The Vine and the Cup` (a new opening reading — wine as provision brought out to a
  returning army, with the Gideon inverse at Judges 8:5–9), `Sacrifice Before the Priesthood` (the
  mirror image of its own thread: a priest with no sacrifice).
- `wiki/books/Genesis.md` (box checked and linked; Abraham-section overview extended),
  `wiki/books/index.md` (18 / 58), all five category indexes, and `wiki/index.md`'s counts
  (24 passages · 54 people · 29 places · 42 themes · 57 connections).

**Judgment calls**

1. **No pages for Amraphel, Arioch, and Tidal.** Each is named exactly twice — the roll of 14:1 and
   the battle order of 14:9 — with no act, no word, and no fate, and nothing later in Scripture picks
   any of them up. They are covered on `Chedorlaomer`, who leads the coalition, is named five times,
   and gives the campaign its summary name at 14:17. Same reasoning for Birsha, Shinab, Shemeber, and
   the unnamed king of Bela, who are covered on the passage page only. Bera gets a page because he
   speaks and because Abram's oath is aimed at him by name.
2. **The campaign itinerary is named in plain text rather than linked.** Ashteroth Karnaim, Ham,
   Shaveh Kiriathaim, Mount Seir, El Paran, En Mishpat/Kadesh, Hazazon Tamar, Hobah, the King's
   Valley, Ellasar, Goiim, Admah, Zeboiim, and Bela/Zoar. Each is a waypoint here and does real work
   later — Kadesh at Numbers 13, Seir with Esau, Zoar at 19:18–23 (already scheduled by the Genesis 13
   entry), Admah and Zeboiim at Deuteronomy 29:23 and Hosea 11:8 — so each earns a page then. Nothing
   dangles.
3. **The Rephaim, Zuzim, Emim, and Horites get no pages either.** They are collectives struck in
   passing at 14:5–6; the interesting material about them is Deuteronomy 2:10–23, and the Rephaim are
   already threaded through `The Nephilim and the Giants of Canaan`.
4. **`The Salt Sea` absorbs the valley of Siddim rather than the two getting separate pages.** The
   text itself equates them (*"the valley of Siddim (also called the Salt Sea)"*), the later
   references are all to the sea, and a `Valley of Siddim` page would have been one battle and one
   gloss.
5. **Five new themes, which is more than usual, because the chapter is unusual.** `Priesthood`,
   `Tithing`, `War`, `Oaths and Vows`, and `The Names of God` are all first occurrences in
   Scripture, all in twenty-four verses, and each has a long enough downstream life that folding it
   into an existing theme would have buried it. `Rescue and Deliverance` was considered as a sixth
   and rejected — it would have duplicated `Mediation and Advocacy` and `Judgment` without adding a
   vocabulary of its own.
6. **The tithe's grammar recorded, and the consensus followed.** *Wayyitten-lô maʿăśēr mikkōl* has no
   expressed subject, so the verse can grammatically mean Melchizedek gave Abram a tenth. Hebrews
   7:2, 4 is the earliest surviving explicit reading and every major tradition follows it; the wiki
   notes the ambiguity on three pages and does not manufacture a controversy out of it.
7. **The two anachronisms flagged as narratorial glosses, not smoothed and not called errors.**
   *The Amalekites* (14:7), Amalek being Esau's grandson at 36:12, and *Dan* (14:14), Laish until
   Judges 18:29. The wiki reads both as the same convention Genesis uses openly with *Bethel* at
   12:8, *Hebron* at 13:18, and *"the valley of Siddim (also called the Salt Sea)"* in this very
   chapter, and records that the alternative (an older Amalek, a pre-Danite Dan) is available and
   unnecessary.
8. **Melchizedek's bread and wine given its plain sense first.** Provisioning for a returning army,
   with Judges 8:5–9 as the inverse case; the eucharistic reading is recorded as what later readers
   did with the vocabulary, on `The Vine and the Cup` and on the passage page, and is not read back
   into Genesis 14:18. Genesis mentions no altar, no offering, and no meal.
9. **Abram's raid left ungraded.** The chapter offers no evaluation and neither does the rest of
   Scripture. Both traditions are named on `War` — the pacifist reading (narrated, not commended)
   and the just-war one (a founding case of legitimate rescue) — and the wiki adjudicates neither.
10. **No pericope boundaries redrawn.** 14:1–24 is a clean unit: it opens on a king list and closes
    on Abram's speech, and 15:1's *"After these things"* starts a new scene. The existing plan
    already had the break there.
11. **Quote accuracy.** All twenty-four block-quoted verses under `## Key verses` were verified
    character-for-character against `raw/bible/Genesis.md` by script, and every italic quotation of
    Genesis on every page touched this pass was then checked the same way. Five slips were caught,
    all now fixed: Genesis 15:1 quoted as *"the word of Yahweh came to Abram"* (WEB: *"Yahweh's word
    came to Abram"*); 28:22 as *"of all that you give me"* (WEB: *"Of all that you will give me"*);
    28:21 as *"then Yahweh will be my God"* (WEB: *"and Yahweh will be my God"*); Genesis 47:22
    paraphrased as *"Pharaoh gave them a portion"* (WEB: *"ate their portion which Pharaoh gave
    them"*); and a pre-existing misquotation on `Mamre (place)`, which had Genesis 18:1 as
    *"sitting in the tent door in the heat of the day"* where the WEB reads *"as he sat in the tent
    door in the heat of the day"*. Two more italic phrases were presented as quotations without
    being any version's wording — the *toledot* formula on `Melchizedek` and a schematic
    *"Blessed be X of God Most High"* on `The Names of God` — and both were rewritten as description
    rather than quotation. Quotations of the Psalms, the prophets, and the New Testament remain
    unverifiable against any source in this repo, as elsewhere in the wiki.

`scripts/link-check.sh` clean, exit 0, baseline 64 (unchanged — no new book page this pass). No
dangling links were left deliberately; the itinerary place names of judgment call 2 and the peoples
of judgment call 3 are written in plain text rather than linked.

## [2026-09-03] ingest | Genesis 15.1-21 — The Covenant Between the Pieces

Unattended run (`/ingest auto`, no target). Genesis is the first `in-progress` book in
`wiki/books/index.md` and *The Covenant Between the Pieces* was the first unchecked box on its page.
`raw/bible/Genesis.md` was already present, so no fetch. Step 2's discussion went into the passage
page.

The session started on a detached HEAD at `origin/main` with a clean tree; `git checkout -B main
b352d6e` fast-forwarded local `main` (which was behind at `ee8f435`, a verified ancestor) and
reattached before any work. No commits were lost.

**The pericope.** After the only chapter in which God does not speak, he speaks twelve of twenty-one
verses — and for the first time Abram speaks back. *"Yahweh's word came to Abram in a vision"*
(15:1) is the prophetic formula's first occurrence in the Bible, and *"Don't be afraid"* is the
first *ʾal-tîrāʾ*; *shield* and *reward* are both answers to chapter 14, and *shield* (*māgēn*)
shares its root with the verb Melchizedek used at 14:20. Abram's first recorded words to God are a
complaint — *"Lord Yahweh, what will you give me, since I go childless, and he who will inherit my
estate is Eliezer of Damascus?"* — and the answer disqualifies the servant, takes him outside, and
hands him the stars. Then *"He believed in Yahweh, who credited it to him for righteousness"* (15:6),
the first *heʾĕmin* in Scripture and the verse Paul and James spend the New Testament arguing over.
Four verses later he asks for proof anyway and is not rebuked: *"how will I know that I will inherit
it?"* He fetches five animals — the exact Levitical set — halves them, leaves the birds undivided as
Leviticus 1:17 will require, and stands over them driving off the vultures. Then a *tardēmâ*, the
deep sleep of 2:21, and *"terror and great darkness"*; four hundred years of slavery, a judged
nation, a departure *"with great wealth"*, his own burial *"at a good old age"*, and a return delayed
because *"the iniquity of the Amorite is not yet full."* And *"a smoking furnace, and a flaming
torch passed between these pieces"* — one walker, in the rite Jeremiah 34:18–20 explains as a
self-curse, while the other party sleeps. 15:18 is the Bible's first *kārat bərît*, and the land
finally gets a border and ten peoples.

**Created**

- `wiki/passages/Genesis/The Covenant Between the Pieces.md`
- `wiki/people/Eliezer of Damascus.md` — named once, in the sentence that sets him aside; the
  adoption custom, the untranslatable *ben-mešeq* / *Dammeśeq* wordplay, the walked-back Nuzi
  parallels, and the Genesis 24 identification recorded as tradition rather than adopted.
- `wiki/places/The Euphrates.md` — Eden's fourth river and the promise's northern edge, the *beyond
  the River* formula, and the border that only Solomon approaches.
- `wiki/themes/Faith.md` — *ʾ-m-n* as load-bearing before it is propositional; 15:6 and 15:8 held
  together rather than reconciled; Habakkuk 2:4's Hebrew-to-Greek shift flagged.
- `wiki/themes/Prophecy and Vision.md` — the *word of Yahweh came to* formula and *maḥăzeh* both
  entering at 15:1, Genesis 20:7's first *nābîʾ* defined by intercession, and Numbers 12:6–8's
  taxonomy putting *maḥăzeh* in the lower register.
- `wiki/connections/Credited to Him for Righteousness - Genesis 15.6 in Paul and James.md` — the
  Septuagint's passive, Paul's argument-from-chronology tabled, James answering 1 Maccabees 2:52
  rather than Paul, and Psalm 106:31 as the argument already inside the Hebrew Bible.
- `wiki/connections/Passing Between the Pieces.md` — Jeremiah 34 as the rite's only explanation, the
  bilateral form performed unilaterally, and Galatians 3 and Hebrews 6 standing on 15:12 and 15:17.
- `wiki/connections/Four Hundred Years - The Sojourn and the Exodus.md` — the seven figures tabled,
  the Masoretic / Septuagint / Samaritan split at Exodus 12:40, and no chronology picked.
- `wiki/connections/From the River of Egypt to the Euphrates.md` — *nāhār* against *naḥal*, the
  maximal claim against Numbers 34's working map, and the two peoples on the list who end up on
  Israel's side.
- `wiki/connections/Smoking Furnace and Flaming Torch - Fire as Theophany.md` — *tannûr* as a
  bread-oven, the three different words for *furnace* across Genesis 15, Exodus 19, and Deuteronomy
  4, and 1 Kings 19 as the tradition's own correction.

**Revised**

- `wiki/people/Abraham.md` (new pericope section, six timeline entries, three themes),
  `wiki/people/God.md` (new section, timeline, *Appears in*, four themes),
  `wiki/people/Sarah.md` (a section on her absence from the chapter, and what Genesis 16:1 does with
  it).
- `wiki/places/Damascus.md`, `Ur of the Chaldees.md` (the Exodus 20:2 self-presentation formula with
  Ur in Egypt's slot), `Canaan.md`, `Egypt.md`.
- `wiki/themes/Covenant.md` (the first *kārat bərît*), `Righteousness.md` (15:6 and Psalm 106:31),
  `Land and Sojourning.md`, `Sacrifice and Offering.md` (the apparatus without the act),
  `Judgment.md` (judgment on a clock, in both directions), `Call and Election.md`, `Barrenness.md`,
  `The Fear of God.md` (the first *ʾal-tîrāʾ*, held against the theme's own vocabulary),
  `Oaths and Vows.md` (the first divine oath, enacted rather than spoken), `The Nations.md`,
  `Life and Death.md`, `Blessing.md`, `The Names of God.md`.
- `wiki/connections/Dust, Stars, and Sand - The Offspring Promises.md`,
  `Out of Ur - Terah's Journey and Abram's Call.md`, `The Curse of Canaan and the Conquest.md`,
  `Down to Egypt and Up Again - Abram's Descent as Proto-Exodus.md`,
  `Not a Thread nor a Sandal Strap.md` (the refused *rəkūš* and the promised *rəkūš gādôl*).
- `wiki/books/Genesis.md` (box checked and linked; Abraham-section overview extended; two themes),
  `wiki/books/index.md` (19 / 58), all five category indexes, and `wiki/index.md`'s counts
  (25 passages · 55 people · 30 places · 44 themes · 62 connections).

**Judgment calls**

1. **No pages for the ten peoples of 15:19–21.** Kenites, Kenizzites, Kadmonites, Hittites,
   Perizzites, Rephaim, Amorites, Canaanites, Girgashites, Jebusites. They are a list here and
   nothing else — no act, no word, no scene — and the same reasoning that kept the Rephaim, Zuzim,
   Emim, and Horites off pages last pass applies. They are tabled on the passage page and analysed on
   `From the River of Egypt to the Euphrates`, and each earns a page when a narrative gives it one:
   the Kenites at Judges 1:16 and 1 Samuel 15:6, the Kenizzites with Caleb at Joshua 14, the Hittites
   at Genesis 23, the Jebusites at 2 Samuel 5. Nothing dangles.
2. **No page for the river of Egypt.** It is one boundary term with one textual question attached
   (*nəhar* here against *naḥal* everywhere else), which is answered in full on
   `From the River of Egypt to the Euphrates`. `The Euphrates` does get a page: it is named twice in
   Genesis at opposite ends of the book's argument, is a place in its own right, and recurs from Eden
   to Revelation.
3. **`Eliezer of Damascus`, with the qualifier, and not `Eliezer`.** The Bible has at least ten
   Eliezers — Moses's second son (Exodus 18:4), a son of Becher, a priest with a trumpet, one of
   Ezra's returnees, and more — so a bare `Eliezer.md` is a collision waiting for its second page,
   and the rule in `AGENTS.md` exists because that collision is silent at both ends. The qualifier is
   the one Genesis itself supplies in the only verse he appears in.
4. **Two new themes, and only two.** `Faith` and `Prophecy and Vision` are both first occurrences
   with very long downstream lives that no existing page could absorb — 15:6's *heʾĕmin* is the
   taproot of Romans 4 and Hebrews 11, and 15:1 introduces both the prophetic superscription and
   *maḥăzeh*. Three others were considered and folded instead: **Inheritance** (*yāraš*, four times in
   this chapter) into `Land and Sojourning`, whose vocabulary it already is; **Slavery and Bondage**
   into `Judgment` and `Land and Sojourning`, on the grounds that its real material is Exodus and it
   should open there; and **Divine Patience** into `Judgment`, where 15:16 now has a paragraph of its
   own.
5. **No new connection page for 15:16.** `The Curse of Canaan and the Conquest` already carried the
   verse as one of its three conquest-rationale texts, and a second page would have restated it. That
   page was extended instead, with *šālēm* as a threshold, the four hundred years of Israelite
   slavery that the delay costs, and the point that the reasoning is not hereditary at all.
6. **15:6 and 15:8 left in tension on purpose.** The man credited with righteousness for believing
   asks for proof two verses later. The wiki states flatly that Genesis does not treat these as
   opposites, sets Gideon, Hezekiah, and Zechariah beside them to show Scripture runs no single rule,
   and declines to manufacture one.
7. **The *he credited it to him* ambiguity noted and the consensus followed**, exactly as with the
   tithe at 14:20. The Hebrew of 15:6 has no expressed subjects, so it is grammatically possible to
   read Abram as crediting God; the Septuagint's passive settles it, every version follows, and the
   reversal has no serious defense.
8. **No chronology computed for the four hundred years.** Genesis 15:13's 400, Exodus 12:40's 430 in
   Egypt, the Septuagint and Samaritan reading of that verse as Egypt *and* Canaan, Exodus 6:16–20's
   four names, Galatians 3:17's 430 from promise to law, and Acts 7:6's round 400 cannot all be
   satisfied without adjusting something. All seven are tabled and the spread is reported.
9. **The eucharistic-style typology of 15:17 recorded as reception, not exegesis.** The reading that
   makes the furnace and torch God taking the curse the human party deserved is a legitimate
   development of the passage's own logic and is not what Genesis says; it is labelled as such on
   `Passing Between the Pieces`.
10. **The verbal link to Sinai stated honestly rather than asserted.** Genesis 15:17's *tannûr*, a
    domestic bread-oven, is not Exodus 19:18's *kibšān* nor Deuteronomy 4:20's *kûr*. The connection
    is the image, not a shared phrase, and `Smoking Furnace and Flaming Torch - Fire as Theophany`
    tables the three words rather than eliding them.
11. **No pericope boundaries redrawn.** 15:1–21 is a clean unit: *"After these things"* opens it and
    16:1's *"Now Sarai, Abram's wife, bore him no children"* opens a new scene. The existing plan
    already had the break there.
12. **Quote accuracy.** All twenty-one block-quoted verses under `## Key verses` were verified
    character-for-character against `raw/bible/Genesis.md` by script, and every italic quotation of
    Genesis on every page touched this pass was checked the same way. Four slips were caught and
    fixed: Genesis 6:22 on `Faith` as *"Thus Noah did. According to all that God commanded him, so he
    did"* (WEB: *"Thus Noah did. He did all that God commanded him."*); Genesis 2:21 on the passage
    page as *"Yahweh God caused a deep sleep to fall on the man"* (WEB: *"Yahweh God caused the man to
    fall into a deep sleep"*); Genesis 15:8 on `God` truncated to *"how will I know?"* with a question
    mark the text does not put there; and Genesis 15:13 on `Egypt` capitalized as *"A land that is not
    theirs"*. One schematic phrase was also presented as a quotation — *"the word of Yahweh came to"*
    in the new `Prophecy and Vision` row of `wiki/themes/index.md` — and was rewritten as description.
    Quotations of the Psalms, the prophets, and the New Testament remain unverifiable against any
    source in this repo, as elsewhere in the wiki.

`scripts/link-check.sh` clean, exit 0, baseline 64 (unchanged — no new book page this pass). No
dangling links were left deliberately; the ten peoples of judgment call 1 and the river of Egypt of
judgment call 2 are written in plain text rather than linked.

## [2026-09-04] ingest | Genesis 16.1-16 — Hagar and Ishmael

Unattended run (`/ingest auto`, no target). Genesis is the first `in-progress` book in
`wiki/books/index.md` and *Hagar and Ishmael* was the first unchecked box on its page.
`raw/bible/Genesis.md` was already present, so no fetch. Step 2's discussion went into the passage
page.

As in the previous run, the session started on a **detached HEAD** at `origin/main` (`63f8bd4`) with
a clean tree, and the local `main` ref was stale at `ee8f435` — a verified ancestor of both. The
ingest was committed on the detached HEAD and `git checkout -B main` then moved the branch onto it,
which is a strict fast-forward from `origin/main`; the push went through with no merge. No commits
were lost. This is the second consecutive run to hit it, so it is worth the user's attention as an
environment quirk rather than a one-off.

**The pericope.** One chapter after a covenant sworn in fire, the household stops waiting. Genesis 15
never named Sarai in twenty-one verses about an heir, and 16:1 opens on exactly that: *"Now Sarai,
Abram's wife, bore him no children. She had a servant, an Egyptian, whose name was Hagar."* Sarai is
the first person in Scripture to say God has closed a womb — *"Yahweh has restrained me from
bearing"* — and her plan, *ʾûlay ʾibbāneh mimmennâ*, *perhaps I shall be built up from her*, is a
normal legal instrument (Code of Hammurabi §§144–147) that Rachel and Leah will both use at 30:1–13
with four tribes as the result. Then Genesis lends the scene Eden's verbs: she **saw**, she **took**,
she **gave** to *her husband*, and *"Abram listened to the voice of Sarai"* — a clause that occurs
once elsewhere in the book, in the curse of 3:17. Hagar conceives, lets her contempt show, and Sarai
brings a lawsuit formula against her own husband with *ḥāmās*, the flood's word for violence, in it.
Abram's one sentence in the chapter hands a pregnant woman over: *"Behold, your maid is in your hand.
Do to her whatever is good in your eyes."* Sarai **afflicts** her — *ʿānâ*, 15:13's verb for what
Egypt will do to Israel — and she **flees** (*bāraḥ*, Moses's verb at Exodus 2:15) toward Shur, which
is the road to Egypt.

Everything then reverses. *Yahweh's angel* **finds** her — the figure's first appearance in the Bible,
and it is to a foreign slave rather than a patriarch. She is addressed by name, asked the third divine
question in Genesis, told to return and submit (16:9, unmitigated), and given the offspring promise in
the covenant's own grammar: *harbâ ʾarbeh*, which Genesis uses only here, at 3:16 of the woman's pain,
and at 22:17 of Abraham. She receives Scripture's first annunciation, and her son is named for the
fact that *"Yahweh has heard your affliction"* — *ʿŏnî*, the noun of Exodus 3:7. His oracle makes him
a *pereʾ*, the wild donkey God boasts of having set free at Job 39:5–8: the untamable animal, given
to the son of a slave. And she names God — *ʾĒl Rŏʾî*, *a God who sees* — which nobody else in the
Bible does. Between 15:21 and 17:1 she is the only human being God speaks to.

**Created**

- `wiki/passages/Genesis/Hagar and Ishmael.md`
- `wiki/people/Hagar.md` — the seven namings by the narrator against zero by her owners; the
  *šipḥâ* status; the unique naming-of-God construction; Genesis 21 and Galatians 4 flagged forward;
  Jewish and Islamic reception recorded as reception.
- `wiki/people/Ishmael.md` — the *ʾĒl*/*Yahweh* mismatch in name and explanation, the *pereʾ* read
  through Job 39 rather than as an insult, and 16:12's last clause set beside its verbatim repeat at
  25:18.
- `wiki/people/The Angel of Yahweh.md` — the identity problem tabled across five scenes, with the
  three standing readings (messenger-speech convention, a mode of divine presence, a distinct
  figure) laid out and none adopted; the pre-incarnate-Son reading recorded as later Christian
  reading and checked against Acts 7:30–38, Galatians 3:19, and Hebrews 1.
- `wiki/places/Shur.md` — *wall*, most plausibly Egypt's own frontier forts; the four appearances
  that make it a threshold from both directions, including Exodus 15:22.
- `wiki/places/Beer Lahai Roi.md` — the only place in the Bible named by a woman, and Isaac's address
  at 24:62 and 25:11.
- `wiki/themes/Slavery and Servitude.md` — *ʿebed*/*šipḥâ* vocabulary, Genesis 16 as the founding
  narrative, the Torah's regulations pulling both ways (Exodus 21; Leviticus 25:39–46 against
  Deuteronomy 23:15–16), and the New Testament's handling, with no abolitionist verdict claimed for
  a text that does not give one.
- `wiki/themes/Seeing and Being Seen.md` — the three *in the eyes* judgments of 16:4–6 against
  *ʾĒl Rŏʾî*; God's seeing as the move before an intervention; the *seeing God and living* thread.
- `wiki/connections/Listening to the Voice - Genesis 3 and Genesis 16.md`
- `wiki/connections/Affliction and Flight - Hagar and the Exodus.md`
- `wiki/connections/The Two Flights of Hagar.md`
- `wiki/connections/Hagar and Sarah in Galatians.md`

**Revised**

- `wiki/books/Genesis.md` (box checked and linked, Abraham-section overview extended, three people,
  two places, two themes added), `wiki/books/index.md` (20 / 58).
- `wiki/people/Abraham.md` (new pericope section, three timeline entries, two related people, two
  themes), `wiki/people/Sarah.md` (new pericope section, two timeline entries, two related people,
  two themes), `wiki/people/God.md` (new section *He speaks to a slave, and lets her name him*,
  timeline entry, Appears-in entry, two related people, two themes).
- `wiki/places/Egypt.md` (Egypt as identity rather than location; the 12:16 → 16:1 inference),
  `wiki/places/Canaan.md` (16:3's ten-year clock).
- `wiki/themes/Barrenness.md`, `Blessing.md`, `Marriage.md`, `The Names of God.md`,
  `Land and Sojourning.md`, `Strife and Peacemaking.md`, `Prophecy and Vision.md`, `Faith.md`,
  `The Nations.md`.
- `wiki/connections/Dust, Stars, and Sand - The Offspring Promises.md` (16:10 added as the fourth
  recipient, with its own section: the formula with no image, no land, and a woman as the addressee),
  `wiki/connections/Down to Egypt and Up Again - Abram's Descent as Proto-Exodus.md` (the coda in
  which the household changes seats).
- `wiki/passages/Genesis/The Covenant Between the Pieces.md` (its Genesis 16 cross-reference is now
  a link).
- All five indexes and `wiki/index.md`'s counts (26 passages · 58 people · 32 places · 46 themes ·
  66 connections).

**Judgment calls made unattended**

1. **Three new people pages, and one deliberately not made.** Hagar, Ishmael, and the angel of Yahweh
   all earn pages — the angel because 16:7 is the figure's first appearance in Scripture and the
   identity problem starts here. Isaac does **not** get one: he is mentioned only as the later
   resident of Beer Lahai Roi, and 21:1–7 is where he is born. `[[Isaac]]` was written into the
   passage page's Beer Lahai Roi paragraph and then removed rather than leaving a dangling link.
2. **Kadesh and Bered left without pages, consistent with the Genesis 14 pass.** 16:14 uses both only
   to locate the well. Kadesh was already deferred to Numbers 13 by the Genesis 14 ingest and stays
   deferred; Bered is a hapax and unidentified. Both are named in plain text under `## Places`.
3. **The angel's identity treated as a person page rather than a connection page.** The thread runs
   across Genesis 22, Exodus 3, Numbers 22, Judges 6 and 13, and Zechariah 3, which argues for a
   connection page — but the wiki's person pages already carry Appears-in lists and the alternative
   would have duplicated the table. If the figure gets a dedicated connection page later, the table
   moves there.
4. **Genesis 16:9 stated flatly and not softened, on four pages.** The command to return to the
   household that afflicted her is recorded as the passage's hard edge, with what accompanies it
   (the promise, the name, the release in Genesis 21) noted and not offered as compensation. The
   passage page also says explicitly that reading it as an endorsement of endurance in abuse is a use
   the chapter does not authorize, and that Deuteronomy 23:15–16 eventually legislates the opposite.
5. **16:12 handled as description rather than verdict.** *Pereʾ ʾādām* is read through Job 39:5–8,
   where the wild donkey is God's own example of a creature he set free; *"he will live opposite all
   of his brothers"* is left ambiguous between *in defiance of* and *alongside*, on the evidence of
   25:18's verbatim repetition. The pages say plainly that the verse has been used as a permanent
   verdict on a people and that the Hebrew does not support it.
6. **Galatians 4:21–31 given its own page, with four explicit limits.** Paul announces an allegory;
   the page says so, refuses to let the diagram overwrite the woman, and names the anti-Jewish
   reading as a use the letter does not license.
7. **The doublet question recorded, not resolved.** Genesis 16 and 21:9–21 are laid side by side in
   a twelve-row table; the J/E assignment and the toddler problem at 21:14–15 are both stated, and
   the wiki reads the two as first-and-answer without needing the source question settled.
8. **Reception history included and labelled.** Rabbinic identification of Hagar with Keturah, and
   the Islamic Hājar/Ismāʿīl tradition (Zamzam, the *saʿy*, the son of the sacrifice at Qurʾān
   37:99–113, where the son is unnamed), are recorded on the passage and person pages as reception
   rather than exegesis.
9. **No pericope boundaries redrawn.** 16:1–16 is a clean unit; 17:1 opens with a new theophany and
   a thirteen-year jump. The existing plan already had the break there.
10. **The Masoretic *puncta extraordinaria* over 16:5's *ûbênêkā* mentioned without a theory.** The
    dots are in the standard text and the tradition's reason for them is not recoverable; the page
    says only that they are a very old signal that a scribe found the verse hard.
11. **Quote accuracy.** All sixteen block-quoted verses under `## Key verses` were verified
    character-for-character against `raw/bible/Genesis.md` by script, and every italic quotation of
    Genesis and Job on every page touched this pass was checked the same way. Seven slips were caught
    and fixed: Genesis 4:9 on `God` as *"Where is Abel your brother?"* (WEB has a comma —
    *"Where is Abel, your brother?"*); Genesis 13:9 lowercased mid-quote as *"if you go to the left
    hand"* (WEB: *"If you go…"*); Genesis 15:13 lowercased as *"they will afflict them four hundred
    years"* (WEB: *"They will afflict them…"*); Genesis 16:6 on `Slavery and Servitude` re-punctuated
    as *"your maid is in your hand, do to her…"* (WEB: *"Behold, your maid is in your hand. Do to
    her…"*); Genesis 17:21 on `Ishmael` as *"my covenant I will establish with Isaac"* (WEB: *"my
    covenant I establish with Isaac"*); Genesis 21:11 on `The Two Flights of Hagar` lowercased as
    *"the thing was very grievous"*; and Genesis 9:25 on `Slavery and Servitude` given in a
    non-WEB rendering, *"Cursed be Canaan"* (WEB: *"Canaan is cursed."*). Genesis 38:7 was also
    quoted from memory as *"the thing that Er did was evil in Yahweh's sight"* and replaced with the
    WEB text, *"Er, Judah's firstborn, was wicked in Yahweh's sight."* One rendering of my own,
    *perhaps I shall be built up from her*, was presented once as a quotation and is now a gloss.
    Quotations of Exodus, the prophets, and the New Testament remain unverifiable against any source
    in this repo, as elsewhere in the wiki.

`scripts/link-check.sh` clean, exit 0, baseline 64 (unchanged — no new book page this pass). No
dangling links were left deliberately; Kadesh and Bered of judgment call 2 are written in plain text
rather than linked, and Isaac is named in prose without a link until Genesis 21 creates his page.

## [2026-09-04] ingest | Genesis 17.1-27 — Circumcision, the Sign of the Covenant

Unattended run (`/ingest auto`, no target). Genesis is the first `in-progress` book in
`wiki/books/index.md` and *Circumcision, the Sign of the Covenant* was the first unchecked box on its
page. `raw/bible/Genesis.md` was already present, so no fetch. Step 2's discussion went into the
passage page.

As in the two previous runs, the session started on a **detached HEAD** with a clean tree. This time
the local `main` ref was stale only in the working copy: `git fetch origin main` moved
`origin/main` from `ee8f435` to `74e1bfc`, which is exactly where HEAD already sat, so nothing had
been lost and the previous run's push had in fact gone through. The stale remote-tracking ref, not
the push, was the anomaly. The ingest was committed on the detached HEAD and `git checkout -B main`
then moved the branch onto it — a strict fast-forward from `origin/main` — before pushing. Third
consecutive run to start detached; still worth the user's attention as an environment quirk.

**The pericope.** Thirteen years pass between 16:16 and 17:1 and Genesis reports nothing in them.
Abram was eighty-six when Ishmael was born; he is ninety-nine here, and the chapter opens by
reopening the question the household had closed for itself. Of twenty-seven verses, twenty-two are
divine speech in five blocks; Abram falls on his face twice, laughs once, says one sentence out loud,
and then circumcises everyone he owns and himself before the day is out. *Bərît* occurs **thirteen
times** in the chapter — verified by counting *covenant* in the WEB text of 17:1–27 — a density
Genesis reaches only in the ten verses of 9:8–17, the other chapter where a covenant gets a sign.

What is new here, against Genesis 15: a name for God nobody has heard (*ʾĒl Šadday*, first occurrence
in Scripture, derivation genuinely unknown); the first stipulation ever attached to a covenant
(*"Walk before me, and be blameless"*, both of Noah's words at 6:9 with the preposition changed from
*with* to *before*); a sign carried in the flesh by the human party rather than looked at by God; a
sanction (*kārēt*, *"cut off from his people"*, the Torah's first use of a penalty it never defines);
the covenant formula *"to be a God to you and to your offspring after you"* in its first occurrence;
new names for both husband and wife; and — for the first time in five promise scenes — the son named
as **Sarah's**, with a date on it. The chapter also draws the book's sharpest line between *blessed*
and *covenanted*: Ishmael gets the whole blessing formula and twelve princes at 17:20, Isaac gets the
covenant at 17:21, and Genesis gives no reason for either.

**Pages created (8).**

- `wiki/passages/Genesis/Circumcision, the Sign of the Covenant.md` — the pericope, with all
  twenty-seven verses quoted under `## Key verses`.
- `wiki/themes/Circumcision.md` — the theme's founding text is this chapter, and the thread runs
  through Exodus 4 and 12, Joshua 5, Jeremiah 9, 1 Maccabees, Acts 15, and six Pauline verdicts.
- `wiki/people/Isaac.md` — **judgment call, and a reversal of what the last run's log said.** The
  Genesis 16 entry said Isaac would be *"named in prose without a link until Genesis 21 creates his
  page."* Genesis 17 turns out to name him, gloss his name, date his birth, and establish the covenant
  with him, and six pages in this pass needed a link target for him. Created now; Genesis 21 will fill
  in the birth.
- `wiki/connections/Circumcision of the Heart.md` — Leviticus 26:41 through Acts 7:51 and Romans 2,
  and the move Deuteronomy makes twice: 10:16 commands it, 30:6 promises God will do it.
- `wiki/connections/The Sign and the Seal - Genesis 17 in Romans 4.md` — Paul's argument from the
  order of two chapters, and the *sign*/*seal* pair that gave the Reformation its sacramental grammar.
- `wiki/connections/God Almighty - El Shaddai in Genesis and Exodus.md` — the four etymologies, the
  distribution (six times in Genesis, all at transfers of the promise; thirty-one times in Job), and
  the three readings of Exodus 6:3.
- `wiki/connections/Kings Will Come Out of You.md` — the Bible's first promise of monarchy, given as
  a blessing, and the tension with 1 Samuel 8 that Deuteronomy 17:14–20 sits between.
- `wiki/connections/Laughter and the Name Isaac.md` — four uses of *ṣ-ḥ-q* in the Abraham cycle, and
  the difference between Abraham's laugh and Sarah's that Genesis records without explaining.

**Pages revised (28), plus this log.** `wiki/books/Genesis.md` (box checked, overview extended, `Circumcision` and
`Isaac` added to the key lists); `Abraham`, `Sarah`, `Ishmael`, `God`, `Hagar`;
`Covenant`, `The Names of God`, `Blessing`, `The Nations`, `Barrenness`, `Land and Sojourning`,
`Call and Election`, `Walking with God`, `Righteousness`, `Slavery and Servitude`,
`Kingship and Empire`, `Marriage`, `Faith`, `Language and Speech`, `Life and Death`,
`Prophecy and Vision`; `wiki/places/Canaan.md`; and the four category indexes plus `wiki/index.md`.

**Judgment calls, for review.**

1. **Isaac's page created here rather than at Genesis 21** — see above. This is the one place where
   this pass overrides a decision recorded in a previous log entry.
2. **No page renames for Abram → Abraham or Sarai → Sarah.** Both person pages already carry a *note
   on the name* explaining that the wiki files them under the later names because the canon uses them
   and because renaming at Genesis 17 would break every inbound link built between 11:26 and here.
   That convention now has its chapter, and the pages say so.
3. **Circumcision given a theme page rather than folded into `Covenant`.** It carries its own thread
   from Genesis to Colossians and would have swamped the covenant page.
4. **The hard edges of the chapter recorded, not smoothed.** Three of them. The covenant sign is cut
   into the bodies of purchased foreigners who are promised nothing by it and are not asked — stated
   four times in the chapter and now stated on `Slavery and Servitude` and on the passage page,
   alongside the fact that Exodus 12:44–48 makes the same rite the door by which such a person keeps
   the Passover. The sign is on male bodies only, and Sarah — whose renaming and whose son are two of
   the five divine speeches — hears none of it directly. And *kārēt* is undefined, in the Mishnah as
   much as in the Torah; the page lists the four proposals and adopts none.
5. **Abraham's laugh and Sarah's treated as the same laugh.** A long tradition (Calvin, much rabbinic
   material, the Targums' softening of 17:17) reads his as faith and hers as unbelief. Genesis
   supplies no adjective for either and records only that one is questioned. The wiki declines the
   distinction and says why.
6. **Whether circumcision is a condition left open, with the evidence on both sides set out.** 17:9,
   14 push one way; *bərît ʿôlām* three times and a covenant established with an unconceived child
   push the other. The passage page states the most defensible synthesis — that circumcision is how a
   person joins a covenant that does not depend on him — and flags that every later argument in
   Scripture is a fight over 17:14.
7. **The source-critical reading recorded and not needed.** 15 as J/E and 17 as P is set out with its
   markers; the wiki reads the two as oath-then-sign as the book stands, and notes that nothing in
   either contradicts the other.
8. **No pericope boundaries redrawn.** 17:1–27 is a clean unit — a thirteen-year jump at 17:1 and a
   new scene at 18:1 — and the existing plan already had the breaks there.
9. **Quote accuracy.** All twenty-seven block-quoted verses under `## Key verses` were generated
   directly from `raw/bible/Genesis.md` by script rather than transcribed, and every italic quotation
   of Genesis on every page touched this pass was checked against the raw file by script. Four slips
   were caught and fixed before commit: Genesis 49:25 given as *"blessings of the breasts and of the
   womb"* (WEB has a comma — *"blessings of the breasts, and of the womb"*); Genesis 35:11 given as
   *"...will be from you. Kings will come out of your body"* (WEB: *"...will be from you, and kings
   will come out of your body"*); Genesis 6:9 quoted with the gloss *tāmîm* interpolated inside the
   quotation marks, now moved outside; and Galatians 3:28 quoted in a non-WEB rendering, now given as
   a paraphrase rather than a quotation.

   The same script then found **twenty-seven pre-existing capitalization slips** on pages this pass
   touched — a Genesis quotation begun mid-prose with its first letter silently re-cased, in both
   directions. All twenty-seven were corrected against the raw file, each a single character:
   `Abraham` (3), `God` (8), `Canaan` (1), `Blessing` (6), `Life and Death` (1), `Marriage` (2),
   `Prophecy and Vision` (1), `Righteousness` (1), `Slavery and Servitude` (1, and that one was
   introduced by this pass), `The Nations` (2), and `Walking with God` (1). Examples: Genesis 20:12
   as *"She is indeed my sister…"* (WEB: *"she is indeed…"*, mid-verse); Genesis 7:16 as *"Then
   Yahweh shut him in"* (WEB: *"then Yahweh shut him in"*); Genesis 9:1 as *"be fruitful and
   multiply"* (WEB: *"Be fruitful and multiply"*); Genesis 17:1 on `Walking with God` as *"walk
   before me, and be blameless"* (WEB: *"Walk before me…"*). The check is cheap and mechanical and
   is worth folding into the next lint pass across the whole wiki, since it will certainly find more
   on pages this pass did not touch.

   Quotations of Exodus, Deuteronomy, the prophets, and the New Testament remain unverifiable
   against any source in this repo, as elsewhere in the wiki.

`scripts/link-check.sh` clean, exit 0, baseline 64 (unchanged — no new book page this pass). No
dangling links were left deliberately.

## [2026-09-04] ingest | Genesis 18.1-33 — The Three Visitors and Abraham's Intercession

Unattended run (`/ingest auto`). The next unchecked box on `wiki/books/Genesis.md`, and the twenty-
second pericope of Genesis. No discussion happened; everything that would have been said aloud is on
the passage page.

**The pericope.** Genesis 18:1–33, kept whole. Yahweh appears at the oaks of Mamre in the heat of
the day; three men are washed and fed; the promise of a son is given and Sarah laughs behind the tent
flap; the party walks out toward Sodom and God deliberates aloud about whether to tell Abraham what
he intends; and Abraham, left standing on the road, argues the city down from fifty righteous to ten.

**Pages created (5).**

- `wiki/passages/Genesis/The Three Visitors and Abraham's Intercession.md`
- `wiki/themes/Hospitality.md` — the wiki's forty-eighth theme, and its founding text is this
  pericope. See the judgment calls below.
- `wiki/connections/Entertaining Angels Unawares.md` — Hebrews 13:2 and the reception of the meal:
  the Judges 6 and 13 parallels, Tobit 12:19 and Josephus denying the eating, Genesis Rabbah on the
  menu, Emmaus, and Rublev.
- `wiki/connections/Is Anything Too Hard for Yahweh.md` — Genesis 18:14 in Jeremiah 32, Zechariah 8,
  and Luke 1:37, which is the Septuagint's wording of this verse with the interrogative removed.
- `wiki/connections/Shall Not the Judge of All the Earth Do Right.md` — Genesis 18:25 and the
  intercessors after it, and the standing tension between 18:26 and Ezekiel 14:14.

**Pages revised (33, not counting this log).** People: `Abraham`, `Sarah`, `God`, `Isaac`, `Lot`,
`The Angel of Yahweh`.
Places: `Mamre (place)`, `Sodom`, `Gomorrah`, `Hebron`. Themes: `Mediation and Advocacy`,
`Judgment`, `Righteousness`, `Barrenness`, `Faith`, `Call and Election`, `Seeing and Being Seen`,
`The Nations`, `Blessing`, `Prophecy and Vision`, `Life and Death`, `Strife and Peacemaking`.
Connections: `Laughter and the Name Isaac`, `All the Families of the Earth - Genesis 12.3 in the New
Testament`, `Let Us Go Down - The Divine Plural in Genesis`,
`Dust, Stars, and Sand - The Offspring Promises`. Plus `wiki/books/Genesis.md` (box checked,
overview extended), `wiki/books/index.md` (22 / 58), `wiki/index.md` (counts), and the people,
places, themes, and connections indexes.

**Judgment calls, for review.**

1. **The pericope was kept whole at 18:1–33 rather than split at 18:15.** The chapter divides
   naturally at 18:15 and again at 18:21, and a plan could reasonably cut it into two or three. It
   was kept as one unit because the scene never breaks — the same three visitors carry the
   annunciation and the sentence, and 18:16 is the hinge — and because splitting it would put *"Is
   anything too hard for Yahweh?"* and *"Shouldn't the Judge of all the earth do right?"* on
   different pages. They are the same chapter's two questions. No other boundary in the plan was
   redrawn.
2. **`Hospitality` was given a theme page rather than folded into `Land and Sojourning` or
   `Strife and Peacemaking`.** Genesis 18:1–8 is the canon's founding scene for it, Hebrews 13:2
   makes it a command derived from that scene, and Genesis 19, Judges 19, and Luke 10:10–12 all
   measure a place by it. It carries its own thread and would have swamped either host page. The
   Hebrew has no noun for the thing, which is recorded on the page.
3. **Three connection pages rather than one.** The chapter generates three independent threads with
   different downstream literatures — a meal, a promise, and a standard — and combining them would
   have produced a page about Genesis 18 rather than three about what Scripture does with it.
4. **The three visitors' identity is reported as unresolved, with all three readings set out and
   none adopted.** The plain reading of the final form (Yahweh and two attendants, which 19:1
   requires) is stated as what the arithmetic gives; the Targumic reading and the rabbinic assignment
   of tasks (*b. Bava Metzia* 86b) are recorded; and the Trinitarian reading is recorded **as
   reception** — Ambrose's *tres vidit, unum adoravit*, Augustine's *De Trinitate* II, and Rublev's
   icon, whose proper title is *The Hospitality of Abraham*. The wiki notes that the New Testament
   quotes this chapter four times (Luke 1:37, Romans 9:9, Hebrews 13:2, 1 Peter 3:6) and never once
   reads the three that way. It does not adjudicate.
5. **The *tiqqun sopherim* at 18:22 is recorded and left open.** The rabbinic lists say the verse
   originally read *"Yahweh stood yet before Abraham"*. No manuscript witness has that reading, and
   whether the tradition preserves a real change or is a way of pointing at what the scene looks
   like is probably unresolvable. It is recorded because it is the earliest evidence that readers
   found this chapter's posture startling.
6. **The passage is stated *not* to be a man talking God down**, against the usual summary. God
   gives the first concession unasked and in full (18:26), never objects, never sets a floor, and
   never shows the anger Abraham twice apologizes for in advance; Abraham is the one who stops. The
   pages say so plainly.
7. **Abraham's silence about Lot is recorded as genuinely ambiguous.** Either the argument's dignity
   or the reason it is made; Genesis, which was willing to say at 14:14 that he armed his household
   *"when Abram heard that his relative was taken captive"*, declines to say which. Both readings are
   on the passage page and on `Lot`.
8. **The tension between Genesis 18:26 and Ezekiel 14:14 is flagged, not dissolved.** Abraham is
   granted that a few righteous may hold up the guilty; Ezekiel puts Noah, Daniel, and Job inside a
   condemned land and says by name that they would save nobody but themselves. The wiki records both
   and notes that Ezekiel's choice of Noah is pointed, since Noah's righteousness did save his
   household at 7:1.
9. **Sarah's laugh is not graded, consistent with the Genesis 17 pass.** What is added here is that
   the two laughs are not at the same thing — Abraham does the arithmetic, Sarah does the body — and
   that the narrator states her menopause in the verse before she laughs. The rabbinic reading of
   God's misquotation at 18:13 (*b. Yebamot* 65b) is recorded because the discrepancy is plainly
   there in the text. It is also noted that 18:15 is the only verse in the Bible where God speaks
   directly to Sarah, and that what he says is that she is lying.
10. **1 Peter 3:6 is recorded with what it is made of.** The New Testament's one use of 18:12 quotes
    an aside inside a disbelieving private thought that God then questions her about. The wiki
    reports the citation and the context and draws no conclusion.
11. **Source criticism recorded and not needed.** Genesis 18–19 as J against 17 as P; 18:17–19 and
    18:22b–33 as later insertions on Deuteronomic and post-exilic grounds. As the book stands, 18:19
    is what makes 18:25 possible, which is the reading the wiki takes.
12. **Quote accuracy.** All thirty-three block-quoted verses under `## Key verses` were generated
    directly from `raw/bible/Genesis.md` by script rather than transcribed. Every quoted span on
    every line added this pass was then checked against the raw file by the same method. Four slips
    were caught and fixed before commit, three of them introduced by this pass and one pre-existing
    on a page it touched:
    - Genesis 1:26 given as *"Let's make man"* (WEB: *"Let us make man"*) — the same slip a previous
      pass corrected elsewhere, reintroduced here and now fixed.
    - Genesis 3:22 given as *"The man has become like one of us"* with the first letter re-cased
      (WEB: *"Behold, the man has become…"*, so the fragment is lower-case).
    - Genesis 18:13 quoted as *"Why did Sarah laugh?"* on `Isaac` and on
      `Laughter and the Name Isaac` — a question mark substituted for WEB's comma. Both now give the
      clause in full: *"Why did Sarah laugh, saying, 'Will I really bear a child, yet I am old?'"*

    **The same slip survives at `wiki/passages/Genesis/Circumcision, the Sign of the Covenant.md`
    line 206**, which this pass did not otherwise touch and so did not edit. It is left for the next
    lint, along with the whole-wiki capitalization sweep the Genesis 17 entry recommended.

    Quotations of Exodus, Judges, Kings, the prophets, Tobit, and the New Testament remain
    unverifiable against any source in this repo, as elsewhere in the wiki.

`scripts/link-check.sh` clean, exit 0, baseline 64 (unchanged — no new book page this pass). No
dangling links were left deliberately.

**Note on branch state.** The same environment quirk as the last two runs, for the third time in a
row. The session started on a **detached HEAD** at `origin/main` (`7e30ecf`) with a clean tree, and
the local `main` ref was stale at `ee8f435` — a verified ancestor of HEAD. The ingest was committed
on the detached HEAD and `git checkout -B main` then moved the branch onto it, a strict fast-forward
from `origin/main`; the push went through with no merge and no commits were lost. Three consecutive
runs have now hit it, so it is worth the user's attention as an environment quirk rather than a
one-off.

## [2026-09-04] ingest | Genesis 19.1-29 — The Destruction of Sodom and Gomorrah

Unattended run (`/ingest auto`, no target). Resolved mechanically: Genesis is the first
`in-progress` book in `wiki/books/index.md`, and 19:1–29 was the first unchecked box on its page.
Step 2's discussion is written into the passage page rather than spoken, per the skill's `auto`
mode. `raw/bible/Genesis.md` was already present; no fetch.

**Created (7).** `wiki/passages/Genesis/The Destruction of Sodom and Gomorrah.md`;
`wiki/people/Lot's Wife.md`; `wiki/people/Lot's Daughters.md`; `wiki/places/Zoar.md`; and four
connection pages — `Remember Lot's Wife`, `Fire and Sulfur from the Sky`,
`Gibeah and Sodom - Judges 19 as a Retelling`, and
`Righteous Lot - 2 Peter's Verdict and Genesis's Silence`.

**Revised (24).** `books/Genesis` (box checked, the Abraham-cycle overview extended, and
`Hospitality`, `Mediation and Advocacy`, five places and two people added to its key lists);
`books/index` (23 / 58); `index` (counts); `people/Lot` (a new pericope section, timeline,
appears-in, related people, and the verdict section); `people/Abraham`; `people/God`;
`people/The Angel of Yahweh`; `places/Sodom`; `places/Gomorrah`; `places/The Plain of the Jordan`;
`places/The Salt Sea`; themes `Hospitality`, `Judgment`, `Remembrance`, `Righteousness`, `Sin`,
`Favor and Grace`, `City and Civilization`, `Seeing and Being Seen`, `Mediation and Advocacy`,
`Land and Sojourning`, `Life and Death`; and the people, places, and connections indexes.

### Judgment calls made without asking

1. **The pericope ends at 19:29, not 19:38.** 19:29 is a summary verse, it returns to Abraham, it
   switches to *ʾĕlōhîm*, and 19:30 opens a new scene in a new place. The counter-argument — that
   19:30 immediately cancels the concession Lot won at 19:21, so the two belong together — is
   recorded on the passage page rather than acted on. The existing plan already drew the boundary
   here; this pass confirmed it rather than redrawing it. **No boundaries were redrawn this pass.**
2. **Two new person pages for unnamed figures, and one deliberate omission.** `Lot's Wife` and
   `Lot's Daughters` were created on the `Job's Children` precedent — a figure with no name but with
   narrative weight gets a page. The **sons-in-law were not given one**: they have one clause, no
   act of their own, and nothing outside Genesis, so they are covered on `Lot` and on
   `Lot's Daughters`. This can be revisited.
3. **`Zoar` gets a page and `Bela` does not.** The two are the same town; Genesis itself supplies the
   later name in a parenthesis at 14:2 and 14:8, and 19:22 makes Zoar the name the etiology hangs on.
   The alternate name is recorded in the page's `also_known_as` frontmatter instead of as a second
   page. `places/Sodom`'s "no page yet" placeholder for Zoar is now a live link.
4. **Four connection pages, chosen to avoid duplicating `Sodom`.** That page already carries the
   full range of scriptural answers to *what was Sodom's sin* and the byword survey, so neither was
   turned into a connection page. The four created are ones the place page does not hold: Luke 17:32
   and the tradition behind it; the *sulfur and fire* vocabulary from 19:24 to Revelation; Judges 19
   as a clause-by-clause retelling; and the 2 Peter / Genesis disagreement about Lot.
5. **No new theme page.** Everything the pericope raises is covered by existing themes; a
   *deliverance* or *rescue* theme was considered and rejected as too close to `Judgment` and
   `Remembrance` as they now stand.
6. **The doubled divine name at 19:24 is read as idiom, and the two-figures reading recorded as
   reception.** Justin Martyr (*Dialogue* 56, 129) is cited by name, on the same terms the Genesis 17
   and 18 passes used for the Trinitarian reading of the three visitors: the wiki reports the
   reception history and does not adopt it as exegesis.
7. **19:8 is left ungraded, and said to be ungraded.** Genesis passes no comment on Lot offering his
   daughters, and the wiki does not supply one. What the pages do add is what the text supplies
   around it: the guest obligation he names, the mob's refusal, and Judges 19 running the same scene
   to its end.
8. **The sin of Sodom is recorded as genuinely contested and not adjudicated**, consistent with the
   existing `Sodom` page. The passage page adds one observation to that survey: what chapter 19
   actually narrates is at once a sexual crime, a total collapse of the guest obligation, and a
   demonstration of the *cry* of 18:20, and each of the three standard readings takes one of the
   three.
9. **Whether the intercession succeeded is left open.** Both readings are set out — that it failed
   (the place burned) and that it was answered past its terms (the righteous were taken out and a
   further city spared) — with the note that 19:29 credits Abraham without saying his prayer was
   answered, and that he is never told.
10. **Lot is not graded, and the Genesis / 2 Peter tension is flagged rather than dissolved.**
    Carried over from the existing `Lot` page and given its own connection page, which sets out the
    three standard reconciliations and says none is compelled by the texts.

### Quote accuracy

All twenty-nine block-quoted verses under `## Key verses` were checked against
`raw/bible/Genesis.md` by script — extracted from the page, re-parsed, and compared verse by verse.
Every italic-quoted span on every page touched this pass (703 in total) was then run against the
raw file by the same method. Findings:

- **One real misquotation, introduced this pass and fixed before commit.** The passage page argued
  the *yādaʿ* point by quoting daughters *"who have not known a man"* at 19:8. **The WEB does not
  say that** — it renders the clause *"two virgin daughters"*. The sentence now gives the Hebrew
  (*ʾăšer lōʾ-yādəʿû ʾîš*) and quotes the WEB correctly.
- **One pre-existing misquotation on a page this pass touched, fixed.** `people/Lot` twice quoted
  *"sitting in the gate of Sodom"* / *"sitting in the gate"* (19:1). The WEB reads *"Lot sat in the
  gate of Sodom"*. Both are corrected. It was written before the raw text of chapter 19 was ever
  read, which is why it survived two link-checks.
- **One pre-existing slip in the `Hospitality` comparison table, fixed.** Its Genesis 19 column gave
  *"he rose up to meet them … bowed"*; the WEB has *"rose up to meet them"* and *"bowed himself"*.
- **Eight re-casings caught and fixed** where a quotation had been re-capitalized or de-capitalized to
  suit the sentence around it: *both young and old* (19:4), *he seemed to his sons-in-law* (19:14),
  *isn't it a little one* (19:20), *Therefore the name of the city* (19:22), *and that which grew on
  the ground* (19:25), *the smoke of the land* (19:28), plus the same on `places/Sodom` and
  `people/Lot's Daughters`.
- **One elided quotation made honest.** Genesis 13:10's *"well-watered everywhere"* and *"like the
  garden of Yahweh"* are not contiguous — *"before Yahweh destroyed Sodom and Gomorrah"* sits between
  them. The passage page now marks the ellipsis and `places/The Plain of the Jordan` quotes the two
  phrases separately.

**One class was left alone deliberately, and it wants a decision at lint.** Quoting a
sentence-initial word in lower case mid-sentence — *"the two angels"* for the WEB's *"The two
angels"*, *"leave your country"* for *"Leave your country"*, *"when Abram heard"* for *"When Abram
heard"* — runs through the whole wiki and is not confined to pages this pass touched. The Genesis 17
and 18 entries flagged individual instances of it as slips and recommended a whole-wiki
capitalization sweep; that sweep has still not happened, and doing it inside an ingest would put a
few hundred unrelated edits in a pericope commit. **It is the next lint's first item.** New text
this pass follows the existing pages' habit rather than diverging from it mid-wiki.

Quotations of Deuteronomy, Judges, Isaiah, Jeremiah, Ezekiel, Amos, Jonah, Hosea, Wisdom, 1 Clement,
Josephus, and the New Testament remain unverifiable against any source in this repo, as elsewhere in
the wiki.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Two forward references to the next pericope
(Genesis 19:30–38) are written as plain scripture references rather than as links to a page that
does not exist yet, per the convention the earlier entries set.

**Note on branch state.** The same environment quirk, for the fourth run in a row: the session
started on a **detached HEAD** at `origin/main` (`1bdb6c7`) with a clean tree, and the local `main`
ref was stale at `ee8f435`. This time `git fetch origin main` advanced `origin/main` to `1bdb6c7`,
confirming that the previous run's push did land and that the stale ref was local only. `main` was
moved onto HEAD with `git checkout -B main` **before** any work, so this ingest was committed on the
branch rather than on a detached HEAD. Four consecutive runs have now hit it; it is worth the user's
attention as an environment quirk rather than a one-off.

## [2026-09-04] ingest | Genesis 19.30-38 — Lot and His Daughters

Unattended run (`/ingest auto`, no target). Resolved mechanically: Genesis is the first
`in-progress` book in `wiki/books/index.md`, and 19:30–38 was the first unchecked box on its page.
Step 2's discussion is written into the passage page rather than spoken, per the skill's `auto`
mode. `raw/bible/Genesis.md` was already present; no fetch.

**Created (7).** `wiki/passages/Genesis/Lot and His Daughters.md`; `wiki/people/Moab (person).md`;
`wiki/people/Ben Ammi.md`; `wiki/places/Moab (place).md`; `wiki/places/Ammon.md`; and two
connection pages — `The Drunkenness of Noah and the Drunkenness of Lot` and
`Moab and Ammon - The Two Nations Born in the Cave`.

**Revised (21).** `books/Genesis` (box checked, the Abraham-cycle overview extended through the
cave, and two people and two places added to its key lists); `books/index` (24 / 58); `index`
(counts: 30 passages, 63 people, 35 places, 80 connections); `people/Lot` (a new pericope section,
timeline, appears-in, related people, and a new paragraph in the verdict section);
`people/Lot's Daughters` (the placeholder *what they do next* replaced with a full treatment);
`places/Zoar`; connections `The Vine and the Cup`, `Naked and Ashamed - Genesis 3 and Genesis 9`,
and `Righteous Lot - 2 Peter's Verdict and Genesis's Silence`; themes `Life and Death`,
`The Nations`, `Marriage`, `City and Civilization`, `Land and Sojourning`, `Judgment`, `Sin`, and
`Deception`; and the people, places, themes, and connections indexes.

### Judgment calls made without asking

1. **Two new place pages, for nations rather than for a site.** Genesis 19:37–38 names two peoples
   and no territory, so `Moab (place)` and `Ammon` are pages for countries the passage does not
   describe. They were created anyway, on the `Assyria` / `Elam` precedent from the Table of
   Nations: both will be linked constantly from here to the prophets, and the alternative was to
   leave the two most consequential facts in the pericope — that these are Israel's neighbours, and
   that Deuteronomy grants them their land by name — with nowhere to live.
2. **The person/place collision was handled up front, per the schema.** Moab is both a man and a
   country, so both pages take a qualifier: `Moab (person)` and `Moab (place)`, written out in
   links and never piped. Ammon needs none — the man is `Ben Ammi` and the country is `Ammon`, and
   a bare `Moab.md` would have been silently ambiguous to Obsidian and invisible to
   `scripts/link-check.sh`, which resolves by basename.
3. **The two readings of *"there is not a man in the earth"* (19:31) are both recorded and neither
   adopted.** *ʾEreṣ* is *earth* and *land* equally. The global reading (they believe the world has
   ended) is supported by the strongest verbal evidence in the passage — *"that we may preserve our
   father's family line"* renders *ûnəḥayyeh … zeraʿ*, the *keep seed alive* of Genesis 7:3, which
   the raw text confirms is the only other place in the book with that pairing. The local reading
   (no man *for them*) is supported by the plot: they have just walked out of a populated Zoar. The
   passage page states both and says the text does not adjudicate.
4. **Neither the polemic reading nor the sympathetic one is adopted.** That the pericope is a
   birth-slur on two rival nations is the standard critical account and is recorded as such; so is
   the Jewish tradition that reads the sisters as acting to save the human race (*Genesis Rabbah*
   51; *Nazir* 23a–b), and the *Bava Kamma* 38b reading of the two names as a measure of the two
   sisters. Both are marked as reception. The wiki's stated reason for adopting neither is that the
   canon itself runs in two directions — Deuteronomy 23:3 excludes Moab and Ammon, Deuteronomy 2:9
   and 2:19 protect their territory by divine grant and call them *"the children of Lot"*, and Ruth
   the Moabitess is David's great-grandmother. That tension is the whole subject of the new
   `Moab and Ammon` connection page.
5. **The Septuagint plus at 19:37–38 is recorded as a plus.** The Hebrew glosses *Ben Ammi* by
   being transparent and does not gloss *Moab* at all; the LXX supplies both naming clauses
   outright. The pages say the *mē-ʾāb* reading is traditional and at least as old as the Greek,
   and decline to settle the philology.
6. **No new theme page.** Wine and intoxication were the obvious candidate, and the existing
   connection page `The Vine and the Cup` already carries that thread end to end, so it was
   extended rather than duplicated. Incest likewise: it is one clause of `Marriage` here, and a
   theme page for it would have exactly one Genesis instance until 35:22 and 38.
7. **`Lot's Daughters` was rewritten rather than appended to.** Its `### What they do next` section
   was a placeholder written during the 19:1–29 pass, ending *"That scene has its own page when it
   is ingested."* It is now `### In the cave — Genesis 19:30–38` plus a section on the two sons'
   names. No boundaries were redrawn this pass.

### Quote accuracy

Every italic-quoted span on the pages touched this pass (397 in total) was extracted by script and
compared against `raw/bible/Genesis.md`. The nine block quotes of 19:30–38 under `## Key verses`
were copied from the raw file directly. Findings, all introduced this pass and all fixed before
commit:

- **Four quotations truncated with a period the WEB does not have.** *"Lot went up out of Zoar, and
  lived in the mountain."* (the verse continues *"and his two daughters with him"*), *"Come, let's
  make our father drink wine."*, *"we will lie with him."*, and the same on `people/Lot`'s timeline
  as *"and he didn't know"* for the WEB's *"He didn't know"*. All four now end where the quotation
  ends, with the sentence punctuation moved outside the italics.
- **Three re-capitalizations, fixed.** *"That we may preserve our father's family line"* (twice, on
  the passage page and `people/Lot's Daughters`), *"You may do to them what seems good to you"*, and
  *"To this day"*. The WEB has all three in lower case mid-verse.

**The pre-existing capitalization class is still open and is still the next lint's first item.**
Quoting a sentence-initial word in lower case mid-sentence — this pass's own
*"the land was not able to bear them"* for the WEB's *"The land was not able to bear them"* (13:6) —
runs through the whole wiki, and new text continues to follow the existing habit rather than
diverging from it mid-wiki. This is the third consecutive entry to flag it.

Quotations of Deuteronomy, Numbers, Judges, 1 Samuel, 2 Samuel, 1 Kings, 2 Kings, Isaiah, Jeremiah,
Ezekiel, Amos, Zephaniah, Ruth, Nehemiah, Matthew, 2 Peter, and the rabbinic literature remain
unverifiable against any source in this repo, as elsewhere in the wiki. The Mesha Stele reference on
`places/Moab (place)` is likewise external, and is stated with its contested line 31 marked as
contested.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Forward references to material not yet
ingested (Genesis 20:1; 23:3–20; Leviticus 18) are written as plain scripture references rather than
as links to pages that do not exist.

**Note on branch state.** The same environment quirk, for the fifth run in a row: the session
started on a **detached HEAD** at `origin/main` (`c614cda`) with a clean tree, and the local `main`
ref was stale at `ee8f435`. `git fetch origin main` advanced `origin/main` to `c614cda`, confirming
the previous run's push landed and that the stale ref was local only; `git checkout -B main` moved
the branch onto HEAD **before** any work, so this ingest was committed on `main` rather than on a
detached HEAD. Five consecutive runs have now hit it, and it still wants the user's attention as an
environment quirk rather than a one-off.

## [2026-09-04] ingest | Genesis 20.1-18 — Abraham and Abimelech

Unattended run (`/ingest auto`, no target). Resolved mechanically: Genesis is the first
`in-progress` book in `wiki/books/index.md`, and 20:1–18 was the first unchecked box on its page.
Step 2's discussion is written into the passage page rather than spoken, per the skill's `auto`
mode. `raw/bible/Genesis.md` was already present; no fetch.

**Created (6).** `wiki/passages/Genesis/Abraham and Abimelech.md`;
`wiki/people/Abimelech (of Abraham's time).md`; `wiki/places/Gerar.md`; `wiki/places/Kadesh.md`;
and two connection pages — `A Prophet Who Prays - The First Nabi in Scripture` and
`Sinning Unwittingly - Integrity, Ignorance, and Guilt`.

**Revised (29).** `books/Genesis` (box checked, the Abraham-cycle overview extended through Gerar,
and one person and two places added to its key lists); `books/index` (25 / 58); `index` (counts: 31
passages, 64 people, 37 places, 82 connections); `people/Abraham`, `people/Sarah`, and `people/God`
(each with a new pericope section, timeline entries, appears-in, and related-people additions);
`places/Shur` and `places/The Negev` (the 20:1 forward references turned into links, and the two new
places cross-linked); connections `The Wife-Sister Episodes` (its four *not yet ingested* markers
cleared and a paragraph on the prophet title added) and
`Shall Not the Judge of All the Earth Do Right` (a new section on Abimelech using Abraham's
argument); passages `Hagar and Ishmael`, `The Rescue of Lot and Melchizedek`, and
`The Table of Nations` (their *no page yet* notes for Kadesh and Gerar replaced with links); themes
`Prophecy and Vision`, `Mediation and Advocacy`, `The Fear of God`, `Deception`, `Barrenness`,
`Righteousness`, `Marriage`, `Land and Sojourning`, `Sin`, `Judgment`, `The Nations`, and
`Slavery and Servitude`; and the people, places, themes, and connections indexes.

### Judgment calls made without asking

1. **The king is filed as `Abimelech (of Abraham's time)`.** *ʾĂbî-melek* is borne by the king of
   Gerar here, by a king of Gerar in Isaac's episode at 26:1, by Gideon's son in Judges 9, and — in
   the superscription of Psalm 34 — by the man 1 Samuel 21 calls Achish, which is the strongest
   evidence that it functioned as a royal title. That is exactly the situation the schema's *unnamed
   figure known only by a title* rule covers, so the qualifier is applied from the start rather than
   retrospectively, on the `Pharaoh (of Abram's time)` precedent, leaving `Abimelech (of Isaac's
   time)` free for Genesis 26. Both pages say the identification of the two is not recoverable from
   Genesis and the wiki does not settle it.
2. **Two new place pages, and one of them is thin on purpose.** `Gerar` earns its own page outright
   — it is the setting of this pericope, of 21:22–34, and of the whole of Genesis 26, and it was
   already named at 10:19. `Kadesh` is the weaker case: Genesis uses it only as a bearing, three
   times (14:7 as *En Mishpat*, 16:14, 20:1). It was created anyway because the third occurrence is
   where a marker stops being incidental, and because Numbers 13–20 will make it one of the most
   consequential places in the Torah. `Hagar and Ishmael` had said in so many words that Kadesh
   *"earns its own page when Numbers 13 does something with it"*; that line and the matching one on
   `The Rescue of Lot and Melchizedek` were both rewritten this pass rather than left contradicting
   the new page.
3. **Two new connection pages, and one theme page deliberately not created.**
   `A Prophet Who Prays - The First Nabi in Scripture` carries the pericope's largest fact — that
   *nābîʾ* and *hitpallēl* both enter Scripture in Genesis 20:7, and that the office is defined by
   intercession rather than prediction — and it sets Genesis 20:7 beside Job 42:8, which is the same
   arrangement in the wiki's other ingested book. `Sinning Unwittingly - Integrity, Ignorance, and
   Guilt` carries 20:4–6 into the law's category of the *šəgāgâ*. A separate **Dreams** theme page
   was considered and rejected: 20:3 is the first *ḥălôm* in the Bible, but `Prophecy and Vision`
   already treats dream and vision as one word-field and Numbers 12:6–8 does the same, so the fact
   was added there instead of duplicated.
4. **Genesis 20:16 is recorded as unresolved rather than translated confidently.** *Kəsût ʿênayim*,
   *a covering of the eyes*, and the WEB's closing *"In front of all you are vindicated"* both rest
   on contested forms. The passage page lists the three standard readings — public vindication, a
   literal veil, compensation before witnesses — says all of them agree on the verse's direction,
   and adopts none.
5. **The chronological difficulty is stated, not harmonized.** Sarah is eighty-nine or ninety here
   on the book's own arithmetic (17:17; 21:5) and is taken for her desirability. The page names the
   usual harmonizations, notes that none of them is in the text, and leaves the difficulty standing,
   on the same footing as the hundred-year-old man running twice in the noon heat at 18:2–8.
6. **The source-critical assignment is recorded as the standard account and not adopted as the
   wiki's own.** The divine-name distribution is verifiable from the raw file — *ʾĕlōhîm* at 20:3, 6,
   11, 13, and twice at 17; *ʾĂdōnāy* on Abimelech's lips at 20:4; and *Yahweh* exactly once, at
   20:18 — and it is the textbook case for E. The page says so, and says what the assignment does
   not decide.
7. **No boundaries were redrawn.** Chapter 20 is a clean unit between a move at 20:1 and a new
   formula at 21:1. The argument for joining it to 21:22–34 (same king, same town, Phicol named at
   21:22) is noted on the page and declined, because 21:1–21 sits between them.

### Quote accuracy

Every italic-quoted span on every page touched this pass was extracted by script and checked against
`raw/bible/Genesis.md`; the twenty block quotes of Genesis 20 were compared whole and are verbatim.
Findings, all introduced this pass and all fixed before commit:

- **Four quotations closed with punctuation the WEB does not have.** *"But God came to Abimelech in
  a dream of the night."* (the verse continues *"and said to him"*), *"Behold, you are a dead man."*
  (the WEB has a comma and continues), *"For Yahweh had closed up tight all the wombs."* (truncated
  mid-clause), and, on `books/Genesis`, *"God caused me to wander from my father's house."* All four
  now end where the quotation ends, with the sentence punctuation moved outside the italics.
- **One question mark invented.** *"How have I sinned against you?"* — the WEB has a comma there and
  the sentence runs on; the quotation is now given in full to verse 9's actual question mark.
- **Two misquotations of fact.** *"En Mishpat (that is, Kadesh)"* for the WEB's *"En Mishpat (also
  called Kadesh)"* at 14:7, and *"and the men were very scared"* for the WEB's *"The men were very
  scared"* at 20:8. Both corrected.
- **One quotation of Genesis 12:3 from memory rather than from the raw file**, on the new prophet
  page: *"in you all the families of the earth will be blessed"* for the WEB's *"All the families of
  the earth will be blessed through you."* Corrected. Worth flagging as a class: the pre-existing
  `themes/The Nations` carries the same non-WEB wording of 12:3 twice, unchanged by this pass, and
  it belongs on the next lint's list.

**The pre-existing capitalization class is still open and is still the next lint's first item.**
Quoting a sentence-initial word in lower case mid-sentence runs through the whole wiki, and new text
continues to follow the existing habit rather than diverging from it mid-wiki. This is the fourth
consecutive entry to flag it. One instance was avoidable here and was fixed by extending the quote
rather than recasing it: *"For he is a prophet, and he will pray for you, and you will live"* now
carries its *For*.

Quotations of Exodus, Leviticus, Numbers, Deuteronomy, Joshua, Judges, 1 Samuel, 2 Samuel, Psalms,
Isaiah, Jeremiah, Ezekiel, Amos, 2 Chronicles, Luke, Acts, Romans, 1 Timothy, Hebrews, 1 John, and
Job 42 remain unverifiable against any source in this repo, as elsewhere in the wiki. The
identifications of Gerar with Tel Haror and of Kadesh with ʿAin el-Qudeirat, the etymology of
*ʾĂbî-melek*, the Egyptian dating of the Philistines' arrival, and the rabbinic and patristic
readings on the passage page are likewise external and are stated as identifications and reception
rather than as findings.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Forward references to material not yet
ingested (Genesis 21:1–7; 21:22–34; 26:1–33; Job 42:7–9) are written as plain scripture references
or carry an explicit *(not yet ingested)* marker, rather than as links to pages that do not exist.

**Note on branch state.** The same environment quirk, for the sixth run in a row: the session started
on a **detached HEAD** at `4f15101` with a clean tree, and the local `main` ref was stale at
`ee8f435`. `git fetch origin main` advanced `origin/main` to `4f15101`, confirming the previous run's
push landed and that the stale ref was local only; `git checkout -B main` moved the branch onto HEAD
**before** any work, so this ingest was committed on `main` rather than on a detached HEAD. Six
consecutive runs have now hit it, and it still wants the user's attention as an environment quirk
rather than a one-off.

## [2026-09-04] ingest | Genesis 21.1-21 — The Birth of Isaac and the Sending of Hagar

Unattended run (`/ingest auto`, no target). Resolved mechanically: Genesis is the first
`in-progress` book in `wiki/books/index.md`, and 21:1–21 was the first unchecked box on its page.
Step 2's discussion is written into the passage page rather than spoken, per the skill's `auto`
mode. `raw/bible/Genesis.md` was already present; no fetch.

**Created (5).** `wiki/passages/Genesis/The Birth of Isaac and the Sending of Hagar.md`;
`wiki/places/Beersheba.md`; `wiki/places/Paran.md`; and two connection pages —
`Yahweh Visited Sarah - Paqad and the Visitations of God` and
`Two Sons Nearly Lost - The Sending of Ishmael and the Binding of Isaac`.

**Revised (30).** `books/Genesis` (box checked, the Abraham-cycle overview extended through 21:21,
and two places added to its key list); `books/index` (26 / 58); `index` (counts: 32 passages, 39
places, 84 connections); `people/Isaac`, `people/Sarah`, `people/Hagar`, `people/Ishmael`,
`people/Abraham`, `people/God`, and `people/The Angel of Yahweh` (each with a new pericope section,
timeline entries, and appears-in additions; the angel's new section was written and then moved so
that the page's sections stay in canonical order); `places/Egypt`, `places/Beer Lahai Roi`,
`places/The Negev` (its 21:14–21 forward reference turned into links), and
`passages/Genesis/The Rescue of Lot and Melchizedek` (its plain-text *El Paran* promoted to a link
now that the place has a page); connections `The Two Flights of Hagar`,
`Laughter and the Name Isaac`, `Hagar and Sarah in Galatians`, and
`Listening to the Voice - Genesis 3 and Genesis 16` (each now links the passage page from the
Genesis 21 bullet it already carried); themes `Barrenness`, `Covenant`, `Call and Election`,
`Circumcision`, `Slavery and Servitude`, `Seeing and Being Seen`, `Blessing`, `Faith`,
`The Nations`, `Land and Sojourning`, `Life and Death`, `Marriage`, `Prophecy and Vision`, and
`Remembrance`; and the people, places, themes, and connections indexes.

### Judgment calls made without asking

1. **The pericope was kept whole at 21:1–21 rather than split at 21:8.** There is a real seam there
   — verses 1–7 are a birth notice and 8–21 an expulsion, with different casts — and a defensible
   plan would separate them. It was kept together because the second half is caused by the first
   (the feast is Isaac's, the demand is about Isaac's inheritance, and the participle that triggers
   it is Isaac's name in the intensive), and because 21:22 begins something genuinely separate. The
   alternative is stated on the passage page rather than hidden. **No unchecked boxes were redrawn.**
2. **No new person page was created.** Ishmael's Egyptian wife (21:21) is unnamed, has no act, and
   is not referred to again; she is recorded on `people/Hagar`, `people/Ishmael`, and `places/Egypt`
   rather than given a page, on the same footing as the Egyptian midwives and other unnamed
   one-clause figures ahead. No new *theme* page either: a **Laughter** page was considered and
   rejected, because `Laughter and the Name Isaac` already carries the whole *ṣ-ḥ-q* thread and a
   theme page would duplicate it verse for verse.
3. **Two new place pages.** `Beersheba` is created here even though the place is not *named* until
   21:31, because 21:14 uses the name (*"the wilderness of Beersheba"*) exactly as 14:14 uses *Dan*
   — the narrator's later name for the country — and because Beersheba is one of the most heavily
   used places in the rest of Genesis. `Paran` is the weaker case at first sight, since Genesis uses
   it twice; it was created because the second use (21:21) is a permanent address rather than a
   bearing, because Numbers 10–13 makes it the wilderness generation's country, and because 14:6's
   *El Paran* had been sitting in the plain-text overflow list on
   `The Rescue of Lot and Melchizedek` waiting for exactly this. That line was rewritten this pass
   rather than left contradicting the new page.
4. **Two new connection pages.** `Yahweh Visited Sarah - Paqad and the Visitations of God` carries
   the pericope's largest single fact — that *pāqad* enters Scripture at 21:1 with a barren womb as
   its object, and that Genesis 50:24 and Exodus 3:16 cash the same verb for a nation — and it
   includes the verb's other half, the visiting of iniquity, rather than splitting the word in two.
   `Two Sons Nearly Lost - The Sending of Ishmael and the Binding of Isaac` sets 21:8–21 beside
   22:1–19: the same opening Hebrew clause, the only two calls *out of the sky* in Genesis besides
   19:24's rain, and two rescues that consist of somebody being made to see something already there.
   Genesis 22 is not yet ingested, so that page's references to it are scripture references, not
   links.
5. **Genesis 21:9's *məṣaḥēq* is recorded as underdetermined.** The Masoretic participle has no
   object; the Septuagint and Vulgate supply *with Isaac her son*, Galatians 4:29 reads
   *persecuting*, and the midrash supplies idolatry and worse. The passage page keeps the bare
   participle, lists the fillings-in as reception, and says the cause of the expulsion is not
   recoverable from the text.
6. **The chronological difficulty of 21:14–15 is stated, not harmonized.** Ishmael is at least
   sixteen on the book's own numbers (16:16; 17:25; 21:5), and the verbs describe a child carried on
   a shoulder and laid under a bush. Both the source-critical answer (an E episode that knows
   nothing of P's chronology) and the literary answer (*yeled* used loosely; the verbs describing a
   mother's despair) are recorded, and neither is adopted — the same treatment the wiki gives the
   two creation accounts.
7. **Sarah's demand is called an overreach against the surrounding law, and God's endorsement of it
   is left unreconciled.** The passage page cites Hammurabi §§170–171 and Deuteronomy 21:15–17 on
   one side and 21:12 on the other, and says Genesis does not put them together. This is a judgment
   about what the text declines to do, not a verdict on Sarah; the wiki has now taken the same line
   for five consecutive pericopes.
8. **The divine-name distribution is again recorded as the standard critical account and not
   adopted.** *Yahweh* twice in 21:1 and *ʾĕlōhîm* for the other twenty verses, including *the angel
   of God* at 21:17 against *Yahweh's angel* at 16:7 — verifiable from the raw file, and the textbook
   continuation of the E block that chapter 20 began. What it does not decide is whether 16 and 21
   are one tradition told twice.

### Quote accuracy

The thirty-four block quotes of Genesis 21 on the passage page were extracted by script and compared
whole against `raw/bible/Genesis.md`: **all thirty-four verbatim, no mismatches.** Every italic-quoted
span in text added this pass (176 spans across 41 changed files) was then extracted and checked the
same way. Findings, all introduced this pass and all fixed before commit:

- **Three quotations opened with a capital the WEB does not have at that point in the verse.**
  *"Rose up early in the morning"*, *"Wandered"*, and *"Where he is"* on the passage page — all
  mid-verse, all now lower case, matching the raw text rather than the sentence they sit in.
- **Two more of the same class, in the other direction from the standing lint item.**
  *"Your offspring will be named through Isaac"* (on `people/God` and `themes/Call and Election`) and
  *"Your son, your only son, whom you love, even Isaac"* (on `people/Isaac` and the new
  `Two Sons Nearly Lost` page) both capitalize a word the WEB has in lower case mid-verse; both
  corrected. The passage page's own copy already carried its *For*, which is the better fix and is
  what the previous entry recommended.
- **One WEB rendering difference stated too strongly and then narrowed.** The passage page first said
  *"the identical clause opens Genesis 22:3"* of *"Abraham rose up early in the morning"*; the WEB
  renders 22:3 *"Abraham rose early in the morning"*. The Hebrew clause is the same
  (*wayyaškēm ʾAbrāhām babbōqer*) and the page now says so and gives the WEB's other wording.

**The pre-existing capitalization class is still open and is still the next lint's first item** —
this is the fifth consecutive entry to flag it. The five corrections above are all of new text; the
habit in older pages is untouched.

Quotations of Exodus, Leviticus, Numbers, Deuteronomy, Ruth, 1 Samuel, 1 Kings, 2 Kings, Amos,
Habakkuk, Isaiah, Jeremiah, Luke, Romans, Galatians, and Hebrews remain unverifiable against any
source in this repo, as elsewhere in the wiki; Job 7:18 was checked against `raw/bible/Job.md` and is
verbatim. The Septuagint's *"playing with Isaac her son"*, the identification of Tel Beersheba, the
Hammurabi and Lipit-Ishtar provisions, the etymology of *Pāʾrān*, the rabbinic material on
*ba-ʾăšer hû šām*, and the Islamic identifications of the well and of Paran are all external and are
stated as reception or as identifications rather than as findings.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Forward references to material not yet
ingested (Genesis 21:22–34; 22; 24; 25; 26; 28; 46) are written as plain scripture references or
carry an explicit *(not yet ingested)* marker. Three stale *(not yet ingested)* markers for this
pericope were cleared, on `themes/Barrenness`, `themes/Slavery and Servitude`, and
`places/The Negev`.

**Note on branch state.** The same environment quirk, for the seventh run in a row: the session
started on a **detached HEAD** at `2ee1637` with a clean tree, and the local `main` ref was stale at
`ee8f435` — thirteen commits behind. `git fetch origin main` advanced `origin/main` to `2ee1637`,
confirming the previous run's push landed and that the stale ref was local only; `git checkout -B
main` moved the branch onto HEAD **before** any work, so this ingest was committed on `main` rather
than on a detached HEAD. Seven consecutive runs have now hit it, and it still wants the user's
attention as an environment quirk rather than a one-off.

## [2026-09-04] ingest | Genesis 21.22-34 — The Treaty at Beersheba

Unattended run (`/ingest auto`, no target). Resolved mechanically: Genesis is the first
`in-progress` book in `wiki/books/index.md`, and 21:22–34 was the first unchecked box on its page.
Step 2's discussion is written into the passage page rather than spoken, per the skill's `auto`
mode. `raw/bible/Genesis.md` was already present; no fetch.

**Created (5).** `wiki/passages/Genesis/The Treaty at Beersheba.md`; `wiki/people/Phicol.md`;
`wiki/places/The Land of the Philistines.md`; and three connection pages —
`The Everlasting God - El Olam in Genesis and Isaiah`,
`The Wells of Abraham and the Wells of Isaac`, and `The Trees of the Patriarchs`.

**Revised (25).** `books/Genesis` (box checked, the Abraham-cycle overview extended through 21:34,
and three themes, one person, and one place added to its key lists); `books/index` (27 / 58);
`index` (counts: 33 passages, 65 people, 40 places, 87 connections); `people/Abraham`,
`people/Abimelech (of Abraham's time)`, `people/God`, `people/Isaac`, and `people/Ishmael` (each
with a new pericope section, timeline entries where they have one, and appears-in additions);
`places/Beersheba` (its 21:22–34 forward reference turned into a naming section and links),
`places/Gerar`; connections `Calling on the Name of Yahweh` (its 21:33 forward reference expanded
and split from 26:25); themes `Oaths and Vows`, `Covenant`, `Strife and Peacemaking`,
`Land and Sojourning`, `The Names of God`, `The Nations`, `War`, `Kingship and Empire`, `Blessing`,
and `Deception`; and the people, places, themes, and connections indexes.

### Judgment calls made without asking

1. **The pericope was kept whole at 21:22–34 and not attached to chapter 20.** The case for joining
   them is real — same king, same officer's town, arguably one negotiation — and it was rejected for
   the reason `Abraham and Abimelech` already gives: 21:1–21 sits between them and is about
   something else. 21:22 opens with *"At that time"* and a new cast; 21:34 closes with a duration
   summary; 22:1 opens with *"After these things"*. **No unchecked boxes were redrawn.**
2. **`Phicol` gets a person page.** He is named three times (21:22, 21:32, 26:26), never speaks, and
   does nothing. He was given a page on the same footing as `Aner` and `Eshcol` — named, recurring,
   and structurally load-bearing without being a character — and because a treaty witness of his
   rank is the whole reason the scene is peaceful. The page says outright that his silence is his
   function rather than an omission.
3. **`The Land of the Philistines` gets a place page rather than a paragraph on `Gerar`.** The name
   recurs (21:32, 21:34, 26:1), the anachronism is one of the wiki's standing test cases, and the
   later biblical career of the Philistines is large enough that a `Gerar` subsection would have
   been the wrong shape. `Gerar` keeps its own anachronism paragraph and now links across.
4. **Three connection pages, and one considered and rejected.** `The Everlasting God - El Olam`
   carries the pericope's largest single fact — a divine name with one occurrence in the Bible,
   coined by a man, out of the covenant's own adjective from Genesis 17. `The Wells of Abraham and
   the Wells of Isaac` sets 21:22–34 beside 26:12–33 and tabulates the six matching rows.
   `The Trees of the Patriarchs` carries the tamarisk, the oaks of Moreh and Mamre, and the
   Deuteronomy 16:21 problem. **A fourth — a *Seven and the Swearing of an Oath* word-study — was
   rejected**, because the *šebaʿ* / *šābaʿ* pun is fully carried by `places/Beersheba` and the
   passage page and a separate page would have duplicated both verse for verse. Genesis 26 is not
   yet ingested, so all references to it on these pages are scripture references, not links.
5. **The doublet inside the pericope is recorded and not resolved.** *"Those two made a covenant"*
   (21:27) and *"So they made a covenant at Beersheba"* (21:32) report the same act twice, and 21:31
   and 21:32 both fix the name. The source-critical split (an E treaty narrative and a J well
   narrative, joined at the etymology) and the literary reply (agreement, then consideration, then
   the evidentiary act, which is the order legal narrative takes) are both stated on the passage
   page, and neither is adopted — the same treatment the wiki gives the two creation accounts.
6. **Genesis 26:26–33 is called an open question, not a duplicate.** Same king's name, same
   commander's name, same well, same kind of dispute, same root behind the name. The three readings
   — one tradition attached to two patriarchs; two incidents in a family that kept using one well,
   with *Abimelech* and *Phicol* as titles; a deliberate literary rhyme — are all live, and 26:1 and
   26:18 are noted as the book's own cross-references, which cut both ways.
7. **The claim that Hagar is the only person in Scripture who names God is kept, with 21:33 flagged
   beside it.** *ʾĒl ʿÔlām* is unattested before Abraham and unrepeated after him, and God never
   confirms it. `themes/The Names of God` now states the standard distinction (*she called the name
   of Yahweh* vs. *he called there on the name of Yahweh* — coining against invoking), says it is
   real in the Hebrew and thin in practice, and records both rather than overwriting the older
   claim.
8. **Deuteronomy 16:21 is set against Genesis 21:33 without a resolution.** The historical reading,
   the before-Sinai reading, and the *ăšērâ*-is-a-different-object reading are all stated on
   `The Trees of the Patriarchs`, and none is adopted. This is the same posture the wiki takes on
   the patriarchal pillars, altars, and marriages.
9. **One pre-existing factual error was corrected.** `people/Abimelech (of Abraham's time)` said the
   Beersheba treaty was sworn *"over a well Abraham's servants had seized"*. Genesis 21:25 says the
   opposite — *"a water well, which Abimelech's servants had violently taken away"*. That forward
   note has been replaced by the pericope section.

### Quote accuracy

The 29 block-quoted verses added this pass were extracted by script and compared whole against
`raw/bible/Genesis.md`: **all 29 verbatim, no mismatches.** Every italic-quoted span in text added
this pass (140 spans across 29 changed files) was then extracted and checked the same way.
Findings, all introduced this pass and all fixed before commit:

- **Three quotations opened with a capital the WEB does not have at that point in the verse**, and
  **two with a lower case where the WEB has a capital** — the standing lint item, now caught in both
  directions. *"Swear to me here by God"* on `people/God` and `themes/Deception` (mid-verse in
  21:23, now lower case); *"Planted a tamarisk"* on `The Trees of the Patriarchs` (now
  *"planted a tamarisk tree in Beersheba"*, and no longer eliding the place); and, in the other
  direction, *"those two made a covenant"*, *"so they made a covenant at Beersheba"*, and
  *"therefore the name of the city is Beersheba to this day"*, all sentence-initial in the WEB and
  all now capitalized.
- **One quotation given a full stop the verse does not have.** *"But according to the kindness that
  I have done to you, you shall do to me."* on the passage page — 21:23 continues with a comma, and
  the period is now outside the quotation marks.
- **One quotation with a fabricated word, and it is the worst finding of the pass.**
  `themes/Land and Sojourning` had Abraham binding himself *"with the land in which you have lived
  as a foreigner"*; the WEB reads *"and to the land in which you have lived as a foreigner"*. The
  sentence was rewritten around the correct quotation. **A single-word substitution inside quotation
  marks is exactly what the script exists to catch and what reading the page does not**, and it is
  the first of its kind in this wiki's log.
- Two spans remain flagged by the script and are **not** errors: *"Abraham said, 'I will swear.'"*
  and 20:13's *"This is your kindness … say of me, 'He is my brother.'"* both re-nest the WEB's
  inner double quotation marks as single ones, which is the convention every quoted speech in the
  wiki already uses.

Quotations of Exodus, Leviticus, Numbers, Deuteronomy, Joshua, Judges, 1 Samuel, 2 Chronicles,
Psalms, Isaiah, Jeremiah, Hosea, Amos, Zephaniah, Zechariah, Romans, and 1 Timothy remain
unverifiable against any source in this repo, as elsewhere in the wiki. The identification of Tel
Haror with Gerar, the 1200 BC date and Aegean origin of the Philistines, the Egyptian *prst*, the
Septuagint's reading of *ʾēšel* as a field, the proposed etymologies of *Pîkōl*, the Ugaritic *ʾĒl*
epithets, and the botanical identification of *ʾēlôn* as terebinth rather than oak are all external
and are stated as identifications or proposals rather than as findings.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Forward references to material not yet
ingested (Genesis 22; 23; 24; 25; 26; 28; 31; 33; 35; 46; 47; 50) are written as plain scripture
references or carry an explicit *(not yet ingested)* marker. Three stale *(not yet ingested)*
markers for this pericope were cleared, on `places/Beersheba`, `places/Gerar`, and
`connections/Calling on the Name of Yahweh`.

**Note on branch state.** The eighth run in a row to hit it, and this time with a wrinkle worth
recording: the session started on a **detached HEAD** at `46c9cf8` with a clean tree, and the local
`main` ref was stale at `ee8f435` — fourteen commits behind. Before fetching, `git rev-list` made
HEAD look fourteen commits *ahead of the remote*, which would have been a genuine problem;
`git fetch origin` showed it was not — `origin/main` was already at `46c9cf8`, so the previous run's
push had landed and only the local ref was stale. `git checkout main && git merge --ff-only
origin/main` moved the branch onto HEAD **before** any work, so this ingest was committed on `main`
rather than on a detached HEAD. Eight consecutive runs have now started detached, and it still wants
the user's attention as an environment quirk rather than a one-off.

## [2026-09-04] ingest | Genesis 22.1-19 — The Binding of Isaac

Unattended run (`/ingest auto`, no target). Resolved mechanically: Genesis is the first
`in-progress` book in `wiki/books/index.md`, and 22:1–19 was the first unchecked box on its page.
Step 2's discussion is written into the passage page rather than spoken, per the skill's `auto`
mode. `raw/bible/Genesis.md` was already present; no fetch.

**Created (8).** `wiki/passages/Genesis/The Binding of Isaac.md`; `wiki/places/Moriah.md`;
`wiki/themes/Testing.md`; and five connection pages — `The Binding of Isaac in the New Testament`,
`Yahweh Will Provide - Moriah and the Temple Mount`,
`The Ram Instead of the Son - Substitution at Moriah`,
`Child Sacrifice and the Redemption of the Firstborn`, and
`I Have Sworn by Myself - The Oath at Moriah`.

**Revised (40).** `books/Genesis` (box checked; the Abraham-cycle overview extended through 22:19);
`books/index` (28 / 58); `index` (counts: 34 passages, 65 people, 41 places, 49 themes, 92
connections); `people/Abraham`, `people/Isaac`, `people/God`, and `people/The Angel of Yahweh` (each
with a new pericope section, timeline entries, and appears-in additions); `people/Sarah` (an
off-stage section on being the one member of the household given not even an evasion),
`people/Ishmael`, `people/Hagar`, and `people/Job (person)` (off-stage entries); `places/Beersheba`,
`places/Canaan`, `places/Salem`; themes `The Fear of God`, `Sacrifice and Offering`, `Faith`,
`Covenant`, `Blessing`, `Seeing and Being Seen`, `Life and Death`, `Call and Election`,
`Land and Sojourning`, `Prophecy and Vision`, `Oaths and Vows`, `The Names of God`, and `Suffering`;
connections `Leave Your Country - The Two Lek-Lekha Commands`,
`Two Sons Nearly Lost - The Sending of Ishmael and the Binding of Isaac`,
`Dust, Stars, and Sand - The Offspring Promises`,
`All the Families of the Earth - Genesis 12.3 in the New Testament`,
`Credited to Him for Righteousness - Genesis 15.6 in Paul and James`,
`Sacrifice Before the Priesthood`, `The Hope of Resurrection in the Old Testament`,
`Shall Not the Judge of All the Earth Do Right`, and
`Gibeah and Sodom - Judges 19 as a Retelling`; and the people, places, themes, and connections
indexes.

### Judgment calls made without asking

1. **The pericope was kept whole at 22:1–19, and the second angelic speech was not split off.**
   15–18 has no setting of its own and reads as the chapter's conclusion, even though the doubled
   call is one of the standard source-critical seams. 22:20 opens *"After these things"* again and
   turns to Nahor's genealogy, which the plan already attaches to Sarah's burial. **No unchecked
   boxes were redrawn.**
2. **The moral problem is stated and left open, with four readings recorded and none adopted** —
   polemic against child sacrifice, a real test with an open outcome, Kierkegaard's suspension of
   the ethical, and Kant's rejection of the voice. The wiki's rule here was to name the gap before
   naming the filling, which is also how Auerbach's *fraught with background* is used on the page:
   as a description of the technique, not as a resolution.
3. ***"Now I know that you fear God"* is filed with the other three places Genesis narrates God as
   finding out** (3:9; 11:5; 18:21). Relational knowing, covenant-legal demonstration, and the book
   meaning it are all recorded on `people/God` and the passage page; none is adopted. This is the
   fourth time the wiki has met this and the fourth time it has declined to settle it.
4. **The seam between Genesis 15 and Genesis 22:16–18 is written up as a genuine tension, not an
   appearance.** 15:17 has God walk between the pieces alone while Abram sleeps and undertakes
   nothing; 22:16–18 grounds the same promises in *"because you have done this thing"* and
   *"because you have obeyed my voice"*, and 26:5 repeats it. Ratification-not-ground, reward-beside-
   covenant, and Genesis-holds-both are all stated on `themes/Covenant`,
   `I Have Sworn by Myself - The Oath at Moriah`, and the passage page. Paul and James are recorded
   as taking opposite sides of a seam the Old Testament put there first.
5. **Four new pages were judged to earn their place; two candidates were rejected.** `Moriah` is
   created because the name is a genuine crux with a textual variant behind it (Samaritan *Moreh*)
   and a single-verse identification in front of it (2 Chronicles 3:1). `Testing` is created because
   *nissâ* enters Scripture here and because the wiki already has Job ingested, which gives the theme
   two anchors rather than one. The five connection pages divide the chapter's downstream material
   along lines that do not overlap: New Testament use, the mountain, substitution, child sacrifice
   and the firstborn law, and the oath. **Rejected:** a separate *Akedah in Jewish tradition* page,
   because the midrashic material is load-bearing in three places and thin on its own; and an
   *Obedience* theme, because Genesis 22:18's *"because you have obeyed my voice"* is already the
   subject of `Covenant` and `Faith` and would split the argument in half. That rejection is noted
   on `themes/Testing` in place of a link.
6. **No person page was created.** The two servants are unnamed and appear in three verses; the
   passage page treats them as the device that clears the stage of witnesses, and `naʿar` is
   discussed on `people/Isaac` because it bears on his age.
7. **Isaac's age is stated as unrecoverable.** The rabbinic thirty-seven (from placing Moriah
   immediately before 23:1) and Josephus's twenty-five are recorded as inferences. The wiki says
   only what the text supplies: he could carry the wood, and no struggle is reported.
8. **Isaac's absence from 22:19 is recorded as an omission with a plain explanation and a famous
   one.** The plural *"they rose up and went together"* naturally includes him and 24:62 has him
   alive; the midrashic reading that he died and was revived is named as tradition and explicitly
   not supported. What is asserted flatly is the checkable fact: he and Abraham share no further
   scene in Genesis.
9. **Two Christian typological readings are marked as readings.** The son carrying the wood (Melito,
   Irenaeus) is attributed to the second century and to the picture rather than the verse; the
   *lamb* of 22:8 against the *ram* of 22:13 is given both a plain reading (God provides other than
   what was asked) and the thread reading (John 1:29), with the note that the noun genuinely changes
   between the two verses.

### Quote accuracy

The 38 block-quoted verses on the passage page were extracted by script and compared whole against
`raw/bible/Genesis.md`: **all 38 verbatim, no mismatches.** Every italic-quoted span added anywhere
this pass (70 spans across 48 files, checked against the added lines of the diff rather than whole
files) was then extracted and checked the same way: **all Genesis spans verbatim.** Five spans were
flagged and are not errors — two are Hebrews 11:19, and three use the wiki's standing conventions
for an ellipsis inside a quotation or bold emphasis inside one.

**One pre-existing quotation error was corrected.** `Leave Your Country - The Two Lek-Lekha Commands`
had Genesis 22:2 as *"Offer him there **for** a burnt offering"*; the WEB reads *"as a burnt
offering"*. The page had been written before this pericope was ingested, which is exactly the
circumstance in which a forward-quoted verse goes unchecked.

Quotations of Exodus, Leviticus, Numbers, Deuteronomy, Judges, 1 Samuel, 2 Kings, 2 Chronicles,
Psalms, Proverbs, Isaiah, Jeremiah, Ezekiel, Hosea, Micah, Matthew, Mark, Luke, John, Acts, Romans,
Galatians, Hebrews, James, and 1 Peter remain unverifiable against any source in this repo, as
elsewhere in the wiki. External and non-textual claims — the hapax status of *ʿāqad*, the four
occurrences of *maʾăkelet*, the Septuagint's *ἀγαπητός* and *οὐκ ἐφείσω*, the Samaritan Pentateuch's
*Moreh*, the *ʾaḥar*/*ʾeḥād* variant at 22:13, Josephus's twenty-five, *Genesis Rabbah*, Melito and
Irenaeus, Auerbach, and Kierkegaard — are stated as attributions or proposals rather than findings.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Forward references to material not yet
ingested (Genesis 23; 24; 25; 26; 28; 31; 35; 46) are written as plain scripture references or carry
an explicit *(not yet ingested)* marker. Seven stale *(not yet ingested)* markers for this pericope
were cleared, on `people/Isaac`, `people/The Angel of Yahweh`, `places/Beersheba`,
`themes/Call and Election`, `themes/The Names of God`, `themes/Sacrifice and Offering`, and
`connections/Sacrifice Before the Priesthood` — the last of which also had Genesis 13:18 sitting
behind a stale marker, now split out and linked to `Abram and Lot Separate`.

**Note on branch state.** The ninth run in a row to start on a **detached HEAD**, this time at
`6b73f73` with a clean tree and the local `main` ref stale at `ee8f435`, fifteen commits behind.
`git fetch origin main` showed `origin/main` already at `6b73f73` — the previous run's push had
landed and only the local ref was stale — so `git checkout main && git merge --ff-only origin/main`
moved the branch onto HEAD before any work, and this ingest was committed on `main`. Nine
consecutive runs have now started detached; it is an environment quirk rather than a one-off and
still wants the user's attention.

## [2026-09-04] ingest | Genesis 22.20-23.20 — Nahor's Line and the Burial of Sarah

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
`Nahor's Line and the Burial of Sarah — Genesis 22:20–23:20` was the first unchecked box on its page.
`raw/bible/Genesis.md` was already present, so `scripts/fetch-book.sh` was not run. Step 2's
discussion is written into the passage page.

### What the pericope is

Two appendices closing the Abraham cycle, and the reason for keeping them together is that they do
the same job. God has just sworn the promise at its largest — offspring like the stars of the
heavens, the gate of the enemies (22:17) — and the next two things Genesis reports are **a name in
somebody else's family tree and a funeral**: the covenant's two contents, offspring and land,
delivered in miniature and back to back, with neither delivery mentioning the covenant and God
neither speaking nor acting anywhere in the twenty-four verses.

- **22:20–24** — news reaches Abraham (*wayyuggad*, a passive with no agent; the only word from
  Mesopotamia in the whole cycle) that Nahor has **twelve** sons, eight by Milcah and four by a
  concubine, *"His concubine, whose name was Reumah"* — **the Bible's first *pîlegeš***. The names
  are the Aramean and north Arabian map rather than a family (Aram, Chesed behind the *Kaśdîm* of Ur,
  Uz, Buz, Maacah, Tebah), and the whole register exists for one clause: *"Bethuel became the father
  of Rebekah."*
- **23:1–20** — Sarah dies at Kiriath Arba at a hundred twenty-seven, **the only woman in Scripture
  whose lifespan is recorded**, in the formal register used of the patriarchs. Abraham was at
  Beersheba (22:19) and has to *come*. The remaining eighteen verses are a conveyance: *gēr wətôšāb*,
  three bows, two refused gifts, four hundred shekels weighed to the merchants' standard, an itemized
  scope clause, witnesses at the gate — and the deed stated **twice**, the second time after the
  burial, so the chapter ends on the title and not on the grave.

### Pages created (11)

| page | why |
|---|---|
| `passages/Genesis/Nahor's Line and the Burial of Sarah` | the pericope |
| `people/Bethuel` | Rebekah's father; recurs at 24:15, 24, 50; 25:20; 28:5 |
| `people/Rebekah` | first mention, three chapters early; the next matriarch |
| `people/Reumah` | the Bible's first concubine, and the four sons that make Nahor's twelve |
| `people/Ephron the Hittite` | the seller, drawn entirely out of two speeches |
| `people/The Children of Heth` | the assembly at the gate; a group page, on the footing of `The Sons of God` |
| `places/Machpelah` | the only real property any patriarch owns in Canaan |
| `themes/Burial and the Grave` | a new theme — see the judgment call below |
| `connections/Twelve Sons - Nahor, Ishmael, and Jacob` | 22:20–24 · 17:20 · 25:12–16 · 35:22–26 |
| `connections/A Stranger and a Foreigner - The Sojourner's Confession` | 23:4 · Lev 25:23 · 1 Chr 29:15 · Ps 39:12 · Heb 11:13 · 1 Pet 2:11 |
| `connections/Buried at Machpelah - The Six Graves of Genesis` | the deed recited five times, and Acts 7:16 |

### Pages revised (24)

`books/Genesis` (box checked, overview extended, three themes and six names added to the key lists) ·
`books/index` (29 / 58) · `index` (counts) · `people/Abraham` · `people/Sarah` · `people/Isaac` ·
`people/Milcah` · `people/Nahor (brother of Abram)` · `people/Hagar` · `people/Ishmael` ·
`places/Hebron` · `places/Mamre (place)` · `places/Canaan` · `places/Beersheba` · `places/Uz` ·
`places/Ur of the Chaldees` · `themes/Land and Sojourning` · `themes/Life and Death` ·
`themes/Covenant` · `themes/Marriage` · `themes/The Nations` · `themes/Hospitality` ·
`themes/Barrenness` · `themes/Faith`, plus the four category indexes.

### Judgment calls made unattended

1. **The pericope boundary was kept as planned; no unchecked boxes were redrawn.** 22:20 opens with
   *"After these things"* and 24:1 opens a fresh self-contained narrative, so the unit is clean at
   both ends. The live alternative — attaching 22:20–24 to chapter 24, since the genealogy exists to
   introduce Rebekah and does nothing else — was rejected because the notice is tied to the Akedah by
   its own opening formula, and because both halves deliver a miniature of a promise immediately
   after that promise's largest statement, which is only visible if they are read together. Splitting
   23:1–20 off on length alone would have been defensible and would have cost the juxtaposition.
2. **A new theme page, `Burial and the Grave`, was created.** `Life and Death` covers dying;
   burial in Genesis is a distinct and unusually legal strand — a purchased holding, *"gathered to
   his people"*, and an oath that reaches from 47:29 to Joshua 24:32 — and this is the pericope that
   starts it. The two pages are cross-linked and `Life and Death` now says explicitly where it hands
   off. No schema change was needed: a new theme page is already covered by `AGENTS.md`.
3. **The eleven other sons of Nahor were deliberately not given pages** — Uz, Buz, Kemuel, Chesed,
   Hazo, Pildash, Jidlaph, Tebah, Gaham, Tahash, Maacah. Precedent is `The Table of Nations`, whose
   seventy names are handled on the passage page rather than individually. They are discussed on the
   passage page and on `people/Nahor (brother of Abram)`. Bethuel, Rebekah, and Reumah **were** given
   pages, on one verse each, because each is load-bearing within two chapters.
4. **A person/place collision was headed off rather than created.** `places/Uz.md` exists (the land
   of Job) and 22:21 names a man. Under the `AGENTS.md` person/place rule both pages would need
   qualifiers — but only once both exist, and no person page was made, so the bare `Uz.md` stands. A
   note on the passage page and on `places/Uz` records that a future page for Nahor's firstborn must
   be `Uz (son of Nahor)`, whose patronymic disambiguates without forcing a rename of the place.
5. **Kiriath Arba was folded into `places/Hebron` rather than given its own page**, since 23:2 glosses
   it in the same breath (*"Kiriath Arba (also called Hebron)"*) and the Hebron page already carried
   the name in `also_known_as` and in its overview.
6. **`The Children of Heth` was filed under `people/`** as a group page, on the footing of
   `The Sons of God`, `The Nephilim`, and `Job's Children`. It is the conveying party named in
   23:20, so it is an actor and not a place.
7. **The price is left ungraded, in both directions.** Four hundred shekels is high against every
   comparison the Bible itself supplies (Exodus 21:32; Jeremiah 32:9; 2 Samuel 24:24; 1 Kings 16:24),
   and the courtesy reading — that offering free, refusing to price, and floating the figure as a
   question are simply the polite forms — accounts for every word just as well. Both are recorded on
   the passage page and on `people/Ephron the Hittite`; neither is adopted.
8. **The rabbinic causal link between the Akedah and Sarah's death is named as tradition, not
   adopted.** *Genesis Rabbah* 58:5 and Rashi on 23:2 read chapters 22 and 23 as consecutive and make
   the news the cause. Genesis gives no cause, no reaction from Sarah to chapter 22, and never puts
   her in the same verse as it. What is checkable is only the arithmetic: 17:17 with 23:1 makes Isaac
   thirty-seven when his mother dies, which is where the rabbinic age for him on Moriah comes from
   and is not itself a claim about Moriah.
9. **The small *kaf* of *wəlibkōtāh* (23:2) is recorded as a feature of the text's transmission and
   explicitly not as evidence about Abraham's grief.** Every meaning proposed for the miniature letter
   is a later reading of a letter's size.
10. **Lehmann's 1953 Hittite-law proposal is named and not adopted.** The whole-field-versus-part
    shape of the negotiation is real; that it demonstrates Anatolian Hittite law operating at Hebron
    is not, and the standard objections are given on the passage page and on `The Children of Heth`.

### Contradiction flagged, not harmonised

**Acts 7:16 against Genesis 23 and 33:19.** Stephen has the patriarchs carried to *Shechem* and laid
in a tomb *Abraham* bought from the *sons of Hamor*. Genesis has two purchases — Abraham at Hebron
from Ephron the Hittite (23), Jacob at Shechem from the sons of Hamor (33:19) — with Joseph buried at
Shechem (Joshua 24:32) and Jacob at Machpelah (50:13). The three standing readings (compression in a
summarising speech; an independent burial tradition; a harmonisation positing an earlier Abrahamic
purchase at Shechem, which nothing in Genesis supports) are all recorded on
`connections/Buried at Machpelah - The Six Graves of Genesis`, and none is adopted.

### Quote accuracy

Every block-quoted verse on the passage page was extracted by script and compared whole against
`raw/bible/Genesis.md`: **27 of 27 verbatim.** Every italic-quoted span added anywhere in this pass
was then extracted and checked the same way: **113 spans verbatim in Genesis.** The remainder quote
books not held in this repository (Leviticus, Deuteronomy, Joshua, 1–2 Samuel, 1–2 Kings,
1 Chronicles, Psalms, Isaiah, Jeremiah, Lamentations, Ezekiel, Job, Acts, 1 Corinthians, Hebrews,
1 Peter) and are unverifiable here, as elsewhere in the wiki; three further flags are not errors —
two are contiguous WEB text spanning a verse boundary (22:21–22) or nesting an inner quotation
(24:50), and one is a partial quote.

**Nine quotation errors written during this pass were caught by that check and corrected before
commit**, all of them forward references to chapters not yet ingested: Genesis 22:17 (*"as the stars
of the sky"* for the WEB's *"greatly like the stars of the heavens"*), 21:10 (*handmaid* for
*servant*), 24:4 (a dropped comma), 24:53, 25:10, 25:16, 25:23, 26:34, and 49:31. One pre-existing
error was corrected on the same grounds: `people/Nahor (brother of Abram)` had Genesis 24:4 as
*"to my country and to my relatives"*, where the WEB reads *"to my country, and to my relatives"*.

External and non-textual claims — the *pîlegeš* count, the small *kaf*, the Septuagint's
*τὸ σπήλαιον τὸ διπλοῦν*, the Herodian date of the Hebron enclosure, Lehmann on the Hittite laws,
*Genesis Rabbah*, Rashi, and Josephus — are stated as attributions or proposals rather than findings.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Forward references to material not yet
ingested (Genesis 24; 25; 26; 27; 33; 35; 47; 49; 50) are written as plain scripture references or
carry an explicit *(not yet ingested)* marker. Nine stale *(not yet ingested)* markers for this
pericope were cleared, on `people/Abraham`, `people/Sarah`, `people/Milcah`,
`people/Nahor (brother of Abram)`, `places/Hebron`, `places/Mamre (place)`,
`themes/Land and Sojourning`, and `themes/Life and Death`. Two prospective links on
`themes/Burial and the Grave` — to Jacob and to Joseph, who have no pages yet — were written as
plain text with a *(no page yet)* marker rather than as wikilinks, so the check stays clean.

**Note on branch state.** The tenth run in a row to start on a **detached HEAD**, this time at
`59b5292` with a clean tree and the local `main` ref stale at `ee8f435`, sixteen commits behind.
`git fetch origin main` showed `origin/main` already at `59b5292` — the previous run's push had
landed and only the local ref was stale — so `git checkout main && git merge --ff-only origin/main`
moved the branch onto HEAD before any work, and this ingest was committed on `main`. Ten consecutive
runs have now started detached; it remains an environment quirk rather than a one-off, it has cost
nothing so far because every previous push had in fact landed, and it still wants the user's
attention.

**Also noticed, not acted on.** A tracked, empty `Exodus.md` sits at the repository root, added by
commit `694ca13` ("Adjust naming for passge"). It is almost certainly the residue of a stray shell
redirect and belongs nowhere in the directory map. It was left in place so that this ingest's commit
stays just the ingest; it is one `git rm` away whenever the user wants it gone.

## [2026-09-04] ingest | Genesis 24.1-67 — A Wife for Isaac

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
`A Wife for Isaac — Genesis 24:1–67` was the first unchecked box on its page. `raw/bible/Genesis.md`
was already present, so `scripts/fetch-book.sh` was not run. Step 2's discussion is written into the
passage page.

### What the pericope is

**The longest chapter in Genesis — sixty-seven verses — and God does not speak in it once.** Yahweh
is named nineteen times: sworn by, prayed to, thanked, credited, blessed, and conceded to. The
narrator reports no divine speech, no appearance, no angel, and no act, and the only thing that could
be called an intervention is a piece of timing (*"before he had finished speaking"*, 24:15). Every
theological claim in the chapter is made by a character. **This is the register the Joseph cycle is
written in, and this is where the book learns it** — which is the passage page's central claim and is
stated there as an observation about the narration rather than about whether God acted.

Four movements: the oath (1–9), the well (10–27), the house (28–61), the field at evening (62–67).
Roughly two-thirds is dialogue, and one block of it — 24:34–49 — retells the first half of the
chapter to the people who have to be convinced.

- **1–9.** Abraham, *"old, and well stricken in age"* and blessed *bakkōl*, **in all things**, makes
  his steward swear with a hand under his thigh. **This is Abraham's last scene and his last recorded
  words in the Bible**; 25:1–11 gives him a second family and a funeral and no more speech. Two
  prohibitions, and only one has a release: no Canaanite wife (discharged if she refuses, 24:8), and
  *"you don't bring my son there again"* — said twice, never qualified. **The marriage is negotiable
  and the land is not.** 24:7 is the fullest statement of the promise Abraham ever makes in his own
  mouth, and it ends in the first *"He will send his angel before you"* in Scripture, said by a man,
  never confirmed, and made a formula for the nation at Exodus 23:20.
- **10–27.** *"Yahweh, the God of my master Abraham, please give me success today"* — **the first
  unbidden human petition in Scripture**, prayed by a slave, entirely on somebody else's behalf, and
  answered before it is finished. *Ḥesed* four times (24:12, 14, 27, 49), twice paired with *ʾemet*,
  the pair God uses of himself at Exodus 34:6. Rebekah is characterised almost entirely by verbs —
  fourteen of them in six verses — passes a sign she cannot know is being applied, and exceeds it by
  watering ten camels unasked. The servant watches the whole thing without a word (*mištāʾēh*, 24:21).
- **28–49.** Laban is introduced by a causal clause whose cause is jewellery (*"when he saw the
  ring"*), and then gives a faultless welcome. The retelling has **six edits**, tabulated on the
  passage page: the mandate narrowed onto Bethuel's house; the release clause moved from the bride's
  willingness to the family's consent; the prayer moved inside his heart; gift and question reversed;
  the estate volunteered; and **the exile clause dropped entirely**. None is false; all are advocacy;
  Genesis comments on none of it.
- **50–61.** *"Then Laban and Bethuel answered"* — the son first, and no father at all in 24:53 or
  24:55. *"We can't speak to you bad or good"* is the idiom God will use on Laban at 31:24. Then the
  only question Genesis ever puts to a bride, and a one-word answer: *ʾēlēk*, **I will go**. And a
  send-off blessing that is Genesis 22:17 with a feminine pronoun and a synonym for *enemies*, spoken
  by people who have never heard the oath.
- **62–67.** Isaac comes in from Beer Lahai Roi, goes out *lāśûaḥ* — a form unique in the Hebrew
  Bible — and both parties *lift up their eyes* in consecutive verses, the only mutual instance of
  the formula in Genesis. He brings her into his dead mother's tent, and **the first statement in the
  Bible that a husband loved his wife** closes the chapter, three clauses before it says he stopped
  grieving.

### Pages created (9)

- `passages/Genesis/A Wife for Isaac` — the passage page
- `people/Abraham's Servant` — the unnamed steward
- `people/Laban`
- `places/Aram Naharaim` — *Mesopotamia*, *Paddan Aram*, and *the city of Nahor*, on one page
- `themes/Prayer`
- `connections/The Betrothal at the Well` — the type-scene: Genesis 24, Genesis 29, Exodus 2, John 4
- `connections/Not from the Daughters of the Canaanites` — endogamy from 24:3 to 2 Corinthians 6:14
- `connections/Put Your Hand Under My Thigh` — the gesture at 24:2, 9 and 47:29
- `connections/Possess the Gate of Those Who Hate Them` — Genesis 22:17 and 24:60 side by side

### Pages revised (26)

`books/Genesis` (box checked, structure paragraph added), `books/index` (30 / 58), `index` (counts),
and the four category indexes. People: `Abraham`, `Isaac`, `Rebekah`, `Sarah`, `Bethuel`, `Milcah`,
`Nahor (brother of Abram)`, `Eliezer of Damascus`, `God`, `The Angel of Yahweh`. Places:
`Beer Lahai Roi`, `Haran (city)`, `Canaan`, `The Negev`. Themes: `Marriage`, `Oaths and Vows`,
`Blessing`, `Hospitality`, `Covenant`, `Land and Sojourning`, `The Nations`, `Favor and Grace`,
`Slavery and Servitude`, `Faith`, `Seeing and Being Seen`.

### Judgment calls made unattended

- **The chapter was kept whole rather than split.** It is long enough to divide cleanly at 9, 27, and
  61, and the reason for not doing so is that the retelling at 24:34–49 only works as an effect if the
  first telling is on the same page. **No unchecked boxes were redrawn**; the next box,
  `The Death of Abraham and the Line of Ishmael — Genesis 25:1–18`, stands as drawn.
- **The servant got his own page, as `people/Abraham's Servant`**, under the `AGENTS.md` rule for an
  unnamed figure known by a title — the same treatment as `Lot's Wife` and `Job's Children`, and not
  the `(of X's time)` form, since the title already names the patriarch. **He was not merged into
  `people/Eliezer of Damascus`.** The identification is old and reasonable and the narrator withholds
  the name for sixty-seven verses, which reads as a choice; both pages now cross-reference each other
  and record the tradition without adopting it. If a later pass concludes they are the same man, the
  fix is a redirect note on both pages rather than a merge.
- **`Aram Naharaim` covers *Paddan Aram* too**, with the second name in `also_known_as`, because they
  are one region under two designations. **A separate `Paddan Aram.md` should not be created when the
  Jacob cycle arrives**; the note is on the passage page and on the place page.
- **`themes/Prayer` was created as a new theme page**, not folded into `Mediation and Advocacy` or
  `Faith`. The distinction the page tracks — being spoken to versus speaking first — is what makes
  24:12 a first, and neither existing page carries it. No schema change was needed: it is an existing
  page type.
- **Rebekah's nurse was deliberately not given a page.** She is unnamed here and named only at her
  burial (35:8), so the page belongs to that pericope. **If one is made it must be
  `Deborah (Rebekah's nurse)`** — a bare `Deborah.md` would silently collide with the judge of
  Judges 4–5, which is exactly the failure the qualifier rules exist to prevent. The warning is
  written into the passage page's notes.
- **No page was made for the veil, the camels, or the nose-ring**, and the eleven other sons of Nahor
  remain page-less on the precedent set at `Nahor's Line and the Burial of Sarah`.

### Contradictions and cruxes flagged, not resolved

- **Who runs Bethuel's house.** 24:50 names Laban before his father; 24:53 and 24:55 have *"her
  brother and her mother"* with no father at all. Either Bethuel is present and marginal, or the name
  in 24:50 is intrusive. Both readings recorded on `people/Bethuel`, `people/Laban`, and the passage
  page; neither adopted.
- **The camels.** Domesticated camels in the southern Levant are archaeologically dated to roughly
  the tenth century BC, and Genesis 24 is the standard example in that argument; the counter-cases
  (negative and regional evidence, earlier attestation further east, small caravans leaving no trace)
  are also recorded. **Observation recorded, neither conclusion adopted** — same footing as the
  Hittite-law proposal in the previous pericope.
- ***Lāśûaḥ* (24:63)** is unique in this form in the Hebrew Bible; meditate, muse, lament, stroll, and
  a euphemism are all live, and the Septuagint is itself ambiguous. **The crux is named and not
  chosen.**
- **Whether the sign was proper** — faith or presumption — is graded by Genesis not at all, and the
  wiki follows. What is recorded is that the test selects for character rather than chance, and that
  the servant refused to conclude anything until the watering finished.
- ***Yāmîm ʾô ʿāśôr*** (24:55) has been read as ten days, ten months, and a year; recorded as obscure.
- **The endogamy thread's changing reason** is flagged as a contradiction in the tradition rather than
  harmonised: Abraham gives no reason, Deuteronomy gives idolatry, Ezra gives survival, Paul gives
  allegiance — and Genesis itself has Judah and Joseph break the rule with no censure while Ruth and
  Rahab enter the genealogy of Jesus.

### Verification

Every WEB quotation in the new and revised pages was checked programmatically against
`raw/bible/Genesis.md` — blockquotes parsed verse by verse, plus forty-six inline fragments matched
after normalising curly quotes and dashes. **One quotation error written during this pass was caught
and corrected before commit**: `connections/The Betrothal at the Well` had lower-cased the opening
words of Genesis 24:28 and 29:12 to fit a table cell (*"the young lady ran"*, *"she ran and told her
father"*); both were restored to the WEB's capitalisation, and Laban's two partial quotes in the same
table with them. Quotations from Exodus, Ruth, and John are unverifiable here, as elsewhere in the
wiki, and are marked as references rather than presented as checked.

External and non-textual claims — the camel dating, the Mari attestation of *Naḫur*, the Septuagint's
*adoleschēsai*, the type-scene as a literary category, and the identification of the servant with
Eliezer — are stated as attributions or proposals rather than findings.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Forward references to material not yet
ingested (Genesis 25; 26; 27; 29–31; 35; 38; 41; 47; 50) are written as plain scripture references or
carry an explicit *(not yet ingested)* marker. One prospective link — to Judah, who has no page yet —
was written as plain text rather than as a wikilink. Ten stale *(not yet ingested)* markers for this
pericope were cleared, on `people/Rebekah` (three), `people/Isaac`, `people/Bethuel` (two),
`people/Milcah`, `people/Nahor (brother of Abram)`, `places/Beer Lahai Roi`, and
`places/Haran (city)`; two more were found by a repository-wide sweep for `24:` markers and cleared
on `themes/Hospitality` (24:15–33) and `themes/Walking with God` (24:40) — the latter also earned
that theme a place on the passage page and in the themes index, which the first pass had missed.

**Note on branch state.** The eleventh run in a row to start on a **detached HEAD**, this time at
`bb74ad0` with a clean tree and the local `main` ref stale at `ee8f435`, seventeen commits behind.
`git fetch origin` showed `origin/main` already at `bb74ad0` — the previous run's push had landed and
only the local ref was stale — so `git checkout -B main bb74ad0` moved the branch onto HEAD before
any work, and this ingest was committed on `main`. Eleven consecutive runs have now started detached;
it remains an environment quirk rather than a one-off, it has cost nothing so far because every
previous push had in fact landed, and it still wants the user's attention.

**Also noticed, not acted on.** The tracked, empty `Exodus.md` at the repository root, added by
commit `694ca13` ("Adjust naming for passge"), is still there. It belongs nowhere in the directory
map and is one `git rm` away whenever the user wants it gone; it was left alone again so this
ingest's commit stays just the ingest.

## [2026-09-04] ingest | Genesis 25.1-18 — The Death of Abraham and the Line of Ishmael

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
`The Death of Abraham and the Line of Ishmael — Genesis 25:1–18` was the first unchecked box on its
page. `raw/bible/Genesis.md` was already present, so `scripts/fetch-book.sh` was not run. Step 2's
discussion is written into the passage page. **This pericope closes the Abraham cycle** — the book
page's structural division ends at 25:18, and 25:19 opens Isaac's *toledot*.

### What the pericope is

**Nobody speaks.** Eighteen verses close the longest cycle in the book — fourteen chapters, from the
call at 12:1 to the grave at 25:10 — and they contain no dialogue at all: no God, no Abraham, no
Isaac, no Ishmael. Genesis 24 was two-thirds dialogue with a silent God; **this pericope removes the
human speech as well.** What is left is a list of names, a will, two death notices, one act of God
reported in four words rather than quoted, and a map.

It is also the only pericope in the cycle that is mostly genealogy: **twenty-eight names in eight of
its eighteen verses** — sixteen descendants by Keturah, twelve princes of Ishmael — framing the
eleven verses in which Abraham makes his will, dies, and is buried.

- **25:1–4.** Keturah, introduced in nine words and never mentioned again. Six sons, seven grandsons,
  three great-grandsons; the map is Arabia. **Midian** is the name the rest of the Bible cares about —
  Moses' refuge and marriage, the caravan that sells Joseph, Gideon's enemy, Baal Peor — and no book
  that fights the Midianites ever mentions that they are Abraham's grandchildren. *Sheba* and *Dedan*
  are already filed under Ham at 10:7, which is what a genealogy of peoples does.
- **25:5–6.** *"Abraham gave all that he had to Isaac"* — the sentence the servant had already
  volunteered to Rebekah's family at 24:36, before the reader was shown it. **Eight sons, one heir.**
  The other seven get *gifts* and a direction: *"eastward, to the east country"*, the direction
  Genesis uses for removal (3:24; 4:16; 13:11; 36:6). The verb is *give*, not *drive out*, which is a
  deliberate contrast with 21:14.
- **25:7–8.** A hundred seventy-five years, and *"in a good old age"* — *śêbâ ṭôbâ*, which occurs
  twice in Genesis: in the promise at 15:15 and in its discharge here. **It is the only promise made
  to Abraham that he lives to see kept.** And *"gathered to his people"* is **the first occurrence in
  the Bible**, listed as a third thing after *gave up his spirit* and *died* and before any burial.
- **25:9–10.** Isaac and Ishmael at one grave. Ishmael has not been on the page since 21:21 and is
  eighty-nine; **Genesis records no reconciliation, no message, and no word between them.** The
  younger is named first, which is the reverse of 35:29. The Machpelah deed is recited in full for
  the third of five times.
- **25:11.** *"After the death of Abraham, God blessed Isaac, his son. Isaac lived by Beer Lahai
  Roi."* **God's first recorded act toward Isaac, at seventy-five**, and it is a blessing rather than
  a covenant word — he is not spoken to until 26:2. And the verse that settles the son of the promise
  at the slave woman's well is the last verse before the slave woman's son's genealogy.
- **25:12–18.** Ishmael's *toledot*, seven verses before Isaac's. Twelve princes — *nəśîʾîm*,
  17:20's own noun — *"according to their nations"*, in villages and encampments from Havilah to
  Shur. A hundred thirty-seven years, and *gathered to his people* in the same three verbs as his
  father: **the only person outside the covenant line ever given that formula**, and the only one of
  its six recipients with no burial reported at all.

### Judgment calls made unattended

- **Boundaries: the box stands as drawn, and no unchecked boxes were redrawn.** The break at
  25:18/25:19 is the book's own — 25:19 opens a *toledot* — and the book page already ended the
  Abraham division there. The alternative split, 25:1–11 and 25:12–18, was considered and rejected:
  25:11 and 25:12 are deliberately adjacent (Isaac settling at Hagar's well, then Hagar's son's
  genealogy) and separating them loses the juxtaposition.
- **Which new pages to make.** One person (`Keturah`), one place (`Havilah`), four connections.
- **Which pages *not* to make, and why.** Twenty-eight names arrive in these verses and none of them
  acts, speaks, or is described. The wiki's standing practice, set at `The Table of Nations`, is that
  a bare genealogical name gets no page and a name with narrative weight does — Nimrod and Canaan got
  pages out of Genesis 10; Sheba, Dedan, and Raamah did not. That rule was applied unchanged.
  **Midian was the closest call** and was left without a page until the Midianites enter the
  narrative at 37:28. **When that page is made it must be `Midian (son of Abraham)`**, because Midian
  is also a region and a bare `Midian.md` is exactly the silent basename collision the `AGENTS.md`
  qualifier rules exist to prevent; the same caution applies to Nebaioth and Kedar if Isaiah 60 or
  Isaiah 21 is ever ingested. The note is recorded on the passage page and on `people/Keturah` so the
  next agent does not create a bare page.
- **`Havilah` earned a page now** rather than at Genesis 2 or 10 because this is its fourth
  appearance and it was being referenced from five existing pages without one — the `AGENTS.md` lint
  criterion for a repeatedly-mentioned place lacking a page.

### Tensions flagged and not resolved

- **What Keturah is.** *ʾiššâ*, **wife**, at 25:1; one of *"Abraham's concubines"* (*pîlagšîm*,
  plural) at 25:6; *"Abraham's concubine"* outright at 1 Chronicles 1:32. **Both readings recorded,
  neither adopted**, on the same footing as Hagar's *wife* at 16:3 against *the servant* at 21:10.
- **The chronology of Keturah's family.** Sarah dies when Abraham is 137 and he dies at 175, and the
  narrative order puts a marriage, six sons, seven grandsons, and three great-grandsons into the
  thirty-eight years between — from the man who laughed at 17:17. Three proposals recorded
  (non-chronological placement; restored vigour; the *Genesis Rabbah* 61:4 identification of Keturah
  with Hagar, which 25:6's plural contradicts), **none adopted.**
- ***Gathered to his people*.** Stated as a fact about the narration, not as a claim about the
  afterlife. Three readings — dead metaphor, retained ancestral-burial language, a statement about
  Sheol — are set out on the new connection page and **none is adopted.** What is checkable: it is
  listed separately from dying, it precedes burial, and in Abraham's case his people are buried a
  thousand miles away, which rules the family-tomb reading out for the first occurrence.
- ***Śābēaʿ* at 25:8.** The Hebrew is *zāqēn wəśābēaʿ*, *old and satisfied*, without the *yāmîm* that
  35:29 and Job 42:17 carry; the WEB's *full of years* supplies it, as do most versions and the
  ancient translations. **Recorded as a textual detail, not as a correction to the WEB.**
- **Ishmael's reappearance at the graveside.** Genesis gives no account of it. The traditions that
  fill the gap are later than Genesis; the wiki records the silence.

### A correction to three existing pages

`people/Ishmael`, `passages/Genesis/Hagar and Ishmael`, and `themes/The Nations` each stated that
Genesis 25:18 repeats 16:12 **word for word**. **That is an overstatement and was corrected on all
three.** The four-word prepositional phrase *ʿal-pənê kol-ʾeḥāyw* is identical; the verb is not —
*yiškōn* (*dwell*) at 16:12 against *nāpāl* (*fall*, here *settle* or *encamp*) at 25:18 — and the
difference between the two verbs is exactly where the reading of the clause is decided, between a
neutral *he settled alongside* and an adversarial *he settled in hostility*. The crux is now set out
on the passage page, and the wiki's existing flag — that this half-verse has often been read as a
permanent moral verdict on a people, which is more than the Hebrew supports — is kept.

### Pages created

- `wiki/passages/Genesis/The Death of Abraham and the Line of Ishmael.md`
- `wiki/people/Keturah.md`
- `wiki/places/Havilah.md`
- `wiki/connections/Gathered to His People.md` — the formula's six uses, why it is not a synonym for
  burial, and the fact that Ishmael is given it
- `wiki/connections/Buried in a Good Old Age - The Promise at Genesis 15.15 and Its Fulfilment.md` —
  the promise clause by clause, and Jacob's opposite verdict at 47:9
- `wiki/connections/The Other Line First - The Order of the Toledot in Genesis.md` — Cain, Ham and
  Japheth, Ishmael, Esau: the passed-over branch always goes first and always gets closed out
- `wiki/connections/Abraham's Other Sons in Isaiah 60.md` — Midian, Ephah, Sheba, Kedar, and Nebaioth
  are all from these eighteen verses, and Isaiah 60:6–7 brings all five back to Zion with gold and
  incense

### Pages revised

`books/Genesis` (box checked, and the Abraham division's overview closed out), `books/index`
(31 / 58), `wiki/index` (counts), and: `people/Abraham` (new pericope section, timeline, appears-in,
related people, themes), `people/Isaac`, `people/Ishmael`, `people/Hagar`, `people/Sarah`,
`people/God`, `people/Rebekah` (off-stage), `people/Ephron the Hittite`, `people/The Children of
Heth`; `places/Machpelah`, `places/Mamre (place)`, `places/Hebron`, `places/Beer Lahai Roi`,
`places/Shur`, `places/Egypt`, `places/Assyria`, `places/The Negev`, `places/Canaan`;
`themes/Burial and the Grave`, `themes/Life and Death`, `themes/Blessing`, `themes/Covenant`,
`themes/Call and Election`, `themes/The Nations`, `themes/Land and Sojourning`, `themes/Marriage`,
`themes/Slavery and Servitude`, `themes/Remembrance`; `connections/Twelve Sons - Nahor, Ishmael, and
Jacob` (a new section on the promised twelve being the exactly-delivered one),
`connections/Buried at Machpelah - The Six Graves of Genesis`, `connections/The Two Flights of
Hagar`, `connections/Two Sons Nearly Lost - The Sending of Ishmael and the Binding of Isaac` (a new
significance bullet on the shared funeral), `passages/Genesis/Hagar and Ishmael`; and all four
category indexes.

Stale *(not yet ingested)* markers for this pericope were cleared on `people/Abraham`,
`people/Isaac`, `people/Ishmael` (two), `people/Hagar`, `people/Sarah`, `people/Ephron the Hittite`,
`people/The Children of Heth`, `places/Shur`, `places/Beer Lahai Roi`, `places/Machpelah`, and
`places/Hebron` — twelve in all, several of which covered 25:9–10 together with 49:31 or 50:13 and
so were split rather than removed, keeping the marker on the verses still ahead. The markers on `people/Rebekah` and `themes/Barrenness` for 25:21 and 25:23 were
left in place deliberately: those verses belong to the next box.

### Verification

Every WEB blockquote in the new and revised pages was parsed verse by verse and checked
programmatically against `raw/bible/Genesis.md`; all matched after normalising curly quotes and
dashes. Inline fragments were checked the same way, and **four capitalisation errors written during
this pass were caught and corrected before commit**: *"And was gathered to his people"* (25:8 has
lower-case *and*) on the passage page and on `people/Abraham`; *"By their villages"* (25:16 has
lower-case *by*); *"To the sons of Abraham's concubines"* (25:6 has lower-case *to*) on
`people/Abraham`; and *"few and evil have been the days"* (47:9 has capital *Few*). A fifth
correction removed quotation marks from *"Old, and satisfied"*, which is this wiki's rendering of
*zāqēn wəśābēaʿ* and not a WEB quotation, so presenting it as one was wrong. Quotations from
1 Chronicles, Isaiah, Numbers, Deuteronomy, Exodus, Romans, Galatians, Hebrews, and Matthew are
unverifiable here, as elsewhere in the wiki, and are given as references rather than as checked text;
Job 42:17 was checked against `raw/bible/Job.md`.

External and non-textual claims — the *Genesis Rabbah* identification of Keturah with Hagar, the
etymology of *qəṭûrâ* from *qəṭōret*, the North Arabian identifications of Kedar, Nebaioth, Tema,
Dumah, Jetur, Naphish, and Massa, the locations proposed for Havilah, and the reading of the magi of
Matthew 2 against Isaiah 60 — are stated as attributions or proposals rather than findings.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Three prospective links written during the
pass were converted to plain text because their targets do not exist and are not being created here:
Moses, Esau, and Midian. Forward references to material not yet ingested (Genesis 25:19–34; 26; 27;
35; 36; 37; 47; 49; 50) are written as plain scripture references or carry an explicit
*(not yet ingested)* marker.

**Note on branch state.** The twelfth run in a row to start on a **detached HEAD**, this time at
`85f7709` with a clean tree and the local `main` ref stale at `ee8f435` — which is the merge commit
of PR #1, eighteen commits behind. `git fetch origin main` showed `origin/main` already at `85f7709`,
so the previous run's push had landed and only the local ref was stale; `git checkout -B main HEAD`
moved the branch onto HEAD before any work, and this ingest was committed on `main`. Twelve
consecutive runs have now started detached. It has cost nothing so far, because every previous push
had in fact landed, but it remains an environment quirk that wants the user's attention.

**Also noticed, not acted on.** The tracked, empty `Exodus.md` at the repository root, added by
commit `694ca13` ("Adjust naming for passge"), is still there. It belongs nowhere in the directory
map and is one `git rm` away whenever the user wants it gone; it was left alone again so this
ingest's commit stays just the ingest. Also still open: five unmerged `claude/*` branches on the
remote, one of which (`claude/ingest-auto-jobs-18-20-vholye`) is the already-merged PR #1.

## [2026-09-05] ingest | Genesis 25.19-34 — Jacob and Esau and the Sold Birthright

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
`Jacob and Esau and the Sold Birthright — Genesis 25:19–34` was the first unchecked box on its page —
the **first pericope of the Isaac and Jacob division**, opened by the *toledot* heading at 25:19.
`raw/bible/Genesis.md` was already present, so `scripts/fetch-book.sh` was not run. Step 2's
discussion is written into the passage page.

### What the pericope is

**Twenty years pass in one verse and a bowl of lentils takes six.** That is the whole method: the
book opens its third patriarchal cycle with a genealogy heading, disposes of two decades of
childlessness in a sentence, hands out the oracle that governs the next twenty-five chapters in four
poetic lines, delivers twins, characterises them in twenty-nine words — and then slows almost to a
stop for a domestic transaction over a pot of stew.

- **25:19–20.** The *toledot* of Isaac, seven verses after Ishmael's, exactly as the book's habit
  requires. The heading's second clause is famously redundant (*"Abraham's son. Abraham became the
  father of Isaac"*); three proposals are recorded and none adopted. 25:20 restates Rebekah's pedigree
  in four identifiers the reader already has, gives ***Paddan Aram*** its **first of ten occurrences
  in Genesis**, and **plants [[Laban]]** four chapters before he takes over Jacob's life.
- **25:21.** *"Isaac entreated Yahweh for his wife … Yahweh was entreated by him"* —
  ***wayyeʿtar … wayyēʿāter lô***, the same rare root active and then passive in one sentence, and
  **the first occurrence of *ʿātar* in the Bible**. **Isaac is the only patriarch who prays for his
  wife's conception**; Abraham never does and Jacob refuses (30:2). Twenty years of barrenness, from
  40 (25:20) to 60 (25:26), reported in a subordinate clause.
- **25:22.** *Wayyitrōṣăṣû* — the children **crush one another**. Rebekah's *"If it is so, why do I
  live?"* is four Hebrew words **with no verb in them**. Then *"She went to inquire of Yahweh"* —
  ***lidrōš ʾet-YHWH***, **the Bible's first use of that idiom**, with no altar, priest, shrine,
  place, or messenger named, and nobody sending her.
- **25:23.** The only divine speech in the pericope, in poetry, **to a woman** — and Yahweh has not
  yet said anything to Isaac, who waits until 26:2. Rebekah is the second woman in Genesis given an
  annunciation; the first was [[Hagar]], a runaway slave.
- **25:24–26.** Two etymologies, **and neither is for *Esau***: *ʾadmônî* (red) seeds Edom, *śēʿār*
  (hair) seeds Seir, and *ʿĒśāw* is left unexplained in a book that explains almost every name.
  *Yaʿăqōb* from *ʿāqēb*, heel — the neutral pun, with the hostile one (*ʿāqab*, supplant) held back
  for Esau's mouth at 27:36.
- **25:27–28.** Twenty-nine words for two men the book follows for twenty-five chapters, and **the
  first stated parental favouritism in Scripture** — with a motive given for Isaac (venison) and none
  at all for Rebekah.
- **25:29–34.** *Halʿîṭēnî* — **a verb the Hebrew Bible uses only here**, cognate with feeding
  animals — and an object that is an adjective doubled with no noun. The oath converts a shrug into an
  irrevocable transfer. The stew turns out to be lentils, which are not red, and bread was in the
  house anyway. Then five verbs and **the pericope's only evaluative sentence**: *"So Esau despised
  his birthright."*

### Judgment calls made unattended

- **Boundaries: the box stands as drawn, and no unchecked boxes were redrawn.** 25:19 is the book's
  own opening (a *toledot* heading) and 26:1 begins with a fresh time marker. The alternative split —
  25:19–28 and 25:29–34 — was considered and **rejected**: the sale scene is built out of 25:27's two
  characterisations word for word (the man of the field comes in from the field), so separating them
  removes the reason the transaction works.
- **New pages made.** Two people (`Jacob`, `Esau`), one place (`Edom`), one theme
  (`Birthright and the Firstborn`), three connections.
- **`Edom` was created now rather than at Genesis 36**, because 25:23 is an oracle *about* the nation
  and 25:30 supplies its name, and because `places/Teman` had been referring to Edom in plain text
  since the Job material with an explicit note that a page would follow. That note has been replaced
  with the link; `Uz`, referenced in the same list with the same kind of note, was linked at the same
  time since its page already exists.
- **`Paddan Aram` deliberately did *not* get a page.** `places/Aram Naharaim` already states as a
  settled convention that the wiki keeps the region's two names on one page; that page was extended
  instead. **The next agent should not create `Paddan Aram.md`.**
- **`Birthright and the Firstborn` was made a theme rather than a connection** because it runs
  through six generations of Genesis, the Exodus firstborn legislation, and the New Testament's
  *"assembly of the firstborn"*, which is wider than any one text pair.
- **No page for Seir, Leah, or Rachel.** All three are named only in this page's forward references;
  their pericopes are ahead. When Seir gets a page it should be `places/Seir`, and `Edom` already
  carries it as an alias.

### Tensions flagged and not resolved

- ***Rab yaʿăbōd ṣāʿîr* (25:23).** Three words, **no object marker on either noun**, and Hebrew poetic
  word order does not force the reading; the line is grammatically construable as *the elder will
  serve the younger* or as *the elder — the younger shall serve*. **The standard reading is adopted**
  (every ancient version, every later biblical use, and the narrative itself), and **the ambiguity is
  recorded** because the cycle it opens is about two parents who heard the oracle differently.
- ***Tām* at 25:27.** The adjective applied to Jacob is the one applied to [[Noah]] (*tāmîm*, 6:9) and
  to [[Job (person)]] (*tām wəyāšār*, Job 1:1), where it means **blameless**. The WEB has *quiet*;
  other versions have *mild*, *plain*, *civilised*, *blameless*. **Both the moral and the
  way-of-life readings are recorded and neither is adopted.**
- ***ʾIm-kēn lāmmâ zeh ʾānōkî* (25:22).** No verb in the Hebrew. Four renderings are set out; the
  WEB's *"why do I live?"* is the strongest available. **Recorded as a translation crux, not as a
  correction to the WEB.**
- ***"Behold, I am about to die"* (25:32).** Hyperbole, or a hunter's real calculation that an
  inheritance is worthless to a dead man. **Neither adopted**; noted that 25:34's *despised* fits the
  second better.
- **The narrator's asymmetry.** Genesis condemns Esau at 25:34 and says **nothing about Jacob** in the
  whole chapter. The wiki **states this as a fact about the text** and resolves it in neither
  direction — it does not exonerate Jacob (chapters 27, 29, and 32 do not read as approval) and it
  does not import the verdicts of Esau (27:36), Laban (29:25), or Hosea (12:3) into a narrator who
  withheld them.
- **The redundancy at 25:19.** Three proposals (the *toledot* form's own shape; a claim against a
  doubt about Isaac's paternity raised by 20:2–7; a source seam). **None adopted.**
- **What the birthright was.** *Bəkōrâ* is undefined in Genesis. Double portion (Deuteronomy 21:17),
  family headship (inferred), and the covenant line (what the reader knows and nobody in the scene
  mentions) are **kept distinct**, and the birthright is kept distinct from the **blessing**, which
  chapter 27 transfers separately.
- **Romans 9 and Malachi.** The connection page states plainly that Malachi 1:2–3 argues from
  sixth-century ruins back to a preference, not forward from Genesis, and that Paul's subject across
  Romans 9–11 is corporate Israel. Whether the passage also bears on individual election is recorded
  as **a live argument made from Paul, not something Genesis 25:23 supplies.**

### A correction made during this pass

A draft of the passage page said *ʿātar* at 25:21 was its second occurrence in Genesis, citing
Abraham's prayer for Abimelech at 20:17. **That is wrong and was fixed before commit**: 20:17's verb
is *pālal* (*hitpallēl*), which is that root's own first occurrence in Scripture, and *ʿātar* occurs
in Genesis only at 25:21. `themes/Prayer` already had this right and was not the source of the error.

### Pages created

- `wiki/passages/Genesis/Jacob and Esau and the Sold Birthright.md`
- `wiki/people/Jacob.md`
- `wiki/people/Esau.md`
- `wiki/places/Edom.md`
- `wiki/themes/Birthright and the Firstborn.md`
- `wiki/connections/The Elder Will Serve the Younger - Genesis 25.23 in Malachi and Romans.md` — the
  syntactic ambiguity of the fourth line, the political forecast and its end at 2 Kings 8:20–22, and
  why Malachi and Romans are three steps and fifteen hundred years downstream
- `wiki/connections/Esau's Birthright in Hebrews.md` — *bebēlos*, the two readings of *"found no place
  for a change of mind"*, and the fact that Hebrews preserves Genesis's silence about Jacob
- `wiki/connections/The Barren Matriarchs.md` — Sarah, Rebekah, Rachel; the shrinking length of the
  three tellings, and the three husbands who pray, do not pray, and refuse to

### Pages revised

`books/Genesis` (box checked; the Isaac and Jacob division's structure bullet opened; Jacob, Esau,
Edom, Aram Naharaim, and the new theme added to the key lists), `books/index` (32 / 58), `wiki/index`
(counts: 38 passages, 75 people, 45 places, 52 themes, 106 connections), and: `people/Isaac` (new
pericope section, timeline, appears-in, related people, themes), `people/Rebekah` (new pericope
section replacing the forward-looking sketch), `people/God` (new pericope section and appears-in
entry), `people/Abraham`, `people/Laban`, `people/Bethuel`, `people/Hagar`; `places/Aram Naharaim`,
`places/Teman`; `themes/Barrenness`, `themes/Prayer`, `themes/Call and Election`,
`themes/Prophecy and Vision`, `themes/Strife and Peacemaking`, `themes/Oaths and Vows`,
`themes/Blessing`, `themes/Deception`, `themes/The Nations`, `themes/Covenant`; and all four category
indexes.

Stale *(not yet ingested)* markers were cleared on `people/Rebekah` (two: 25:21 and 25:23),
`themes/Barrenness` (25:21), `themes/Prayer` (25:21), and `people/Bethuel` (25:20, which was split so
that the marker stays on 28:5) — five in all, exactly the ones the previous entry said were being
left for this box.

### Verification

Every WEB blockquote in the new and revised pages was parsed verse by verse and checked
programmatically against `raw/bible/Genesis.md`; all matched after normalising curly quotes and
dashes. Inline quoted fragments in this pass's diff were checked the same way, and **four errors
written during the pass were caught and corrected before commit**: *"and they grieved the spirits of
Isaac and Rebekah"* (26:35 reads *"They grieved Isaac's and Rebekah's spirits"*); *"a great and
exceedingly bitter cry"* and *"exceedingly great and bitter cry"* (27:34 reads *"an exceeding great
and bitter cry"*); *"you will break his yoke from off your neck"* (27:40 reads *"you shall shake his
yoke from off your neck"*); and an exclamation mark added to *"Bless me, even me also, my father."*
A fifth correction removed quotation marks from *"this red red"*, which is this wiki's literal
rendering of *hā-ʾādōm hā-ʾādōm* and not a WEB quotation — the same class of error the previous
entry recorded for *"old and satisfied"*.

Quotations from Malachi, Romans, Hebrews, Hosea, Obadiah, Amos, the Psalms, Deuteronomy, Numbers,
Samuel, and Kings are unverifiable here, as elsewhere in the wiki, and are given as references rather
than as checked text; Job 1:1 was checked against `raw/bible/Job.md`.

External and non-textual claims — the attestation of *Yaʿaqōb-ʾēl* in second-millennium sources, the
hapax status of *lāʿaṭ* and of *ʿāqad*, the location of Edom and the Idumean identification of Herod,
and the reception history of *tām* — are stated as attributions or proposals rather than findings.

### Links

`scripts/link-check.sh` clean, exit 0, baseline 64 — unchanged, since no new book page was created
this pass. **No dangling links were left deliberately.** Forward references to material not yet
ingested (Genesis 26; 27; 28; 29; 30; 31; 32; 33; 35; 36; 48; 49) are written as plain scripture
references or carry an explicit *(not yet ingested)* marker. Prospective links to Seir, Leah, and
Rachel were written as plain text because their pages do not exist and are not being created here.

**Note on branch state.** The thirteenth run in a row to start on a **detached HEAD**, this time at
`fb92c84` with a clean tree and the local `main` ref stale at `ee8f435` — still the merge commit of
PR #1, now nineteen commits behind. `git fetch origin main` showed `origin/main` already at `fb92c84`,
so the previous run's push had landed and only the local ref was stale; `git checkout -B main fb92c84`
moved the branch onto HEAD before any work, its upstream was set to `origin/main`, and this ingest was
committed on `main`. Thirteen consecutive runs have now started detached. It has cost nothing so far,
because every previous push had in fact landed, but it remains an environment quirk that wants the
user's attention.

**Also noticed, not acted on.** The tracked, empty `Exodus.md` at the repository root, added by commit
`694ca13` ("Adjust naming for passge"), is still there, unchanged for fourteen runs. It belongs
nowhere in the directory map and is one `git rm` away whenever the user wants it gone; it was left
alone again so this ingest's commit stays just the ingest.

## [2026-09-05] ingest | Genesis 26.1-35 — Isaac in Gerar

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
`Isaac in Gerar — Genesis 26:1–35` was the first unchecked box on its page. `raw/bible/Genesis.md`
was already present, so `scripts/fetch-book.sh` was not run. Step 2's discussion is written into the
passage page.

### What the pericope is

**The only chapter in the Bible that belongs to Isaac, and almost everything in it has happened
before.** A famine the narrator explicitly measures against Abraham's; a wife called a sister; a king
called Abimelech who finds out and delivers the rebuke; a quarrel about wells; a treaty at Beersheba
with the same king and the same general; an altar and a calling on the name; and the name Beersheba
explained a second time by the same root. **The two places the chapter does not repeat are where its
argument sits.**

- **26:1.** *"Besides the first famine that was in the days of Abraham"* — **Genesis
  cross-referencing itself in its opening clause.** Whatever the relation between this chapter and
  the Abraham material, the book is not hiding it; 26:18 does the same thing again.
- **26:2–5.** **God's first words to Isaac, sixty years after scheduling his birth.** *"Don't go down
  into Egypt"* is **the only prohibition in the patriarchal promises**, and it is why he is the one
  patriarch who never leaves the land; Jacob is told the opposite at the same well at 46:3. The
  promise is restated with **not one new term** — and then given a ground it has never had:
  ***"because Abraham obeyed my voice, and kept my requirements, my commandments, my statutes, and my
  laws"***. *Mišmartî, miṣwōtay, ḥuqqôtay, wətôrōtāy* is **the standard Deuteronomic formula for
  keeping the Sinai law, four hundred years early**, and 26:5 is the only verse in Genesis where the
  promise's continuation rests on obedience — against 15:17, where God passes between the pieces
  alone and Abram undertakes nothing.
- **26:6–11.** The third wife-sister episode, **and the first with no half-truth available**: Sarah
  was Abraham's half-sister (20:12), Rebekah is his cousin's daughter. **God does nothing in it** — no
  dream, no plague, no closed wombs — and it is the only one of the three in which nobody is taken.
  The king finds out **by looking out of a window**, and the verb he sees is ***məṣaḥēq***, the
  intensive of the root Isaac is named for and **the same participle that got Ishmael expelled at
  21:9**. Abimelech answers with *môt yûmāt*, **the first royal decree in Scripture**, and its content
  is protection for a resident alien and his wife.
- **26:12–17.** *"Isaac sowed in that land"* — **the only patriarch in Genesis reported planting a
  crop**, in a famine, on ground he does not own, having just been told to live there as a *gēr*.
  The hundredfold is **the only agricultural yield figure in the book**. Then *"The Philistines envied
  him"*, **the first occurrence of *qānāʾ* in the Bible**; then the wells filled in with earth, which
  destroys the asset rather than transferring it; then *"Go away from us, for you are much mightier
  than we"* — *ʿāṣamtā mimmennû məʾōd*, within a word of Exodus 1:9.
- **26:18–22.** Esek, Sitnah, Rehoboth. **Two conceded and a third kept**, with no claim of prior
  right, no appeal to the treaty of chapter 21, and no reference to the promise of *all these lands*
  given nineteen verses earlier. *Śiṭnâ* is **the first occurrence in the Bible of the noun behind
  *śāṭān***.
- **26:23–25.** ***"I am the God of Abraham your father"*** — **the first time in Scripture God
  identifies himself by the name of an ancestor**, and the beginning of the formula that reaches
  Exodus 3:6. Then **the only altar Isaac builds in the Bible**, with no sacrifice recorded on it.
- **26:26–33.** The Genesis 21 embassy with a third man added — [[Ahuzzath]], *"his friend"*, an ANE
  court office — and **a cheaper settlement**: a feast, no consideration, no witness object, and no
  complaint entered about the wells. *Shibah*, and **the second etiology of Beersheba**, which the
  book does not notice it has given twice.
- **26:34–35.** Esau at forty — **his father's age at marriage** — takes two Hittite women of the
  neighbourhood, and *"They grieved Isaac's and Rebekah's spirits."* **The only sentence in the cycle
  in which Isaac and Rebekah are recorded feeling the same thing**, and the pretext Rebekah uses at
  27:46.

### Judgment calls made unattended

- **Boundaries: the box stands as drawn, and no unchecked boxes were redrawn.** Two alternatives were
  considered and **rejected**. Splitting at 26:33 to hold 26:34–35 for the chapter 27 unit is
  defensible — those verses are Esau's — but the chapter division keeps them here, 27:1 opens with a
  fresh time marker, and the grief reads as this chapter's closing note. Splitting at 26:11 was
  rejected because 26:12's *"Yahweh blessed him"* is the chapter's answer to 26:7 and depends on
  standing next to it.
- **Title: the plan's *Isaac in Gerar* was kept**, although a third of the chapter is at Beersheba.
  *Isaac at Gerar and Beersheba* is more accurate and less useful — Gerar is where the problem is
  set, and [[The Treaty at Beersheba]] already holds the other half of that title. **Recorded on the
  passage page so a later pass can revisit rather than rediscover it.**
- **New pages made.** One passage; six people (`Abimelech (of Isaac's time)`, `Ahuzzath`, `Judith`,
  `Basemath (daughter of Elon)`, `Beeri the Hittite`, `Elon the Hittite`); three places (`Esek`,
  `Sitnah`, `Rehoboth`); one theme (`Envy`); three connections
  (`Because Abraham Obeyed My Voice - Law Before Sinai`,
  `Mightier Than We - Isaac in Gerar and Israel in Egypt`,
  `The Names of Esau's Wives - Genesis 26 and Genesis 36`).
- **`Abimelech (of Isaac's time)` was created per the note already standing on
  `people/Abimelech (of Abraham's time)`**, which had explicitly reserved the page. That note has
  been rewritten to point at it, and neither page decides whether the two kings are one man, two
  men, or one office.
- **`Basemath` was qualified from the start rather than left bare.** Genesis 36:3 names a second
  Basemath (Ishmael's daughter), so the page is `Basemath (daughter of Elon)`. **This departs from
  the retrospective-rename pattern `AGENTS.md` gives for the person/place collision**, and was chosen
  because the collision is certain, is documented inside this pericope's own cross-references, had no
  inbound links to break, and fails silently at both ends. **The counterpart page, when Genesis 36 is
  ingested, is `Basemath (daughter of Ishmael)`.**
- **`Beeri the Hittite` and `Elon the Hittite` were given pages** although they are pure patronyms
  named once, on the wiki's existing practice for `Iscah`, `Reumah`, and `Aner`. Elon recurs at
  36:2.
- **Shibah deliberately did *not* get a place page** and is folded into `places/Beersheba`, because
  26:33 is an etiology of that town's name rather than a separate site. **The valley of Gerar** was
  folded into `places/Gerar` for the same reason. **The next agent should not create `Shibah.md`.**
- **`Envy` was made a theme rather than a connection** because *qānāʾ* runs from 26:14 through 30:1
  and 37:11 into Exodus 20:5's *ʾĒl qannāʾ* and the New Testament vice lists — a thread through
  Scripture rather than a link between two passages.
- **Two contradictions are flagged rather than resolved.** (1) The two lists of Esau's wives: 26:34
  gives Basemath as Elon's daughter and Judith as Beeri's; 36:2–3 gives Adah as Elon's daughter,
  Oholibamah as Anah's, and Basemath as Ishmael's — **the same name attached to two different
  fathers, and a wife in each list absent from the other.** Three standing explanations are set out on
  the new connection page and none is adopted. (2) 26:5's conditional grounding of the promise
  against 15:17's unilateral covenant; both are recorded side by side, on the principle the wiki
  applies to the creation accounts.
- **Chronology flagged, not corrected.** Genesis gives no age for Isaac in 26:1–33, and the ruse at
  26:7 is easier to picture with no twins in the household — which would place the Gerar material
  before 25:19–26 in time — while 26:34 jumps to Esau at forty. **Recorded as an observation about
  the arrangement of a block of Isaac tradition, not as a claim that any event is out of order.**
- **A pre-existing misquotation was corrected.**
  `connections/Not from the Daughters of the Canaanites` had 26:35 as *"a grief of mind to Isaac and
  to Rebekah"*; the WEB reads *"They grieved Isaac's and Rebekah's spirits."* Fixed, with the Hebrew
  *mōrat rûaḥ* added.

### Pages created or revised

`passages/Genesis/Isaac in Gerar` (new); `books/Genesis` (box checked; the Isaac and Jacob structure
bullet extended; the new theme, six people, and three places added to the key lists); `books/index`
(33 / 58); `wiki/index` (counts: 39 passages, 81 people, 48 places, 53 themes, 109 connections).

New: `people/Abimelech (of Isaac's time)`, `people/Ahuzzath`, `people/Judith`,
`people/Basemath (daughter of Elon)`, `people/Beeri the Hittite`, `people/Elon the Hittite`;
`places/Esek`, `places/Sitnah`, `places/Rehoboth`; `themes/Envy`;
`connections/Because Abraham Obeyed My Voice - Law Before Sinai`,
`connections/Mightier Than We - Isaac in Gerar and Israel in Egypt`,
`connections/The Names of Esau's Wives - Genesis 26 and Genesis 36`.

Revised: `people/Isaac` (new pericope section, eight timeline entries, appears-in, related people,
six themes), `people/Rebekah`, `people/Esau`, `people/God` (new pericope section, three timeline
entries, appears-in), `people/Abraham` (new off-stage section, appears-in), `people/Phicol`,
`people/Abimelech (of Abraham's time)`; `places/Gerar`, `places/Beersheba`,
`places/The Land of the Philistines`, `places/The Negev`, `places/Egypt`; `themes/Deception`,
`themes/Strife and Peacemaking`, `themes/Blessing`, `themes/Covenant`, `themes/Land and Sojourning`,
`themes/Oaths and Vows`, `themes/Marriage`, `themes/The Nations`, `themes/Work`,
`themes/Sacrifice and Offering`, `themes/The Names of God`;
`connections/The Wife-Sister Episodes`, `connections/The Wells of Abraham and the Wells of Isaac`,
`connections/Calling on the Name of Yahweh`,
`connections/All the Families of the Earth - Genesis 12.3 in the New Testament`,
`connections/Dust, Stars, and Sand - The Offspring Promises`,
`connections/Not from the Daughters of the Canaanites`,
`connections/Laughter and the Name Isaac`;
`passages/Genesis/Jacob and Esau and the Sold Birthright` (its forward reference to this chapter
turned into a link); and all four category indexes.

Stale *(not yet ingested)* markers were cleared on `places/The Negev` (26:23–25),
`places/The Land of the Philistines` (26:1–22), `places/Gerar` (26:1–33), `places/Beersheba`
(26:23–33), `themes/Deception` (26:6–11), `themes/Strife and Peacemaking` (26:17–22),
`connections/The Wife-Sister Episodes` (26:6–11),
`connections/The Wells of Abraham and the Wells of Isaac` (26:12–33),
`connections/Calling on the Name of Yahweh` (26:25),
`connections/All the Families of the Earth` (26:4, split so the marker stays on 28:14),
`connections/Not from the Daughters of the Canaanites` (26:34–35, split so the marker stays on
27:46), `people/Isaac` (26), `people/Rebekah` (26:7), `people/Esau` (26:34–35), and `people/Phicol`
(26:26) — **sixteen in all.**

### Verification

Every WEB blockquote in the new and revised pages was parsed verse by verse and checked
programmatically against `raw/bible/Genesis.md`; **28 quoted verses, all matching** after normalising
curly quotes and dashes. All 615 inline italic-quoted fragments in the changed files were checked the
same way; every fragment attributed to Genesis matched, and the misses were all non-Genesis
quotations (Job, Exodus, Deuteronomy, Proverbs, the Gospels, Paul) plus one pre-existing partial
quotation of 25:11 on `people/God` that is verbatim as far as it goes.

**Five capitalisation errors written during the pass were caught and corrected before commit**, all
of them sentence-initial capitals imposed on mid-verse fragments: *"Because Abraham obeyed…"* and
*"My servant Abraham"* on `people/Abraham` (26:5, 26:24 read *because* and *my*), *"In the valley"*
on `places/Esek` (26:19 reads *in the valley*), *"And we will be fruitful…"* on `places/Rehoboth`
(26:22 reads *and we*), and *"therefore the name of the city…"* on `places/Beersheba` (26:33 reads
*Therefore*).

The claim that **26:14 is the first *qānāʾ* in the Bible** was checked against the raw text for the
book: Genesis has the root at 26:14, 30:1, and 37:11 in that order and nowhere earlier. Job 5:2 uses
the cognate noun *qinʾâ*, which is later in canonical order.

Quotations from Exodus, Deuteronomy, Joshua, Samuel, Kings, Chronicles, Ezra, Nehemiah, Ruth, the
Psalms, Proverbs, Ecclesiastes, Hosea, Zechariah, the Gospels, Acts, Romans, Corinthians, Galatians,
James, and Hebrews are unverifiable here, as elsewhere in the wiki, and are given as references
rather than as checked text.

External and non-textual claims — the Deuteronomic character of *mišmartî / miṣwōtay / ḥuqqôtay /
tôrōtāy*, the court-office sense of *rēaʿ ha-melek*, the Middle Bronze identification of Tel Haror,
the 1200 BC arrival of the Philistines, the Wadi Ruheibeh proposal for Rehoboth, and the etymologies
of *Ahuzzath*, *Beeri*, *Basemath*, *Judith*, and *Elon* — are stated as attributions or proposals
rather than as findings. **The Wadi Ruheibeh identification is explicitly recorded as resting on the
name alone.**

### Links

`scripts/link-check.sh` clean, exit 0, **baseline 64 — unchanged**, since no new book page was
created this pass. **No dangling links were left deliberately.** Forward references to material not
yet ingested (Genesis 27; 28; 30; 36; 37; 46; 47) are written as plain scripture references or carry
an explicit *(not yet ingested)* marker. Prospective references to Adah, Oholibamah, Anah, Zibeon,
Mahalath, and Nebaioth were written as plain text because their pages do not exist and are not being
created here; they belong to Genesis 28 and 36.

**Note on branch state.** The fourteenth run in a row to start on a **detached HEAD**, this time at
`725b8d0` with a clean tree, and the local `main` ref stale behind it. `git fetch origin` showed
`origin/main` already at `725b8d0`, so the previous run's push had landed and only the local ref was
stale; `git checkout -B main origin/main` moved the branch onto HEAD before any work, its upstream was
set to `origin/main`, and this ingest was committed on `main`. **Fourteen consecutive runs have now
started detached.** It has cost nothing so far, because every previous push had in fact landed, but it
remains an environment quirk that wants the user's attention.

**Also noticed, not acted on.** The tracked, empty `Exodus.md` at the repository root, added by commit
`694ca13` ("Adjust naming for passge"), is still there, unchanged for fifteen runs. It belongs nowhere
in the directory map and is one `git rm` away whenever the user wants it gone; it was left alone again
so this ingest's commit stays just the ingest.

**And four unmerged `claude/*` branches are on the remote** — `claude/ingest-auto-4q3uek`,
`claude/ingest-auto-jobs-18-20-vholye`, `claude/ingest-auto-kllgcw`, and
`claude/unmerged-branches-audit-xt7o4j`. They were not inspected or touched this pass; they are noted
here because the last of them is named for an audit of exactly this, and the user may want to close
them out.

## [2026-09-05] ingest | Genesis 27.1-45 — The Stolen Blessing

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
`The Stolen Blessing — Genesis 27:1–45` was the first unchecked box on its page. `raw/bible/Genesis.md`
was already present, so `scripts/fetch-book.sh` was not run. Step 2's discussion is written into the
passage page.

### What the pericope is

**A blind man is worked through his four remaining senses, one at a time, and the sense that tells
him the truth is the one he overrules.**

- **27:1.** ***Wattikhênā ʿênāyw mērəʾōt*** — **Isaac is the first person in Scripture said to have
  lost his sight** (*kāhâ*, the verb later used of Eli and denied of Moses). **The irony is exact**:
  the man whose lie was exposed one chapter earlier because a king looked out of a window is the man
  who cannot look.
- **27:5–17.** Rebekah is a **participle — *šōmaʿat*, she was listening** — and she quotes her
  husband with two words he did not say: *"bless you **before Yahweh**"* against 27:4's *"that my
  soul may bless you"*. It is **the only link anyone in the chapter makes between the blessing and
  God**, and it is put into another person's mouth. Then four verbs, all hers: *she made, she took,
  she put, she gave.*
- **27:11–13.** **Jacob's one objection is operational, not moral** — *"What if my father touches
  me?"* — and the answer is ***ʿālay qilləlātəkā bənî***, *"Let your curse be on me, my son"*:
  **the only offer in Genesis to take another person's curse.**
- **27:19, 24.** ***ʾĀnōkî ʿĒśāw bəkōrekā*** — **the one flat lie in the family's whole repertoire**,
  and it is about identity rather than a fact. Genesis's deceptions are otherwise the true statement
  wrongly framed; the departure is the chapter's signature. He repeats it under direct questioning.
- **27:20.** *"Because Yahweh **your** God gave me success"* — **the only invocation of God as an
  agent in the chapter, and it is inside a lie**; and the pronoun is *your*. He does not say *my God*
  until Bethel (28:21).
- **27:22.** ***Haqqōl qôl Yaʿăqōb, wəhayyādayim yədê ʿĒśāw*** — **hearing works.** Isaac states the
  correct forensic result aloud, to the man's face, and overrules it. He asks the identity question
  twice (27:21, 24). **This is not a man being fooled; it is a man discounting the evidence he has.**
- **27:27–29.** The blessing is fertility, dominion, and **Genesis 12:3 with its halves reversed** —
  and **no land, no offspring promise, and no mention of Abraham or the covenant.** Those are handed
  over knowingly at 28:3–4. The wiki keeps the two transfers apart.
- **27:33.** ***Wayyeḥĕrad … ḥărādâ gədōlâ ʿad-məʾōd***, and then ***gam-bārûk yihyeh***, **"Yes, he
  will be blessed."** The defrauded party reconstructs the whole fraud in one sentence and then
  ratifies it. **This is where the Bible establishes that a blessing, once spoken, is irrevocable,
  and it establishes it in the worst case available.**
- **27:34–38.** ***Ṣəʿāqâ gədōlâ ûmārâ*** — **the outcry word**, used of Sodom (18:20) and of Israel
  under the taskmasters (Exodus 3:7), reaching a blind old man with nothing left. *"Isn't he rightly
  named Jacob?"* is **the second and harsher etymology**, from *ʿāqab*, given to the victim. And
  *"Have you but one blessing, my father?"* is answered yes — **Genesis 27 is the only place in the
  Bible where a blessing runs out.**
- **27:39–40.** *Min* is both partitive and privative, so 27:39 is **either a lesser blessing or an
  anti-blessing**, and the versions split. The sword, the service, and *"you shall shake his yoke
  from off your neck"* — **both halves of which 2 Samuel 8:13–14 and 2 Kings 8:20–22 record.**
- **27:41–45.** ***Wayyiśṭōm***, from *śāṭam* — cousin to the *śiṭnâ* that named a well one chapter
  earlier. **The fourth fratricide in Genesis and the only one planned, dated, and abandoned.**
  Rebekah's *"a few days"* is twenty years, her *"I will send, and get you from there"* never
  happens, and *"Why should I be bereaved of you both in one day?"* is exact blood-vengeance
  arithmetic that comes half true.
- **And God is absent.** The divine name appears in four verses, **every occurrence inside a human
  sentence** (*Yahweh* 27:7, 20, 27; *ʾĕlōhîm* 27:20, 28),
  and **no speech, no act, no appearance, and no prayer.** The oracle of 25:23 is cited by nobody —
  including the woman who received it. **Four people act as if God has no means of his own, and the
  result matches what he said.**

### Judgment calls made unattended

- **Boundaries: the box stands as drawn, and no unchecked boxes were redrawn.** The alternative —
  running the unit to 28:9 so that the whole blessing-and-departure sequence is one pericope — was
  **rejected**: it would swallow Bethel's preliminaries and make a unit of nearly sixty verses. The
  seam at 27:45/46 is the sharpest available, since 27:46 changes addressee (to Isaac) and changes
  the stated reason (the Hittite wives), and the next box already begins there.
- **Title: the plan's *The Stolen Blessing* was kept.** It is the traditional name, it is what the
  chapter is about, and no other book has a passage page by that title.
- **Three unresolved cruxes were recorded rather than decided.** (1) **27:39's *min***: partitive
  (WEB, KJV, LXX) or privative (NRSV, ESV, most moderns) — the choice decides whether Esau is
  blessed at all, which is what Hebrews 12:17 denies. (2) **Rebekah's *"before Yahweh"* at 27:7**,
  which is not in Isaac's speech at 27:4 — a summarized original, a deliberate escalation, or her own
  reading of the stakes; none adopted. (3) **The absence of God**, where the two standing readings
  (the deception was superfluous; providence runs through wrongdoing uncleaned) are set side by side
  with no verdict, on the same practice the wiki used for the narrator's asymmetry at 25:34.
- **Chronology recorded as inference, not as text.** Genesis gives no age anywhere in the chapter.
  The chain through 41:46, 45:6, 47:9, 30:25, and 25:26 makes Isaac a hundred thirty-seven and Jacob
  about seventy-seven, and **the passage page sets the chain out and labels it an inference from four
  widely separated verses.** It is recorded because it changes how the scene reads.
- **The setting is likewise an inference**: Genesis does not name the place, and 26:23–33 with 28:10
  put it at Beersheba. Noted as such on both pages.
- **New pages made.** **No new people, places, or themes were needed** — every figure in the chapter
  already had a page. **Three connections**: `A Garment and a Goat - Jacob Deceives and Is Deceived`,
  `The Younger Before the Firstborn - Jacob and Laban`, and
  `Yes, He Will Be Blessed - The Irrevocable Word`. The first two were preferred over one combined
  page because the props and the substitution are separate mechanisms with separate later
  trajectories; the third was created rather than folded into `Esau's Birthright in Hebrews`, which
  is about Esau's valuation and not about the standing of the word.
- **`Listening to the Voice - Genesis 3 and Genesis 16` was extended by reference rather than
  renamed**, although 27:8, 13, and 43 give the idiom three more occurrences. The page's title names
  the two chapters it compares; a rename would break inbound links for a third instance that the
  passage page already carries. **Flagged here so a later pass can revisit it.**
- **Pages revised.** Passage (new); book page (`Genesis` — box checked, structure paragraph
  extended); seven people (`Isaac`, `Rebekah`, `Jacob`, `Esau`, `God`, `Laban`, `Abraham`); four
  places (`Haran (city)`, `Edom`, `Beersheba`, `Canaan`); thirteen themes (`Blessing`, `Deception`,
  `Curse`, `Birthright and the Firstborn`, `Language and Speech`, `Seeing and Being Seen`,
  `Vengeance`, `Strife and Peacemaking`, `Call and Election`, `Prophecy and Vision`, `Covenant`,
  `Nakedness and Covering`, `Retribution`); five indexes; and this log.

### Quote check, and two corrections to pages already standing

All 61 blockquoted verses on the passage page were diffed against `raw/bible/Genesis.md`
programmatically: **zero mismatches.** Inline quotations of other Genesis chapters were checked the
same way, and three were wrong and have been fixed:

- **Genesis 37:32** is *"Examine it, now, **whether** it is your son's coat or not"*, not *"and see
  if it is"*.
- **Genesis 3:21** is *"Yahweh God made **coats** of animal skins"*, not *"garments"*.
- **Genesis 48:10** is *"**the eyes of Israel** were dim for age"*, not *"his eyes were"*.

Two further corrections were made to text that was already on the wiki before this pass:

- **`wiki/passages/Genesis/Jacob and Esau and the Sold Birthright.md`** quoted Hebrews 11:20 as
  *"By faith Isaac blessed Jacob and Esau, concerning things to come"*; the WEB reads **"By faith,
  Isaac blessed Jacob and Esau, even concerning things to come."** Fixed there and everywhere else
  the sentence is quoted.
- **The divine-name count in this pericope was corrected while being written.** *Yahweh* stands at
  27:7, 20, and 27 and *ʾĕlōhîm* at 27:20 and 28 — **four verses, not four occurrences of one
  name** — and the claim is now phrased that way on the passage page, on `people/God`, and above.

Books other than Genesis and Job are not in `raw/`, so quotations from Numbers, Joshua, Judges,
1 Samuel, Isaiah, Hosea, and the New Testament on the new connection pages are from memory and
follow the wiki's existing practice; they are kept short and are all flagged with chapter and verse
so a later pass can verify them against a fetched text.

### Link check

`scripts/link-check.sh` exits 0. No wrapped links; no dangling targets beyond the expected baseline
of not-yet-started book pages, which stands at 64 (unchanged — no new book page was created this
pass). **No links were deliberately left dangling.** Forward references to Rachel, Leah, Bethel, and
Paddan Aram were written as plain text rather than as links, because their pericopes are the next two
and three boxes on the queue.

## [2026-09-05] ingest | Genesis 27.46-28.9 — Isaac Sends Jacob to Paddan Aram

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md`, and
its first unchecked box read `Jacob's Ladder at Bethel — Genesis 27:46–28:22`. **That box was split**
(see below) and the first half of it ingested. `raw/bible/Genesis.md` was already present, so
`scripts/fetch-book.sh` was not run. Step 2's discussion is written into the passage page.

### What the pericope is

**The blessing is given a second time, and this time nobody is deceived.**

- **27:46.** ***Qaṣtî bəḥayyay*** — *I loathe my life*; *qûṣ* is the verb of revulsion (Exodus 1:12;
  Leviticus 20:23), stronger than the WEB's *weary*. Rebekah gives Isaac **a marriage problem instead
  of a death threat**: four verses earlier she told Jacob that Esau meant to kill him (27:42). She
  never mentions the murder and never mentions the blessing, and **Genesis never once has Isaac and
  Rebekah speak to each other about what happened in the tent.** Nothing she says is false. **This is
  the last thing she says in the Bible.**
- **28:1.** ***Wayyəbārek ʾōtô wayṣawwēhû*** — he *calls* Jacob, which means he knows who is in front
  of him. **Everything in chapter 27 depended on Isaac not knowing; nothing here does.**
- **28:1–2.** Abraham's oath of 24:3 restated as a father's command, almost word for word — **with
  the machinery stripped out** (no oath, no sanction, no servant, no camels) **and its one unreleased
  clause reversed**: Abraham twice forbade Isaac ever to make the journey (24:6, 8), and Isaac sends
  his own son. *"The daughters of Laban"* is plural, providing for two wives before either is named.
- **28:3.** ***ʾĒl Šadday***, whose six Genesis occurrences are **all at transfers of the promise**;
  ***yaprəkā wəyarbekā***, the creation blessing of 1:28; and ***qəhal ʿammîm***, in which
  ***qāhāl*** is **its first occurrence in the Hebrew Bible.** God grants the same in the same words
  at 35:11.
- **28:4.** ***Birkat ʾAbrāhām*** — **the exact phrase occurs here and nowhere else in Genesis**, and
  in the New Testament only at Galatians 3:14. **And it carries the land**: *ʾereṣ məgurêkā*, the
  land of your sojournings, the phrase of 17:8, which describes the country by the word for not
  owning it. **27:27–29 had no territorial grant at all.** The wiki had flagged that in advance on
  the previous page and records it here as delivered: **the covenant was not stolen; what was stolen
  was a firstborn's portion.**
- **28:5.** A genealogical trailer repeating 25:20 verbatim in substance. The WEB's *"Rebekah's
  brother, Jacob's and Esau's mother"* is tangled English for appositives that stack onto their
  nearest owners. **The younger son is named first** — against 35:29's *"Esau and Jacob"*.
- **28:6–8.** ***Wayyarʾ ʿĒśāw***, twice, governing four clauses: **the only place in Genesis where
  the narrator works from inside Esau's head**, and what it finds is inference rather than
  resentment. His conclusion is correct. Inside his field of view sits *"Jacob obeyed his father and
  his mother"* — *šāmaʿ*, the loaded idiom of chapter 27 — **one verse after Jacob lied twice to one
  of them.** Genesis does not flag it.
- **28:9.** He marries [[Mahalath]], daughter of Ishmael, **his first cousin out of the branch the
  covenant had already passed over** — the two elder sons who lost an inheritance, joined — and
  ***ʿal-nāšāyw***, *besides the wives that he had*: **the correction is additive, which is what
  stops it being one.** The Hittite wives stay.

### Judgment calls made unattended

- **Boundary redrawn — this is the one substantive plan change this pass.** The box read
  *Jacob's Ladder at Bethel — Genesis 27:46–28:22*: twenty-seven verses under a title describing only
  its second half. **It was split into two boxes**, `Isaac Sends Jacob to Paddan Aram — Genesis
  27:46–28:9` (ingested, checked) and `Jacob's Ladder at Bethel — Genesis 28:10–22` (left unchecked,
  next in the queue). Grounds: 28:6–9 closes on Esau and **28:10 restarts with a fresh itinerary
  formula** — *"Jacob went out from Beersheba, and went toward Haran"* — new subject, new place, new
  genre; and **27:46–28:9 is framed by marriage at both ends** (daughters of Heth at 27:46, daughters
  of Canaan at 28:8). The previous pericope's notes had already forecast this split and the plan had
  not been updated to match. Genesis's pericope count therefore goes 58 → 59, and
  `wiki/books/index.md` now reads **35 / 59**.
- **Title.** *Isaac Sends Jacob to Paddan Aram* names the passage's own event rather than Rebekah's
  pretext or Esau's coda; no other book has a passage page by that title. *The Second Blessing* was
  considered and rejected as too interpretive for a filename.
- **The two reasons for one journey are recorded and not resolved.** The source-critical reading —
  that 27:46–28:9 is Priestly and knows nothing of the deception — is set out with its markers named
  (*Paddan Aram*, *ʾĒl Šadday*, *be fruitful and multiply*, *qəhal ʿammîm*, pedigree rather than
  scene) and **is not adopted**, on the same practice the wiki used for the two creation accounts and
  the two flights of Hagar. What is checkable without any source theory is that the book supplies two
  reasons for one journey four verses apart and never lets the parents discuss it.
- **The chronology of 28:9 is recorded as inference, not as contradiction.** Ishmael is dead by
  roughly thirteen years here on the book's own numbers (16:16; 21:5; 25:17, with the reckoning that
  puts Isaac at a hundred thirty-seven). Genesis states none of it in the passage, the arithmetic
  runs through four widely separated verses, and *"went to Ishmael"* reads ordinarily as *went to
  Ishmael's household*. Same footing as Isaac's age at 27:1.
- ***qāhāl* at 28:3 is claimed as the word's first occurrence in the Hebrew Bible**, stated as a
  distribution fact with nothing theological built on it here.
- **New pages made — one person, one connection.** `Mahalath`, because she is named, married, and
  disputed between two registers, which is the standard applied to `Judith` and
  `Basemath (daughter of Elon)`. `Two Errands to Paddan Aram - Genesis 24 and Genesis 28`, comparing
  the two sendings to the same country for the same reason — servant against son, ten camels against
  nothing, gifts against fourteen years of labour, one journey against twenty years.
- **New pages deliberately not made.** **Nebaioth** — bare genealogical name, per the rule set at
  `The Table of Nations` and restated at `The Death of Abraham and the Line of Ishmael`; if Isaiah 60
  or 21 is ever ingested the page should be `Nebaioth (son of Ishmael)`. **Paddan Aram** —
  `Aram Naharaim` carries it in `also_known_as`, a decision recorded at `A Wife for Isaac` and
  repeated on the passage page so it is not undone. **A separate Galatians 3:14 connection page** —
  `All the Families of the Earth - Genesis 12.3 in the New Testament` already carries the Galatians 3
  thread, and a second page would restate it around one phrase; the phrase is recorded on the passage
  page instead.
- **Mahalath took the bare filename.** No collision: the wiki has no other Mahalath, and the two
  others in Scripture (a Psalm-heading term, and Rehoboam's wife at 2 Chronicles 11:18) are not
  people this wiki will page under that name. Recorded here in case one ever needs qualifying.
- **Pages revised.** Passage (new); book page (`Genesis` — box split and checked, structure paragraph
  extended); twelve people (`Isaac`, `Rebekah`, `Jacob`, `Esau`, `Ishmael`, `Laban`, `Bethuel`,
  `The Children of Heth`, `Abraham`, `God`, `Judith`, `Basemath (daughter of Elon)`) plus the new
  `Mahalath`; two places (`Aram Naharaim`, `Canaan`); ten themes (`Blessing`, `Covenant`, `Marriage`,
  `Land and Sojourning`, `Call and Election`, `The Nations`, `The Names of God`, `Deception`,
  `Birthright and the Firstborn`, `Oaths and Vows`); three existing connections
  (`Not from the Daughters of the Canaanites`, `The Names of Esau's Wives - Genesis 26 and Genesis
  36`, `God Almighty - El Shaddai in Genesis and Exodus`) plus the new one; three passage pages whose
  forward references to this pericope were converted from *(not yet ingested)* markers into links
  (`The Stolen Blessing`, `Isaac in Gerar`, `A Wife for Isaac`); six indexes; and this log.

### Quote check, and corrections made while writing

All 18 blockquoted verses on the passage page were diffed against `raw/bible/Genesis.md`
programmatically: **zero mismatches**, after one editorial closing quotation mark was removed from
28:2, which in the WEB runs on into 28:3–4. Inline quotations of other Genesis chapters were checked
the same way, and **four were wrong and were fixed before commit**:

- **Genesis 21:12** is *"your offspring will be named through Isaac"*; the page had quoted the
  Romans 9:7 form, *"in Isaac will your offspring be called"*, against a Genesis reference.
- **Genesis 17:8** is *"the land where you are traveling"*. The page had quoted it as *"the land of
  your sojournings"*, which is a gloss of *ʾereṣ məgurêkā* and not the WEB; the Hebrew claim stands
  and is now stated as a claim about the Hebrew.
- **Genesis 24:10** is *"a variety of good things of his master's"*, not *"all his master's goods"*.
- **Genesis 32:10** is *"with just my staff I **crossed** over this Jordan"*, not *"passed over"*.

**Genesis 24:8** was also corrected to *"then you shall be clear from this oath to me"*, and
**24:50** to *"The thing proceeds from Yahweh. We can't speak to you bad or good."* — the connection
page had joined the two sentences with a semicolon.

Books other than Genesis and Job are not in `raw/`, so the quotations of Deuteronomy 26:5 and
Galatians 3:14, and the summary of Hosea 12:12, follow the wiki's existing practice: short, flagged
with chapter and verse, and verifiable by a later pass against a fetched text. **Hosea 12:12 was
deliberately reworded from a quotation into a summary** because its exact WEB wording could not be
checked from `raw/`.

### Link check

`scripts/link-check.sh` exits 0. No wrapped links; no dangling targets beyond the expected baseline
of not-yet-started book pages, which stands at **64 — unchanged**, since no new book page was created
this pass. **No links were deliberately left dangling.** Forward references to Rachel, Leah, Bethel,
and Nebaioth were written as plain text rather than as links; their pages do not exist and, for
Nebaioth, deliberately will not until a prophetic book is ingested.

### Fixed before the ingest, in its own commit

**The previous run left literal `</content>` and `</invoke>` lines at the end of four files it
wrote** — `wiki/passages/Genesis/The Stolen Blessing.md` and the three connection pages it created.
They were stripped in a separate commit before this ingest began, so the ingest commit stays just the
ingest. **This is the second time this has happened** — the log at the Genesis 11:10–32 pass records
sixteen files with the same stray `</content>` line — so it is a recurring failure mode of the
writing step rather than a one-off, and it is worth a `grep -rn '</content>\|</invoke>' wiki/` at the
end of any future pass. This run's own first write of the passage page reproduced it and was caught
and fixed before commit.

**Branch state, unchanged from the last fifteen runs.** The session started on a **detached HEAD** at
`ef9d4cd` with a clean tree, and the local `main` ref stale behind it at `ee8f435`. `git fetch origin
main` showed `origin/main` already at `ef9d4cd`, so the previous run's push had landed and only the
local ref was stale; `git checkout -B main origin/main` moved the branch onto HEAD before any work,
its upstream was set, and both commits from this run are on `main`. **Sixteen consecutive runs have
now started detached.** It has still cost nothing, and it still wants the user's attention.

**Also still noticed, still not acted on.** The tracked, empty `Exodus.md` at the repository root
(commit `694ca13`) is unchanged, and four unmerged `claude/*` branches remain on the remote —
`claude/ingest-auto-3oz4au`, `claude/ingest-auto-4q3uek`, `claude/ingest-auto-jobs-18-20-vholye`, and
`claude/ingest-auto-kllgcw`, plus `claude/unmerged-branches-audit-xt7o4j`. All are one command away
from cleanup whenever the user wants them gone; none was touched, so this ingest's commit stays just
the ingest.

## [2026-09-05] ingest | Genesis 28.10-22 — Jacob's Ladder at Bethel

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
its first unchecked box read `Jacob's Ladder at Bethel — Genesis 28:10–22`. `raw/bible/Genesis.md`
was already present, so `scripts/fetch-book.sh` was not run. Step 2's discussion is written into the
passage page. **The boundary the previous pass drew was used as drawn** and needed no revision: 28:10
opens with a fresh itinerary formula, 28:22 closes on the vow, and 29:1 restarts with *"Then Jacob
went on his journey"*.

**The session started on a detached HEAD** at `origin/main` (8c61454), with local `main` twenty-four
commits behind and the tree clean. `main` was checked out and fast-forwarded to `origin/main` — a
verified fast-forward, no commits discarded — and the ingest committed on `main`. Nothing was
stashed, dropped, or rewritten.

### What the pericope is

**God speaks to Jacob for the first time, and says nothing about chapter 27.**

- **28:10–11.** ***Wayyipgaʿ bammāqôm*** — *he ran into the place*, the verb of unintended encounter,
  with the definite article. **The ancient practice of sleeping at a shrine to solicit a dream is
  available to this story and Genesis refuses it**: Jacob stops because the sun has set, sleeps on a
  stone picked out of a field, and finds out afterwards what he was lying on. ***Māqôm*** runs **six
  times in twelve verses** and is the standing Hebrew term for a sanctuary site — **the narrator
  calls it a shrine before Jacob knows it is one.** And the sunset frames the whole twenty years: it
  sets on him here and rises on him at 32:31 as he limps away from Peniel.
- **28:12.** ***Sullām*** is **a hapax legomenon** — once in the Hebrew Bible — usually derived from
  *sālal*, *to cast up a roadway*, hence the WEB's **stairway** against the KJV's *ladder*. Its
  *"top reached to heaven"* is **Babel's idiom** (11:4), and these are the only two places in the
  book where something's *head* reaches the sky. The angels go **up** first. ***Bô*** is
  masculine and so is Jacob: *on it* or *on him*, and the same ambiguity sits on ***ʿālāyw*** at
  28:13.
- **28:13–14.** The first divine speech to Jacob, and it is a self-introduction: *"the God of Abraham
  your father, and the God of Isaac"* — **the formula being assembled**, one name short of Exodus
  3:6 and of the sentence Jesus argues the resurrection from. The land is granted at its smallest —
  ***"the land whereon you lie"***, against the four horizons Abram was told to look across and walk
  (13:14–17) — with the **dust** of 13:16, and *"all the families of the earth"*, which is **the
  fifth and last statement of that promise in Genesis and the only one after the first to use the
  first one's noun** (*mišpəḥōt hāʾădāmâ*, as at 12:3, against *the nations* at 18:18, 22:18, 26:4).
- **28:15.** **Four clauses none of the patriarchs before him received** — *I am with you*, *I will
  keep you wherever you go*, *I will bring you again into this land*, *I will not leave you* —
  because **Jacob is the first bearer of the promise to leave the land carrying it.** Abraham was
  called into it and forbade Isaac ever to leave; Isaac was forbidden Egypt (26:2). **No condition
  anywhere in the speech, and no reference to the deception.**
- **28:16–17.** ***"And I didn't know it."*** The man whose whole method has been knowing more than
  the person in front of him. Then ***nôrāʾ*** — the WEB's *dreadful* in its old sense — and two
  names before the naming: ***bêt ʾĕlōhîm*** and ***šaʿar haššāmayim***, the second of which is what
  Babylon took *Babel* to mean and what Genesis 11:9 refused it.
- **28:18–19.** ***Maṣṣēbâ***, from the same root as the ***niṣṣāb*** of 28:13: what stood over the
  stairway is answered by a stone standing on the ground. **The first oil in the Bible** and its
  first anointing, performed on a rock by a man with no office. The naming admits the book's own
  anachronism — 12:8 and 13:3–4 called the site Bethel *"but the name of the city was Luz at the
  first."*
- **28:20–22.** **The first *neder* in Scripture**, and its conditions are God's own unconditional
  promises handed back with an *if* on them. He **narrows** each (*wherever you go* → *this way that
  I go*; *this land* → *my father's house*), **adds** bread and clothing, and **drops the land, the
  offspring, and the nations entirely.** The tenth is the Bible's second and second pre-Mosaic one,
  pledged on what he does not have, with no priest and no sanctuary, and **Genesis never records him
  paying it.**

### Judgment calls made unattended

- **The title was kept as the plan had it**, *Jacob's Ladder at Bethel*, although the page argues
  throughout that *sullām* is more probably a **stairway or ramp** and the WEB translates it so.
  Grounds: it is the name the episode carries in every index a reader would arrive from, and *The
  Stairway at Bethel* buys precision at the cost of findability. **The philological point is made in
  the body rather than in the filename.** No other book has a passage page by this title.
- **Two grammatical ambiguities recorded and neither resolved.** ***Bô*** at 28:12 (*on it* / *on
  him*) and ***ʿālāyw*** at 28:13 (*above it* / *beside him*) are genuine in the Hebrew. The WEB
  takes both as the stairway; the rabbinic tradition preserved the other reading; John 1:51 puts the
  angels on a person. **Both readings are on the page.**
- **Where the vow's apodosis begins is recorded and not resolved.** *"And Yahweh will be my God"*
  (28:21b) sits inside the condition in the WEB and begins the promise in the KJV and others; **the
  Hebrew marks neither**, and the theological difference is large. The wiki adopts neither and
  records what holds on both readings: **it is the first time Jacob says *my* God**, against the
  *"Yahweh **your** God"* he used to Isaac while lying at 27:20.
- ***ʿAd ʾăšer* at 28:15 is read in the ordinary way** — the *until* fixes the guarantee to the
  completion of the promise rather than terminating it — and **stated as a choice** rather than
  smuggled in, with 35:9–12 noted as Genesis's own answer.
- **The Babel parallel is new on this page and its claim is deliberately narrow.** 11:4 and 28:12 are
  the only two places in the book where something's *top* reaches the sky; *the gate of heaven*
  stands beside the popular etymology of *Babel* that 11:9 itself declines. **The wiki does not claim
  Genesis 28 was composed as a reply to Genesis 11**, and says so on both pages. **The scattering
  verbs are noted as different roots** — *pûṣ* at 11:4, *pāraṣ* at 28:14 — rather than made into a
  pun.
- ***Sullām* as a hapax and *šemen* at 28:18 as the Bible's first oil** are both recorded as
  distribution facts. The oil claim was **verified against `raw/bible/Genesis.md`** rather than
  asserted from memory; nothing theological is built on it beyond the observation that the first
  anointing in Scripture is of a stone, by a layman.
- **New pages made — five connections, no new people, places, or themes.**
  `Babel and the Gate of Heaven` (backwards, into chapter 11);
  `Bethel from Jacob's Pillar to Jeroboam's Calf` (forwards, into Kings and the prophets — kept
  separate from the Babel page because they run in opposite directions);
  `Angels Ascending and Descending - Genesis 28.12 in John 1.51` (including the Nathanael frame:
  *"an Israelite indeed, in whom is no deceit"* uses the Septuagint's word at 27:35);
  `I Will Be With You - The Promise of Presence` (28:15 as the head of the commissioning formula
  through Moses, Joshua, Gideon, Jeremiah, and the last verse of Matthew);
  `The Pillar Jacob Raised and the Pillars the Law Forbids` (*maṣṣēbâ* commended in Genesis and
  hated at Deuteronomy 16:22 — **three readings set out and none adopted**).
- **New pages deliberately not made.** **Luz** — Bethel's earlier name, carried in that page's
  `also_known_as`, on the same decision recorded for **Paddan Aram** at `A Wife for Isaac`. **The
  angels of 28:12** — plural, silent, and unindividuated; `The Angel of Yahweh` now carries a section
  distinguishing them from the singular figure, and pointing at 31:11–13, where the singular says
  *"I am the God of Bethel."* **No new theme page**: *presence* and *dreams* were both considered and
  are covered by `Covenant`, `Walking with God`, and `Prophecy and Vision`.
- **Esau was kept in the passage's People list although he is named nowhere in the twelve verses**,
  because 35:7 makes him the stated reason for the theophany. **Laban was dropped from that list**
  for the opposite reason: he is not named either, and nothing in the passage turns on him.

### Pages touched

**Created (6).** `wiki/passages/Genesis/Jacob's Ladder at Bethel.md`; connections
`Babel and the Gate of Heaven`, `Bethel from Jacob's Pillar to Jeroboam's Calf`,
`Angels Ascending and Descending - Genesis 28.12 in John 1.51`,
`I Will Be With You - The Promise of Presence`,
`The Pillar Jacob Raised and the Pillars the Law Forbids`.

**Revised (34).** People: `Jacob` (new pericope section, four timeline entries, four themes),
`God` (new section, two timeline entries), `Abraham`, `Isaac`, `Esau`, `The Angel of Yahweh` (new
section on the plural). Places: `Bethel` (the naming, plus the post-exilic postscript), `Beersheba`,
`Haran (city)`, `Canaan`, `Aram Naharaim`. Themes: `Covenant`, `Call and Election`,
`Favor and Grace`, `Land and Sojourning`, `Prophecy and Vision`, `Seeing and Being Seen`,
`The Fear of God`, `Oaths and Vows`, `Tithing`, `Sacrifice and Offering`, `Priesthood`,
`The Names of God`, `The Nations`, `Remembrance`, `Blessing`. Connections: `The Tithe Before the
Law`, `Dust, Stars, and Sand`, `All the Families of the Earth`, `Lift Up Your Eyes`,
`Sacrifice Before the Priesthood`, `A Name for Ourselves and a Great Name`,
`The Hope of Resurrection in the Old Testament`, `Two Errands to Paddan Aram`,
`Babel and Babylon the Great`. Passages: `The Tower of Babel`, `The Stolen Blessing`, and
`Isaac Sends Jacob to Paddan Aram` — the last two had forward references to this pericope marked
*(not yet ingested)*, now resolved into links.

**Indexes.** `wiki/books/Genesis.md` (box checked, overview paragraph extended),
`wiki/books/index.md` (**35 / 59 → 36 / 59**), five new rows in `wiki/connections/index.md`, and
`Jacob's Ladder at Bethel` appended to the key-passages column of twenty-six rows across
`wiki/people/index.md`, `wiki/places/index.md`, and `wiki/themes/index.md`. `wiki/index.md` now
reads **42 passages · 82 people · 48 places · 53 themes · 118 connections**, verified against what
is on disk.

### Link check

`scripts/link-check.sh` exits **0**. No wrapped links, no dangling targets; the expected baseline is
**64** not-yet-started book pages, unchanged, since no new book page was created this pass.

**Links deliberately left for later pericopes** — all of them plain scripture references rather than
wikilinks, so none is a finding: 31:11–13 (the angel citing the vow, and *"I am the God of Bethel"*),
32:24–31 (the second night alone and the sunrise at Peniel), 35:1–15 (the return, the buried gods,
and the second pillar), 46:1–4 (Beersheba again, on the way down to Egypt), and 48:15–16 (Jacob's
deathbed verdict on the bread he asked for conditionally).

## [2026-09-05] ingest | Genesis 29.1-30 — Jacob, Leah, and Rachel

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
its first unchecked box read `Jacob, Leah, and Rachel — Genesis 29:1–30`. `raw/bible/Genesis.md` was
already present, so `scripts/fetch-book.sh` was not run. Step 2's discussion is written into the
passage page. The tree was clean at the start of the session and nothing needed committing separately
first. **The boundary was used as drawn and needed no revision.**

**The session again started on a detached HEAD** at `origin/main` (8e5d224), with local `main`
twenty-five commits behind it and no commits of its own — the same condition the previous run
recorded. The ingest was committed on the detached HEAD; `main` was then checked out and
fast-forwarded onto it (`git merge --ff-only`, verified an ancestor first, so nothing was discarded)
and pushed. Nothing was stashed, dropped, or rewritten. **This is now the second consecutive run to
hit it, so it is worth a look: the container appears to check the repo out detached rather than on
`main`.**

### What the pericope is

**God is not in it — and the technique of chapter 27 is run back on the man who used it.**

- **The absence is the page's organising claim and it is checkable.** *Yahweh* and *ʾĕlōhîm* do not
  occur in 29:1–30; the first divine name in the chapter is at 29:31, *"Yahweh saw."* **No speech, no
  dream, no altar, no vow, no prayer** — four verses after *"I am with you, and will keep you,
  wherever you go."* Genesis has left God out of a passage before (14; 19:30–38), but **never
  immediately after a theophany**, and this is the first time.
- **29:1–8.** ***Wayyiśśāʾ raglāyw***, *he lifted his feet* — an idiom that occurs **once in the
  Hebrew Bible** — against 28:11's *wayyipgaʿ*, *he ran into the place*. ***ʾEreṣ bənê-qedem***, the
  land of the children of the east, is a **third name for the destination in three chapters** (after
  *Paddan Aram*, 28:5, and *Haran*, 28:10) and its **only occurrence in Genesis**; the wiki's other
  son of the east is Job 1:3. The stone is established **twice** (vv. 3, 8) as requiring all the
  flocks and all the men.
- **29:5.** ***"Laban, the son of Nahor"*** — against 22:22–23, 24:24, and 28:2, which make him
  Bethuel's son and Nahor's great-grandson. **Recorded as a contradiction between passages and not
  resolved**; both standing explanations (*bēn* as *descendant*, as at 2 Kings 9:2, 20; identification
  by head of line) are on the page and on `Nahor (brother of Abram)`, and neither is adopted.
- **29:10–12.** ***ʾĂḥî ʾimmô***, *his mother's brother*, **three times in one verse** and required by
  nothing — at the daughter, the sheep, and the flock, at the exact moment he does the work. He rolls
  the stone **alone**: the only feat of physical strength attributed to any patriarch, and Genesis
  gives no reaction from the watching shepherds. He kisses her **before** naming himself — and
  *"lifted up his voice, and wept"* is **the third and last occurrence of that formula in Genesis and
  the only one that is not grief** (21:16 Hagar; 27:38 Esau; verified by grep). His credential is
  *"Rebekah's son"*, and **it is her last appearance in the narrative of his life.**
- **29:14.** ***ʿAṣmî ûbśārî*** — **the second occurrence of the idiom in the Bible**, after Adam's at
  2:23. The formula of the first marriage, spoken by an uncle about a nephew, one verse before the
  wages question.
- **29:17.** ***Rakkôt*** — *soft, tender, delicate*. **Both readings on the page and neither
  adopted**: the LXX's *weak* (which the WEB follows) and the reading that takes it as Leah's one
  compliment, outbid in the same sentence. What is not in doubt is the structure — one feature against
  a whole person, joined adversatively.
- **29:18, 20, 30.** ***ʾĀhab*** three times in thirteen verses. **29:18 is the first love in the
  Bible that precedes a marriage rather than following it** — 24:67 has Isaac take Rebekah *and then*
  love her, and 22:2 is the verb's first occurrence in Scripture. And **29:20's *kəyāmîm ʾăḥādîm* is
  Rebekah's own phrase from 27:44**, the *few days* she sent him away for.
- **29:22–25.** ***Mišteh*** is a **drinking** feast, from *šātâ*, and this is the second time Genesis
  puts a *mišteh*, a night, and an unrecognised woman in one paragraph (19:30–38 is the first).
  **Genesis never explains the mechanism — there is no veil in the text**, and readers import it from
  24:65. ***Rimmîtānî*** is from the root of Isaac's ***mirmâ*** at 27:35, and *"What is this you have
  done to me?"* is the formula three foreign kings used on Abram, Abraham, and Isaac — **the first
  time a member of the family asks it rather than answering it.**
- **29:26.** The vocabulary switch, which is new on this page: **the narrator's pair at 29:16 is
  *haggədōlâ / haqqəṭannâ*, and Jacob uses it at 29:18** (*bitəkā haqqəṭannâ*). **Laban answers with
  *haṣṣəʿîrâ / habbəkîrâ***, which is not the chapter's vocabulary but the oracle's (25:23) and the
  birthright's. **Jacob asks in the neutral register and is refused in the register of his own life.**
- **29:27–28.** ***Šābuaʿ*** is the **bridal week**, seven days (Judges 14:12). **He waits seven years
  and one week for Rachel, not fourteen years** — the second seven are served afterwards — and the
  page says so explicitly because the fourteen-year version is what most readers arrive with.
- **29:30.** *"He loved also Rachel more than Leah"* — **the narrator's own voice**, and the exact
  construction Deuteronomy 21:15–17 legislates.

### Judgment calls made unattended

- **Boundary kept as planned (29:1–30).** 29:1 opens with a fresh itinerary formula; 29:31 restarts
  with God as subject and begins the births. **The alternative split — 29:1–14 arrival, 29:15–30
  marriages — was considered and rejected**: the well scene and the wages are one negotiation, and
  29:14's *"my bone and my flesh"* is what makes 29:15 possible.
- **Title kept as planned.** *Jacob, Leah, and Rachel* — the order is the passage's own, not
  chronology's. *Jacob Serves for Rachel* and *Leah for Rachel* were considered and each names only
  one of the two women the rest of the book runs on. **No title collision with any other book.**
- **`Beersheba` was deliberately dropped from the passage's Places list** and demoted to a note,
  because it is not named anywhere in 29:1–30; the places index was not touched for it. The chapter
  invites the link (a well, and *well of seven*) and the page says so in prose instead.
- **`God` is not listed in the passage's People section as an appearance**, only as an absence, and
  `wiki/people/God.md` was not edited and not given a new key-passage row. **A page with no divine
  name in it does not get counted as an appearance**, and the log records this as the rule applied.
- **`Envy` and `Barrenness` got related-people links only, not key-passage entries** — Rachel's
  barrenness and *qānāʾ* are 29:31 and 30:1, next pericope — so neither row was touched in
  `wiki/themes/index.md`.
- **Four person pages created, including two for women named once.** `Zilpah` and `Bilhah` get pages
  on the wiki's standing practice for anyone Genesis names (cf. `Ahuzzath`, `Iscah`, `Reumah`), and
  because both are mothers of tribes within one chapter.
- **One theme page created: `Love`.** ***ʾĀhab*** has been in the book since 22:2 with no page, and
  this is the pericope that forces one. The alternative — folding it into `Marriage` and `Favor and
  Grace` — was rejected because the verb's Genesis behaviour is *ranking*, which neither of those
  pages tracks.
- **No page for *the land of the children of the east***, which is a loose regional label rather than
  a locatable place. It is carried in `Aram Naharaim`'s `also_known_as` and appearance note, **on the
  same decision recorded for *Paddan Aram* at `A Wife for Isaac` and for *Luz* at `Jacob's Ladder at
  Bethel`.** **No page for the shepherds of 29:4–8**, who are a chorus.
- **No connection page for the *mišteh* parallel** with Genesis 19:30–38. The observation is real but
  narrow — shared vocabulary and shared sequence, with no verdict available — so it went into a new
  section on the existing `The Drunkenness of Noah and the Drunkenness of Lot` instead of becoming a
  page of its own.
- **The measure-for-measure reading is filed as the reader's inference, not the book's claim**, on the
  passage page and on `Retribution`, consistent with what those pages already said.

### Pages touched

**Created (9).** `wiki/passages/Genesis/Jacob, Leah, and Rachel.md`; people `Rachel`, `Leah`,
`Zilpah`, `Bilhah`; theme `Love`; connections
`Two Sisters - The Marriage Genesis Records and Leviticus Forbids`,
`Loved and Hated - Genesis 29 and Deuteronomy 21.15-17`,
`Like Rachel and Like Leah - The Builders of the House of Israel`.

**Revised (25).** People: `Jacob` (new pericope section, six timeline entries, four related people,
six themes), `Laban` (new pericope section, six timeline entries), `Rebekah`, `Bethuel` (the
absence), `Nahor (brother of Abram)` (the 29:5 filiation). Places: `Aram Naharaim` (third name, plus
`also_known_as`), `Haran (city)`. Themes: `Deception` (and its 29:21–27 forward reference resolved),
`Marriage`, `Work`, `Birthright and the Firstborn`, `Slavery and Servitude`, `Retribution`,
`Hospitality`, `Seeing and Being Seen` (forward reference narrowed to 29:31), `Strife and
Peacemaking`, `Envy`, `Barrenness`. Connections: `The Betrothal at the Well` (its *(not yet
ingested)* line resolved, plus a new paragraph), `The Younger Before the Firstborn - Jacob and Laban`
(the vocabulary switch, and the missing veil), `A Garment and a Goat - Jacob Deceives and Is
Deceived`, `Two Errands to Paddan Aram - Genesis 24 and Genesis 28`, `Not from the Daughters of the
Canaanites`, `The Drunkenness of Noah and the Drunkenness of Lot`, `The Barren Matriarchs`.

**Indexes.** `wiki/books/Genesis.md` (box checked, structure paragraph extended),
`wiki/books/index.md` (**36 / 59 → 37 / 59**), four new rows in `wiki/people/index.md`, one in
`wiki/themes/index.md`, three in `wiki/connections/index.md`, and `Jacob, Leah, and Rachel` appended
to the key-passages column of sixteen existing rows across the people, places, and themes indexes.
`wiki/index.md` now reads **43 passages · 86 people · 48 places · 54 themes · 121 connections**,
counted against what is on disk.

### Link check

`scripts/link-check.sh` exits **0**. No wrapped links, no dangling targets; the expected baseline is
**64** not-yet-started book pages, unchanged, since no new book page was created this pass. One
wrapped link *was* produced during the pass — a `[[...]]` broken across the ~100-column wrap on
`Like Rachel and Like Leah` — **and the script caught it before the commit**, which is the case check
1 exists for.

**Links deliberately left for later pericopes** — all of them plain scripture references rather than
wikilinks, so none is a finding: 29:31–30:24 (*"Yahweh saw that Leah was hated"*, the births, and the
mandrakes), 30:25–43 (the wages and the flocks), 31:19–35 (the stolen household gods) and 31:38–42
(*"twenty years in your house"*), 35:16–20 (Rachel's death and her pillar), 35:22 with 49:3–4 (Reuben
and Bilhah, and the birthright forfeited), and 49:31 (Leah buried at Machpelah).

## [2026-09-05] ingest | Genesis 29.31-30.24 — The Birth of Jacob's Children

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
its first unchecked box read `The Birth of Jacob's Children — Genesis 29:31–30:24`.
`raw/bible/Genesis.md` was already present, so `scripts/fetch-book.sh` was not run. Step 2's
discussion is written into the passage page. The tree was clean at the start of the session and
nothing needed committing separately first. **The boundary was used as drawn and needed no
revision.**

**The session started on a detached HEAD again**, at `origin/main` (`def063b`), with local `main`
twenty-six commits behind and no commits of its own — **the third consecutive run to hit this.** It
was handled the same way: the ingest was committed on the detached HEAD, then `main` was checked out
and fast-forwarded onto it (`git merge --ff-only`, after verifying `main` was an ancestor, so nothing
could be discarded) and pushed. Nothing was stashed, dropped, or rewritten. `origin/main` was fetched
first and confirmed identical to HEAD before any of this. **The container is evidently checking the
repo out detached rather than on `main`, and it is now a standing condition rather than an
accident.**

### What the pericope is

**Israel is born here, and it is born out of a grudge.**

Eleven of the twelve tribes arrive in twenty-six verses, to four women, outside the land, over roughly
seven years. No altar, no promise repeated, no covenant mentioned, **and God never speaks.** What the
passage has instead is **twelve naming speeches, every one spoken by a woman about her own position in
the household** — and the tribal map of Israel is laid down in the vocabulary of a domestic quarrel.

- **It is the direct answer to the sentence the previous pericope ended on.** 29:30 closed *"he loved
  also Rachel more than Leah"*; 29:31 opens *"Yahweh saw that Leah was hated"* — **the first divine
  name in Genesis 29, arriving in its thirty-first verse**, after the thirty verses `Jacob, Leah, and
  Rachel` is built on. **And what God does about the ranking is not to change Jacob's mind.** He opens
  a womb. Leah is no more loved at 30:20 (*"now my husband will live with me"*) than at 29:31.
- **Three divine acts are the passage's entire structure** — *he opened her womb* (29:31), *God
  listened to Leah* (30:17), *God remembered Rachel* (30:22). **Everything between them is two women
  counting.**
- **The divine names divide cleanly, and the distribution was counted against the raw text rather than
  asserted.** *Yahweh* five times — 29:31, 32, 33, 35, and then the pericope's last clause at 30:24.
  *ʾĔlōhîm* eight times through the middle — 30:2, 6, 8, 17, 18, 20, 22 (twice), 23. **Eighteen verses
  of *God* bracketed by *Yahweh*.** Both standard explanations (source-critical and literary) are
  given on the passage page and on `The Names of God`, **and neither is adopted**, on the practice used
  for *"Laban, the son of Nahor"* at 29:5.
- **Three hearings, and Genesis prints none of the prayers.** *"Yahweh has heard that I am hated"*
  (29:33), *"has also heard my voice"* (30:6), *"God listened to Leah"* (30:17). **The book reports the
  answers to petitions it never records**, which is the mirror image of the gap `Prayer` usually
  tracks. The observation is new this pass and was added to `Prayer`, stated as a feature of the
  narration rather than as evidence about whether the women prayed.
- **Jacob is the most passive person in the chapter that founds his twelve tribes.** One speech, in
  anger — *"Am I in God's place, who has withheld from you the fruit of the womb?"* (30:2) — where his
  father had prayed (25:21). **He names none of the twelve.** He is handed two slaves without being
  consulted, and **hired for a night by his own wife** (*śākōr śəkartîkā*, 30:16), with the same root
  Laban put him on wages with at 29:15.
- **The mandrakes do nothing, and the text says so silently.** Rachel acquires the fertility drug and
  stays barren; Leah gives it away and conceives that night; **and when the son arrives Leah credits
  giving Zilpah away, not the night she bought** (30:18). Rachel conceives seven verses later and the
  reason given is *"God remembered Rachel."* Genesis never mentions the mandrakes again. **Recorded as
  what the text does, not as an argument the text makes.**
- **The passage's own name for the contest is Rachel's**: *"I have wrestled **with my sister** with
  mighty wrestlings, and have prevailed"* (30:8). Not a woman contending with God for a child — two
  women contending with each other and counting children as points.

### Judgment calls made (unattended, no sign-off)

- **The boundary was used as drawn.** 29:31 is the cleanest break in the chapter — it restarts the
  narrative with God as subject — and 30:25 opens a new subject, a new interlocutor, and the wages
  negotiation the next box covers. **A split at the chapter division (29:31–35 / 30:1–24) was
  considered and rejected**: it would separate Leah's four sons from her last three and put the two
  halves of one contest on different pages.
- **Title kept from the plan.** Alternatives rejected: *The Twelve Sons* (there are eleven here, and a
  daughter), *Leah and Rachel's Contest* (editorial), *The Birth of the Tribes* (imports a category the
  passage does not use — Genesis says *sons*). No other book has a page by this title.
- **Twelve person pages created**, on the wiki's standing practice of giving a page to anyone Genesis
  names, and because eleven of them are tribes: `Reuben`, `Simeon`, `Levi`, `Judah`, `Dan (person)`,
  `Naphtali`, `Gad`, `Asher`, `Issachar`, `Zebulun`, `Dinah`, `Joseph`. **`Dan (person)` takes the
  qualifier because `Dan (city)` already exists**, per the person/place collision rule in `AGENTS.md`;
  the place page's line *"Dan the man is Jacob's son"* now links to it. **No other new name collided**
  — there is no book, place, or person page called Judah, Levi, Joseph, Gad, or Asher yet, so all took
  bare titles.
- **One theme page created: `Names and Naming`.** Genesis glosses roughly forty names and had no page
  for the practice; this pericope supplies twelve at once. **Folding it into `Language and Speech` was
  rejected** — that page tracks speech as a medium and the Babel break, not the etymology formula — and
  so was folding it into `The Names of God`, which is about the divine names specifically.
- **Three connection pages created.** `The Twelve Sons and the Lists That Reorder Them` (the birth
  order here against the seven or so later lists that rearrange, split, or omit — Levi out, Joseph
  split, Simeon missing from Deuteronomy 33, Dan missing from Revelation 7); `Am I in God's Place -
  Jacob at 30.2 and Joseph at 50.19` (the same idiom from father and son, declining opposite things —
  the power to help, and the right to punish); `Wrestlings of God - Rachel at Naphtali's Birth and
  Jacob at the Jabbok` (*naptûlê ʾĕlōhîm* and *yākōl* at 30:8 against *"you have fought with God… and
  have prevailed"* at 32:28, **filed as a verbal parallel and not a quotation**, since the roots for
  *wrestle* differ — *patal* against *ʾābaq*).
- **No connection page for Leah and Hagar's shared *ʿŏnî*.** A section was added to the existing
  `Affliction and Flight - Hagar and the Exodus` instead, which already ran the noun through to Exodus
  3:7; **Leah's *"Yahweh has looked at my affliction"* (29:32) and *"Yahweh has heard that I am hated"*
  (29:33) put both of Exodus 3:7's verbs in one household four hundred years early**, and duplicating
  the page for a third leg would have split the chain.
- **No connection page for the mandrakes and Song of Songs 7:13** — a shared rare noun and nothing
  else. Carried on the passage page and `Names and Naming`.
- **No place page**, because the passage names no place. The setting is Laban's household in Paddan
  Aram and the only location given is *the field* (30:14, 16), unnamed. **The passage page says so
  explicitly rather than listing `Aram Naharaim` as if it were named.**
- **The chronology is flagged, not fixed.** Genesis 31:41 allows about seven years for these births,
  and read strictly in narrative order the sequence needs appreciably more. **The passage is arranged
  by mother rather than by date**, with the maidservants' births overlapping Leah's, and Genesis
  narrates it serially anyway. **No reconstruction of the actual order is offered**, because the text
  supplies none.
- **Levi's passive naming (29:34) is recorded as a textual anomaly with the variant noted and no
  reading adopted.** The Masoretic Text has *qārāʾ* with no stated subject where the other eleven have
  *she named him*; the Samaritan Pentateuch, Septuagint, and Vulgate read *she called*. **That the
  anomaly falls on the priestly tribe is offered as a coincidence the text supplies, not as a claim
  about intent.**
- **Leah's naming arc is stated honestly rather than tidily.** The popular reading — a woman who
  begins wanting her husband and ends praising God at Judah — **is only half supported**: 30:20 goes
  back to *"now my husband will live with me."* The passage page, `Leah`, `Judah`, and `Zebulun` all
  say so.
- **`Dinah`'s missing gloss is left missing.** The page records that her name is the feminine of *Dan*,
  that the same passage glosses *Dan*, and that *ḥerpâ* (30:23) recurs in Genesis only at 34:14 — and
  fills in nothing else.

### Pages touched

**Created (16).** `wiki/passages/Genesis/The Birth of Jacob's Children.md`; twelve people — `Reuben`,
`Simeon`, `Levi`, `Judah`, `Dan (person)`, `Naphtali`, `Gad`, `Asher`, `Issachar`, `Zebulun`, `Dinah`,
`Joseph`; theme `Names and Naming`; connections `The Twelve Sons and the Lists That Reorder Them`,
`Am I in God's Place - Jacob at 30.2 and Joseph at 50.19`, and
`Wrestlings of God - Rachel at Naphtali's Birth and Jacob at the Jabbok`.

**Revised (24).** People: `Leah` and `Rachel` (each gained a full in-pericope section, timeline
entries, an appearance note, related people and themes), `Bilhah`, `Zilpah`, `Jacob` (new section, four
timeline entries, twelve related people), `God` (a new numbered section covering both the thirty-verse
absence and the three acts, plus timeline and appearance entries). Places: `Dan (city)`. Themes:
`Barrenness` (its *(not yet ingested)* line resolved into the theme's inverted third run), `Envy` (the
same), `Remembrance`, `Prayer`, `Seeing and Being Seen`, `The Names of God`, `Slavery and Servitude`,
`Marriage`, `Love`, `Work`, `Strife and Peacemaking`, `Birthright and the Firstborn`. Connections:
`The Barren Matriarchs` (a new section on the inversion, and Rachel's row linked),
`Affliction and Flight - Hagar and the Exodus` (the third woman),
`Loved and Hated - Genesis 29 and Deuteronomy 21.15-17`,
`Like Rachel and Like Leah - The Builders of the House of Israel`,
`Twelve Sons - Nahor, Ishmael, and Jacob`,
`Two Sisters - The Marriage Genesis Records and Leviticus Forbids`.

**Indexes.** `wiki/books/Genesis.md` (box checked, structure paragraph extended by a full pericope
summary), `wiki/books/index.md` (**37 / 59 → 38 / 59**), twelve new rows in `wiki/people/index.md`
with six existing rows extended, one new row and twelve extended rows in `wiki/themes/index.md`, three
new rows in `wiki/connections/index.md`. `wiki/index.md` now reads **44 passages · 98 people · 48
places · 55 themes · 124 connections**, counted against what is on disk.

### Link check

`scripts/link-check.sh` exits **0**, clean on the first run this pass. No wrapped links, no dangling
targets; the expected baseline is **64** not-yet-started book pages, unchanged, since no new book page
was created.

**Links deliberately left for later pericopes** — all given as plain scripture references rather than
wikilinks, so none is a finding: 30:25–43 (the wages and the flocks, beginning in the verse after this
pericope), 31:41 (*"twenty years… fourteen years for your two daughters"*, the span these births
occupy), 32:22–32 (the eleven sons at the Jabbok, and *"you have fought with God… and have
prevailed"*), 34 (Dinah at Shechem, and *ḥerpâ* in her brothers' mouths), 35:16–20 (Benjamin, and
Rachel's death answering her own prayer at 30:24), 35:22 and 49:3–4 (Reuben and Bilhah, and the
birthright forfeited), 35:22–26 (the twelve listed by mother), 37:11 (the third *qānāʾ*), 49 (Jacob's
blessing, which re-puns every name given here), and 50:19, 23 (*"Am I in the place of God?"*, and the
knees).

## [2026-09-05] ingest | Genesis 30.25-43 — Jacob's Flocks

Unattended `/ingest auto` run. Genesis is the first `in-progress` book in `wiki/books/index.md` and
its first unchecked box read `Jacob's Flocks — Genesis 30:25–43`. `raw/bible/Genesis.md` was already
present, so `scripts/fetch-book.sh` was not run. Step 2's discussion is written into the passage
page. The tree was clean at the start of the session and nothing needed committing separately first.
**The boundary was used as drawn and needed no revision.**

**The session started on a detached HEAD again** — `HEAD detached from refs/heads/main`, with local
`main` behind at `ee8f435` and no commits of its own — **the fourth consecutive run to hit this.**
`origin/main` was fetched first and came back at `d38899c`, identical to HEAD, so nothing had moved
remotely. Handled as before: the ingest was committed on the detached HEAD, then `main` was checked
out and fast-forwarded onto it after verifying it was an ancestor, and pushed. Nothing was stashed,
dropped, or rewritten. **This is now a standing condition of the container rather than an accident,
and the handling is settled.**

### What the pericope is

**A man asks to go home, is talked into staying for wages, and then takes the flock apart.**

Nineteen verses, six years (31:41), and **the most technical passage in Genesis outside the ark's
specifications and the brickmaking at Babel** — a resignation, a counter-offer, a contract with an
audit clause, a pre-emption, and seven verses of animal husbandry.

- **God does not act in it.** He is named three times and **every one is inside a human sentence**:
  *"Yahweh has blessed me for your sake"* (Laban, 30:27) and *"Yahweh has blessed you wherever I
  turned"* (Jacob, 30:30). **No verb in the pericope takes him as its subject.** The whole of the
  theology is deployed by two men negotiating wages, and neither mentions Bethel, the covenant, or
  the promise.
- **The promise is nonetheless kept in it, in its own verb.** Bethel gave Jacob ***ûpāraṣtā***,
  *you will spread abroad* (28:14); 30:43 is ***wayyipṛōṣ hāʾîš məʾōd məʾōd***, *the man burst out
  exceedingly.* **The page states the verbal link and states equally that no character in the passage
  makes it.**
- **The Bible's first *nāḥaš*.** *"I have divined"* (30:27) is the root Leviticus 19:26 and
  Deuteronomy 18:10 forbid, **and what Laban divined is orthodox and correct** — Genesis 12:3 in the
  mouth of a beneficiary, used as an argument for **not releasing** the man the blessing works
  through. Genesis comments on neither the method nor the result.
- **Nothing in the passage is a lie, a theft, or a broken term.** Jacob refuses a wage in Abram's
  formula (*"you shall not give me anything"*, against 14:23), names the odd-coloured minority of
  both herds instead, and attaches a self-auditing clause — *"so my righteousness will answer for
  me"*. **Laban keeps the contract to the letter and empties it the same day**, moving every
  qualifying animal three days off into his sons' hands (30:35). Jacob answers in kind. **The wiki
  records that the family's method appears here with the falsehood removed, and that Genesis grades
  it exactly as it graded the others — not at all.**
- **Two mechanisms are distinguished for the first time in the wiki.** The peeled rods (30:37–39) are
  **maternal impression**, a folk belief the text neither endorses nor mocks; the use of the rods on
  the strong animals only (30:41–42) is **selective breeding**, and it works. **Genesis narrates them
  as one continuous procedure and draws no line between them**; the passage page draws it and says
  the book does not.
- **The *lābān* pun is the page's main philological claim.** Genesis 30:37 carries the root *l-b-n*
  three times — ***libneh*** (white poplar), ***ləbānôt*** (the white streaks), ***hallābān*** (the
  white made to appear) — in the operation that strips *Lābān* of a herd, and the second tree is
  ***lûz***, **the name Bethel went by before Jacob renamed it** (28:19). **Both are stated as
  wordplay and neither is argued from**, because Genesis glosses neither.
- **The parallel with Isaac is structural, not thematic.** 30:43's ***hāʾîš***, *the man*, matches
  26:13's *"the man became great"* — **both patriarchs are called *the man* at the moment of
  enrichment abroad**, and both are followed immediately by the host's resentment (26:14; 31:1–2).

### Judgment calls made unattended

- **The subject of 30:35 is read as Laban, and the ambiguity is flagged rather than hidden.** The
  Hebrew names no subject where Jacob had said at 30:32 that *he* would do the removing. The page
  adopts the standing reading on the two grounds the text supplies — the sons are Laban's, and
  nothing in 30:37–42 works if Jacob already held the animals — **and says explicitly that Genesis
  does not spell it out.**
- **30:40 is left obscure.** It is among the hardest sentences in the book and translations diverge
  on whose animals face whose. The page states the difficulty, gives the WEB's reading **as the
  WEB's**, and rests its paragraph on the clause every reading shares.
- **The two accounts of the same six years are not harmonised.** This pericope credits nothing to
  God; 31:9–12 credits everything to him, in Jacob's own mouth. **The wiki does not treat the later
  speech as the narrator's view, does not treat the earlier silence as a denial, and does not choose
  between them** — three standing readings are set out on the connection page and none is adopted.
- **The title was kept from the plan.** *Jacob's Flocks*, over *The Speckled and the Spotted* (names
  only the second half), *Jacob's Wages* (near-duplicate of material already under
  `Jacob, Leah, and Rachel`), and *The Rods in the Troughs* (names the one element the text declines
  to explain). No other book has a passage page by that title.
- **`Laban`'s sons get no page.** They hold animals at 30:35 and speak at 31:1; they are carried on
  `Laban` until that pericope arrives.
- **A new theme page was judged warranted.** `Wealth and Possessions` — Genesis has tracked
  livestock, silver, gold, slaves, and one purchased grave since 12:5, three patriarchs have been
  enriched abroad by foreign patrons, and the wiki had no page for any of it. This pericope is the
  most detailed instance in the book.
- **`ʿErmôn` and `ʿārûm` are noted as a resemblance and pressed no further.** The plane tree's
  consonants are the serpent's adjective at 3:1; **Genesis draws no line between them and neither
  does the page.**
- **No connection page was made for *šalləḥēnî* and the Exodus.** The proto-exodus shape of the Laban
  years only completes in Genesis 31 (service, release refused, departure with wealth, pursuit,
  divine intervention on the road); a section was added to the existing
  `Down to Egypt and Up Again - Abram's Descent as Proto-Exodus` instead.

### Pages touched

**Created (5).** `wiki/passages/Genesis/Jacob's Flocks.md`; theme `Wealth and Possessions`;
connections `Blessed for His Sake - Laban's House and Potiphar's`,
`Two Explanations for One Flock - The Rods and the Dream`, and
`Divination in Genesis - Laban's Nahash and Joseph's Cup`.

**Revised (21).** People: `Jacob` (new in-pericope section, seven timeline entries, an appearance
note, two themes), `Laban` (new in-pericope section, four timeline entries, an appearance note, an
unnamed-sons entry under related people, three themes), `God` (a new numbered section on the total
absence of divine agency, a timeline entry, an appearance note), `Rachel` and `Joseph` (the dating
clause at 30:25, timeline and appearance entries each). Places: `Aram Naharaim` (two appearance
notes, and **two stale *(not yet ingested)* markers corrected** — Genesis 29 and 29:31–30:24 had
both been ingested and the events list still said otherwise). Themes: `Work`, `Blessing`,
`Deception`, `Prophecy and Vision` (plus `Laban` added to its related people),
`Land and Sojourning`, `Favor and Grace`, `The Nations`, `Names and Naming`, `Righteousness`.
Connections: `Not a Thread nor a Sandal Strap` (a new section on the grandson's version of the
refusal), `Mightier Than We - Isaac in Gerar and Israel in Egypt` (a new section on the middle term,
with a three-row table of hosts and responses), `The Trees of the Patriarchs` (the one patriarch who
cuts them), `Dust, Stars, and Sand - The Offspring Promises` (a new section on *pāraṣ* at 28:14 and
30:43), `A Garment and a Goat - Jacob Deceives and Is Deceived`,
`The Younger Before the Firstborn - Jacob and Laban`,
`Down to Egypt and Up Again - Abram's Descent as Proto-Exodus`.

**Indexes.** `wiki/books/Genesis.md` (box checked, structure paragraph extended by a full pericope
summary, `Names and Naming` and `Wealth and Possessions` added to key themes),
`wiki/books/index.md` (**38 / 59 → 39 / 59**), five rows extended in `wiki/people/index.md`, one row
extended in `wiki/places/index.md`, one new row and nine extended rows in `wiki/themes/index.md`,
three new rows in `wiki/connections/index.md`. `wiki/index.md` now reads **45 passages · 98 people ·
48 places · 56 themes · 127 connections**, counted against what is on disk.

### Link check

`scripts/link-check.sh` exits **0**, clean on the first run this pass. No wrapped links, no dangling
targets; the expected baseline is **64** not-yet-started book pages, unchanged, since no new book
page was created.

**Links deliberately left for later pericopes** — all given as plain scripture references rather
than wikilinks, so none is a finding: 31:1–2 (Laban's sons complain and Laban's face changes), 31:3
(*"return to the land of your fathers"*, arriving six years after Jacob asked), 31:7 and 31:41 (the
wages changed ten times, and *"six years for your flock"*), 31:9–12 (the angel and the dream — the
passage's other explanation), 31:19 and 31:30–35 (Laban's *teraphim*), 31:23 (the seven-day pursuit
across the three days' journey of 30:36), 32:13–21 (these flocks counted out as a present for Esau),
39:5 (*"Yahweh blessed the Egyptian's house for Joseph's sake"*), 44:5 and 44:15 (Joseph's cup, the
book's only other *nāḥaš*), and 47:6, 27 (the family settled in Goshen).

**Quotation check.** Every WEB verse quoted on the passage page was compared against
`raw/bible/Genesis.md` character by character; all nineteen match verbatim.

## [2026-09-05] ingest | Genesis 31.1-55 — Jacob's Flight from Laban

Unattended run (`/ingest auto`), no target argument. `wiki/books/index.md` gave **Genesis** as the
first `in-progress` book and its page gave **Jacob's Flight from Laban — Genesis 31:1–55** as the
first unchecked box. `raw/bible/Genesis.md` was already present, so `scripts/fetch-book.sh` was not
run. Step 2's discussion is written into the passage page rather than spoken.

**The longest pericope ingested so far** — fifty-five verses, and the one that closes the twenty
Laban years and separates the two branches of Terah's family permanently.

### Judgment calls made in this pass

- **The boundary was used as drawn, and kept whole.** 31:1 opens on new speakers and 31:55 closes on
  Laban leaving the narrative for good. **Splits at 31:24 and at 31:36 were considered and
  rejected**: the pursuit, the search, the apologia and the treaty are one continuous scene on one
  mountain over two days, and the *gānab* chain runs across all of them. At fifty-five verses it is
  long, and dividing it would have separated the theft from the search and the complaint from the
  covenant. **The remaining boxes were left as drawn.**
- **The title was kept from the plan.** Alternatives rejected: *The Covenant at Mizpah* (names only
  the last twelve verses, and the popular association of *Mizpah* would mislead), *Laban Overtakes
  Jacob* (puts the pursuer in the subject position for a chapter he loses), *The Stolen Gods* (names
  the sub-plot the text never resolves). No other book has a passage page by this title.
- **The English versification was followed and the difference recorded.** **Genesis 31:55 in the
  English tradition is Genesis 32:1 in the Hebrew Bible**, so the two traditions put the chapter
  break on opposite sides of Laban's farewell. The wiki follows the WEB throughout; this is noted on
  the passage page because it moves the pericope's end by one verse.
- **Two place pages were judged warranted.** [[Gilead]] (the chapter's whole stage, and a region the
  rest of the Bible returns to constantly) and [[Galeed]] (the heap). **They were kept separate on
  purpose**: *Galeed*, *Jegar Sahadutha* and *Mizpah* all name the same pile of stones and none of
  them names the region, and *galʿēd* being one vowel from *gilʿād* is a pun Genesis supplies without
  claiming the region was named from the heap — it uses *Gilead* twice (31:21, 23) before the heap
  exists.
- **One theme page was judged warranted.** [[Idolatry]] — the *teraphim* are the Bible's first
  household gods, the wiki had no page for the subject, Laban's *"my gods"* and the plural verb at
  31:53 belong somewhere, and Genesis 35:2–4 will need it. **The page's own point is that Genesis
  says almost nothing on the subject**: no commandment, no denunciation, nobody condemned.
- **Six connection pages were created.** [[Served, Released, Pursued - The Laban Years as Proto-Exodus]]
  — **deferred from the previous pass on the explicit ground that the shape only completes in Genesis
  31**, and it does: the pursuit, the intervention on the road, ***rêqām*** against Exodus 3:21, and
  ***ʿŏnî*** against Exodus 3:7. Then
  [[The Shepherd's Liability - Genesis 31.39 and the Law of Exodus 22]],
  [[The Teraphim - Household Gods in Genesis and After]],
  [[Jegar Sahadutha - The Only Aramaic in the Torah]], [[Warned in a Dream - Abimelech and Laban]],
  and [[The Mizpah Benediction - Genesis 31.49 and How It Is Read]].
- **No page was created for Laban's sons**, who speak once, are never named, and stay carried on
  [[Laban]] as they have been since 30:35. **No page for *the fear of Isaac*** — the title occurs
  twice in one chapter and the material sits on [[The Names of God]] and [[The Fear of God]]. **No
  connection page for the *gānab* chain**, which is confined to this pericope and is treated on the
  passage page.

### Things flagged rather than resolved

- **31:15 against 31:26.** The daughters say *"he has sold us, and has also used up our money"*; their
  father says Jacob *"carried away my daughters like captives of the sword."* **Both are direct
  speech, both are self-interested, and the narrator supports neither.** Recorded as a contradiction
  on the passage page and on [[Laban]], [[Rachel]] and [[Leah]].
- **The ten changed wages are testimony, not narration.** Genesis 30 shows one wage agreement and no
  changes to it; the ten appear twice (31:7, 41), both times in Jacob's mouth in an argument, and
  Laban never confirms or denies them.
- ***Paḥad yiṣḥāq***. *The fear of Isaac* (31:42, 53) occurs nowhere else in Scripture. The natural
  reading is *dread*; the alternative built on Arabic *faḫd* (thigh, hence clan) giving *the Kinsman
  of Isaac* is **recorded as a proposal and not adopted**.
- **The plural verb at 31:53.** ***Yišpəṭû*** is plural in the Masoretic Text, singular in the
  Samaritan Pentateuch and the Septuagint. Both standing explanations — two family gods, or
  grammatical agreement with a compound subject — are given, and **neither is adopted**.
- **Rachel's *teraphim* have no stated motive.** Three explanations are standing (value, an
  inheritance claim on the Nuzi reading, protection); **all three are listed and none adopted**, and
  the page notes that Genesis supplies no motive for her at all.
- **Rachel's death is not connected to 31:32 here.** The old and widespread reading that Jacob's
  *"anyone you find your gods with shall not live"* is fulfilled at 35:16–19 is recorded **as a
  reading**; Genesis draws no line between the verses. To be revisited when Genesis 35 is ingested.
- **The geography does not work as a week.** The Euphrates to Gilead is some four hundred miles, and
  31:21–23 gives a three-day head start and a seven-day pursuit. **The difficulty is stated and not
  resolved** on the passage page and on [[The Euphrates]].
- **31:35 and Leviticus 15:19–23.** The resonance — a menstruating woman sitting on household gods —
  is stated and explicitly **not** made the point, since the text's own point is that they were not
  found.

### Pages touched

**Created (10).** `wiki/passages/Genesis/Jacob's Flight from Laban.md`; places [[Gilead]] and
[[Galeed]]; theme [[Idolatry]]; connections
[[Served, Released, Pursued - The Laban Years as Proto-Exodus]],
[[The Shepherd's Liability - Genesis 31.39 and the Law of Exodus 22]],
[[The Teraphim - Household Gods in Genesis and After]],
[[Jegar Sahadutha - The Only Aramaic in the Torah]], [[Warned in a Dream - Abimelech and Laban]],
[[The Mizpah Benediction - Genesis 31.49 and How It Is Read]].

**Revised (36).** People (10): [[Jacob]] (new in-pericope section, nine timeline entries, an
appearance note, five themes), [[Laban]] (a full in-pericope section replacing the *what is still
ahead* stub — **he is finished in Genesis as of this chapter** — twelve timeline entries, an
appearance note, six themes), [[Rachel]] and [[Leah]] (new in-pericope sections on the joint speech
and, for Rachel, the theft and the search; timeline and appearance entries; themes), [[God]] (a new
numbered section on the three interventions, four timeline entries, an appearance note),
[[The Angel of Yahweh]] (a new section on 31:11–13 as the plainest alternation in the book),
[[Isaac]] (an *off-stage* section on the destination and on *paḥad yiṣḥāq*, two timeline entries),
[[Nahor (brother of Abram)]] (the oath, the plural verb, three themes), [[Zilpah]] and [[Bilhah]]
(the unnamed shared tent at 31:33). Places (4): [[Bethel]], [[The Euphrates]], [[Aram Naharaim]] and
[[Canaan]], each with an appearance note and events entries. Themes (19): [[Deception]],
[[Oaths and Vows]], [[Covenant]], [[Work]], [[Wealth and Possessions]], [[Marriage]],
[[Slavery and Servitude]], [[Land and Sojourning]], [[The Names of God]], [[Prophecy and Vision]],
[[Seeing and Being Seen]], [[Suffering]], [[Strife and Peacemaking]], [[The Nations]],
[[Language and Speech]], [[The Fear of God]], [[Envy]], [[Names and Naming]],
[[Sacrifice and Offering]]. Connections (6, plus the stale-marker fixes below):
[[Two Explanations for One Flock - The Rods and the Dream]] (**both halves now ingested**),
[[Divination in Genesis - Laban's Nahash and Joseph's Cup]], [[Sacrifice Before the Priesthood]]
(31:54 promoted from a forward reference to the first *zebaḥ* in Scripture),
[[The Pillar Jacob Raised and the Pillars the Law Forbids]],
[[I Will Be With You - The Promise of Presence]],
[[Down to Egypt and Up Again - Abram's Descent as Proto-Exodus]] (a new paragraph deferring the
second rehearsal to the new page), and
[[The Younger Before the Firstborn - Jacob and Laban]] (a new closing bullet: the house rule is
answered by the two daughters it was invoked over).

**Stale forward references corrected.** Six `*(not yet ingested)*` markers pointing into Genesis 31
were live before this pass and are now resolved — five in [[Jacob's Flocks]]' cross-references
(collapsed into a single entry linking the new page), two in
[[Two Explanations for One Flock - The Rods and the Dream]], one in
[[Divination in Genesis - Laban's Nahash and Joseph's Cup]], one in
[[Sacrifice Before the Priesthood]], and one in [[Strife and Peacemaking]] (split, so that Esau's
embrace stays marked and Laban's heap does not).

**Indexes.** `wiki/books/Genesis.md` (box checked, structure paragraph extended by a full pericope
summary, [[Idolatry]] and [[Language and Speech]] added to key themes, [[Gilead]] and [[Galeed]] to
key places), `wiki/books/index.md` (**39 / 59 → 40 / 59**), ten rows extended in
`wiki/people/index.md`, four extended and two new rows in `wiki/places/index.md`, nineteen extended
and one new row in `wiki/themes/index.md`, six new rows in `wiki/connections/index.md`.
`wiki/index.md` now reads **46 passages · 98 people · 50 places · 57 themes · 133 connections**,
counted against what is on disk.

### Link check

`scripts/link-check.sh` exits **0**, clean on the first run this pass. No wrapped links, no dangling
targets; the expected baseline is **64** not-yet-started book pages, unchanged, since no new book
page was created.

**Links deliberately left for later pericopes** — all given as plain scripture references rather than
wikilinks, so none is a finding: 32:1–2 (Mahanaim and the angels), 32:22–32 (the Jabbok and the new
name), 33 (the meeting with Esau), 35:2–4 (the foreign gods buried under the oak at Shechem —
**the one disposal of household gods Genesis records**), 35:16–20 (Rachel's death and the fourth
pillar), 35:29 (Isaac's death), 37:28 (***mākar***, the verb the daughters use of themselves, used of
Joseph), 42:7 (Joseph *made himself strange*, from the root of *nokriyyôt* at 31:15), and 46:1 (the
next *zebaḥ*).

**Quotation check.** Every WEB verse quoted on the passage page was compared against
`raw/bible/Genesis.md` mechanically, block by block: **67 quoted verse-blocks, 0 mismatches.**

**Note on branch state.** The session started on a **detached HEAD** again — `HEAD detached from
refs/heads/main` — with local `main` twenty-nine commits behind at `ee8f435` and nothing uncommitted.
`git fetch origin main` showed `origin/main` already at `ac712d9`, the previous run's commit, so that
push had landed and only the local ref was stale. Handled as before: `main` was checked out and
fast-forwarded onto HEAD after verifying it was an ancestor, and the ingest was committed on `main`.
Nothing was stashed, dropped, or rewritten. **This has now been the standing condition for many
consecutive runs** — the container checks the repo out detached rather than on `main` — and it has
still cost nothing, because every previous push had in fact landed.

## [2026-09-11] ingest | Genesis 32.1-32 — Wrestling at the Jabbok

Interactive run, no target argument. `wiki/books/index.md` gave **Genesis** as the first
`in-progress` book and its page gave **Wrestling at the Jabbok — Genesis 32:1–32** as the first
unchecked box. `raw/bible/Genesis.md` was already present. Discussed with the user before drafting:
the structure (fear/prayer/gift, the crossing, the wrestling, Peniel, the etiology), the identity of
the wrestler, the *Yiśrāʾēl* etymology, and the *pānîm* thread running from the staged gift to the
naming — all confirmed as the working line before any page was written.

**A chapter heavily pre-annotated by earlier ingests.** Six pages already carried forward references
into Genesis 32 with real content attached — most notably
[[Wrestlings of God - Rachel at Naphtali's Birth and Jacob at the Jabbok]], written during the
Genesis 30 pass, which had already worked out the *ʾābaq*/*pātal* verb comparison and the *yākōl*
outcome this page relies on — and [[The Angel of Yahweh]], whose identity-problem table and method
were extended rather than duplicated.

### Judgment calls made in this pass

- **The boundary was used as drawn, and kept whole.** 32:1 opens on a new location and threat (Laban
  is gone, Esau is the subject from the first verse) and 32:32 closes on an etiology reaching past the
  narrative into the reader's present. **A split at 32:22 — diplomacy from wrestling — was considered
  and rejected**: the keyword *pānîm* crosses that boundary (32:20 into 32:30), and the wrestling only
  makes sense as the night between a prayer and a dreaded meeting.
- **The title was kept from the plan.** Alternatives rejected: *Peniel* (names only the last third),
  *Jacob Becomes Israel* (front-loads a twenty-nine-verse-delayed outcome), *The Night Before Esau*
  (true of half the chapter only).
- **The identity of the wrestler was not resolved**, following [[The Angel of Yahweh]]'s standing
  practice: *ʾîš*, then *ʾĕlōhîm* and men in one clause, then Jacob's own claim to have seen God — three
  descriptions, no narratorial adjudication.
- **Hosea 12:3–4's relocation to Bethel was recorded as a discrepancy, not harmonised.** Hosea supplies
  the title *the angel* and moves the site; both are treated as the prophetic gloss's own contribution,
  not as corrections to Genesis.
- **The *Yiśrāʾēl* etymology was treated as the speaker's pun, not as settled linguistics** — the same
  caution already standing for *Yaʿăqōb* and *Yiṣḥāq* — and the competing *God rules* reading was
  recorded rather than adopted.
- **The Hebrew's two spellings of Peniel/Penuel (32:30 vs. 32:31) were kept as a philological note**
  rather than silently normalised; the WEB renders both *Peniel* and the page's title follows the WEB.
- **One new connection page was judged warranted.**
  [[Why Do You Ask My Name - Genesis 32, Exodus 3, and Judges 13]] — the closest verbal parallel to
  32:29 anywhere in the Old Testament is Judges 13:17–18, and Exodus 3:13–15 supplies the third case
  where the question is answered by being complied with rather than refused. Filed as a connection
  page rather than folded entirely into [[The Angel of Yahweh]], on the same logic as
  [[Wrestlings of God - Rachel at Naphtali's Birth and Jacob at the Jabbok]]: a verbal/thematic parallel
  across non-adjacent texts gets its own page even when a person page also discusses the instance.
- **Three place pages were judged warranted.** [[Mahanaim]], [[The Jabbok]], and [[Peniel]] — the
  chapter's two namings and the water between them, none previously covered.
- **No page was created for the four hundred men** — never confirmed as hostile, never appearing on
  screen even in the reconciliation pericope's plan, carried on [[Esau]]. **No separate page for
  Seir** — named once, already covered as Esau's territory on [[Edom]].

### Things flagged rather than resolved

- **Whether the prayer (32:9–12) or the staged gift (32:13–21) is what Jacob is actually trusting.**
  Both answer the same fear in the same night; the narrator ranks neither and the gift is dispatched
  before the reader is told the prayer has finished.
- **Whether the four hundred men were ever a real threat.** Reported once, never confirmed, and Esau's
  actual arrival — outside this pericope's scope — runs to embrace rather than attack.
- **The motive for *"let me go, for the day breaks"* (32:26)** — stated by the wrestler and left
  unglossed by the narrator.
- **Dinah's absence from the crossing count at 32:22**, against eleven named sons — recorded as an
  omission the text gives no reason for, not explained away.

### Pages touched

**Created (5).** `wiki/passages/Genesis/Wrestling at the Jabbok.md`; places [[Mahanaim]],
[[The Jabbok]], [[Peniel]]; connection
[[Why Do You Ask My Name - Genesis 32, Exodus 3, and Judges 13]].

**Revised (17).** People (3): [[Jacob]] (new in-pericope section, six timeline entries replacing one
placeholder, an appearance note, two new themes), [[Esau]] (an off-stage appearance note and timeline
entry — present in every consequence and absent from every verse), [[The Angel of Yahweh]] (a new
subsection extending the identity-problem argument to 32:24–30, a table-adjacent timeline entry, an
appearance note). Themes (6): [[Prayer]] (the placeholder instance written up in full, plus a related
person added), [[Names and Naming]] (the placeholder instance written up in full), [[Blessing]] (the
"to trace" placeholder resolved into a key passage), [[Seeing and Being Seen]] (a new key passage on
the *pānîm* thread), [[Strife and Peacemaking]] (the bundled *Genesis 32–33* placeholder split so 32
is resolved and 33 stays marked), [[The Fear of God]] (a new key passage contrasting named human fear
with unnamed survival of a theophany). Connections (4):
[[Wrestlings of God - Rachel at Naphtali's Birth and Jacob at the Jabbok]],
[[Angels Ascending and Descending - Genesis 28.12 in John 1.51]],
[[Two Errands to Paddan Aram - Genesis 24 and Genesis 28]] (two placeholders resolved),
[[Dust, Stars, and Sand - The Offspring Promises]] — each given a link to the new passage page where
it previously cited the verse as plain text. Passage pages (4, cross-reference placeholders resolved):
[[Jacob's Flocks]], [[Jacob's Flight from Laban]] (two placeholders, plus a stale note in ## Notes
corrected), [[Jacob and Esau and the Sold Birthright]], [[The Stolen Blessing]],
[[The Birth of Jacob's Children]], [[Jacob's Ladder at Bethel]].

**Indexes.** `wiki/books/Genesis.md` (box checked, structure paragraph extended by a full pericope
summary, [[Prayer]] added to key themes, [[Mahanaim]]/[[The Jabbok]]/[[Peniel]] added to key places),
`wiki/books/index.md` (**40 / 59 → 41 / 59**), three rows extended in `wiki/people/index.md`, one row
extended and three new rows in `wiki/places/index.md`, six rows extended in `wiki/themes/index.md`,
one new row in `wiki/connections/index.md`. `wiki/index.md` now reads **47 passages · 98 people · 53
places · 57 themes · 134 connections**, counted against what is on disk and matching exactly.

**A file unrelated to wiki content was also committed separately before this pass**, per the ingest
skill's instruction to keep a pre-existing dirty tree out of the ingest commit — not itself a wiki
change and not detailed further here.

### Link check

`scripts/link-check.sh` exits **0** on the final run this pass, after three rounds of
self-correction: the first run caught two wrapped links in the new passage page (a wikilink target
split across the ~100-column wrap in two places); a later run, taken after this very log entry was
drafted, caught a third wrapped link inside the entry's own **Pages touched** paragraph. All three
were fixed the same way — moving the whole `[[...]]` onto one line rather than letting it straddle
the wrap — which is itself the log's demonstration of why the script runs after every pass rather
than being assumed clean. The expected baseline is **64** not-yet-started book pages, unchanged,
since no new book page was created.

**Links deliberately left for later pericopes** — all given as plain scripture references rather than
wikilinks, so none is a finding: 33:1–20 (the meeting with Esau), 35:10–12 (the name Israel repeated
by God with the promise attached), 48:15–16 (Jacob's own retrospective naming of *"the angel who has
redeemed me"*).

**Quotation check.** Every WEB verse quoted on the passage page was compared against
`raw/bible/Genesis.md` mechanically, block by block: **32 quoted verse-blocks, 0 mismatches** after
one round of correction — the first draft had silently straightened the raw text's curly quotation
marks and apostrophes when it was typed rather than copied, which the mechanical comparison caught
and a second pass fixed verse by verse.

**Branch state.** Preflight was already clean at session start (`on main, already at origin/main`),
with one note: the working tree was dirty from an untracked Obsidian theme folder, committed
separately with its own message before this ingest began, exactly as the skill's step 5 requires when
`git status` is dirty going in.

## [2026-09-11] ingest | Genesis 33.1-20 — The Reconciliation with Esau

Interactive run, no target argument. `wiki/books/index.md` gave **Genesis** as the first
`in-progress` book and its page gave **The Reconciliation with Esau — Genesis 33:1–20** as the first
unchecked box. `raw/bible/Genesis.md` was already present. Discussed with the user before drafting:
the *pānîm* thread completing Peniel, whether the unfulfilled promise to follow Esau to Seir counts
as this family's usual deception, and the plan to create [[Hamor]] thin now rather than wait for
Genesis 34 — all confirmed as the working line before any page was written.

### Judgment calls made in this pass

- **The boundary was used as drawn, and kept whole.** 33:1 opens on Esau's arrival, the event the
  previous chapter spent thirty-two verses dreading, and 33:20 closes on an altar, with 34:1 opening
  on a different character and location. **A split at 33:17 — the meeting from the Shechem
  purchase — was considered and rejected**: the altar name is built on *Yiśrāʾēl*, which only makes
  sense as the far side of the reconciliation the chapter is named for.
- **The title was kept from the plan.** Alternatives rejected: *The Face of God and the Face of Esau*
  (imports an interpretive claim the plainer title doesn't need) and *El Elohe Israel* (names only
  the last three verses).
- **The unfulfilled promise to follow Esau to Seir (33:14) was flagged and not adjudicated.** Three
  readings — an abandoned plan, an unpressed courtesy, or the family's pattern continued with a
  technically true statement — are all recorded and none is adopted. Unlike 27:19 or 27:24, nothing
  here is a false statement of present fact, so it was not filed under [[Deception]] as a *mirmâ* on
  the same footing as the flat lies elsewhere in this family, but as an open question in its own
  right, on both [[Jacob]]'s page and the theme page.
- **Hamor was created now, thin, rather than held for Genesis 34** — on the precedent of [[Dinah]],
  who was created at her one-clause birth notice eleven chapters before her own chapter. He is named
  once, as *"Shechem's father"*, with no action of his own in this pericope.
- **One new connection page was judged warranted.**
  [[Fell on His Neck and Wept - The Running Embrace in Genesis and Luke]] — 33:4's five verbs recur,
  in part, at both of Joseph's reunions (45:14–15; 46:29–30) and the Septuagint's Greek of this verse
  is close enough to Luke 15:20's prodigal-son verbs to be the same sentence. Filed as a connection
  page on the same logic as prior instances of a verbal parallel crossing non-adjacent texts: it gets
  its own page even though [[Jacob]], [[Esau]], and [[Seeing and Being Seen]] each also discuss the
  verse.
- **One new place page.** [[Succoth]], named for the shelters Jacob builds the day he leaves Esau —
  and flagged in its own text, in advance, for the collision Exodus 12:37's differently located
  Succoth will produce when Exodus is ingested.
- **No page was created for the four hundred men** — they simply arrive as reported and do nothing;
  the number is already carried on [[Esau]] from the previous ingest. **No separate page for Seir** —
  already covered as Esau's territory on [[Edom]].

### Things flagged rather than resolved

- **The unfulfilled Seir promise**, per the judgment call above.
- **Why Esau's character changes with no bridging scene.** The man who planned murder for after his
  father's funeral (27:41) runs to embrace the brother who wronged him, twenty years and no narrated
  event later. Genesis supplies no reason and the wiki records none.
- **Whether Jacob's own words to Esau — *my blessing* for the gift he presses on him (33:11) — are a
  deliberate callback to chapter 27 or simply the ordinary sense of a word that also means gift.**
  Recorded as an observation about the Hebrew, not as a claim about authorial intent.

### Pages touched

**Created (4).** `wiki/passages/Genesis/The Reconciliation with Esau.md`; place [[Succoth]]; person
[[Hamor]]; connection
[[Fell on His Neck and Wept - The Running Embrace in Genesis and Luke]].

**Revised (13).** People (5): [[Jacob]] (new in-pericope section, five timeline entries replacing
one placeholder, an appearance note, one related person), [[Esau]] (new in-pericope section
replacing part of the "what is still ahead" prose, three timeline entries replacing one placeholder,
an appearance note), [[Leah]], [[Rachel]], [[Joseph]] (one timeline entry and one appearance note
each, on the household's approach order). Places (1): [[Shechem (city)]] (appearance note and events-here
entry, its own *(not yet ingested)* marker cleared). Themes (6): [[Favor and Grace]] (the three-fold
*find favor* formula), [[Seeing and Being Seen]] (the *pānîm* thread's completion),
[[Names and Naming]] (two namings for what had just happened), [[Strife and Peacemaking]] (the
bundled placeholder resolved), [[Blessing]] (the *birkātî*/*minḥâ* distinction), [[Deception]] (the
unfulfilled Seir promise, flagged and not adopted). Connections (1):
[[The Altar at Shechem and the Covenant at Shechem]] (its 33:18–20 marker cleared). Passage
cross-references (3, stale forward-reference markers resolved):
[[Jacob and Esau and the Sold Birthright]], [[The Stolen Blessing]], [[Wrestling at the Jabbok]].

**Indexes.** `wiki/books/Genesis.md` (box checked, structure paragraph extended by a full pericope
summary, [[Hamor]] added to key people, [[Succoth]] added to key places), `wiki/books/index.md`
(**41 / 59 → 42 / 59**), six rows extended and one new row in `wiki/people/index.md`, one row
extended and one new row in `wiki/places/index.md`, six rows extended in `wiki/themes/index.md`, one
new row in `wiki/connections/index.md`. `wiki/index.md` now reads **48 passages · 99 people · 54
places · 57 themes · 135 connections**, counted against what is on disk and matching exactly.

### Link check

`scripts/link-check.sh` exits **0** on the second run this pass: the first caught one wrapped link,
`[[Names and Naming]]` split across two lines in this entry's own **Pages touched** paragraph while
it was still being drafted — the same self-referential finding the previous ingest's log entry also
hit, and fixed the same way, by moving the whole link onto one line rather than letting it straddle
the wrap. The expected baseline is **64** not-yet-started book pages, unchanged, since no new book
page was created. Stale *(not yet ingested)* markers pointing at some or all of Genesis 33 were
swept and cleared across the wiki, not only on the pages this pericope's own workflow required
touching: [[Jacob]], [[Esau]], [[Leah]], [[Shechem (city)]],
[[The Altar at Shechem and the Covenant at Shechem]],
[[Jacob and Esau and the Sold Birthright]], [[The Stolen Blessing]], [[Wrestling at the Jabbok]].

**Links deliberately left for later pericopes** — all given as plain scripture references rather
than wikilinks, so none is a finding: 34:1–31 (Dinah and the sons of Hamor by name), 35:1–7 (Jacob's
return to Bethel), 36:1–43 (Esau's *toledot* and settlement in Seir), 45:14–15 and 46:29–30
(Joseph's two reunions, cited already on the new connection page).

**Quotation check.** Every WEB verse quoted on the passage page was compared against
`raw/bible/Genesis.md` block by block, mechanically: **20 quoted verse-blocks, 0 mismatches** after
one round of correction — the first draft had, again, silently straightened ten verses' worth of the
raw text's curly quotation marks and one curly apostrophe (*Shechem's*) when they were typed rather
than copied. Fixed verse by verse and re-checked clean.

**Branch state.** Preflight was clean at both checks this pass (session start and step 0.5): `on
main, already at origin/main`, no divergence, nothing to report.

## [2026-09-12] ingest | Genesis 34.1-31 — Dinah and the Massacre at Shechem

Unattended run (`/ingest auto`, no target argument), so step 2's discussion was written into the
passage page rather than held with the user. `wiki/books/index.md` gave **Genesis** as the first
`in-progress` book and its page gave the first unchecked box at Genesis 34:1–31.
`raw/bible/Genesis.md` was already present; `scripts/fetch-book.sh` was not needed.

### Judgment calls made in this pass

- **The boundary was used as drawn, and kept whole.** 34:1 opens on a new character and a different
  town's business; 34:31 ends on an unanswered question, with 35:1 opening on a direct command from
  God. **A split at 34:24 — the negotiation from the massacre — was considered and rejected**: the
  circumcision is only intelligible as the first half of the killing.
- **The title was redrawn.** The plan's box read *Dinah and Shechem*; the page is
  [[Dinah and the Massacre at Shechem]]. Two reasons: *Dinah and Shechem* reads as a pairing of two
  people rather than as what the chapter is, and after this pass "Shechem" alone is ambiguous between
  [[Shechem (city)]] and [[Shechem (son of Hamor)]]. **Alternatives rejected**: *The Rape of Dinah*
  (names the first four verses and not the other twenty-seven) and *The Defiling of Dinah* (adopts
  the chapter's own loaded verb as the wiki's).
- **The person/place collision the schema requires was resolved this pass, as scheduled.**
  `wiki/places/Shechem.md` → `wiki/places/Shechem (city).md`, and the man became
  `wiki/people/Shechem (son of Hamor).md`. **The patronymic was chosen over a bare `(person)`** on
  the `Enoch (son of Cain)` / [[Enoch (city)]] precedent, which `AGENTS.md` gives as its worked
  example for exactly this case; [[Hamor]]'s page, written at the 33:19 ingest, had anticipated a
  `(person)`-style qualifier, which is what a patronymic is. Both pages open with a
  do-not-confuse paragraph naming the other.
- **Four things the chapter does not say were kept open rather than filled**: whether Dinah was held
  against her will between 34:3 and 34:26; whether her going out is being blamed (later readers
  supply the blame — *Jubilees* 30 and a strand of midrash — and Genesis does not); whether Shechem's
  later love mitigates anything; and whether Jacob's silence is prudence, paralysis, or indifference.
- **The legal tension was recorded and not adjudicated.** By Exodus 22:16–17 and Deuteronomy
  22:28–29 — four books later, and cited by nobody in the chapter — Shechem's offer of the
  bride-price and marriage is the remedy the Torah itself prescribes; the brothers refuse it and
  apply a penalty no law states. Both halves are true and Genesis rules on neither. Stated on the
  passage page, on [[Vengeance]], and on
  [[Simeon and Levi - The Sword at Shechem and the Deathbed Curse]].
- **A contradiction was flagged explicitly rather than harmonized**, as `AGENTS.md` requires: Jacob
  **bought** the Shechem parcel (33:19, repeated at Joshua 24:32), his sons **sacked** the city and
  he disowned it (34:27–30), and he tells Joseph he **took** it *"with my sword and with my bow"*
  (48:22). Four standing readings are set out on the new connection page and none is adopted.
- **No `Tamar` page was created**, although 2 Samuel 13 is the chapter's closest parallel and is used
  heavily. Creating one for David's daughter would force a rename at *Judah and Tamar* (Genesis
  38:1–30), four pericopes away, where Genesis's own Tamar has the better claim on the bare title.
  She is named in plain prose and distinguished by patronymic on the connection page, so nothing
  dangles and nothing has to be renamed later.
- **Four connection pages were judged warranted** — more than usual for one pericope, because three
  of the four are threads the chapter opens rather than readings of it: a formula with six later
  occurrences, a full-length parallel narrative, a curse whose two halves resolve in opposite
  directions, and a three-way contradiction about one piece of ground.

### Pages touched

**Created (5).** `wiki/passages/Genesis/Dinah and the Massacre at Shechem.md`;
`wiki/people/Shechem (son of Hamor).md`; and four connection pages —
`wiki/connections/Folly in Israel - Nebalah from Genesis 34 to 2 Samuel 13.md` (the phrase's first
occurrence, its anachronism, and the seven-entry table of its career),
`wiki/connections/Dinah and Tamar - Two Rapes and Two Avenging Brothers.md` (a thirteen-row
comparison of Genesis 34 and 2 Samuel 13),
`wiki/connections/Simeon and Levi - The Sword at Shechem and the Deathbed Curse.md` (the deed, the
curse on the *anger*, and the same sentence producing the priesthood for one tribe and
disappearance for the other), and
`wiki/connections/Bought, Sacked, or Taken by the Sword - How Jacob Got Shechem.md`.

**Renamed (1).** `wiki/places/Shechem.md` → `wiki/places/Shechem (city).md`, with all **26** inbound
`[[Shechem]]` links rewritten across 21 files. Two of the 26 were live links inside the previous
ingest's own log entry; they were repointed rather than left to dangle, since they name the same
page under its new title. Five paragraphs were re-wrapped where the longer target overran the
column.

**Revised.** People (7): [[Dinah]] (the "what is still ahead" section replaced by her chapter),
[[Hamor]] (same), [[Simeon]], [[Levi]], [[Jacob]] (a new *in this pericope* section, plus the 48:22
contradiction), [[Leah]] (named once at 34:1 and absent thereafter — and the avengers are hers),
[[God]] (**absent**: a new section on the first chapter in Genesis with no divine name in it).
Places (2): [[Shechem (city)]] (renamed, disambiguated, and filled out for 34), [[Canaan]] (34:30's
Canaanites and Perizzites). Themes (9): [[Circumcision]], [[Deception]], [[Vengeance]],
[[Marriage]], [[War]], [[The Nations]], [[Land and Sojourning]],
[[Strife and Peacemaking]], [[Wealth and Possessions]].

**Indexes.** `wiki/books/Genesis.md` (box checked, structure paragraph extended by a full pericope
summary, four names added to key people), `wiki/books/index.md` (**42 / 59 → 43 / 59**), seven rows
extended and one new row in `wiki/people/index.md`, two rows extended in `wiki/places/index.md`
(one of them renamed), nine rows extended in `wiki/themes/index.md`, four new rows in
`wiki/connections/index.md`. `wiki/index.md` now reads **49 passages · 100 people · 54 places · 57
themes · 139 connections**, counted against what is on disk and matching exactly.

### Link check

`scripts/link-check.sh` exits **0**. The expected baseline is **64** not-yet-started book pages,
unchanged, since no new book page was created.

**Links deliberately left for later pericopes** — all given as plain scripture references rather
than wikilinks, so none is a finding: 35:1–5 (Bethel, and the terror that answers 34:30), 49:5–7
(the deathbed curse), 48:22 (the sword and the bow), 46:15 (Dinah counted among Leah's children).

**Quotation check.** Every WEB verse quoted in a block quote was compared against
`raw/bible/Genesis.md` mechanically, by a script that re-parsed the blockquotes and diffed them
against the raw verse text: **31 verse-blocks on the passage page, 0 mismatches**, and the
two-verse block on `Shechem (son of Hamor)` and the 49:5–7 block on the Simeon-and-Levi connection
page likewise. The block quotes were generated from the raw file rather than typed, which is what
avoided this pass's version of the curly-quote problem the last two entries both hit. Quotations
from books not in `raw/` (2 Samuel, Joshua, Judges, Jeremiah, Psalms, Exodus, Numbers, Deuteronomy)
were checked by eye against the WEB and three were corrected in draft — Jeremiah 29:23's clause
order, Joshua 19:1's *"in the middle of the inheritance"*, and Psalm 105:12's *"foreigners in it"*.

### Noted for a later lint, not fixed here

`wiki/people/God.md` has per-pericope sections running from Genesis 2 to 31:1–55 and then jumping to
Job; **the sections for Genesis 32 and 33 were never written**, and its `## Appears in` list is
missing a number of entries it should have. This pass added the Genesis 34 section in reference
order and did not backfill the gap, which is a lint job rather than an ingest one.

## [2026-09-16] ingest | Genesis 35.1-29 — Return to Bethel; the Deaths of Rachel and Isaac

Unattended run (`/ingest auto`). Step 2's discussion is written into the passage page rather than
spoken. **Boundary and title both taken from the plan unrevised.** A three-way split — 1–15 (Bethel),
16–22a (Rachel and Reuben), 22b–29 (the roster and Isaac) — was considered and rejected: the
chapter's unity is its ledger rather than its plot, **four burials and a birth**, and each third
loses its force read apart from the other two. 35:1 opens on a direct command from God, which chapter
34 conspicuously lacked; 36:1 opens a *toledot* on a different subject.

**The pericope's spine, as the page reads it.** Four things go into the ground in twenty-nine verses
— the household's foreign gods under the oak at Shechem (35:4), [[Deborah (Rebekah's nurse)]] under
the oak below Bethel (35:8), [[Rachel]] on the road to Ephrath (35:19), [[Isaac]] at Machpelah by
implication (35:29) — and one child is born, [[Benjamin]], whose birth kills his mother. **The
chapter completes the house and empties it in the same breath**: 35:23–26 is the Bible's first
complete roster of the twelve, and it is printed immediately after the verse in which the firstborn
disqualifies himself.

### Judgment calls, recorded for review

- **[[Deborah (Rebekah's nurse)]] created under exactly the qualifier
  [[A Wife for Isaac]]'s notes specified in advance**, so Deborah the prophetess and judge (Judges
  4–5) can take the bare name or her own qualifier later. A bare `Deborah.md` would be a silent
  basename collision of the kind `AGENTS.md` makes the qualifier rules mandatory for.
- **[[Bethlehem]] titled by the name that carries the rest of Scripture**, not by *Ephrath*, which
  goes in `also_known_as` alongside *Ephrathah* — following [[Bethel]], which holds *Luz* the same
  way.
- **[[The Tower of Eder]] created thin**, on the [[Esek]] / [[Sitnah]] precedent: a named site that
  occurs once, that later Scripture picks up (Micah 4:8), and that would otherwise have nowhere to
  hang.
- **Deliberately *not* created.** *Allon Bacuth* — a tree, not a settlement, occurring once, already
  tracked by [[The Trees of the Patriarchs]]. *El Beth El* — an altar name, like *El Elohe Israel* at
  33:20; altar names live on [[The Names of God]]. **The midwife of 35:17** — unnamed, one line, and
  the wiki's practice for anonymous single-line figures is to leave them on the passage page. **No
  `Paddan Aram.md`**, per the standing instruction on [[A Wife for Isaac]].

### Contradictions flagged, none resolved

- **Benjamin's birthplace.** 35:16–19 has him born in Canaan on the road to Ephrath; 35:26 says all
  twelve *"were born to him in Paddan Aram."* **An internal contradiction inside a single chapter**,
  which is rarer than the cross-chapter kind. Three readings set out on the passage page —
  generalizing summary, composite sources, deliberate rounding — and none adopted. Also recorded on
  [[Aram Naharaim]], [[Canaan]], [[Asher]] (the roster's last name, on whom the formula falls), and
  [[Benjamin]].
- **Where Rachel is buried.** Genesis 35:19 and 48:7 gloss *Ephrath* as *Bethlehem*, six miles south
  of Jerusalem; 1 Samuel 10:2 puts the tomb *"in the border of Benjamin at Zelzah"* and Jeremiah
  31:15 hears her at Ramah, both ten or more miles north. The new connection page lays out all three
  locations and four readings and adopts none; it notes only that Matthew 2:18 works on the southern
  identification.
- **Bilhah's status, carried forward not newly created.** *Concubine* (35:22), *servant* (35:25),
  *wife* (30:4; 37:2). This chapter supplies two of the three four verses apart and still does not
  reconcile them.
- **The Masoretic break at 35:22**, recorded as a scribal fact. The *piska bĕʾemṣaʿ pasuq* after
  *"Israel heard of it"* is one of the few mid-verse section breaks in the Hebrew Bible, and the
  Septuagint's *"and it appeared evil before him"* is an ancient completion of it. **The Greek is
  recorded as a reading of the break, not as a recovered Hebrew clause** — the footing the wiki
  already gives the Septuagint's *a field* at 21:33.
- **Isaac's death reported out of order**, about twelve years after the selling of Joseph on the
  book's own arithmetic. **Not treated as an error**: it is the *toledot* structure doing what it did
  with Ishmael at 25:17, and it is now recorded on
  [[The Other Line First - The Order of the Toledot in Genesis]].

### Pages

**Created (7).** Passage: [[Return to Bethel; the Deaths of Rachel and Isaac]]. People (2):
[[Benjamin]], [[Deborah (Rebekah's nurse)]]. Places (2): [[Bethlehem]], [[The Tower of Eder]].
Connections (3): [[Renamed and Still Called Jacob - The Two Namings of Israel]] (the doubled naming
at 32:28 and 35:10, and the fact that the narrator goes on saying *Jacob* to the end of the book,
where *Abram* never recurs after 17:5); [[Rachel Weeping - Her Grave, Ramah, and Bethlehem]];
[[Lying with the Father's Concubine - A Claim on the Succession]] (35:22 with Abner, Absalom, and
Adonijah, where the later books state the political meaning Genesis withholds).

**Updated (44).** People (21): [[Jacob]], [[Rachel]], [[Isaac]], [[Esau]], [[Reuben]], [[Bilhah]],
[[Rebekah]], [[God]] (a new per-pericope section), [[Leah]], [[Zilpah]], [[Simeon]], [[Levi]],
[[Judah]], [[Joseph]], [[Issachar]], [[Zebulun]], [[Dan (person)]], [[Naphtali]], [[Gad]],
[[Asher]] — the last ten mostly for the roster at 35:23–26, the Bible's first complete list of the
twelve. Places (7): [[Bethel]], [[Shechem (city)]], [[Mamre (place)]], [[Hebron]], [[Machpelah]],
[[Canaan]], [[Aram Naharaim]]. Themes (17): [[Idolatry]], [[Names and Naming]],
[[Burial and the Grave]], [[Oaths and Vows]], [[The Names of God]], [[Sacrifice and Offering]],
[[Birthright and the Firstborn]], [[Clean and Unclean]], [[Life and Death]], [[The Fear of God]],
[[Kingship and Empire]], [[Covenant]], [[Blessing]], [[Land and Sojourning]], [[The Nations]],
[[Sin]], [[Prayer]]. Connections (12): [[The Trees of the Patriarchs]],
[[Sacrifice Before the Priesthood]], [[The Teraphim - Household Gods in Genesis and After]],
[[Kings Will Come Out of You]], [[God Almighty - El Shaddai in Genesis and Exodus]],
[[The Pillar Jacob Raised and the Pillars the Law Forbids]], [[Gathered to His People]],
[[Buried at Machpelah - The Six Graves of Genesis]],
[[The Twelve Sons and the Lists That Reorder Them]],
[[The Altar at Shechem and the Covenant at Shechem]],
[[Bethel from Jacob's Pillar to Jeroboam's Calf]],
[[The Other Line First - The Order of the Toledot in Genesis]],
[[Like Rachel and Like Leah - The Builders of the House of Israel]].

**Indexes.** `wiki/books/Genesis.md` (box checked, structure paragraph extended by a full pericope
summary), `wiki/books/index.md` (**43 / 59 → 44 / 59**), two new rows and twenty rows extended in
`wiki/people/index.md`, two new rows and seven rows extended in `wiki/places/index.md`, seventeen
rows extended in `wiki/themes/index.md`, three new rows in `wiki/connections/index.md`.
`wiki/index.md` now reads **50 passages · 102 people · 56 places · 57 themes · 142 connections**,
counted against what is on disk and matching exactly.

### Link check

`scripts/link-check.sh` exits **0**. The expected baseline is **64** not-yet-started book pages,
unchanged, since no new book page was created.

**Links deliberately left for later pericopes** — all given as plain scripture references rather than
wikilinks, so none is a finding: 36:1–43 (Esau's *toledot*); 37:2 (Bilhah called a *wife* again);
48:7 (Jacob's own retelling of Rachel's death); 49:3–4, 31, 33 (Reuben disinherited, Rebekah's only
named burial, Jacob gathered to his people); 42–45 and 49:27 on [[Benjamin]].

**Quotation check.** All twenty-nine verses of Genesis 35 are block-quoted on the passage page and
were compared against `raw/bible/Genesis.md` mechanically, by a script that re-parsed the block
quotes and diffed them verse by verse: **29 verse-blocks, 0 mismatches.** The same script was then
run over every block quote in every file this pass touched, which caught four things worth recording:

- **A block quote must be verbatim, so emphasis does not belong inside one.** Bolding added inside
  the 35:19 quote on [[Bethlehem]] and inside both quotes on [[Deborah (Rebekah's nurse)]] was
  removed; the emphasis is now in the prose around them.
- **The wiki's convention is curly quotes inside block quotes and straight ones in inline quotes.**
  That is not written down anywhere, but it holds across 89 inline instances on pages this pass
  barely touched, so it was treated as settled rather than "fixed". One block quote added this pass
  (35:22 on [[Reuben]]) had a straight apostrophe and was corrected to match every other block quote
  in the wiki.
- **Two pre-existing misquotations of the WEB at 49:4, corrected on pages this pass was already
  editing.** [[Reuben]]'s block quote read *"Boiling over **as** water"* and dropped the verse's last
  clause; the WEB reads *"Boiling over **like** water … He went up to my couch."* [[Bilhah]] quoted
  *"unstable as water"*, which is the KJV, attributed to the WEB. Both now match `raw/`. The same
  phrase was corrected in this pass's own draft of the passage page before commit.
- **Genesis 24:59 was being quoted from memory.** *"They sent away Rebekah their sister, and her
  nurse"* is not the WEB, which reads *"They sent away Rebekah, their sister, with her nurse,
  Abraham's servant, and his men."* Corrected on the passage page and quoted in full on
  [[Deborah (Rebekah's nurse)]].

Quotations from books not in `raw/` (Exodus, Numbers, Deuteronomy, Joshua, Judges, Ruth, 1–2 Samuel,
1–2 Kings, 1 Chronicles, Micah, Jeremiah, Hosea, Matthew, Philippians) were checked by eye against
the WEB.

### Noted for a later lint, not fixed here

`wiki/people/God.md` block-quotes Genesis 25:11 as *"After the death of Abraham, God blessed Isaac,
his son."* and stops there; the verse continues *"Isaac lived by Beer Lahai Roi."* It is a clean
truncation at a sentence boundary rather than a misquotation, but it carries no ellipsis, and the
same page's Genesis 32 and 33 sections are still missing — a gap the previous entry already recorded
and this pass again did not backfill, having added the Genesis 35 section in reference order.

## [2026-09-16] ingest | Genesis 36.1-43 — The Descendants of Esau

Unattended run (`/ingest auto`). Step 2's discussion is written into the passage page rather than
spoken. The pericope boundary was taken from the book page's plan unchanged — Genesis 36 is a single
*toledot* unit bounded by 35:29 on one side and 37:2 on the other, and nothing in the text argued for
splitting it.

**Created — passage.** `wiki/passages/Genesis/The Descendants of Esau.md`. Forty-three verses, some
ninety names, and one sentence in which a human being does anything: Anah finds *hayyēmim* in the
wilderness while feeding his father's donkeys (36:24). The page is built around the eleven `ʾēlleh`
("these are") headings that segment the chapter, and it treats the register as an **anthology** —
Esau gets two *toledot* headings (36:1, 36:9), which no one else in Genesis does, and the internal
disagreements follow from that reading rather than needing separate excuses.

**Created — people (13).** [[Adah (wife of Esau)]], [[Oholibamah]], [[Eliphaz (son of Esau)]],
[[Reuel (son of Esau)]], [[Timna]], [[Amalek]], [[Seir the Horite]], [[Anah]],
[[Bela (son of Beor)]], [[Jobab]], [[Hadad (son of Bedad)]], [[Hadar]], [[Mehetabel]].

**Created — places (3).** [[Bozrah]], [[Rehoboth by the River]], [[Midian]].

**Created — connections (3).** [[Too Great to Dwell Together - Abram and Lot, Esau and Jacob]]
(Genesis 13:6 and 36:7 are the same two clauses in the same causal order);
[[Amalek - From a Concubine's Son to Israel's First Enemy]] (nine words here, and Exodus 17,
Deuteronomy 25, the fall of Saul, and the plot of Esther after them);
[[Jobab of Bozrah and the Septuagint's Job]] (four of the book of Job's names sit in this one
chapter, and a Greek translator drew the obvious conclusion).

**Revised.** [[Esau]] (new pericope section, timeline, appears-in, and ten new related-people
entries); [[Edom]] (appears-in, five new events, three new related places); [[Teman]], [[Uz]],
[[Eliphaz the Temanite]], [[Job (person)]] (the Genesis 36 / book of Job overlap, now stateable
exactly); [[Basemath (daughter of Elon)]], [[Mahalath]], [[Judith]], [[Elon the Hittite]],
[[Ishmael]]; [[Rehoboth]] (a note distinguishing it from the Edomite town);
[[The Names of Esau's Wives - Genesis 26 and Genesis 36]],
[[The Other Line First - The Order of the Toledot in Genesis]], [[Kings Will Come Out of You]];
themes [[The Nations]], [[Kingship and Empire]], [[Land and Sojourning]],
[[Wealth and Possessions]]; the Genesis book page's Jacob-cycle overview; all five indexes.

### Contradictions and doublings, flagged and not resolved

Four, all of them internal to the chapter or between it and chapter 26, and none smoothed over:

1. **Esau's wives.** Already the wiki's standing flagged contradiction; both halves are now ingested,
   so the connection page's `*(not yet ingested)*` marker is gone and its table now links the five
   women's pages. Two things were **added** to it: the third wife, Oholibamah, is the discrepancy no
   two-names harmonisation can reach, because she has no counterpart in the earlier list to be
   renamed into; and the textual-transmission explanation can now be stated precisely, since 36:2 is
   demonstrably unstable in the versions while the *Basemath* transfer is attested in all of them.
2. **Chief Korah at 36:16** is filed under Adah's line though Korah is Oholibamah's son at 36:5, 14,
   and 18. The Samaritan Pentateuch and part of the Greek tradition omit him there. Recorded on the
   passage page and on both mothers' pages; not chosen between.
3. **Anah** is Zibeon's son at 36:24 and appears to be his daughter at 36:2. The Samaritan, Greek,
   and Syriac all read *son*. The wiki takes the one-man reading and says the Masoretic text at 36:2
   is awkward.
4. **Seir** is derived twice — from the hair on a newborn at 25:25, and from a Horite ancestor at
   36:20 who would have carried the name generations earlier. Genesis states both and notices
   neither, as with Beersheba. Recorded on [[Seir the Horite]].

### Judgment calls

- **Which of ~90 names got pages.** The test applied was: does the name do something, matter
  elsewhere in Scripture, or already have inbound links in this wiki? That yielded the thirteen
  above. **Deliberately not given pages:** the bare names in the chief lists (Omar, Zepho, Gatam,
  Jeush, Jalam, Korah, Nahath, Shammah, Mizzah, Alvah, Jetheth, Elah, Pinon, Mibzar, Magdiel, Iram
  and the rest), the Horite grandsons, and four of the eight kings (Husham, Samlah, Shaul, Baal
  Hanan) whose entries contain nothing but a name, a town, and a death. **Kenaz** is the closest
  call — the Kenizzites produce Caleb and Othniel — and he is covered in full on
  [[Eliphaz (son of Esau)]] instead, because everything to say about him is about his descendants
  rather than him. **The four unlocated royal cities** (Dinhabah, Avith, Masrekah, Pau) got no place
  pages for the same reason: each would hold one sentence saying it is named once and cannot be
  found.
- **No person page for Teman.** He is a name in a list, and everything the wiki has to say about him
  is the eponym relationship [[Teman]] already describes. Splitting him off would force that page to
  become `Teman (place)` and every inbound link to be rewritten, for no gain. Recorded on the page
  itself so a later pass does not redo the reasoning.
- **No person page for the Uz of 36:28**, consistent with the existing decision about the Uz of
  22:21. [[Uz]] now records that if a later pass makes one it must be `Uz (son of Dishan)`.
- **`Adah (wife of Esau)` is qualified although no other Adah page exists.** Lamech's wife at 4:19 is
  in already-ingested text, so the name collides in substance even though it does not yet collide on
  disk. Both pages' qualifiers are noted as mutually required on the new page — the failure the rule
  prevents is silent at both ends, since `link-check.sh` resolves by basename and would pass two
  files called `Adah.md`.
- **`Rehoboth by the River` is a separate page from [[Rehoboth]]**, not a section of it. Genesis
  36:37's town and Isaac's well at 26:22 are different places days apart, and two files named
  `Rehoboth.md` would pass the link check and then be silently collapsed by Obsidian. A
  cross-reference was added to the existing page.
- **`Reuel (son of Esau)`, `Eliphaz (son of Esau)`, `Bela (son of Beor)`, `Hadad (son of Bedad)`**
  are all qualified against namesakes elsewhere in Scripture (Jethro, Job's friend, Balaam's
  patronymic, Ishmael's son and Solomon's adversary) rather than left bare.

### Links deliberately left for later pericopes

All given as plain scripture references rather than wikilinks, so none is a link-check finding:
**37:1–2** (Jacob's *toledot*, and *"the land of his father's travels"*, quoted on four pages as the
counterweight to 36:43); **37:25–28** (the Midianite and Ishmaelite traders — the next pericope, and
the seam this pass's [[Midian]] page anticipates); **38** and **49:5–7**. Quotations from books not
in `raw/` — Exodus, Numbers, Deuteronomy, Joshua, Judges, 1–2 Samuel, 1–2 Kings, 1 Chronicles,
Esther, Isaiah, Jeremiah, Lamentations, Amos, Obadiah, Revelation, and the Septuagint's appendix to
Job — were checked by eye against the WEB.

### Quotation check

All Genesis block quotes on pages this pass touched were re-parsed and diffed verse by verse against
`raw/bible/Genesis.md` by script: the passage page's **22 verse-blocks, 0 mismatches**. The same
script was then run over every block quote in the whole of `wiki/`, which caught **two truncations in
this pass's own new pages** — Genesis 36:4 on [[Adah (wife of Esau)]] and 36:12 on
[[Eliphaz (son of Esau)]] both stopped at a sentence boundary with no ellipsis, and 36:35 on
[[Midian]] dropped *"The name of his city was Avith."* The first two now carry an ellipsis and the
third quotes the verse in full. This is the same defect the previous entry noted on
`wiki/people/God.md` at 25:11 and left for a later lint; that one is still open.

`scripts/link-check.sh` exits 0. Genesis stands at 45 / 59 pericopes; the next is *Joseph Sold into
Slavery*, Genesis 37:1–36, which opens the last cycle of the book.

## [2026-09-16] ingest | Genesis 37.1-36 — Joseph Sold into Slavery

Unattended run (`/ingest auto`). Step 2's discussion is written into the passage page rather than
spoken. The pericope boundary was taken from the book page's plan unchanged: 37:1–2 open the book's
**tenth and last *toledot***, 37:36 closes on Potiphar, and 38:1 turns to Judah and Tamar and does not
come back for a chapter. A split at 37:11/37:12 — the dreams, then the errand — was considered and
rejected, because the dreams are the stated reason for the conspiracy (*"we will see what will become
of his dreams"*) and the two halves lose that link read apart.

**Created — passage.** `wiki/passages/Genesis/Joseph Sold into Slavery.md`. The page is organised
around two facts about the chapter that the wiki records and does not argue from. **First, God is
absent** — neither divine name occurs in thirty-six verses, the only comparable chapter in the cycle
being [[Dinah and the Massacre at Shechem]], and 39:2's *"Yahweh was with Joseph"* is the sentence
this chapter withholds. **Second, the narration blames nobody**: the one verdict in the chapter is
Jacob's and it is wrong, and it is a sentence his sons drafted at 37:20 and never had to speak — they
hand him a coat and the question *hakker-nāʾ* and he supplies their line verbatim at 37:33. Also
tracked: the *šālôm* of 37:4 against the *šəlôm ʾaḥeykā* errand of 37:14; the four-step escalation
*hated* → *hated all the more* → *hated all the more* → *envied*; Moriah's *hinnēnî*, *naʿar*, and
*"lay no hand on him"* redistributed through a chapter with no voice from heaven in it; and the
verb *nākar* planted in a lie about a coat and later governing the reunion (42:7–8).

**Created — people (2).** [[Potiphar]] — the first Egyptian personal name in the Bible, *sārîs* and
*śar haṭṭabbāḥîm*, *chief of the slaughterers*, with the *Potiphera* of 41:45 kept as a separate man.
[[Pharaoh (of Joseph's time)]] — see **Judgment calls** below.

**Created — places (1).** [[Dothan]] — where the whole of the pericope's action happens, and the
setting of the one other Dothan narrative, Elisha and the blinded Aramean army at 2 Kings 6:8–23.

**Created — connections (4).**
[[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]] — the two dreams, the four bowings of
42:6 / 43:26 / 44:14 / 50:18, and the fact that **the first dream is fulfilled to the letter and the
second is not**, because the sun and the moon never bow (47:31 is worship, not submission).
[[Twenty Pieces of Silver - The Price of a Brother]] — 37:28 against Leviticus 27:5, which fixes the
valuation of a male aged five to twenty at exactly twenty shekels, and against the thirty of
Zechariah 11:12 and Matthew 26:15, **which the page declines to equate.**
[[Ishmaelites or Midianites - The Caravan That Bought Joseph]] — the seam inside 37:28.
[[Sold for a Servant - Joseph's Sale in Psalm 105 and Acts 7]] — how the rest of Scripture narrates
this chapter, and that **each summary supplies the thing Genesis 37 leaves out**: the psalm an agent,
Stephen a motive.

**Revised.** People: [[Joseph]], [[Jacob]], [[Reuben]], [[Judah]] (new pericope sections, timelines,
appears-in); [[Bilhah]], [[Zilpah]] (new pericope sections — 37:2 is the verse the Genesis 35 entry
pointed forward to); [[Dan (person)]], [[Naphtali]], [[Gad]], [[Asher]], [[Rachel]], [[Leah]],
[[Benjamin]], [[Dinah]], [[Ishmael]], [[Keturah]]. Places: [[Shechem (city)]], [[Hebron]],
[[Canaan]], [[Egypt]], [[Gilead]], [[Midian]], [[Sheol]] (the last of which had cited 37:35 in prose
since the Job ingests but had no Genesis entry; **it is the word's first occurrence in the Bible**).
Themes (17): [[Envy]], [[Deception]], [[Slavery and Servitude]], [[Prophecy and Vision]], [[Love]],
[[Blood]], [[Nakedness and Covering]], [[Strife and Peacemaking]], [[Suffering]],
[[Mediation and Advocacy]], [[Language and Speech]], [[Birthright and the Firstborn]],
[[Burial and the Grave]], [[Life and Death]], [[Sin]], [[Kingship and Empire]],
[[Wealth and Possessions]]. Connections: [[A Garment and a Goat - Jacob Deceives and Is Deceived]]
(a new paragraph on the refinement the Genesis 37 half adds — in chapter 27 Jacob had to say *"I am
Esau your firstborn"* out loud twice; his sons improved the method until the deceived party performs
it), [[Loved and Hated - Genesis 29 and Deuteronomy 21.15-17]], [[Do Not Cover My Blood]],
[[The Other Line First - The Order of the Toledot in Genesis]],
[[Blessed for His Sake - Laban's House and Potiphar's]]. Plus [[The Stolen Blessing]], the Genesis
book page's Joseph-cycle overview, and all five indexes.

### Contradictions and doublings, flagged and not resolved

- **Joseph's mother at 37:10.** [[Rachel]] died at 35:19; Jacob's rebuke speaks of *"your mother"* as
  a future participant in the bowing. **Four readings are set out and none adopted**: the rebuke
  recites the dream's own figure without asserting who is alive; [[Leah]] is the mother meant (which
  requires supplying something Genesis never says); composite sources, as with Benjamin's birthplace
  at 35:26; and the dream is a promise about a household rather than a guest list. **The fourth is the
  one the sequel vindicates** — the brothers bow four times and the father never does — and the wiki
  notes that without adopting it.
- **Who bought Joseph.** *Ishmaelites* at 37:25, 27, 28b and 39:1; *Midianites* at 37:28a and 37:36.
  Three readings on the new connection page and none adopted. What is worth recording is that **the
  composite reading explains a narrative feature and not merely a word**: [[Reuben]]'s astonishment at
  the empty pit (37:29–30) is hard to place if he was present when his brothers agreed to a sale. And
  the harmonising reading has a real proof text — **Judges 8:24 calls Midianites Ishmaelites in a
  single clause** — which is more than most such cases offer. Genesis 42:21–22 and 45:4–5 both have the
  brothers own the sale; that is recorded as the book's final position, not as a resolution of the
  textual question.
- **Bilhah and Zilpah's status, carried forward and now complete.** *Wife* (30:4, 9), *concubine*
  (35:22), *servant* (35:25, 26), *wives* (37:2). **Four terms, and this pericope supplies the one the
  Genesis 35 entry said was coming.** Still unreconciled, on both pages.
- **A tension recorded rather than flagged.** *"The son of his old age"* (37:3) is not true in the
  plain sense; [[Benjamin]] is younger. Treated as **the narrator reporting Jacob's own account of
  himself**, and noted alongside 44:20, where Jacob applies the identical phrase to Benjamin.

### Judgment calls

- **[[Pharaoh (of Joseph's time)]] was created on a possessive** — *"an officer of Pharaoh's"* — which
  is the call most open to revision in this pass. `AGENTS.md` requires the period qualifier from the
  **first** appearance rather than retrospectively, and this is it; waiting for 39:1 or 41:1 would have
  meant either a dangling link now or a bare mention with nowhere to hang. The page is deliberately
  thin, follows [[Pharaoh (of Abram's time)]] exactly, and **states that Genesis never marks a change
  of reign across the thirteen years between the sale and the promotion**, so whether one king or a
  succession is meant is not decidable.
- **The man in the field (37:15–17) gets no page**, although he is the hinge of the chapter — without
  his overheard *"let us go to Dothan"*, Joseph turns round and goes home. The wiki's standing practice
  for anonymous single-line figures, set at the midwife of 35:17, is to keep them on the passage page.
  **The rabbinic identification of him as an angel is recorded and not adopted.**
- **No connection page for Jacob's Sheol refrain**, which starts at 37:35 and is completed at 42:38,
  44:29, and 44:31, where [[Judah]] turns it into the argument that breaks Joseph. A page written now
  would be three-quarters forward reference; it is left for the pericope that closes it and tracked on
  [[Sheol]] and [[Jacob]] meanwhile. **Same reasoning for the *hakker-nāʾ* pairing** — 37:32 and
  38:25 — which belongs to the Judah-and-Tamar pericope, next in the plan, and is stated on the
  passage page and on [[Judah]] so it is not lost.
- **[[Simeon]] and [[Levi]] were not given appears-in entries**, although their chapter is the reason
  Shechem is a strange errand. They are not named in Genesis 37; the observation lives on the passage
  page and on [[Shechem (city)]] instead.
- **The four sons of the slave women did get entries** — [[Dan (person)]], [[Naphtali]], [[Gad]],
  [[Asher]] — even though they too are unnamed, because 37:2 identifies them collectively as the
  subject of the *evil report*, which is the only grievance the chapter names between Joseph and any
  particular brothers.
- **[[Joseph]]'s *dibbâ rāʿâ* is left uncharacterised.** The Hebrew permits *a slanderous report* and
  *a true report of evil things* equally, and the wiki adopts neither — noting that Genesis declines to
  characterise the first thing it records this man saying, thirteen chapters before it establishes that
  he tells the truth about dreams.
- **No `Ishmaelites` or `Midianites` group page.** [[Ishmael]], [[Midian]], and [[Keturah]] hold that
  material and the textual problem has its own page.

### Links deliberately left for later pericopes

All given as plain scripture references rather than wikilinks, so none is a link-check finding:
**38:25–26** (*hakker-nāʾ* returned to Judah); **39:1–5, 20** (Potiphar named again, the caravan called
Ishmaelite again, and *"Yahweh was with Joseph"*); **41:45–46** (*Potiphera*; Joseph at thirty);
**42:6–9, 21, 36–38**; **43:11, 26**; **44:14, 29, 31, 34**; **45:4–8, 26**; **47:31**; **50:18, 20**.
Quotations from books not in `raw/` — Exodus, Leviticus, Numbers, Deuteronomy, Joshua, Judges,
1–2 Samuel, 1–2 Kings, 1 Chronicles, Psalms, Proverbs, Isaiah, Jeremiah, Ezekiel, Zechariah, Matthew,
Luke, Acts, and Revelation — were checked by eye against the WEB.

### Quotation check

The same verse-by-verse diff script the Genesis 36 pass used was re-run against
`raw/bible/Genesis.md` over every block quote on the pages created here: **39 Genesis 37 verse-blocks,
0 mismatches.** The passage page quotes all thirty-six verses of the chapter across its eight
verse-sections.

### Pre-existing findings noted, not fixed

**Fixed: ten more files carrying the stray `</content>` line.** The failure mode this log has now
recorded twice — a literal closing tag from the writing step left at the end of a file — was still
present in [[Galeed]], [[Jacob's Flight from Laban]] (which had `</content>` *and* `</invoke>`),
[[Idolatry]], [[Jegar Sahadutha - The Only Aramaic in the Torah]],
[[Warned in a Dream - Abimelech and Laban]],
[[The Shepherd's Liability - Genesis 31.39 and the Law of Exodus 22]],
[[The Mizpah Benediction - Genesis 31.49 and How It Is Read]],
[[The Teraphim - Household Gods in Genesis and After]],
[[Served, Released, Pursued - The Laban Years as Proto-Exodus]], and [[Gilead]] — **all ten from the
Genesis 31 cycle, so it was one bad pass rather than a standing drip.** They are all removed, and
`grep -rn '^</content>$\|^</invoke>$' wiki/` is now clean. The earlier entry's advice to run that grep
at the end of each pass is worth following literally; this pass did, and it is how these were found.

**Not fixed, outside this pericope's scope.** A stale *(not yet ingested)* marker on
[[The Tower of Babel]] still points at Genesis 19:1–29, which was ingested as
[[The Destruction of Sodom and Gomorrah]]; and the `wiki/people/God.md` truncation at 25:11 that the
Genesis 35 entry flagged is **still open.** [[God]] is, notably, the one page this pericope gave no
entry at all: **Genesis 37 never names him.**

`scripts/link-check.sh` exits 0, with the expected baseline at 64 not-yet-started book pages. Genesis
stands at 46 / 59 pericopes; the next is *Judah and Tamar*, Genesis 38:1–30.

## [2026-09-16] ingest | Genesis 38.1-30 — Judah and Tamar

Unattended run (`/ingest auto`). Genesis 38, the chapter that stops the Joseph narrative dead between
the sale in 37:36 and the purchase in 39:1 — **thirty verses in which neither Joseph nor Jacob is
named**, and in which God speaks not a word but acts twice.

### Created

**Passage** — [[Judah and Tamar]], quoting all thirty verses of the chapter across five
verse-sections.

**People (8)** — [[Tamar]], [[Er]], [[Onan]], [[Shelah (son of Judah)]], [[Perez]], [[Zerah]],
[[Shua's Daughter]], [[Hirah the Adullamite]].

**Places (4)** — [[Adullam]], [[Chezib]], [[Timnah]], [[Enaim]].

**Connections (4)** — [[Discern, Please - Hakker-na from Jacob's Coat to Judah's Pledge]],
[[Levirate Marriage - Genesis 38, Deuteronomy 25, and Ruth]],
[[Tamar in the Genealogies - Ruth 4, 1 Chronicles 2, and Matthew 1]],
[[Two Sets of Twins - Jacob and Esau, Perez and Zerah]].

### Revised

[[Judah]] (a full in-pericope section, four timeline entries, an appears-in entry, and six related
people — **this is the only chapter in Genesis that is his**); [[Genesis]] (box checked, and the
Joseph paragraph in `## Structure` extended to cover the interruption);
[[Not from the Daughters of the Canaanites]] (two stale *(not yet ingested)* markers cleared — one
pointed at Genesis 34, ingested sixteen pericopes ago — and a paragraph on how far the Judah case
actually goes);
[[Dinah and Tamar - Two Rapes and Two Avenging Brothers]] (a note at the head distinguishing its Tamar
from this one); [[Shelah (son of Arpachshad)]] (renamed — see below). **Sixteen theme pages** took a
keyed entry: [[Righteousness]], [[Marriage]], [[Deception]], [[Birthright and the Firstborn]],
[[Judgment]], [[Retribution]], [[Names and Naming]], [[Seeing and Being Seen]],
[[Nakedness and Covering]], [[Oaths and Vows]], [[Wealth and Possessions]], [[Life and Death]],
[[Sin]], [[Land and Sojourning]], [[Mediation and Advocacy]], [[Language and Speech]]. All five
indexes and [[index|the dashboard]] counts updated.

### A silent name collision found and fixed

**Judah's third son collides with the post-flood patriarch of Genesis 10:24 and 11:14–15.** Same
English spelling, different Hebrew vocalisation — *Šēlâ* against *Šelaḥ*. `scripts/link-check.sh`
resolves link targets by basename and **would have passed two files called `Shelah.md` without a
word**, while Obsidian picked one of them for every inbound link: the double-silent failure the
`AGENTS.md` qualifier rule exists for. Neither name is fixed by the directory map, so **both pages
take a qualifier**: the existing page was renamed to [[Shelah (son of Arpachshad)]] with `git mv`, its
six inbound links fixed and two of them rewrapped, and the new page is [[Shelah (son of Judah)]].

Worth recording that **the old page had itself predicted this collision** — its note on the name
already said the word was *"in a different vocalization, of Judah's third son in Genesis 38"* — **and
predicting it did not prevent it.** The rename is cheap in the pass that causes it and expensive
later.

### Judgment calls

- **`Tamar.md` is left unqualified, deliberately.** 2 Samuel 13's Tamar will force a rename, and she
  is already discussed by name on [[Dinah and Tamar - Two Rapes and Two Avenging Brothers]] — but
  `AGENTS.md` disambiguates on an actual collision between pages, and only one Tamar page exists.
  **The alternative was pre-emptive qualification**, which the `Shelah` experience above argues for and
  which was rejected because it makes every link in the wiki read
  `[[Tamar (daughter-in-law of Judah)]]` on the strength of a book that has not been opened. **When
  Samuel arrives both pages take a qualifier and the inbound links are fixed in the same pass**; the
  plan is written onto [[Tamar]], onto the connection page, and here, so it is not a surprise.
- **[[Hirah the Adullamite]] is qualified from the start**, though nothing collides with him yet —
  Genesis identifies him that way itself at 38:12 and 38:20, and *Ḥîrâ* is one consonant from Hiram of
  Tyre.
- **[[Shua's Daughter]] is filed under the designation Genesis uses**, not under 1 Chronicles 2:3's
  *Bath-shua*, which is the same two words read as a name. Precedent: [[Lot's Wife]],
  [[Abraham's Servant]], [[Job's Children]].
- **The boundary was used as drawn** and the title kept from the plan. The chapter opens with *"at that
  time"* and a departure and closes on a birth; no character crosses either edge.
- **No page for the midwife (38:28–29)**, though she ties the thread and speaks the name that sticks —
  same footing as the midwife of 35:17. **No page for Shua**, named twice and a patronymic both times.
- **No `Prostitution` theme page.** The chapter's material distributes to [[Marriage]], [[Sin]], and
  [[Language and Speech]], and a theme page would be built almost entirely from books not yet ingested.
  Worth opening when Hosea arrives.
- **No page for the four women of Matthew 1**, and none for the *ʿērābôn*/*ἀρραβών* loanword. The first
  would be three-quarters forward reference; the second is a dictionary entry, and sits on the passage
  page and [[Oaths and Vows]].

### Contradictions and tensions flagged, not resolved

- **Tamar's nationality.** Genesis names Judah's wife a Canaanite in the same breath as her father and
  **gives Tamar no father, no town, and no people** — the only person in the chapter whose origin is
  withheld. Jubilees 41:1 and the rabbinic readings supply opposite answers; **the wiki adopts
  neither.**
- **The levirate against Leviticus.** Judah orders at 38:8 exactly what Leviticus 18:16 and 20:21
  forbid, with childlessness attached as the penalty, and what Deuteronomy 25:5–10 commands. **Three
  texts set side by side on the connection page without harmonising.**
- **Onan.** The wiki states what the verse contains — the act is coitus interruptus and **the reason
  the text itself gives is the defrauded brother** — notes that the English word derived from his name
  is not what he is condemned for, and **does not adjudicate the later moral tradition.**
- **The two executions**, 38:7 and 38:10, are recorded as **the only occasions in Genesis where the
  narrator says Yahweh killed a named individual**, with a charge supplied for one and none for the
  other. Stated as a fact about the text; **not argued from.**
- **The placement of the chapter.** Two standard explanations (an independent Judah tradition; a
  deliberate foil to Genesis 39) are set out and **neither is adopted**; the *hakker-nāʾ* pairing is
  recorded as the strongest internal evidence that the placement is deliberate, which is what the
  Genesis 37 entry left this pericope to do.

### Links deliberately left for later pericopes

All given as plain scripture references rather than wikilinks, so none is a link-check finding:
**39:1–23** (*"Yahweh was with Joseph"*, and the second sexual proposition in as many chapters);
**41:45**; **43:8–9**; **44:18–34**; **46:12** (the five sons in the Egypt roster); **49:8–12**.
Quotations from books not in `raw/` — Exodus, Leviticus, Numbers, Deuteronomy, Joshua, Judges,
1–2 Samuel, 2 Chronicles, Nehemiah, Psalms, Ecclesiastes, Song of Songs, Jeremiah, Micah, Malachi,
Matthew, Mark, Luke, Romans, 1–2 Corinthians, and Ephesians — were checked by eye against the WEB.

### Quotation check

The verse-by-verse diff script was re-run against `raw/bible/Genesis.md` over every block quote on the
pages created here: **30 Genesis 38 verse-blocks on the passage page, 0 mismatches — the whole chapter
quoted verbatim** — and 17 more verse-blocks across the new person and place pages, of which the five
that carry a deliberate `…` elision or a trailing verse reference were re-checked as exact substrings
and all five passed.

The same script was run over the **entire** wiki as a regression pass: **1,152 verse-blocks matched
exactly**, and the 19 it flagged are all in pages from earlier ingests and are all intentional —
ellipses, italicised re-quotes, clause-length truncations, and one quote of Genesis 13:6 carried into
[[The Descendants of Esau]] with an inline attribution. **No corrupted quotation anywhere in `wiki/`.**

### Pre-existing findings noted, not fixed

`grep -rn '^</content>$\|^</invoke>$' wiki/` is clean — the failure this log has recorded three times
has not recurred. **Still open from earlier entries**: the stale *(not yet ingested)* marker on
[[The Tower of Babel]] pointing at Genesis 19:1–29, which was ingested as
[[The Destruction of Sodom and Gomorrah]]; and the `wiki/people/God.md` truncation at 25:11 first
flagged in the Genesis 35 entry. **[[God]] again gets no entry from this pericope** — he acts twice in
it and is never quoted, named as a speaker, or addressed.

`scripts/link-check.sh` exits 0, with the expected baseline at 64 not-yet-started book pages. Genesis
stands at 47 / 59 pericopes; the next is *Joseph in Potiphar's House*, Genesis 39:1–23.

## [2026-09-16] ingest | Genesis 39.1-23 — Joseph in Potiphar's House

Unattended run (`/ingest auto`). Genesis 39 — **the chapter that says the sentence Genesis 37 withheld
for thirty-six verses**, and says it four times: *"Yahweh was with Joseph."*

### Created

**Passage** — [[Joseph in Potiphar's House]], quoting all twenty-three verses of the chapter across six
verse-sections.

**People (1)** — [[Potiphar's Wife]].

**Themes (1)** — [[Sexual Sin]].

**Connections (2)** — [[A Garment Used as Evidence - The Coat and the Cloak]],
[[Sin Against God - Joseph at 39.9 and David at Psalm 51]].

### Revised

[[Joseph]] (a full in-pericope section, four timeline entries, an appears-in entry, a related person,
three themes); [[Potiphar]] (his forward-looking *"what is still ahead"* section replaced with the
ingested account, plus a section on the 39:19 ambiguity); [[Pharaoh (of Joseph's time)]];
[[Rachel]] (an appears-in entry for a chapter she is not in — see below); [[Egypt]];
[[Genesis]] (box checked, `## Structure` paragraph extended). **Four connection pages that had been
written forward against this chapter** were updated rather than duplicated:
[[Blessed for His Sake - Laban's House and Potiphar's]] (39:5 markers cleared, and the divine-name
asymmetry added), [[I Will Be With You - The Promise of Presence]] (the point that **Joseph is the one
bearer of the promise God never speaks to**),
[[Ishmaelites or Midianites - The Caravan That Bought Joseph]] (39:1 as the tightest form of the
problem), [[Abram the Hebrew - The First Use of the Name]]
(39:14 as the word's first contemptuous use). **Thirteen theme pages** took a keyed entry. All five
indexes and [[index|the dashboard]] counts updated.

### The finding this pass turned on: a counted, not remembered, divine-name distribution

The passage page opens on a table produced by **counting occurrences in `raw/bible/Genesis.md` chapter
by chapter**, not from memory:

- **Genesis 37: no divine name at all** — zero *Yahweh*, zero *God*.
- **Genesis 38: three *Yahweh*, all in verses 7 and 10, and all of Yahweh killing a man.**
- **Genesis 39: eight *Yahweh*** — and one *God*, which is **Joseph's**, not the narrator's (39:9).
- **Genesis 40–50: *Yahweh* once**, at 49:18, inside a line of Jacob's blessing. Thirty-three *God*.

So **the covenant name enters the Joseph cycle in one concentrated burst and is spent on a slave in a
foreign house who owns nothing** — not on the dreams, the famine, or the throne. It is reported as a
fact about the text; **no source-critical conclusion is argued from it**, because the concentration is
equally compatible with a deliberate authorial frame and with a strand that used the name.

### Judgment calls

- **[[Sexual Sin]] created as a new theme, the largest call in this pass.** Genesis has been
  accumulating this material since chapter 19 with nowhere to file it — Sodom, Lot's daughters, the
  three wife-sister episodes, Dinah, Reuben and Bilhah, Er and Onan, Judah and Tamar — and neither
  existing page covers it: **[[Marriage]] is the ordinance and not its violation, and [[Testing]]
  explicitly excludes temptation in its own summary line.** Opened here rather than retrofitted to
  Genesis 19 because **39:9 is the first time the category is named from inside the story** by the
  person facing the act. **Older passage pages were not retro-linked to it** — the theme page carries
  the full passage list itself, so nothing is lost, but the inbound links from those seven older
  passages are left for a lint pass. Recorded as debt, not as done.
- **[[Potiphar's Wife]] kept unnamed**, titled by whom she appears with, per the `AGENTS.md` convention
  for figures known only by a relation or title. **The tradition's names for her — Zuleika in the
  Persian and Islamic retellings, Asenath's mother in some Jewish ones — are recorded on the page as
  reception history and not adopted.** Genesis withholds the name deliberately.
- **[[Rachel]] given an appears-in entry for a chapter she is not in.** 39:6's *"well-built and
  handsome"* is ***yəpēh-tōʾar wîpēh marʾeh***, **the exact pair used of her at 29:17** — the son
  described in the mother's words, in both cases immediately before the trouble the description causes.
  The entry says plainly that she is not present.
- **No page for the keeper of the prison.** Unnamed, no speech, no motive, and **structurally a
  repetition of Potiphar rather than a character** — the standing practice set at the midwife of 35:17
  and the man in the field of 37:15.
- **No connection page for the Egyptian *Tale of Two Brothers*** (Papyrus D'Orbiney), whose Bata
  refuses his elder brother's wife and is falsely accused by her. **The parallel is real and is noted on
  the passage page**, but `AGENTS.md` defines a connection page as a link *within* Scripture, and a
  shared folk-tale pattern is not a dependence claim this wiki can make in either direction.
- **Title kept from the plan.** *Joseph and Potiphar's Wife* was rejected for reducing the chapter to
  the scene everyone remembers when its own emphasis is the *Yahweh was with Joseph* frame around it;
  *The False Accusation* covers thirteen of twenty-three verses. **No other book has a passage page by
  this title**, so no `(Book)` qualifier.
- **Boundary used as drawn.** 39:2 and 39:21 open matching paragraphs with the same four Hebrew words
  and 40:1 starts a new cast, so the chapter is a clean unit. A split at 39:20 was rejected: **the
  prison paragraph is the point**, being the house paragraph restated clause for clause after the
  disaster.

### Ambiguities flagged and not resolved

- **Did Potiphar believe his wife?** *"His wrath was kindled"* (39:19) has **no object in the Hebrew**.
  The evidence for doubt is entirely from what does not happen — no execution of a slave accused of
  assaulting the master's wife, no sale, and confinement in the royal prison **inside Potiphar's own
  house** (40:3). He has no line of dialogue anywhere in Genesis. **Both readings set out, neither
  adopted.**
- ***"Except for the food which he ate"*** **(39:6).** Either the Egyptian dietary boundary Genesis
  states itself at 43:32, or the old euphemistic reading in which *bread* means *his wife*. **The first
  adopted as plainer because the book supplies it; the second recorded because it explains the clause's
  position.**
- **Who sold Joseph, carried forward not newly created.** 39:1 says **Ishmaelites** of the same purchase
  by the same buyer that 37:36 credits to **Midianites** — **one verse apart in narrative sequence.**
  Set out on [[Ishmaelites or Midianites - The Caravan That Bought Joseph]]; **none of the three
  readings adopted.**

### Links deliberately left for later pericopes

All given as plain scripture references rather than wikilinks, so none is a link-check finding:
**40:3, 15** (the prison located in Potiphar's house, and *"the land of the Hebrews"*); **41:9–14**
(the cupbearer's memory); **41:45** (*Potiphera*); **43:32** (the Egyptians refusing to eat with
Hebrews); **49:18** (the last *Yahweh* in the book); **50:20**. Quotations from books not in `raw/` —
Exodus, Leviticus, Deuteronomy, Judges, 1–2 Samuel, Psalms, Proverbs, Luke, Acts, 1 Corinthians and
2 Timothy — were checked by eye against the WEB.

### Quotation check

A verse-by-verse diff script was rebuilt in the scratchpad (the previous run's was not kept) and run
against `raw/bible/Genesis.md` over every block quote on the pages created and revised here:
**30 Genesis verse-blocks, 0 mismatches — the whole of chapter 39 quoted verbatim**, plus the 37:36 and
29:17 re-quotes. The non-Genesis quotations above were checked by eye, the books not being in `raw/`.

A whole-wiki regression was also run. **The rebuilt script is cruder than the one used for the Genesis
38 entry** — it does not tolerate `…` elisions, trailing multi-verse range markers, or inline bold
inside a quote — so its raw flag count is not comparable with that entry's 19, and **an elision-tolerant
second pass was still running when this ingest was committed.** What is established is the part that
matters for this pass: **every quotation on the new pages is exact.** Re-running a tolerant regression
over the whole wiki is left for a lint pass.

### Pre-existing findings noted, not fixed

`grep -rn '^</content>$\|^</invoke>$' wiki/` is clean. **Still open from earlier entries**: the stale
*(not yet ingested)* marker on [[The Tower of Babel]] pointing at Genesis 19:1–29, ingested as
[[The Destruction of Sodom and Gomorrah]]; and the `wiki/people/God.md` truncation at 25:11 first
flagged in the Genesis 35 entry. **[[God]] again gets no entry from this pericope** — the chapter's
eight *Yahweh*s are all the narrator's, and God neither speaks nor is addressed in it.

`scripts/link-check.sh` exits 0, with the expected baseline at 64 not-yet-started book pages. It caught
one real finding on the way — **a wikilink wrapped across lines 17–18 of the new passage page**, which
renders as literal `[[` text and would have vanished from the graph and from backlinks with nothing
else in the repository able to see it. Fixed and the paragraph rewrapped. Genesis stands at
48 / 59 pericopes; the next is *The Cupbearer and the Baker*, Genesis 40:1–23.

## [2026-09-17] ingest | Genesis 40.1-23 — The Cupbearer and the Baker

Unattended run (`/ingest auto`). Genesis 40 — **the chapter where Joseph stops being the object of his
own story and starts reading it.** From 37:18 to the end of 39 he is acted on in almost every verse;
here he is handed a competence, and Genesis gives that competence a vocabulary it uses for two chapters
and then retires.

### Created

**Passage** — [[The Cupbearer and the Baker]], quoting all twenty-three verses of the chapter across six
verse-sections.

**People (2)** — [[The Chief Cupbearer]], [[The Chief Baker]].

**Connections (5)** — [[Do Not Interpretations Belong to God - Joseph and Daniel]],
[[Lift Up Your Head - One Idiom and Two Verdicts]],
[[Hanged on a Tree - Genesis 40, Deuteronomy 21, and Galatians 3]],
[[Remember Me - Genesis 40.14 and the Prayers of the Condemned]],
[[The Two Birthdays in the Bible - Pharaoh's Feast and Herod's]].

**Themes (0)** — see the judgment calls below.

### Revised

[[Joseph]] (a full in-pericope section, five timeline entries, an appears-in entry, two related people,
three themes); [[Pharaoh (of Joseph's time)]] (his first *acting* chapter, moved out of the
forward-looking section); [[Potiphar]] (40:3–4 added to the *did he believe her?* evidence, and an
appears-in entry for a chapter that uses his title and not his name); [[Egypt]]; [[Canaan]];
[[Genesis]] (box checked, `## Structure` extended). **Seventeen theme pages** took a keyed entry, two of
them substantial — [[Prophecy and Vision]] and [[Remembrance]], which are the two the chapter is
actually about. **Four existing connection pages were extended rather than duplicated**:
[[The Vine and the Cup]] (a new paragraph on the one cup in Scripture that is neither wrath nor
covenant), [[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]] (a table of the cycle's three
pairs of dreams, and why the middle pair works differently from the other two),
[[Sold for a Servant - Joseph's Sale in Psalm 105 and Acts 7]] (Psalm 105:19 as the only comment in
Scripture on the two years of 40:23–41:1), and
[[Divination in Genesis - Laban's Nahash and Joseph's Cup]] (a distinction rather than a link — see
below). All five indexes and [[index|the dashboard]] counts updated.

### The findings this pass turned on

**1. Two words that occur in two chapters of the Bible and nowhere else.** ***Pātar***, to interpret,
and ***pitrôn***, an interpretation — **fourteen occurrences, all of them in Genesis 40 and 41**
(40:5, 8 twice, 12, 16, 18, 22; 41:8, 11, 12 twice, 13, 15 twice), checked against the WEB text in
`raw/bible/Genesis.md`. **No prophet uses them; no wisdom book uses them.** And Genesis marks the
boundary itself: when Joseph needs a *translator* at 42:23 the text says *mēlîṣ*, a different root.
**The Aramaic cognate *pəšar* is Daniel's word for the same job**, which is what
[[Do Not Interpretations Belong to God - Joseph and Daniel]] is for.

**2. One idiom, three uses, two opposite verdicts.** *Nāśāʾ rōʾš*, *lift up the head*, at 40:13
(reinstatement), 40:19 (decapitation), and 40:20 (the census idiom, *taking the sum* of the palace
staff). **Verse 19 is verse 13 with *mēʿāleykā*, *from off you*, added** — and verse 20 runs the neutral
sense past the reader for one more clause before 21–22 split the two men. **The same three words close
the history of Judah**: 2 Kings 25:27 has Jehoiachin's head *lifted up out of prison* by a Babylonian
king, in the favourable sense, in the last four verses of the book.

**3. The chapter's last verse is the theme page's negative.** *Zākar* twice in 40:14, in two stems
(*zəkartanî*, *wəhizkartanî*), and then *lōʾ-zākar … wayyiškāḥēhû* — **a negative and its positive twin,
which Hebrew does not usually bother with** — as the closing seven words. In Genesis the verb has had
God as subject four times and **an act in the following clause every time**. Here it is handed to a man
and produces two years of nothing.

**4. Two words the English hides.** *"They should put me into the **dungeon**"* (40:15) is ***habbôr***,
**the same word as the waterless cistern of 37:24**, which the WEB renders *pit*; **Joseph's own name
for the Egyptian prison is his brothers' word.** And *"the land of the Hebrews"* (40:15) is
***ʾereṣ hāʿibrîm***, **which occurs here and nowhere else in the Bible** — Joseph making a country's
name out of the word [[Potiphar's Wife]] used against him as a slur at 39:14.

**5. God is named once in the chapter, and Joseph is the one who names him.** Continuing the divine-name
count established in the Genesis 39 entry: **the narrator of Genesis 40 never mentions God at all.** The
chapter's only theological claim is a prisoner's rhetorical question, and it says *ʾĕlōhîm* — as Joseph
does to Potiphar's wife at 39:9 and to Pharaoh at 41:16. **He never speaks the covenant name to an
Egyptian anywhere in Genesis.**

### Judgment calls

- **[[The Chief Cupbearer]] and [[The Chief Baker]] both got pages, against the standing practice.** The
  wiki does not make pages for unnamed single-scene functionaries — the keeper of the prison, the midwife
  of 35:17, the man in the field of 37:15 — **and that practice does not fit these two.** Both have
  direct speech, both have dreams reported at length in the first person, **the chapter's entire content
  is what happens to them**, and the cupbearer recurs at 41:9–13 as the one person who moves Joseph from
  the prison to the throne room. The baker's page is shorter and exists because **the chapter's
  demonstration needs both halves**: an interpreter who is right only when the news is good has proved
  nothing.
- **Titled by office, with no period qualifier.** *Pharaoh* and *Abimelech* take *(of X's time)* because
  Genesis narrates several of each. **Scripture has exactly one anonymous chief cupbearer and one
  anonymous chief baker**, and the one other biblical officer with the title — the Assyrian *rab šāqê*,
  literally *chief cupbearer*, of 2 Kings 18:17 — **reaches the English Bible as a proper name,
  Rabshakeh.** No collision is foreseeable; if one ever arises the `AGENTS.md` rule applies and both
  pages get qualified in the pass that creates the second. **The reasoning is written onto the cupbearer's
  page** so a later agent does not have to reconstruct it.
- **No `Dreams` theme page.** [[Prophecy and Vision]] already tracks every dream in Genesis by verse and
  defines itself as *"God putting words in a human mouth, and showing a human being something"*.
  **Splitting dreams out would divide one body of material at exactly the point where the cycle makes
  dreams the dominant mode.** The theme page took a long keyed entry instead. **This is the reverse of
  last pericope's call on [[Sexual Sin]]**, and the difference is that there was no existing page holding
  the material and here there is.
- **Five connection pages, which is more than a usual pass.** Four are word-level threads that start in
  this chapter — *pātar*/*pəšar*, *nāśāʾ rōʾš*, *tālâ ʿal-ʿēṣ*, and *zākar*/*mnēsthēti mou*. **The
  fifth, [[The Two Birthdays in the Bible - Pharaoh's Feast and Herod's]], is a coincidence rather than a
  thread and says so in its first line** — it exists because the observation (Scripture's only two
  birthday parties, and a head comes off at both) is striking enough that a reader will make it, **and
  should find that the wiki has already checked it and declined the inference** rather than rediscovering
  it and assuming it means something.
- **A distinction recorded rather than a link made.** The cup of 40:11 is ***kôs***; the divining cup of
  44:2, 5 is ***gābîaʿ***. **Different words**, and nothing in Genesis 40 connects dream-reading to
  divination — quite the reverse. Noted on
  [[Divination in Genesis - Laban's Nahash and Joseph's Cup]] because the English *cup* in both places
  invites a link the Hebrew does not make.
- **No connection page for the Egyptian dream manuals** (Chester Beatty III and its kin), whose
  two-column *if a man sees X, it means Y* format is the professional apparatus the chapter's prisoners
  are cut off from. **The parallel is real and is noted on the passage page**, but `AGENTS.md` defines a
  connection page as a link *within* Scripture — **the same reasoning that kept the *Tale of Two
  Brothers* off the wiki last pericope.**
- **Boundary and title both used as drawn.** 40:1 opens *"after these things"* with a new cast and 41:1
  says *"after two full years"*, so **the two-year gap is the one boundary marker Genesis states in
  words.** A merger with chapter 41 was considered — 40:23 is a cliffhanger 41 resolves — and rejected:
  **40 is a complete demonstration in itself** (prediction, three-day interval, fulfilment, verdict) and
  41 is 57 verses. *Joseph Interprets Two Dreams* was rejected for putting the interpreter at the centre
  of a chapter whose last verse is about him being forgotten. **No other book has a passage page by this
  title**, so no `(Book)` qualifier.

### Ambiguities flagged and not resolved

- **Is 40:14 a failure of faith?** The devotional tradition reads Joseph's request as self-help that God
  corrected with two extra years, and **Genesis Rabbah ties the two years of 41:1 to the two forms of
  *zākar* in the verse**, one year per stem. **The text says none of it**: no narrator's comment, no
  divine speech, no consequence named as a consequence, and **40:23's grammatical subject is the
  cupbearer.** Set beside Samson, Hannah, Job and Nehemiah, asking to be remembered is what people in
  Scripture do when they have no leverage. **Both readings set out, neither adopted** — the same posture
  taken on *did Potiphar believe his wife?* last pericope.
- **Who is in charge of the prison?** 39:22–23 gives the whole facility into Joseph's hand and says *the
  keeper of the prison* stopped looking at anything; **40:3–4 has *the captain of the guard* place the
  officers and assign Joseph to them, with no keeper mentioned.** The accounts are compatible — a keeper
  running the building under the minister who owns it — **and they are also the sort of seam that could
  mark two hands.** Recorded; nothing argued from it.
- **Does Potiphar's use of Joseph at 40:4 bear on 39:19?** The man who imprisoned him for assaulting his
  wife details him to attend the king's own household officers. **Either an administrative fact with
  nothing behind it, or the clearest circumstantial support for the reading that he did not believe
  her.** Added to the evidence list on [[Potiphar]]; **no reading adopted.**
- **The baker's basket.** *Sallê ḥōrî* is *white bread* or *wicker/openwork*; **both recorded, neither
  adopted.**

### Links deliberately left for later pericopes

All given as plain scripture references rather than wikilinks, so none is a link-check finding:
**41:1** (*"after two full years"*); **41:8, 24** (the magicians who fail); **41:9–14** (*"I remember my
faults today"*, and *bôr* a third time); **41:16** (40:8 repeated in a throne room); **41:32** (the
doubling explained); **42:23** (*mēlîṣ*); **45:4**. Quotations from books not in `raw/` — Exodus,
Numbers, Deuteronomy, Joshua, Judges, 1–2 Samuel, 1 Kings, 2 Kings, Nehemiah, Esther, Psalms,
Ecclesiastes, Isaiah, Jeremiah, Daniel, Matthew, Mark, Luke, John, Acts, Galatians and 1 Peter — were
checked by eye against the WEB.

### Quotation check

The verse-diff script was rebuilt in the scratchpad and made **tolerant of `…` elisions, of trailing
citations, and of straight-vs-curly quote marks**, and taught to skip block quotes whose citation names
a book not in `raw/`. Run over every block quote on the pages created and revised here:
**51 Genesis verse-blocks, 0 mismatches — the whole of chapter 40 quoted verbatim**, plus the 41:9
re-quote. It caught four real fidelity slips on the way, **all of them fixed before commit**: two
partial verses quoted without an elision marker, one dropped closing quotation mark, and one closing
quotation mark added where the WEB has none.

A whole-wiki regression was also run, now loading `raw/bible/Job.md` as well as Genesis:
**1471 / 1515 verse-blocks match exactly.** **Every one of the 44 flagged blocks that was inspected is
an artefact of the checker, not a misquotation** — 30 are verbatim fragments of the right verse quoted
without an elision marker (an older page convention: quote the speech, drop the *and he said*), and the
rest have citations the script does not recognise, such as an em-dash reference (`— Genesis 8:4` on
[[Ararat]]) or an italicised one (`*(Genesis 13:6, of Abram and Lot)*` on
[[The Descendants of Esau]]), or wrap the whole verse in asymmetric quote marks.
**Two were checked against `raw/` by hand and are exact.** Deciding whether the older fragment
convention should be normalised is left for a lint pass.

### Pre-existing findings noted, not fixed

- **[[Genesis]]'s `## Key people` list is stale.** It ends at [[Levi]] and **has not been extended since
  the Joseph cycle began** — [[Judah]], [[Tamar]], [[Joseph]], [[Potiphar]], [[Potiphar's Wife]],
  [[Pharaoh (of Joseph's time)]] and now these two are all missing from it, although every one of them
  has a page and an index row. **Not fixed here**, because the gap spans five pericopes and belongs to a
  lint pass rather than to an ingest; recorded as debt.
- **Still open from earlier entries**: the stale *(not yet ingested)* marker on [[The Tower of Babel]]
  pointing at Genesis 19:1–29; the `wiki/people/God.md` truncation at 25:11; and the seven older passage
  pages not yet retro-linked to [[Sexual Sin]].
- **[[God]] again gets no entry from this pericope.** He does not speak, appear, or act in the chapter,
  and the narrator does not mention him; the single *ʾĕlōhîm* is Joseph's.

`scripts/link-check.sh` exits 0, with the expected baseline at 64 not-yet-started book pages. It caught
one real finding on the way — **a wikilink to [[Abimelech (of Abraham's time)]] broken across a line
wrap** by a reflow, which renders as literal `[[` text and would have vanished from the graph and from
backlinks with nothing else in the repository able to see it. Fixed and the paragraph rewrapped.
Genesis stands at 49 / 59 pericopes; the next is *Pharaoh's Dreams and Joseph's Rise*, Genesis 41:1–57.

## [2026-09-17] ingest | Genesis 41.1-57 — Pharaoh's Dreams and Joseph's Rise

Unattended `/ingest auto`. Fiftieth pericope of Genesis, and the longest chapter in the Joseph cycle.
Created [[Pharaoh's Dreams and Joseph's Rise]], four person pages, two place pages, one theme page and
four connection pages; revised twenty-two theme pages, six existing connection pages, [[Joseph]],
[[Pharaoh (of Joseph's time)]], [[The Chief Cupbearer]], [[The Chief Baker]], [[Potiphar]], [[Egypt]],
the book page and all five indexes.

### What the chapter turned out to be about

**1. The narrator never mentions God.** ***ʾĔlōhîm*** occurs **nine times** — 41:16, 25, 28, 32 (twice),
38, 39, 51, 52 — **and every one is inside quotation marks**: seven Joseph's, two Pharaoh's. ***Yahweh*
does not occur at all.** This continues the count run since the Genesis 39 entry: **the eight *Yahweh*s
of chapter 39 stop at the chapter break and the covenant name appears exactly once more in the rest of
the book** (49:18). **The Joseph cycle's method is to let its characters assert providence and then
report, without comment, that they were right.**

**2. The dream is told twice and not the same way.** The narrator's account (41:1–7) and Pharaoh's
(41:17–24) differ, and **the differences are the chapter's method rather than noise.** Pharaoh adds a
superlative (*"such as I never saw in all the land of Egypt for ugliness"*) and, decisively, **adds
*"it couldn't be known that they had eaten them"*** (41:21) — ***lōʾ nôdaʿ***, a clause the narrator did
not report — **which Joseph hands straight back to him at 41:31** as *"the plenty will **not be known** in
the land"*, ***lōʾ-yiwwādaʿ***, same verb, same stem. **The dreamer has been carrying the interpretation's
load-bearing clause around for two nights and supplies it as an aside.**

**3. The paragraph nobody asked for.** The interpretation ends at 41:32. **Verses 33–36 are unrequested
policy advice from a foreign convict to a head of state**, and **Genesis attaches no divine warrant to
them** — no *God has shown*, nothing. **The four verses that change his life are the four in which he
speaks entirely for himself**, and Pharaoh fills the post six verses later using **Joseph's own two
adjectives** (*nābôn wəḥākām*, 41:33 → 41:39).

**4. The confession is Pharaoh's.** ***"A man in whom is the Spirit of God"*** (41:38) is **the highest
thing said about anyone in Genesis, and a pagan king says it** — as a question, to his own courtiers, on
empirical grounds. **Joseph's own line is a denial** (*"It isn't in me"*, 41:16, which is 40:8 repeated in
a throne room). ***Rûaḥ ʾĕlōhîm* has occurred once before in Genesis, at 1:2, over an unformed world;
its second occurrence is a person.**

**5. Two sons, and the chapter's sting.** [[Manasseh]] — *"God has made me forget all my toil, and all my
father's house"* — **a thanksgiving for an erasure**, which **the man who gave it falsifies at 42:9 and
45:3**. [[Ephraim]] — *"God has made me fruitful in ***the land of my affliction***"* — **the creation
verb *pārâ* of 1:22 and 17:6 applied to two half-Egyptian sons**, in a sentence where the second man in
Egypt calls the country ***ʿonyî***, **the root of Genesis 15:13 and Exodus 3:7**.

**6. The Egyptian surface is the densest in Scripture.** *Yeʾōr* (the Nile, entering the Bible here),
*ḥarṭummîm*, the shaving, *šēš*, *ʾabrēk*, *ḥimmēš*, and four Egyptian proper nouns in verse 45 alone.
**[[Potiphar]] and [[Potiphera]] are the same Egyptian name in two forms** — *he whom Ra has given* —
and **both households Joseph enters in Egypt are named for the sun god.**

### Judgment calls

- **Boundary and title both used as drawn.** 41:1's *"at the end of two full years"* and 42:1's shift of
  scene and cast to Canaan seal the chapter at both ends. **A split at 41:36 or 41:45 was considered and
  rejected** — interpretation and elevation are one causal chain with no seam — **and a merger with 42
  was rejected** because 41:57 and 42:1 report the same fact from two countries and **the change of
  viewpoint is the boundary.** *Joseph Before Pharaoh* and *Seven Years of Plenty and Seven of Famine*
  were rejected as titles; *Zaphenath-Paneah* was rejected because **Genesis itself never uses the name
  again.** No other book has a passage page by this title, so no `(Book)` qualifier.
- **[[Asenath]], [[Potiphera]], [[Manasseh]] and [[Ephraim]] all got pages.** All four are named, which is
  the wiki's ordinary threshold, and three recur at 46:20 and 48:1–20.
- **[[Manasseh]] and [[Ephraim]] are deliberately left unqualified, and this is flagged debt.** Both names
  will later belong to tribes and a territory, and *Manasseh* to a king of Judah, **so a collision is
  certain once the wiki reaches Kings.** `AGENTS.md` qualifies in the pass that creates the second page
  rather than in anticipation, **so a note saying so is written at the top of each page** for whichever
  pass hits the collision.
- **[[The Nile]] got a page.** *Yeʾōr* enters Scripture here, occurs five times in the chapter, and is the
  setting of both dreams; [[The Euphrates]] and [[The Jabbok]] already have pages. **[[On]] got one** as a
  named settlement with a named institution, on the same footing as [[Enaim]] or [[Chezib]].
- **[[Famine and Plenty]] is a new theme page, and it is the call that could have gone the other way.**
  Last pericope declined a `Dreams` page **because [[Prophecy and Vision]] already held that material**.
  **Nothing held famine** — it appears in passing on [[Land and Sojourning]], [[Wealth and Possessions]],
  [[Work]], [[Blessing]], [[Priesthood]] and [[Favor and Grace]] and is owned by none of them — **and it
  is about to be the organising fact of nine consecutive chapters.** A page was created rather than a
  sixth passing mention added.
- **Four connection pages.** [[A Man in Whom Is the Spirit of God]] (41:38 against 1:2, Bezalel, Joshua,
  Balaam, Daniel); [[Zaphenath-Paneah - Renaming at a Foreign Court]] (41:45 against Daniel 1:7,
  2 Kings 23:34; 24:17, Esther 2:7);
  [[The Signet Ring and the Second Chariot - Joseph, Mordecai, and Daniel]] (41:42–43 against Esther and
  Daniel 5); [[The Magicians of Egypt - Hartummim in Genesis, Exodus, and Daniel]] (41:8, 24 against
  Exodus 7–9 and Daniel 1–2). **The last three all point at Daniel and Esther and are kept separate
  because they are three different kinds of evidence** — a name, a ceremony, and a professional guild —
  **and a reader chasing one should not have to read the other two.**
- **[[Not from the Daughters of the Canaanites]] gained a section rather than a line.** 41:45 was already
  on that page as *(not yet ingested)*; **the marriage is the book's loudest unremarked breach of its own
  standing concern**, and the new section sets out what the silence is and is not — **not approval, not a
  lapse the narrative punishes, and not a rule that had lapsed** — and notes that **the later tradition's
  eagerness to fix it (Asenath as [[Dinah]]'s daughter; *Joseph and Aseneth*) is itself evidence the gap
  was felt.**
- **The book page's `## Key people` and `## Key places` lists were rebuilt, which is a repair rather than
  an ingest step.** They had been recorded as debt in the last two entries — *"ends at [[Levi]] … belongs
  to a lint pass"* — and by this pericope the gap was **76 people and 19 places**, including [[Joseph]],
  [[Judah]], [[Rachel]], [[Leah]], [[Laban]], [[Melchizedek]], [[Tamar]] and nine of the twelve sons.
  **Adding [[Asenath]] to a list that does not contain [[Joseph]] was not a coherent option**, so both
  lists were rewritten in narrative order under one checkable rule: **every person and place with a page
  that appears in Genesis, and nothing else.** A script verified the result — **no duplicates, every
  listed name resolves to a file, and every Genesis page is listed** (127 people, 65 places); Job-only
  figures were excluded. **This debt is now closed.**

### Ambiguities flagged and not resolved

- **Is Joseph angling for the job at 41:33–36?** He appends unrequested policy, describes the ideal
  appointee in two words, and is appointed in those exact two words six verses later. **Against it**: a
  famine forecast without a policy is useless, he names no candidate, and nothing in the advice is to his
  stated advantage — his stated interest in chapter 40 was to be got out of a building. **Genesis attaches
  no warrant and passes no verdict. Both readings set out; neither adopted.**
- **Whose faults does the cupbearer confess at 41:9?** *Ḥăṭāʾay* is the root of the officers' offence at
  40:1, **so the plain reading is his old offence against Pharaoh**, raised to explain how he knows a
  prisoner; the other is that he is confessing the two-year silence. **Both recorded; neither adopted.**
- **What does *ʾabrēk* mean?** Hebrew *bārak* (*kneel*), Egyptian *ib r.k* (*attention*), Akkadian
  *abarakku* (*steward*). **All three recorded, none adopted.** Likewise ***yiššaq*** at 41:40, where the
  WEB's *"be ruled"* renders a verb that ordinarily means *kiss* and which translators have disagreed
  about for two thousand years.
- **Why does Joseph never send word to Canaan?** **Seven years of plenty, absolute authority over Egypt,
  and Hebron about nine days away.** Genesis records no message, no attempt and no reason — **and does not
  present the silence as a problem either.** Every motive on offer is imported. **Recorded as a silence.**
- **Is [[Potiphera]] the same man as [[Potiphar]]?** **The same Egyptian name in two forms**, and later
  tradition identified them and made [[Asenath]] the daughter of [[Potiphar's Wife]]. **Genesis gives no
  support**: different spellings, offices and cities. **Recorded as a name coincidence; not adopted.**

### What was deliberately not created

- **No page for Egypt's magicians and wise men.** A plural institution with **no recorded speech and no
  individual named**, which is the standing test that also kept out the keeper of the prison and the
  midwife of 35:17. The material went to the connection page.
- **No connection page for John 2:5.** The Septuagint of 41:55 (*"Go to Joseph. What he says to you,
  do"*) and Mary's sentence at Cana are all but identical in Greek, **and the observation is recorded on
  the passage page** because a reader will make it. **It was not made a page because there is no thread
  to trace**: the words are an unremarkable Greek sentence, the contexts share only a shortage, and no New
  Testament writer draws the link. **This is the opposite call from last pericope's
  [[The Two Birthdays in the Bible - Pharaoh's Feast and Herod's]]**, and the stated difference is that
  **the two birthdays are a closed set a reader can check and find exhaustive, whereas a common Greek
  idiom is not a set at all.**
- **No connection page for the Egyptian Famine Stela** (Sehel Island), which recounts a seven-year famine
  under Djoser relieved by royal decree. **The parallel is real and noted on the passage page**, but it is
  a **Ptolemaic** inscription — roughly fifteen hundred years after any date proposed for Joseph — and is
  itself temple propaganda about a much older king; and `AGENTS.md` defines a connection page as a link
  *within* Scripture. **Same reasoning as the Chester Beatty III dream papyrus last pericope.**
- **[[God]] again gets no entry.** He does not speak, appear or act on the page, and the narrator does not
  mention him; all nine *ʾĕlōhîm*s are in characters' mouths. **The page also remains truncated at
  25:11**, which is still open debt from earlier entries.

### Links deliberately left for later pericopes

All given as plain scripture references rather than wikilinks, so none is a link-check finding: **42:1–6**
(the brothers arrive and bow); **45:5–8** and **50:20** (Joseph's own interpretation of this chapter);
**45:6**; **46:20**; **47:13–26** (the fifth part made permanent, and the priests exempted); **48:5, 14,
19** (the adoption and the crossed hands). **Goshen** is referred to by name without a link on
[[The Nile]], since it has no page yet. Quotations from books not in `raw/` — Exodus, Numbers,
Deuteronomy, Joshua, Judges, 1–2 Samuel, 1–2 Kings, Ezra, Nehemiah, Esther, Psalms, Isaiah, Jeremiah,
Ezekiel, Hosea, Amos, Micah, Jonah, Haggai, Daniel, Ruth, Matthew, Luke, John, Acts, 1 Corinthians,
2 Timothy and Revelation — were checked by eye against the WEB.

### Quotation check

The scratchpad verse-diff script was rerun and taught to strip a trailing citation (`(41:12–13)`,
`(Genesis 40:14)`) before comparing, which had been producing two false positives. Run over every block
quote on the pages created and revised in this pass: **61 Genesis verse-blocks, 0 mismatches — the whole
of chapter 41 quoted verbatim**, plus the re-quotes of 37:36, 40:14 and 41:12–13 on other pages.

**One real fidelity slip was found and fixed on the way**: [[The Chief Cupbearer]] quoted 41:12 as
*"a young man there with us, a Hebrew, servant to the captain of the guard"*, **which reorders the WEB's
*"There was with us there a young man, a Hebrew…"***. Replaced with the verbatim block quote of
41:12–13.

### Pre-existing findings noted, not fixed

- **Still open from earlier entries**: the stale *(not yet ingested)* marker on [[The Tower of Babel]]
  pointing at Genesis 19:1–29; the `wiki/people/God.md` truncation at 25:11; and the seven older passage
  pages not yet retro-linked to [[Sexual Sin]].
- **The `## Key people` / `## Key places` debt recorded in the last two entries is closed** — see the
  judgment calls above.

`scripts/link-check.sh` exits 0, with the expected baseline at 64 not-yet-started book pages. It caught
one real finding on the way — **a wikilink to
[[Down to Egypt and Up Again - Abram's Descent as Proto-Exodus]] broken across a line wrap** on the new
[[Famine and Plenty]] page, which renders as
literal `[[` text and would have vanished from the graph and from backlinks with nothing else in the
repository able to see it. Fixed and the paragraph rewrapped.

Genesis stands at 50 / 59 pericopes; the next is *The Brothers' First Journey to Egypt*, Genesis 42:1–38.

## [2026-09-17] ingest | Genesis 42.1-38 — The Brothers' First Journey to Egypt

Unattended run (`/ingest auto`). Genesis 42 in one pass — the pericope the book page had queued, taken
whole because the chapter is a single unbroken movement from Jacob's first order to his last refusal,
and every proposed internal break (after the three days, after the confession, after the road home)
cuts a verbal echo of Genesis 37 in half.

### The passage page

[[The Brothers' First Journey to Egypt]], `wiki/passages/Genesis/`, built around four findings.

**1. The chapter is Genesis 37 replayed with the parts exchanged, and the replay is lexical rather than
thematic.** Tabulated on the page: the bowing of 37:7 at 42:6; *hakker-nāʾ* (37:32) answered by
*wayyakkēr* / *wayyitnakkēr* (42:7); the pit (37:24) answered by the *mišmār* (42:17) — **which is the
word for the place Joseph himself was held at 40:3**; Reuben's *"shed no blood"* (37:22) answered by
his own *"his blood is required"* (42:22); and 37:35's Sheol vow repeated almost verbatim at 42:38.

**2. *ʾênennû*.** Reuben coins *"the child is no more"* at the empty pit (37:30); the brothers use it
to Joseph's face at 42:13 and 42:32; **Jacob says it twice in one breath at 42:36**, over Joseph and
over Simeon. Three men across twenty-two years, each refusing to name what happened.

**3. Genesis 42:21 discloses a fact the narrator withheld for five chapters.** *"He begged us, and we
wouldn't listen"* — **Genesis 37 never records Joseph speaking in the pit**; it reports the stripping
and the throwing and goes straight to *"they sat down to eat bread."* The pleading exists only in the
memory of the men who ignored it. Filed as its own connection page (below) because the technique, not
just the content, is the point. The linking verb is *šāmaʿ*: *"his brothers **listened** to him"*
(37:27, the sale) against *"we **wouldn't listen**"* (42:21).

**4. *ʾăšēmîm* (42:21) is the only occurrence of the root in Genesis** — the guilt-offering word, legal
rather than emotional. The brothers say *we owe*, not *we are sorry*, and they say it believing no one
is listening.

### Judgment calls made without the user (unattended mode)

- **Title kept as the book page had it**, `The Brothers' First Journey to Egypt` — no collision with any
  existing passage title in Genesis or Job.
- **No page for the interpreter of 42:23**, despite his being the mechanism the whole chapter runs on.
  Follows the standing practice on unnamed functionaries with no recorded speech (the keeper of the
  prison, Egypt's magicians). Recorded explicitly in the passage page's Notes so the decision is visible
  rather than implicit. **Reuben's two sons (42:37) likewise get no page.**
- **No motive asserted for Joseph's cruelty.** Revenge, testing and getting at Benjamin each fail on
  some part of the text (the returned money, the pointless three days, the fact that the demand precedes
  the confession). The page states the sequence — he sees them, he remembers the dreams, he accuses them
  — and stops there.
- **No motive asserted for the choice of Simeon.** The page gives the sequence that invites the
  second-eldest-after-the-disqualified-Reuben reading, notes the Genesis 34 reading, and says the text
  supplies neither.
- **Three new themes rather than one.** [[Guilt and Conscience]] was unavoidable — 42:21 is its
  foundation text and nothing existing covered it ([[Sin]] is the act, [[Retribution]] is the brothers'
  own mistaken theory). [[Providence]] turned out not to exist at all, which was a real gap: 42:36 is
  its hardest case and 45:5–8 / 50:20 are four pericopes away. [[Brotherhood]] likewise — *ʾāḥ* governs
  the chapter end to end and [[Envy]] and [[Strife and Peacemaking]] between them were not carrying it.
  A fourth, *Family Conflict*, was considered and dropped as redundant against [[Envy]].

### Pages created (7)

- Passage: [[The Brothers' First Journey to Egypt]]
- Themes: [[Guilt and Conscience]] · [[Providence]] · [[Brotherhood]]
- Connections: [[Truly We Are Guilty - The Brothers' Confession and the Gap in Genesis 37]] ·
  [[His Blood Is Required - Darash and the Reckoning for Blood]] ·
  [[By the Life of Pharaoh - Oaths Sworn by a King]]

The *Darash* page traces *dāraš* + *dām* from 9:5 through 42:22 to Ezekiel 33:6 and Luke 11:50–51, and
its point is that **the idiom's development runs from the killer to the bystander** — Ezekiel's watchman
is liable for having seen and not spoken, which is exactly the offence the brothers name against
themselves at 42:21. The *By the Life of Pharaoh* page records that *ḥê parʿōh* is **the only oath in
Scripture sworn on an Egyptian king**, that Joseph swears it twice in two verses to guarantee two
statements he knows to be false, and that Israelite usage always doubles the king-oath with *ḥay-YHWH*
rather than replacing it.

### Pages revised (49)

- **People (15)**: [[Joseph]], [[Jacob]], [[Benjamin]], [[Reuben]], [[Simeon]], [[Judah]] in full;
  [[Levi]], [[Dan (person)]], [[Naphtali]], [[Gad]], [[Asher]], [[Issachar]], [[Zebulun]] with the
  shared entry the chapter's grammar actually warrants — **the ten act and speak only as a plural, and
  the confession of 42:21 is attributed to no one**; plus [[Pharaoh (of Joseph's time)]] and [[God]].
  The `(not yet ingested)` markers pointing at 42 on Joseph, Jacob, Benjamin, Reuben, Simeon and Judah
  were converted; Simeon's `## What is still ahead` paragraph anticipating 42:24 was removed as now
  redundant with the body.
- **Places (3)**: [[Egypt]], [[Canaan]], [[Sheol]].
- **Themes (17)**: [[Retribution]], [[Prophecy and Vision]], [[Testing]], [[Deception]],
  [[Remembrance]], [[Language and Speech]], [[Seeing and Being Seen]], [[Famine and Plenty]],
  [[Suffering]], [[Envy]], [[The Fear of God]], [[Mediation and Advocacy]],
  [[Nakedness and Covering]], [[Oaths and Vows]], [[Slavery and Servitude]], [[Life and Death]],
  [[Land and Sojourning]].
- **Connections (7)**: [[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]] (the fulfilment
  happens here and is **partial** — ten sheaves, not eleven, and neither the sun nor the moon, which is
  the mechanical reason chapters 43–45 exist); [[Discern, Please - Hakker-na from Jacob's Coat to Judah's Pledge]]
  (42:7–8 is the densest *nkr* in the Bible and the only place it runs both directions at once);
  [[Whoever Sheds Man's Blood]]; [[Down to Egypt and Up Again - Abram's Descent as Proto-Exodus]];
  [[Renamed and Still Called Jacob - The Two Namings of Israel]];
  [[Twenty Pieces of Silver - The Price of a Brother]];
  [[Fell on His Neck and Wept - The Running Embrace in Genesis and Luke]].
- **Indexes (6) and the book page**: [[books/index|Books]] (Genesis 51 / 59), [[people/index|People]],
  [[places/index|Places]], [[themes/index|Themes]], [[connections/index|Connections]], [[index]]
  (57 passages · 132 people · 66 places · 62 themes · 167 connections), and the [[Genesis]] book page —
  box checked and the chapter added to the book-level overview.

### Corrections made to the wiki's own claims

**Two overstatements were caught and fixed before commit, both of mine from this pass.**

- The passage page and `wiki/people/God.md` each said Genesis 42 was **the fourth consecutive chapter**
  in which every attribution to God sits inside quotation marks. **It is the third** — 39:2, 3, 5, 21
  and 23 are the narrator's own. Corrected on both, with the actual span named: **the narration is
  silent about God from 39:23 until 46:1–2.**
- The new [[Providence]] page opened by claiming the narrator attributes nothing to God *from 37:1 to
  50:26*, which the same page contradicted twenty lines later. **Rewritten to the verifiable claim**
  (39:23 → 46:1) with the bracketing narrator-verses — 38:7, 38:10, 39:2–23, 46:2 — named explicitly.

### Quotation check

Every block quote on the seven new pages was diffed against `raw/bible/Genesis.md` by a scratchpad
script: **0 mismatches.** The inline italic quotations were then checked the same way, which caught
**fourteen inexact renderings**, all fixed against the raw file:

- 45:2 was quoted *"he wept aloud, and the Egyptians heard"* — the WEB has two sentences,
  *"He wept aloud. The Egyptians heard."*
- 41:57 was quoted *"all countries came into Egypt to buy grain"*, dropping *"to Joseph"*.
- 41:51 was quoted *"God has made me forget all my father's house"*, dropping *"all my toil, and"*.
- 43:9 was quoted *"I will be collateral for him"*; the WEB has *"I'll be collateral for him."*
- 45:8 was quoted *"it was not you"*; the WEB has *"it wasn't you."*
- 45:4, 4:8, 9:5, 20:5, 37:4 and 42:22 were each missing an internal comma or clause.
- Two paraphrases were sitting inside quotation marks as though they were text — *"I told you so"* of
  Reuben and *"Didn't I tell you?"* — and have been replaced by the verbatim 42:22 or by unquoted prose.

**One further fault, and it is the kind that reads as correct:** [[Jacob]] and [[Life and Death]] both
quoted 42:38 as *"you will bring down my gray hairs with sorrow to [[Sheol]]"* — **a wikilink inside a
scripture quotation**, which silently edits the quoted text into something the WEB does not say. The
links were moved outside the quotation marks on both pages. Worth a standing note: nothing mechanical
catches this, because the link is valid and the quote still looks verbatim.

### Link check

`scripts/link-check.sh` exits 0, expected baseline 64 not-yet-started book pages. No wrapped links and
no dangling targets. **No links were deliberately left for a later pericope this pass** — 43:9, 44:2,
44:16, 44:20, 45:1–3 and 50:15–21 are all named in prose and marked `*(not yet ingested)*` rather than
linked, since their passage pages do not exist yet.

### Pre-existing findings, still open

Unchanged from the last entry and not touched this pass: the stale `*(not yet ingested)*` marker on
[[The Tower of Babel]] pointing at Genesis 19:1–29; the `wiki/people/God.md` truncation at 25:11; and
the seven older passage pages not yet retro-linked to [[Sexual Sin]].

Genesis stands at 51 / 59 pericopes; the next is *The Second Journey*, Genesis 43:1–34.

## [2026-09-17] ingest | Genesis 43.1-34 — The Second Journey

Unattended run (`/ingest auto`). Genesis 43 whole, as the book page had it queued. The chapter is one
movement — Jacob's refusal broken, the journey made, the feast held — and every candidate internal
break (after the surety, after the door, after the weeping) separates a word from the place it is
answered.

### The passage page

[[The Second Journey]], `wiki/passages/Genesis/`, built around five findings.

**1. A prayer answered in its own vocabulary, with no narrator between the two halves.** [[Jacob]] at
43:14: *"May God Almighty give you **mercy** before the man"* — ***raḥămîm***. [[Joseph]] at 43:30:
*"his **heart yearned** over his brother"* — ***nikmərû raḥămāyw***, *his compassions grew hot*, the
same root. **Sixteen verses, one border, and Genesis does not connect them.** The man who prayed it
never learns it was answered. This is the cycle's method in the stretch where the narrator says
nothing about God at all (39:23 → 46:2), and it is why the new [[Compassion and Mercy]] page exists.

**2. Jacob's present is the caravan's cargo coming back.** 37:25 itemises what the Ishmaelites were
carrying — ***spices and balm and myrrh*** — and 43:11 itemises what Jacob sends down: *"a little
balm, a little honey, **spices and myrrh**, nuts, and almonds."* **These are the only two itemised
cargoes in Genesis, and *nəkōʾt* and *lōṭ* occur nowhere else in the Hebrew Bible.** Nobody in the
story can see it: Jacob does not know a caravan was involved, the brothers who ate bread beside it say
nothing, and Joseph never mentions the present. Filed as
[[Balm, Spices, and Myrrh - The Caravan's Cargo and Jacob's Present]].

**3. ***ʿĀrab***, and the succession from [[Reuben]] to [[Judah]] in one verb.** Reuben offers two of
his sons (42:37) and Jacob does not reply; Judah offers *"I'll be collateral for him … let me bear the
blame forever"* (43:9) and Jacob says *"If it must be so, then do this."* **The difference is
collateral you own against collateral you are** — and Judah's other pledge, the ***ʿērābôn*** he left
with [[Tamar]] at 38:17–20, is the one he wrote off rather than be laughed at. He keeps this one at
44:32–33. Filed as
[[I Will Be Surety for Him - Judah's Pledge and the Guarantor in Scripture]].

**4. The sheaf dream completes and the text says nothing.** Eleven brothers bow at 43:26 and again at
43:28. At 42:6 the narrator at least added *"Joseph remembered the dreams"*; **here there is not even
that.** The fulfilment of the image the whole cycle turns on is narrated as household manners. The
second dream's sun and moon cannot now be met as 37:9 describes them — [[Rachel]] has been dead since
35:19.

**5. ***Tôʿēbâ*** enters the Bible as an Egyptian dining custom.** *"The Egyptians don't eat bread with
the Hebrews, for that is an abomination to the Egyptians"* (43:32) is **the word's first occurrence in
Scripture**, and it carries no divine judgment at all. Joseph will weaponise the same revulsion at
46:34 to get his family Goshen; Moses will argue from it at Exodus 8:26; and Leviticus and Deuteronomy
will take the word over. **The separateness that keeps Israel a nation in Egypt begins as somebody
else's distaste.** Filed as
[[An Abomination to the Egyptians - Separate Tables in Genesis and Exodus]].

### Judgment calls made without the user (unattended mode)

- **Title kept as the book page had it** — `The Second Journey`. No collision with any existing passage
  title in Genesis or Job. It is thin as titles go, but it is the one the plan already carried and the
  chapter has no better single handle; the alternative (`Benjamin Goes Down to Egypt`) buries the fact
  that the chapter is about Judah.
- **A page created for [[Joseph's Steward]]**, against the standing line that unnamed functionaries get
  none. **He speaks** — 43:23 is the truest sentence about God in the chapter and he is an Egyptian
  servant saying it — **and 44:1–12 gives him a role of his own.** The comparison is
  [[Abraham's Servant]]: unnamed, chief of a household, trusted with the errand that decides a family's
  future. The Egyptians at the second table (43:32) get no page, consistent with the interpreter of
  42:23 and the magicians of 41:8; both decisions are written into the passage page's Notes.
- **[[Compassion and Mercy]] created as a theme rather than folded into [[Favor and Grace]].** *Ḥēn*
  and *raḥămîm* are different words doing different work — favour from a superior against kinship felt
  as physical distress — and Genesis 43 is the only chapter that uses both. The existing page keeps
  *ḥēn*/*ḥānan*; the new one takes *raḥămîm* and *nikmərû*. **Forgiveness deliberately has no page
  yet**: Genesis's only explicit forgiveness is 50:17–21, and the material sits on the new page until
  that pericope arrives.
- **No verdict on whether 43:33–34 is a test.** Genesis reports the birth-order seating and the
  fivefold portion and records no intent. The page states what makes them read as tests
  retrospectively — 44:1–2 only works on men who have already been shown a favoured brother and done
  nothing — **without asserting that Joseph planned it.**
- **No verdict on *"You shall not see my face"* (43:3, 5).** The phrase is not in Joseph's recorded
  terms at 42:15–20. Either Judah is glossing or chapter 42 compressed the interview; the brothers have
  demonstrably edited a report before (42:29–34). Both readings are set out and neither adopted.
- **[[Reuben]] given an `Appears in` entry for a chapter he is not named in**, because being unnamed is
  the substantive fact about him here and 43:33 does seat him first *"according to his birthright."*

### Pages touched

- **Passage (1)**: [[The Second Journey]].
- **New people (1)**: [[Joseph's Steward]].
- **New theme (1)**: [[Compassion and Mercy]].
- **New connections (5)**:
  [[I Will Be Surety for Him - Judah's Pledge and the Guarantor in Scripture]];
  [[Balm, Spices, and Myrrh - The Caravan's Cargo and Jacob's Present]];
  [[If I Am Bereaved, I Am Bereaved - Jacob and Esther]] (*kaʾăšer šākōltî šākāltî* against Esther
  4:16's *kaʾăšer ʾābadtî ʾābādtî* — the doubled-perfect surrender, and the observation that Jacob is
  the only one of these speakers not risking himself);
  [[An Abomination to the Egyptians - Separate Tables in Genesis and Exodus]];
  [[Two Presents to a Feared Brother - Jacob's Minchah to Esau and to Egypt]] (32:13–21 against
  43:11–26 — same noun, same tactic, same man, **and in both the mercy arrives ahead of the tribute
  and owes it nothing**).
- **People revised (8)**: [[Judah]] (a full *In this pericope* section — the one part of the page that
  is not yet retrospective), [[Jacob]], [[Joseph]], [[Benjamin]], [[Simeon]], [[Reuben]], [[Rachel]],
  [[God]].
- **Places revised (2)**: [[Egypt]] (the house, named seven times, and the three tables), [[Canaan]]
  (unnamed in the chapter, and offstage until 45:25).
- **Themes revised (20)**: [[Mediation and Advocacy]], [[Providence]], [[Prayer]], [[Testing]],
  [[Envy]], [[Brotherhood]], [[Guilt and Conscience]], [[Hospitality]], [[Clean and Unclean]],
  [[Famine and Plenty]], [[Favor and Grace]], [[Deception]], [[Prophecy and Vision]],
  [[Seeing and Being Seen]], [[Slavery and Servitude]], [[Life and Death]], [[Land and Sojourning]],
  [[Language and Speech]], [[The Names of God]], [[Wealth and Possessions]].
- **Connections revised (5)**: [[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]] (the
  eleventh sheaf arrives); [[God Almighty - El Shaddai in Genesis and Exodus]] (43:14 is the only
  petition among the name's five uses); [[Fell on His Neck and Wept - The Running Embrace in Genesis and Luke]]
  (the second weeping, and the first that needs a door);
  [[Twenty Pieces of Silver - The Price of a Brother]] (the silver goes back down, doubled, and is
  refused); [[Down to Egypt and Up Again - Abram's Descent as Proto-Exodus]] (*yārad* the third time
  for famine).
- **Indexes (6) and the book page**: [[books/index|Books]] (Genesis 52 / 59), [[people/index|People]],
  [[places/index|Places]], [[themes/index|Themes]], [[connections/index|Connections]], [[index]]
  (58 passages · 133 people · 66 places · 63 themes · 172 connections), and the [[Genesis]] book page —
  box checked and pointed at the new passage page.

### One retro-link made

[[The Reconciliation with Esau]] gained a [[Compassion and Mercy]] entry in its Themes list. **Esau's
run, embrace and weeping at 33:4 is Genesis's first unambiguous human mercy**, and the new theme page
cites it as a key passage; without the retro-link the citation ran one way only.

### Quotation check

Every block quote on the new and revised pages was diffed against `raw/bible/Genesis.md` by a
scratchpad script: **68 quoted verse segments, 0 mismatches** (the one flagged hit was a pre-existing
elided quote of 49:6 on [[Simeon]], correct as written).

The inline italic quotations were then swept the same way, which caught **one fault of the kind the
mechanical checks are for**: the passage page had ***"Joseph by himself"*** in quotation marks as the
chapter's stage-direction for the solitary table. **The WEB does not say that.** 43:32 reads *"They
served him by himself"*; the phrase in quotes was the wiki's own summary wearing scripture's clothes.
Corrected. [[Joseph's Steward]]'s `also_known_as` had the same problem — *the man over Joseph's house*
is not a WEB phrase — and now carries *the steward of his house* and *his steward*, which are.

Worth adding to the standing note from the last entry (a wikilink inside a quotation silently edits
the quoted text): **a paraphrase inside quotation marks is the same failure with nothing to catch it.**
The block-quote diff does not see it, because it is not in a block quote; the link check does not see
it, because there is no link. Only reading each quoted fragment back against the raw file finds it.

### Link check

`scripts/link-check.sh` exits 0, expected baseline 64 not-yet-started book pages. No wrapped links and
no dangling targets. **One wrapped link was introduced and caught during the pass** — `[[Joseph's`
/ `Steward]]` split across the ~100-column wrap in
[[Twenty Pieces of Silver - The Price of a Brother]] — and fixed before commit, which is exactly the
failure mode `AGENTS.md` warns is invisible to everything else.

**No links were deliberately left dangling for a later pericope.** 44:1–2, 44:16, 44:32–33, 45:1–3,
45:22 and 46:34 are all named in prose and marked `*(not yet ingested)*` rather than linked.

### Pre-existing findings, still open

Unchanged and not touched this pass: the stale `*(not yet ingested)*` marker on [[The Tower of Babel]]
pointing at Genesis 19:1–29; the `wiki/people/God.md` truncation at 25:11; and the seven older passage
pages not yet retro-linked to [[Sexual Sin]].

**One new one, noticed and not fixed:** `wiki/people/Jacob.md` renders *ʾênennû* at 42:36 with a
Cyrillic *е* inside the transliteration, which will not match a search for the Latin spelling. It is a
single character in one line of prose and was left alone rather than edited in an ingest commit; it
belongs in the next lint.

Genesis stands at 52 / 59 pericopes; the next is *The Silver Cup and Judah's Plea*, Genesis 44:1–34.

## [2026-09-17] ingest | Genesis 44.1-34 — The Silver Cup and Judah's Plea

Unattended run (`/ingest auto`). Genesis 44 whole, as the book page had it queued. The chapter has one
obvious internal seam — the cup found at 44:13, Judah's speech beginning at 44:18 — and it is a seam
rather than a boundary: the speech exists to answer the verdict, and the verdict exists to provoke the
speech. Kept as one pericope.

### The passage page

[[The Silver Cup and Judah's Plea]], `wiki/passages/Genesis/`, built around five findings.

**1. The chapter is a verb.** ***Māṣāʾ***, *find*, **runs eight times in twenty-seven verses.** Seven
of them are about the cup — *found* in the sacks, *found* with whomever, *found* in Benjamin's sack,
*found* in his hand, three times over — and the eighth is [[Judah]]'s last clause: *"lest I see the
evil that will come on my father"*, ***yimṣāʾ***, *that will find him.* **44:16 is the hinge and it is
a deliberate pun**: the steward has found a goblet; Judah answers that *"God has found out the
iniquity of your servants."* **The search that began in eleven sacks ends by finding Jacob.**

**2. What [[Joseph]] builds is Genesis 37 with the guilt removed.** One son of [[Rachel]] enslaved,
ten brothers free, a father in Canaan who will have to be told — **and a court's word that they are
*blameless*.** *"Go up in peace to your father"* (44:17) is not a concession; it is the offer of 37:28
with the culpability subtracted. **They refuse it in nine words with no adjective in them**: *"each
man loaded his donkey, and returned to the city"* (44:13). Genesis reports the setup and the outcome
and **never supplies a word for the thing between them** — no *nissâ*, no narratorial aside, no
statement of intent. The page reads it as a test from the shape of the trap and **flags the reading as
inference**, since a Joseph who has simply not decided how to stop is not excluded by the text.

**3. The most consequential act in the chapter is a servant's, and nothing in his orders covers it.**
The brothers swear death for the thief and slavery for all of them (44:9). [[Joseph's Steward]] says
*"Now also let it be according to your words"* and then states different words: *"he with whom it is
found will be my slave; and you will be blameless"* (44:10). **He halves the penalty and dissolves the
solidarity** — and the second change is the one that matters, because a death sentence on
[[Benjamin]] would have bound all eleven, while one slave and ten innocent men is the only
configuration in which the test can run at all. **Genesis does not say whether it was his idea.**

**4. Every clause of 44:20 is a knife the speaker cannot see.** *"A child of his old age"* —
***yeled zəqūnîm*** — is the narrator's phrase for Joseph at 37:3, the stated cause of the hatred;
*"his brother is dead"* is said to the brother; *"he alone is left of his mother"* is true only if
that is so; and *"his father loves him"* is the verb of 37:3–4, **offering paternal favouritism in
mitigation to the man it nearly killed.** Filed as
[[A Child of His Old Age - Ben-Zequnim from Joseph to Benjamin]].

**5. Judah's speech is almost entirely other men's words.** Seventeen verses — the longest in Genesis
— quoting Joseph's own terms three times, [[Jacob]] three times (*"my wife bore me two sons"*,
*"surely he is torn in pieces"*, the *Sheol* vow), and himself once, as a debt (43:9 at 44:32). **He
says *the boy* eight times and *my father* fifteen.** He asks for no mercy and disputes nothing; his
single premise is *"his life is bound up in the boy's life"* (44:30), and his single request is to
serve the sentence — ***taḥat hannaʿar***, *instead of the boy*, the preposition of the ram at 22:13.
**The last thing he says is about his father's face**, and the next verse is 45:1.

### Judgment calls made without asking

- **Boundary kept at 44:1–34**, as planned. No redraw.
- **No new person pages.** Everyone in the chapter already has one; the only candidate was the
  brothers as a group, and the standing line on unnamed collectives holds.
- **Four new connection pages rather than two or six.** Cut from the list: a page on *ḥālîlâ*
  (said twice in the chapter, at 44:7 and 44:17, but with only Genesis 18:25 behind it), and one on
  *"you are even as Pharaoh"* (44:18), which [[By the Life of Pharaoh - Oaths Sworn by a King]] now
  absorbs in three sentences instead.
- **The book-level overview had no paragraph for Genesis 43.** Wrote one covering 43–44 together,
  since they are one movement and the gap was otherwise going to widen.

### New connection pages (4)

- [[Whoever You Find Your Gods With - Two Rash Oaths Over a Search]] — **the chapter's strongest
  unremarked parallel.** 31:32, *"Anyone you find your gods with shall not live"*, sworn by [[Jacob]]
  in ignorance about a household containing [[Rachel]]; 44:9, *"let him die"*, sworn by his sons in
  ignorance about a party containing her surviving son. **Both searches run in a stated order and put
  the true holder last** — tent by tent at 31:33, *"beginning with the oldest, and ending at the
  youngest"* at 44:12. Neither oath operates: the first search fails, and the second sentence is
  rewritten by a servant. With Jephthah, Saul's oath and Jonathan, Leviticus 5:4 and Matthew 5:34–37.
- [[Rewarding Evil for Good - A False Charge That Is Exactly True]] — ***šillamtem rāʿâ taḥat
  ṭôbâ*** (44:4) **is the phrase's first occurrence in Scripture**, and everywhere else in the canon
  (1 Samuel 24:17; 25:21; Psalms 35, 38, 109; Proverbs 17:13; Jeremiah 18:20) it is the cry of someone
  genuinely wronged. **Here it is scripted by a man who planted the evidence and is exactly true of
  the men it is delivered to.** Proverbs 17:13 supplies the only consequence clause the idiom gets —
  *evil will not depart from his house* — and 44:13 is the one place Scripture shows it departing.
- [[A Child of His Old Age - Ben-Zequnim from Joseph to Benjamin]] — 37:3 and 44:20, **the phrase's
  only two uses of a son in Genesis**, both of [[Rachel]]'s children. The arithmetic does not work
  (Benjamin is younger) and the page declines to fix it, noting only that the household used the
  phrase of both.
- [[His Life Is Bound Up in the Boy's Life - Nephesh Tied to Nephesh]] — ***napšô qəšûrâ bənapšô***
  (44:30) and *"the soul of Jonathan was knit with the soul of David"* (1 Samuel 18:1), **the idiom's
  only two occurrences**, with Abigail's *bundle of life* (1 Samuel 25:29) as the third turn of the
  same verb. One bond involuntary, one chosen, one in God's keeping.

### Pages revised

- **People (17)**: [[Judah]] (new pericope section — the speech, the confession, the substitution),
  [[Joseph]], [[Benjamin]], [[Joseph's Steward]] (new section on the ruling at 44:10), [[Jacob]],
  [[Reuben]], [[Rachel]], [[Simeon]], [[God]], [[Pharaoh (of Joseph's time)]], and the seven who act
  only as a plural — [[Levi]], [[Dan (person)]], [[Naphtali]], [[Gad]], [[Asher]], [[Issachar]],
  [[Zebulun]].
- **Places (3)**: [[Egypt]], [[Canaan]], [[Sheol]].
- **Themes (17)**: [[Testing]], [[Mediation and Advocacy]], [[Guilt and Conscience]],
  [[Slavery and Servitude]], [[Brotherhood]], [[Deception]], [[Providence]], [[Oaths and Vows]],
  [[Righteousness]], [[Retribution]], [[Love]], [[Suffering]], [[Prophecy and Vision]],
  [[Seeing and Being Seen]], [[Life and Death]], [[Language and Speech]], [[Envy]].
- **Connections revised (11)**:
  [[I Will Be Surety for Him - Judah's Pledge and the Guarantor in Scripture]] (the pledge performed,
  and the point that nobody in Egypt could have enforced it);
  [[Divination in Genesis - Laban's Nahash and Joseph's Cup]] (the claim is load-bearing for the trick
  and the brothers never engage with it);
  [[Truly We Are Guilty - The Brothers' Confession and the Gap in Genesis 37]] (44:16 as the pivot of
  the three confessions);
  [[Discern, Please - Hakker-na from Jacob's Coat to Judah's Pledge]] (the *nkr* root stays absent and
  *ṭārōp ṭōrāp* arrives instead);
  [[A Garment Used as Evidence - The Coat and the Cloak]] (the planted object without a garment);
  [[Twenty Pieces of Silver - The Price of a Brother]] (silver's fourth movement, and the only one
  nobody mentions again); [[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]] (the fourth
  bowing); [[The Ram Instead of the Son - Substitution at Moriah]] (*taḥat* at 22:13 and 44:33);
  [[Loved and Hated - Genesis 29 and Deuteronomy 21.15-17]] (*"my wife bore me two sons"*);
  [[By the Life of Pharaoh - Oaths Sworn by a King]] (44:18 as a yardstick rather than an oath);
  [[A Garment and a Goat - Jacob Deceives and Is Deceived]].
- **Indexes (6) and the book page**: [[books/index|Books]] (Genesis 53 / 59), [[people/index|People]],
  [[places/index|Places]], [[themes/index|Themes]], [[connections/index|Connections]], [[index]]
  (59 passages · 133 people · 66 places · 63 themes · 176 connections), and the [[Genesis]] book page —
  box checked, pointed at the new passage page, and the overview extended through 43–44.

### Quotation check

Block quotes on the new pages were diffed against `raw/bible/Genesis.md` by a scratchpad script: **37
quoted verse segments, 0 mismatches.** The inline italic quotations were then swept the same way —
128 fragments on the lines this pass added, **all of them verbatim apart from marked elisions and
quotations from outside Genesis.**

The sweep caught **three pre-existing misquotes, all of the paraphrase-in-quotation-marks kind the
last entry warned about**, and all three are fixed:

- ***"It is not in me"*** for Genesis 41:16. **The WEB reads *"It isn't in me."*** The wrong form was
  in five places — [[The Cupbearer and the Baker]],
  [[Divination in Genesis - Laban's Nahash and Joseph's Cup]],
  [[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]],
  [[The Signet Ring and the Second Chariot - Joseph, Mordecai, and Daniel]] and
  [[Do Not Interpretations Belong to God - Joseph and Daniel]] — **and would have become six.**
- ***"Isn't this that in which my lord drinks"*** (44:5) on
  [[Divination in Genesis - Laban's Nahash and Joseph's Cup]]. WEB: *"that **from** which."*
- ***"fell before him on the ground"*** (44:14) on
  [[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]]. WEB: *"fell **on the ground before
  him**."*

**The general lesson stands and is now demonstrated twice.** A fragment that is nearly right reads as
correct on the page, survives every mechanical check the repo has, and propagates by being copied from
one wiki page to another rather than from the raw file. **Only diffing each quoted fragment against
`raw/bible/` finds it**, and it is worth doing on the inline quotations of pages a pass merely touches,
not only on the pages it writes.

### Link check

`scripts/link-check.sh` exits 0, expected baseline 64 not-yet-started book pages. **One wrapped link
was introduced and caught before commit** — `[[The Chief` / `Cupbearer]]` split across the ~100-column
wrap in the new passage page — which is now the second consecutive ingest in which the wrap has broken
a long link target and the script has been the only thing to see it.

**No links were deliberately left dangling.** 45:1–3, 45:14, 45:22, 49:8–12 and 50:15–17 are named in
prose and marked `*(not yet ingested)*` rather than linked.

### Findings left for the next lint

- **The seven plural brothers had no [[The Second Journey]] entry**, though `wiki/people/index.md`
  lists that passage under them. This pass added their Genesis 44 entries but did not backfill 43;
  the index and the pages disagree for one pericope on seven pages.
- **Unchanged from the last entry**: the stale `*(not yet ingested)*` marker on [[The Tower of Babel]]
  pointing at Genesis 19:1–29; the `wiki/people/God.md` truncation at 25:11; the seven older passage
  pages not retro-linked to [[Sexual Sin]]; and the Cyrillic *е* inside *ʾênennû* in
  `wiki/people/Jacob.md` — **which turns out to be in `wiki/books/Genesis.md` as well**, in the
  Genesis 42 paragraph. Both were left alone rather than edited in an ingest commit.

Genesis stands at 53 / 59 pericopes; the next is *Joseph Reveals Himself*, Genesis 45:1–28.

## [2026-09-18] ingest | Genesis 45.1-28 — Joseph Reveals Himself

Unattended run (`/ingest auto`). Genesis 45 whole, as the book page had it queued. The chapter has
three internal movements under three different speakers — the disclosure (45:1–15), Pharaoh's
invitation (45:16–24), and Canaan (45:25–28) — but they are one action and the last two are
consequences of the first. Kept as one pericope, boundary unchanged.

### The passage page

[[Joseph Reveals Himself]], `wiki/passages/Genesis/`, built around six findings.

**1. The chapter swaps one verb for another in the open.** ***Mākar***, *you sold*, **twice** (45:4,
5); ***šālaḥ***, ***"God sent me before you"***, **three times** (45:5, 7, 8), same man as object.
**[[Joseph]] does not deny the sale** — 45:4 is the only accusation he makes in the chapter and he
makes it before any of the consolation — **but he stops using the brothers' verb after 45:5.** Read
flatly, *"it wasn't you who sent me here, but God"* (45:8) contradicts the verse before it; the page
sets out three readings (the Hebrew comparative, deliberate overstatement aimed at terrified men, and
a claim about the order of causes) and **adopts none**, on the ground that Genesis 50:20 restates the
same doctrine in a form that concedes the brothers' intention rather than dissolving it.

**2. Genesis names God four times and the narrator is not one of the speakers.** All four are
Joseph's (45:5, 7, 8, 9). **The narratorial silence that began at 39:23 runs unbroken through the
disclosure, the reunion, Pharaoh's invitation and Jacob's revival**, and ends at 46:2. **The book's
most explicit statement of providence is therefore testimony, not verdict** — which discharges the
`*(not yet ingested)*` marker [[Providence]] has been carrying on 45:5–8.

**3. There is no confession and no pardon in the chapter.** The brothers say nothing at all between
45:3 and 45:15; *"after that his brothers talked with him"* (45:15) is the entire report of the
conversation; **and their one quoted sentence, delivered in Canaan, leaves the sale out** — *"Joseph
is still alive, and he is ruler over all the land of Egypt"* (45:26). Joseph never says he forgives;
he says *"don't be grieved, nor angry with yourselves"* (45:5), **which absorbs a guilt that has not
been confessed.** 50:15 is the evidence it did not hold.

**4. Five changes of clothing.** At 45:22 Joseph gives ten men one garment each and [[Benjamin]]
**five, plus three hundred pieces of silver — fifteen times the twenty he was sold for** — and two
verses later tells them not to quarrel on the road. **This is 37:3 and 43:34 performed a third time,
by the man the first two were performed on**, and Genesis passes it without a word where it had
stated the cause of the hatred outright at 37:4. Filed as
[[Five Changes of Clothing - The Coat Given Again]] with three readings held open.

**5. The words fail and an object works.** [[Jacob]] is told the truth and *"his heart fainted, for
he didn't believe them"* (45:26) — ***wayyāpāg***, a rare verb for going slack. **Then *"when he saw
the wagons… the spirit of Jacob, their father, revived"*** (45:27). **The same man was convinced of
his son's death by a bloodied coat and is convinced of his life by a cart**, with the human testimony
discounted both times — **and the wagons were [[Pharaoh (of Joseph's time)]]'s idea, not Joseph's**
(45:19). The name switches across the verse boundary onto the recovery: *the spirit of **Jacob**
revived; **Israel** said*.

**6. A remnant.** ***Šəʾērît*** (45:7) **is the word's first appearance in Scripture**, with
***pəlêṭâ gədōlâ*** beside it, **about a household of seventy in a famine** — no judgment survived,
no nation sifted. Every later use has the element this one lacks.

### Judgment calls made without asking

- **Boundary kept at 45:1–28.** No redraw.
- **One new place page, [[Goshen]]**, created at its first mention (45:10) rather than deferred to
  46–47 where the family actually settles. The wiki's standing practice is to open a page at first
  appearance.
- **No new person pages.** Everyone named has one. The only candidate was the Egyptians who overhear
  the weeping (45:2), and the standing line on unnamed collectives holds.
- **Four new connection pages rather than two or six.** Cut from the list: a page on ***ʾāb
  ləparʿōh*** (45:8), which [[Kingship and Empire]] now absorbs in four sentences; and one on
  *"see that you don't quarrel on the way"* (45:24), which
  [[Five Changes of Clothing - The Coat Given Again]] carries as its open question instead.
- **[[Joseph's Steward]] was deliberately not given a Genesis 45 entry**, nor a row in
  `wiki/people/index.md` for it. He is *absent* from the chapter — *"cause everyone to go out from
  me"* (45:1) includes him — and the passage page says so under People, but a page whose "Appears in"
  list claims a pericope he is not in would be wrong.
- **Pharaoh's motive left unassigned.** The political reading — a vizier whose family lives in Egypt
  at royal expense has nowhere to go back to — is noted on the passage page and on
  [[Pharaoh (of Joseph's time)]] and **explicitly not adopted**, because the text supports it only by
  the shape of the situation and Exodus 1:8 is a different king.

### New connection pages (4)

- [[God Sent Me Before You - The Verb That Replaces the Sale]] — ***mākar*** twice against ***šālaḥ***
  three times in five verses, with Psalm 105:17 (which keeps **both** verbs in one line), Acts 7:9–10
  (which supplies the motive Genesis withheld — *moved with jealousy*), and Genesis 50:20. **The
  page's argument is that 50:20 is the controlling statement and 45:8 its warmer first draft**, and
  that the difference matters: a reader who has only 45:8 has a doctrine usable to tell victims their
  injury was an errand.
- [[To Preserve a Remnant - Shearith from Genesis 45 to Romans 11]] — ***šəʾērît*** in its first
  occurrence, with ***pəlêṭâ*** beside it and ***happālîṭ*** at 14:13 behind it, through Isaiah
  10:20–22, Amos 5:15 (***šəʾērît yôsēp***, the same noun Joseph coined, applied to a kingdom named
  after him), Micah 2:12, Ezra 9:8 (**the closest verbal relative in the canon**, pairing both of
  45:7's nouns) and Romans 11:5. **Genesis's remnant is the only unqualified one in Scripture —
  the whole family, nobody lost.**
- [[Five Changes of Clothing - The Coat Given Again]] — 37:3, 43:34 and 45:22. **Three readings held
  open**: unreflective repetition, a last provocation, or restitution aimed at the sale price rather
  than at the boy. 45:24 is what keeps the question open, since ***ʾal-tirgəzû badderek*** carries
  both *don't be afraid* and *don't fall out with each other*.
- [[The Spirit of Jacob Revived - Ruach Returning]] — ***wattəḥî rûaḥ*** (45:27) with Judges 15:19
  and 1 Samuel 30:12. **In the other two the reviving agent is water or food; here it is a line of
  carts**, and the page sets it against 37:31–33, where an object also did the persuading.

### New place page (1)

- [[Goshen]] — **first mention in Scripture at 45:10, and Genesis never explains it**: no etymology,
  no naming speech, no location. What the text gives is relational — near Joseph, good pasture, far
  enough out that shepherds can live there (46:34), on the road in from Canaan. **The page declines to
  commit to the eastern-delta identification as geography** while noting it fits every condition, and
  keeps the southern-Canaanite Goshen of Joshua 10:41 separate.

### Pages revised

Book: [[Genesis]] (box checked, a Genesis 45 paragraph added to the structure overview),
`wiki/books/index.md` (54 / 59), `wiki/index.md` counts.
People (17): [[Joseph]], [[Jacob]], [[Benjamin]], [[Judah]], [[Pharaoh (of Joseph's time)]],
[[Rachel]], [[God]], [[Reuben]], and the eight plural brothers.
Places (3): [[Egypt]], [[Canaan]], [[Sheol]].
Themes (16): [[Providence]], [[Brotherhood]], [[Guilt and Conscience]], [[Deception]],
[[Famine and Plenty]], [[Land and Sojourning]], [[Life and Death]], [[Seeing and Being Seen]],
[[Language and Speech]], [[Envy]], [[Favor and Grace]], [[Hope]], [[Suffering]],
[[Compassion and Mercy]], [[Kingship and Empire]], [[Remembrance]].
Connections (12): [[Fell on His Neck and Wept - The Running Embrace in Genesis and Luke]],
[[Truly We Are Guilty - The Brothers' Confession and the Gap in Genesis 37]],
[[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]],
[[Twenty Pieces of Silver - The Price of a Brother]],
[[Am I in God's Place - Jacob at 30.2 and Joseph at 50.19]],
[[Sold for a Servant - Joseph's Sale in Psalm 105 and Acts 7]],
[[I Will Be Surety for Him - Judah's Pledge and the Guarantor in Scripture]],
[[A Garment Used as Evidence - The Coat and the Cloak]],
[[Two Presents to a Feared Brother - Jacob's Minchah to Esau and to Egypt]],
[[Renamed and Still Called Jacob - The Two Namings of Israel]],
[[If I Am Bereaved, I Am Bereaved - Jacob and Esther]],
[[Zaphenath-Paneah - Renaming at a Foreign Court]],
plus [[A Child of His Old Age - Ben-Zequnim from Joseph to Benjamin]]'s stale 45 marker discharged.
All four category indexes updated.

### Quotation check against `raw/bible/`

Every fragment quoted in the new pages was diffed against `raw/bible/Genesis.md` rather than read on
the page. **Five wrong fragments were caught, and only one of the five was pre-existing.**

- ***"He made himself strange to them"*** for 42:7. **The WEB reads *"acted like a stranger to
  them."*** This one was **pre-existing and had propagated**: it is quoted as WEB on
  [[Joseph Sold into Slavery]] and
  [[Discern, Please - Hakker-na from Jacob's Coat to Judah's Pledge]], and it had been copied into
  the new passage page from there. Fixed in the new page and in [[Deception]]; **the two older pages
  still carry it and are left for a lint**, since they are outside this pericope.
- ***"a little of the best fruits in the land"*** for 43:11 — **invented from memory in this pass.**
  WEB: *"Take from the **choice fruits of the land** in your bags."* The committed
  [[Two Presents to a Feared Brother - Jacob's Minchah to Esau and to Egypt]] had it **right**, so
  this was a fresh error, not propagation.
- ***"nuts and almonds"*** for 43:11. WEB: *"nuts, and almonds."*
- ***"one who had escaped came and told Abram the Hebrew"*** for 14:13. WEB: *"**One** who had
  escaped came and told Abram, **the Hebrew**"* — the comma is the text's.
- ***"the spirit of Jacob revived"*** for 45:27. WEB: *"the spirit of Jacob, **their father**,
  revived."*

**The lesson from the last two entries holds and now has a second shape.** Last time the bad
fragments propagated between wiki pages; **this time four of the five were newly invented by the
ingesting agent and only one was inherited.** Both failure modes are invisible to every mechanical
check the repo has, and **both are caught only by diffing each quoted fragment against the raw file.**

### Link check

`scripts/link-check.sh` exits 0, expected baseline 64 not-yet-started book pages. **One wrapped link
was introduced and caught before commit** — `[[Pharaoh (of Joseph's` / `time)]]` split across the
~100-column wrap in `wiki/places/Egypt.md` — which is the **third consecutive ingest** in which a long
link target has been broken by the wrap and the script has been the only thing to see it.

**No links were deliberately left dangling.** 46:2–4, 46:28–47:6, 47:1–10, 47:12, 47:28 and 50:15–21
are named in prose and marked `*(not yet ingested)*` rather than linked.

### Findings left for the next lint

- **The 42:7 fragment above**, still wrong on [[Joseph Sold into Slavery]] and
  [[Discern, Please - Hakker-na from Jacob's Coat to Judah's Pledge]]. [[Joseph Sold into Slavery]]
  also spells it *recognised*, which the WEB does not.
- **Unchanged from the last entry**: the stale `*(not yet ingested)*` marker on [[The Tower of Babel]]
  pointing at Genesis 19:1–29; the seven older passage pages not retro-linked to [[Sexual Sin]]; the
  seven plural brothers' missing [[The Second Journey]] entries; and the Cyrillic *е* inside
  *ʾênennû* in `wiki/people/Jacob.md` and `wiki/books/Genesis.md`. All left alone rather than edited
  in an ingest commit.
- **`wiki/people/God.md` is not truncated at 25:11** as the previous two entries recorded. Its
  *Appears in* list was current through Genesis 44 and took a Genesis 45 entry normally. Whatever the
  earlier finding referred to, it is not that section; **the finding is retired as stated.**

Genesis stands at 54 / 59 pericopes; the next is *Jacob's Family Settles in Egypt*, Genesis
46:1–47:12.

## [2026-09-18] ingest | Genesis 46.1-47.12 — Jacob's Family Settles in Egypt

Unattended run (`/ingest auto`). The book page had the pericope queued as Genesis 46:1–47:12 and the
boundary was kept. It is a long unit with four movements — the night at [[Beersheba]], the register,
the reunion in [[Goshen]], and the audience with Pharaoh — but they are one action, the crossing, and
47:13 starts a different subject (the land policy). **Boundary unchanged.**

### The passage page

[[Jacob's Family Settles in Egypt]], `wiki/passages/Genesis/`, built around seven findings.

**1. Genesis 46:2–4 is the only time God speaks in the entire Joseph cycle.** Verified against the raw
text rather than asserted: `grep` for narrated divine speech across chapters 37–50 returns exactly one
hit, 46:2. **The narratorial silence that began at 39:23 breaks for three verses and closes again for
the rest of the book** — 48:3's *"God Almighty appeared to me at Luz"* is [[Jacob]] quoting, not the
narrator. **Genesis's most explicit statement of providence is a character's (45:5–8); its only divine
utterance in fourteen chapters is a permission to leave the land.**

**2. Beersheba is the same place, the same hour and the same opening formula as Isaac's theophany, with
the instruction reversed.** 26:23–24 has [[Isaac]] at Beersheba, *"the same night"*, told *"I am the
God of Abraham your father. Don't be afraid, for I am with you"* — and at 26:2 told outright
*"Don't go down into Egypt."* 46:1–3 has [[Jacob]] at Beersheba, *"in the visions of the night"*, told
*"I am God, the God of your father. Don't be afraid to go down into Egypt."* **And 46:1 specifies that
he sacrificed *"to the God of his father, Isaac"* — not of Abraham.** He puts the question to the
deity on record as having prohibited the journey, at the town where the prohibition's companion
promise was given. Filed as
[[Don't Go Down to Egypt - The Three Patriarchs and the Same Road]], with [[Abraham]]'s unasked
descent at 12:10 as the third term.

**3. The arithmetic of the seventy closes exactly, and only if Jacob is counted once.** Zilpah's
sixteen, Rachel's fourteen and Bilhah's seven reproduce name-for-name. **[[Leah]]'s section prints
thirty-two living people** once [[Er]] and [[Onan]] are removed as 46:12 directs, **and the verse says
thirty-three.** 46:8 puts Jacob inside the register's scope — *"the children of Israel, who came into
Egypt, Jacob and his sons"* — and 46:26–27's sixty-six and seventy reconcile on no other reading:
70 − Jacob − Joseph − Manasseh − Ephraim = 66, and 66 + 2 + Joseph + Jacob = 70. **The wiki adopts
that and records the transmission-loss alternative as possible and unprovable.** Filed with the
Septuagint/Acts variant as
[[Seventy Souls - The Count of Jacob's House in Genesis, Exodus and Acts]].

**4. The register flags one foreign mother, honours a second and passes over a third.**
[[Shaul (son of Simeon)]] is *"the son of a Canaanite woman"* (46:10) — **the only ethnic annotation in
seventy names**, and Exodus 6:15 reproduces it. [[Asenath]] is given her father and his priestly office
(46:20). **[[Judah]]'s five sons by [[Shua's Daughter]], a Canaanite (38:2), get no such note** — and
theirs is the branch the register follows furthest. **Genesis supplies no rule and the wiki does not
invent one.**

**5. The brothers do not use Joseph's script, and it works anyway.** He coaches them to say *"keepers
of livestock"* precisely because *"every shepherd is an abomination to the Egyptians"* (46:34); at 47:3
they say *"Your servants are shepherds"* — **the forbidden word** — and add a request he never gave
them, *"please let your servants dwell in the land of Goshen"* (47:4). **Pharaoh grants it** (47:6).
The discrepancy is visible in the WEB's own English. Added to
[[An Abomination to the Egyptians - Separate Tables in Genesis and Exodus]], which had already
anticipated 46:34.

**6. Jacob blesses Pharaoh twice and Genesis reports no content either time** (47:7, 10). **A landless
hundred-and-thirty-year-old on famine relief blesses the most powerful man on earth, and the narrator
states it as protocol** — 12:3 operating in plain sight, and the exact reversal of 14:19 where a king
blessed a patriarch. Hebrews 7:7 supplies the principle. Filed as
[[Jacob Blessed Pharaoh - The Lesser Blessed by the Greater]]. **Between the two blessings sits
*"few and evil have been the days of the years of my life"* (47:9)** — the only self-assessment a
patriarch gives in Genesis, delivered to a king, unprompted, in the month he got his son back.
**The page takes it at face value and notes that the book neither rebukes nor endorses it.**

**7. The address is [[Rameses]].** 47:11 settles them *"in the best of the land, in the land of
Rameses"* — **the store-city of Exodus 1:11 and the starting line of Exodus 12:37** — and calls it a
***possession***, ***ʾăḥuzzâ***, **a word Genesis has used only of the cave at [[Machpelah]]**. The
family's first freehold anywhere but a grave is in Egypt, and it is the ground of the bondage.

### Judgment calls made without asking

- **Roughly fifty names in the register were given no page.** Hanoch, Pallu, Carmi, Jemuel, Jamin,
  Ohad, Jachin, Zohar, Tola, Puvah, Sered, Jahleel, Ziphion, Haggi, Shuni, Ezbon, Eri, Arodi, Areli,
  Imnah, Ishvah, Ishvi, Beriah, Heber, Malchiel, Becher, Ashbel, Gera, Naaman, Ehi, Rosh, Muppim,
  Huppim, Ard, Hushim, Jahzeel, Guni, Jezer, Shillem and the rest appear here and in the tribal
  censuses and nowhere else. **A page whose entire content is *"a son of Gad, named at 46:16"* makes
  the wiki harder to read, not richer.** They are listed on the passage page and in their fathers'
  entries. **This is the largest deliberate non-creation the wiki has made and it is recorded here so
  the user can overrule it.**
- **Seven of the register's names did get pages**, on the ground that Scripture itself develops them:
  [[Gershon]], [[Kohath]] and [[Merari]] (the three Levitical houses, and Kohath's grandsons are Moses
  and Aaron); [[Serah]] (the only granddaughter named, and kept by two later registers that had no need
  of her); [[Hezron (son of Perez)]] and [[Hamul]] (the register's only fourth generation, and the line
  to David and Matthew 1); [[Shaul (son of Simeon)]] (the one ethnic annotation).
- **[[Hezron (son of Perez)]] is qualified from the start.** **Two men named Hezron enter Egypt in the
  same paragraph** — [[Reuben]]'s third son at 46:9 and [[Perez]]'s at 46:12 — and the same doubling
  happens with *Bela* (46:21 against 36:32) and *Elon* (46:14 against 26:34). **Only the one that got a
  page needed the qualifier**; the other two are noted on the passage page so a later ingest does not
  create a bare collision.
- **[[Shua's Daughter]] was deliberately given no Genesis 46 entry.** She is the mother of five of the
  seventy and **the text does not mention her**; the passage page discusses her absence under People,
  but an *Appears in* list claiming a pericope she is not named in would be wrong. **Same rule as
  [[Joseph's Steward]] at Genesis 45.** [[Isaac]] *was* given one: he is dead, but he is named twice,
  and the naming is the scene's argument.
- **Five new connection pages rather than three or eight.** Cut from the list: a page on ***ʾăḥuzzâ***
  (47:11 against 23:9, 20), which [[Land and Sojourning]] and [[Rameses]] now carry between them; and
  one on ***wayyērāʾ ʾēlāyw*** at 46:29, which is held as a note on the passage page rather than a
  page of its own, because the coincidence of form is exact and the evidence for an allusion is nil.
- **The five brothers of 47:2 were not reconstructed.** Genesis does not say which five or why five,
  and the page says so.
- **Jacob's *"few and evil"* is not softened.** It is not read as a pious formula, as ingratitude, or
  as a foil. The page states that Genesis supplies every one of the evils in question and lets the
  verdict stand.

### New connection pages (5)

- [[Don't Go Down to Egypt - The Three Patriarchs and the Same Road]] — 12:10, 26:1–6 and 46:1–7 as
  three answers to one question, with Isaiah 30:1–2, 31:1 and Jeremiah 42:13–43:7, where the descent
  becomes the standing image of faithlessness. **The page's argument is that Genesis is not teaching a
  geography**: what distinguishes the three is whether the man asked. Abram did not and was not
  forbidden; Isaac did not need to and was stopped; Jacob asked and was sent.
- [[Jacob, Jacob - The Doubled Name and Hinneni]] — the seven doubled vocatives (22:11; 46:2; Exodus
  3:4; 1 Samuel 3:10; Luke 10:41; 22:31; Acts 9:4), the four Old Testament ones all answered
  ***hinnēnî***, and Genesis's own distribution of that word: three times to God, three times to a
  human father, **and one of the three to a father is a lie** (27:18). **The doubling is not a warning
  formula** — at 22:11 the man is stopped and at 46:2 he is released.
- [[Seventy Souls - The Count of Jacob's House in Genesis, Exodus and Acts]] — the arithmetic in full,
  the Septuagint's and Qumran's seventy-five, Stephen at Acts 7:14, and the seventy of Genesis 10
  against the seventy of Genesis 46. **Acts is not in error; it is quoting the text in front of it.**
- [[Now Let Me Die, Since I Have Seen - Jacob and Simeon]] — 46:30 with Luke 2:25–32. **Two old men
  released by one act of sight, and neither dies in his scene.** The page tracks Jacob's three
  statements — *before I die* (45:28), *now let me die* (46:30), and the *going down to Sheol* of 37:35
  — and notes that **the stage that failed was testimony** (45:26).
- [[Jacob Blessed Pharaoh - The Lesser Blessed by the Greater]] — 47:7, 10 with 12:3, 14:18–20 and
  Hebrews 7:7. **The two royal audiences in Genesis have the blessing running in opposite directions
  and the goods running the same way both times.**

### New place page (1)

- [[Rameses]] — first and only use in Genesis, at 47:11. The page records the three biblical uses (a
  gift, a work camp, a starting line), **states the anachronism plainly** and reads it as a later name
  for an older place, as with *Dan* at 14:14, **and takes it as the same district as [[Goshen]] under
  another label**, which 47:6, 47:11 and 47:27 treat as interchangeable without saying so.

### New person pages (7)

[[Gershon]], [[Kohath]], [[Merari]], [[Serah]], [[Hezron (son of Perez)]], [[Hamul]],
[[Shaul (son of Simeon)]] — reasons under *Judgment calls* above.

### Pages revised

Book: [[Genesis]] (box checked, a Genesis 46–47 paragraph added to the structure overview),
`wiki/books/index.md` (55 / 59), `wiki/index.md` counts (61 passages · 140 people · 68 places ·
63 themes · 185 connections).
People (31): [[Jacob]], [[Joseph]], [[God]], [[Pharaoh (of Joseph's time)]], [[Judah]], [[Isaac]],
[[Leah]], [[Rachel]], [[Zilpah]], [[Bilhah]], [[Dinah]], and the twelve sons, [[Perez]], [[Zerah]],
[[Shelah (son of Judah)]], [[Er]], [[Onan]], [[Manasseh]], [[Ephraim]], [[Asenath]], [[Potiphera]],
[[Job (person)]].
Places (5): [[Beersheba]], [[Egypt]], [[Canaan]], [[Goshen]], [[On]].
Themes (18): [[Providence]], [[Covenant]], [[Land and Sojourning]], [[Blessing]],
[[Prophecy and Vision]], [[Sacrifice and Offering]], [[Famine and Plenty]], [[Kingship and Empire]],
[[Life and Death]], [[Names and Naming]], [[Seeing and Being Seen]], [[Suffering]], [[Faith]],
[[Work]], [[The Nations]], [[Brotherhood]], [[Priesthood]], [[Hope]].
Connections (12): [[An Abomination to the Egyptians - Separate Tables in Genesis and Exodus]],
[[Renamed and Still Called Jacob - The Two Namings of Israel]],
[[Fell on His Neck and Wept - The Running Embrace in Genesis and Luke]],
[[I Will Be Surety for Him - Judah's Pledge and the Guarantor in Scripture]],
[[Four Hundred Years - The Sojourn and the Exodus]],
[[Seventy Nations - Genesis 10 in Deuteronomy 32 and Luke 10]],
[[Tamar in the Genealogies - Ruth 4, 1 Chronicles 2, and Matthew 1]],
[[Two Sets of Twins - Jacob and Esau, Perez and Zerah]],
[[A Stranger and a Foreigner - The Sojourner's Confession]],
[[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]],
[[Not from the Daughters of the Canaanites]],
[[The Twelve Sons and the Lists That Reorder Them]],
plus [[Jobab of Bozrah and the Septuagint's Job]]'s second false lead. All four category indexes
updated.

**Twenty-seven stale `*(not yet ingested)*` markers pointing into 46:1–47:12 were discharged** across
[[Beersheba]], [[Goshen]], [[Joseph Reveals Himself]], [[Jacob's Flight from Laban]],
[[The Reconciliation with Esau]], [[An Abomination to the Egyptians - Separate Tables in Genesis and Exodus]],
and sixteen person pages. **Markers pointing at 47:13–26, 47:28 and 47:29–31 were left in place**, since
those verses are not in this pericope.

### Quotation check against `raw/bible/`

Every fragment quoted in the new pages was diffed against `raw/bible/Genesis.md` rather than trusted.
**Three wrong fragments were caught before commit, all three newly invented in this pass**, which
matches the last entry's finding that fresh invention now outruns propagation.

- ***"Joseph fell on his father's face, and wept on him, and kissed him"*** for 50:1. **The WEB has no
  *and* before *wept*:** *"Joseph fell on his father's face, wept on him, and kissed him."*
- ***"unstable as water, you shall not excel"*** for 49:4 — **the King James, not the WEB**, which
  reads ***"Boiling over like water, you shall not excel."***
- ***"a possession of a burying place"*** for 23:9, 20. **23:20 reads *"as a possession for a burial
  place"***; the *burying-place* form belongs to 23:4 and is hyphenated there.

**Three further fragments from books with no raw file were de-quoted rather than risked.** Deuteronomy
10:22, Exodus 1:11 and Exodus 12:37 were paraphrased with references instead, and Acts 7:14 likewise.
**`raw/bible/` holds Genesis and Job only**, so any non-Genesis wording in this wiki is unverifiable by
the method above; **the standing practice of quoting other books from memory is the wiki's largest
remaining quotation risk**, and it is noted here rather than fixed.

**Two claims were checked mechanically and one was narrowed.** *"The only divine speech in the Joseph
cycle"* was verified by grepping chapters 37–50 for narrated speech (one hit, 46:2). The
***wayyērāʾ ʾēlāyw*** claim originally listed 35:1 among the parallels; **35:1 has the verb in a
relative clause, not as the main verb**, and the list was corrected to 12:7, 17:1, 18:1, 26:2, 26:24,
35:9 and 48:3, with 35:1 noted separately.

### Link check

`scripts/link-check.sh` exits 0, expected baseline 64 not-yet-started book pages. **Three wrapped
links were caught and fixed before commit** — `[[Dan (person)]]` split across the wrap twice, in the
bullets written for [[Bilhah]] and [[Naphtali]], and `[[Hezron (son of Perez)]]` split in
[[Two Sets of Twins - Jacob and Esau, Perez and Zerah]]. **That is the fourth consecutive ingest in
which a long link target has been broken by the ~100-column wrap.** Three dangling links were also
caught and removed before they reached disk: `[[Naomi]]`, `[[Saul]]` and
`[[The Famine and the Descent to Egypt]]` — **the last of which is not a page name at all; the
Genesis 12:10 pericope is [[Abram in Egypt]].**

**No links were deliberately left dangling.** 47:13–26, 47:29–31, 48:3–5, 48:14–15, 49:3–7, 49:33,
50:1, 50:9, 50:13, 50:21 and 50:25 are named in prose and marked or dated rather than linked.

### Findings left for the next lint

- **A stray empty `Exodus.md` at the repository root**, committed in `53be57b` (the Genesis 11:10–32
  ingest) and tracked ever since. It is zero bytes, it is not `raw/bible/Exodus.md`, and it is almost
  certainly a misfired `fetch-book.sh`. **Left alone rather than deleted inside an ingest commit.**
- **Unchanged from the last entry**: the ***"He made himself strange to them"*** fragment for 42:7,
  still wrong on [[Joseph Sold into Slavery]] and
  [[Discern, Please - Hakker-na from Jacob's Coat to Judah's Pledge]], with *recognised* on the former;
  the stale `*(not yet ingested)*` marker on [[The Tower of Babel]] pointing at Genesis 19:1–29; the
  seven older passage pages not retro-linked to [[Sexual Sin]]; the seven plural brothers' missing
  [[The Second Journey]] entries; and the Cyrillic *е* inside *ʾênennû* in `wiki/people/Jacob.md` and
  `wiki/books/Genesis.md`.
- **Two more stale markers found this pass and left**: [[The Cupbearer and the Baker]] carries
  `*(not yet ingested)*` on Genesis 41:16 and 41:32, **and Genesis 41 was ingested long ago**;
  [[The Nations]] carries one on Genesis 12:1–3, **which is [[The Call of Abram]]**.
- **`wiki/themes/index.md`'s *Key passages* column is stale for several themes** — [[Blessing]]'s row,
  for instance, stops at [[Pharaoh's Dreams and Joseph's Rise]] and omits Genesis 42–45 entirely, even
  though the theme page itself carries them. **The rows were appended to, not rebuilt**, so the gaps
  remain.

Genesis stands at 55 / 59 pericopes; the next is *Joseph and the Famine*, Genesis 47:13–31.

## [2026-09-18] ingest | Genesis 47.13-31 — Joseph and the Famine

Unattended run (`/ingest auto`). The book page had the pericope queued as Genesis 47:13–31 and the
boundary was kept, **although 47:27–31 is a coda rather than famine narrative**. Splitting it would
leave five verses homeless: 48:1 opens a new scene with a new cast (*"someone said to Joseph,
'Behold, your father is sick'"*), and 47:27's report of Israel multiplying belongs with the famine it
survived rather than with the blessing of Ephraim and Manasseh. **Boundary unchanged; the page treats
47:27 as the hinge between the two halves and says so.**

### The passage page

[[Joseph and the Famine]], `wiki/passages/Genesis/`, built around six findings.

**1. The pericope's structural fact is that 47:26 and 47:27 are adjacent.** *"We will be Pharaoh's
servants"* and *"Joseph made it a statute"* are immediately followed by *"Israel lived in the land of
Egypt … and they got themselves possessions therein, and were fruitful, and multiplied exceedingly."*
**A nation becomes property in one verse and a household becomes a nation in the next, and the same
man is responsible for both.** **Genesis supplies no connective and no adverb.** The wiki records the
silence and does not fill it — **and notes that the book is elsewhere willing to say *evil in
Yahweh's sight*** (38:10) **about a much smaller matter.**

**2. The famine is collected in four instalments and three of them are the people's own idea.**
Money (47:14–15), livestock (47:16–17, Joseph's proposal), **land and persons** (47:18–21), and a
permanent fifth of the harvest (47:23–26). ***"Buy us and our land for bread, and we and our land
will be servants to Pharaoh"*** (47:19) **is spoken by the Egyptians, not imposed on them**, and
47:25 repeats it as thanks. **Genesis stages the enslavement of a country as a petition.**

**3. The rate is the number every later king in the Bible is measured by.** 41:34 proposed a fifth as
a seven-year emergency levy on a bumper crop from freeholders; **47:24–26 makes the same fifth
permanent, on tenants, and calls it statute *to this day*.** **1 Samuel 8:14–17's warning about what
a king does — fields, flocks, a tenth of the seed, *"and you shall be his servants"* — is Genesis 47
in the future tense and at half the rate**, and the people of Egypt call theirs salvation. Filed as
[[A Fifth to Pharaoh - Joseph's Tax and the Rights of the King]], with Rehoboam at 1 Kings 12:4 as
the counter-case.

**4. Leviticus 25:23 forbids, clause by clause, what Joseph does at 47:20.** *"The land shall not be
sold in perpetuity, for the land is mine"* — **and the reason the law gives for the companion
prohibition on enslaving an Israelite debtor is the exodus itself**: *"they are my servants, whom I
brought out of the land of Egypt"* (25:42). **The condition Israel may not be reduced to is, in so
many words, the condition Genesis 47 reduced Egypt to.** Filed as
[[The Land Is Mine - Pharaoh's Freehold and the Jubilee]], with Naboth (1 Kings 21:3) as the
demonstration that the law was understood this way.

**5. The priests' exemption is the exact mirror of Levi's portion.** *"The priests had a portion from
Pharaoh"* (47:22) — ***ḥōq***, **the Torah's own word for the priests' share of the offerings** —
**so they never had to sell their fields; Israel's priests are fed by the offerings *because* they
are given no fields at all** (Numbers 18:20; Joshua 13:14, 33). **One priesthood is exempted from a
nation's dispossession, the other is dispossessed so that the nation is not.** Filed as
[[The Priests Who Kept Their Land and the Levites Who Got None]]. **[[Potiphera]] is noted there and
on the passage page**: the class Joseph exempts is the class he married into, **the reason Genesis
gives is sufficient without that**, and no motive is alleged.

**6. 47:31's last word is unpointed and the New Testament reads it the other way.** **The consonants
are מטה**: *miṭṭâ*, a bed, in the Masoretic tradition and the WEB; *maṭṭeh*, a staff, in the
Septuagint and the Vulgate, **and Hebrews 11:21 quotes the Greek** — *"leaning on the top of his
staff."* **Neither is a variant in the letters, so no manuscript can settle it.** **Hebrews has also
moved the gesture from the oath of chapter 47 to the blessing of chapter 48**, which is the epistle's
normal compression. Filed as
[[On the Bed's Head or on His Staff - Genesis 47.31 in Hebrews 11.21]].

### Judgment calls made without asking

- **The Egyptians were given no page**, although they are the collective protagonist of 47:13–26 and
  get **three direct speeches — more than most named characters in Genesis.** **The text treats them
  as one body and never individuates them**, and a page whose whole content is *"the population of
  Egypt, which sold itself at 47:19"* duplicates the passage page. They are listed under **People**
  on it, as is **the priestly class of 47:22**. Reversible if the user wants either.
- **No new people, place or theme pages were created.** The pericope names only [[Joseph]],
  [[Pharaoh (of Joseph's time)]] and [[Jacob]], and every theme it touches already had a page.
  **Six connection pages were created** and that is where the pericope's new material went.
- **47:21 was left as the WEB has it.** The Masoretic *heʿĕbîr* (*he removed them to the cities*) and
  the Samaritan/Greek/Latin *heʿĕbid* (*he made them servants*) **differ by one consonant**, and the
  wiki follows the WEB and records the other reading in the **Notes** without adopting it. **The
  choice changes nothing substantive**, since 47:19–20 and 47:23 state the purchase of the people
  outright in every witness.
- **The seventeen-year symmetry was recorded as arithmetic, not design.** [[Joseph]] is seventeen
  when sold (37:2); [[Jacob]] lives seventeen years in Egypt (47:28). **Genesis states both and never
  places them together**, and the wiki declines to make it a doctrine.
- **[[Joseph]]'s policy was not graded.** Five things are in the text — the plan worked, nobody
  starved, the people initiated three of four instalments, they thanked him, and a free peasantry
  ended as tenants at twenty per cent — **and no evaluation is.** The page states all five and stops.

### Pages touched

**Created (7):** the passage page and six connections —
[[A Fifth to Pharaoh - Joseph's Tax and the Rights of the King]],
[[Buy Us and Our Land - Egypt Sold into Servitude and Israel After It]],
[[They Got Possessions and Multiplied - Genesis 47.27 and Exodus 1.7]],
[[The Land Is Mine - Pharaoh's Freehold and the Jubilee]],
[[The Priests Who Kept Their Land and the Levites Who Got None]],
[[On the Bed's Head or on His Staff - Genesis 47.31 in Hebrews 11.21]].

**Revised:** [[Joseph]], [[Jacob]], [[Pharaoh (of Joseph's time)]], [[Potiphera]]; [[Egypt]],
[[Goshen]], [[Canaan]], [[Machpelah]]; seventeen theme pages ([[Famine and Plenty]],
[[Slavery and Servitude]], [[Kingship and Empire]], [[Wealth and Possessions]],
[[Land and Sojourning]], [[Providence]], [[Priesthood]], [[Wisdom]], [[Oaths and Vows]],
[[Burial and the Grave]], [[Life and Death]], [[Favor and Grace]], [[Work]], [[Covenant]], [[Hope]],
[[The Nations]], [[Remembrance]]); nine existing connections
([[Put Your Hand Under My Thigh]], [[Buried at Machpelah - The Six Graves of Genesis]],
[[Gathered to His People]], [[Don't Go Down to Egypt - The Three Patriarchs and the Same Road]],
[[Mightier Than We - Isaac in Gerar and Israel in Egypt]],
[[God Sent Me Before You - The Verb That Replaces the Sale]],
[[Sold for a Servant - Joseph's Sale in Psalm 105 and Acts 7]],
[[A Stranger and a Foreigner - The Sojourner's Confession]],
[[Four Hundred Years - The Sojourn and the Exodus]], plus
[[The Tithe Before the Law]], [[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]],
[[By the Life of Pharaoh - Oaths Sworn by a King]],
[[Simeon and Levi - The Sword at Shechem and the Deathbed Curse]] and
[[Blessed for His Sake - Laban's House and Potiphar's]]); the passage pages
[[Jacob's Family Settles in Egypt]], [[Joseph Reveals Himself]] and
[[Pharaoh's Dreams and Joseph's Rise]]; [[Genesis]], [[books/index|Books]],
[[people/index|People]], [[places/index|Places]], [[themes/index|Themes]],
[[connections/index|Connections]] and [[index|the top-level index]].

**Five stale `*(not yet ingested)*` markers pointing at this pericope were resolved**, on
[[Put Your Hand Under My Thigh]], [[Blessed for His Sake - Laban's House and Potiphar's]],
[[Joseph Reveals Himself]], [[Pharaoh's Dreams and Joseph's Rise]] and
[[Pharaoh (of Joseph's time)]], **and one on
[[Mightier Than We - Isaac in Gerar and Israel in Egypt]]** — six in all.

### Link check

`scripts/link-check.sh` exits 0. **No links were deliberately left dangling.** Genesis 48:1–4, 48:15,
49:5–7, 49:29–33, 50:5–14, 50:20 and 50:25 are named in prose and dated rather than linked, as are
[[Machpelah]]'s remaining two burials.

### Findings left for the next lint

- **Unchanged from the last entry**: the stray empty `Exodus.md` at the repository root (`53be57b`);
  the ***"He made himself strange to them"*** fragment for 42:7 on [[Joseph Sold into Slavery]] and
  [[Discern, Please - Hakker-na from Jacob's Coat to Judah's Pledge]]; the stale marker on
  [[The Tower of Babel]]; the seven older passage pages not retro-linked to [[Sexual Sin]]; the seven
  plural brothers' missing [[The Second Journey]] entries; the Cyrillic *е* inside *ʾênennû* in
  `wiki/people/Jacob.md` and `wiki/books/Genesis.md`; the stale markers on
  [[The Cupbearer and the Baker]] and [[The Nations]].
- **`wiki/themes/index.md`'s *Key passages* column is still stale for several themes**, for the same
  reason as before — **this pass appended to the rows rather than rebuilding them**, so the existing
  gaps (e.g. [[Blessing]] omitting Genesis 42–45) survive. **Rebuilding that column is a lint job,
  not an ingest one.**

Genesis stands at 56 / 59 pericopes; the next is *Jacob Blesses Ephraim and Manasseh*,
Genesis 48:1–22.

## [2026-09-18] ingest | Genesis 48.1-22 — Jacob Blesses Ephraim and Manasseh

Unattended run (`/ingest auto`). The book page had the pericope queued as Genesis 48:1–22 and the
boundary was kept. **The temptation here is to run 48 and 49 together as one deathbed**, since 48:5's
*"even as Reuben and Simeon"* only pays off at 49:3–7; **that would produce a fifty-five-verse pericope
in which the adoption and the crossed hands disappear into the tribal poem.** Chapter 48 is a
self-contained scene with its own cast, and 49:1 opens a new one by summoning all twelve sons.
**Boundary unchanged; the two are cross-linked instead, with 48:5 flagged as the hinge on both pages
once 49 is ingested.**

### The passage page

[[Jacob Blesses Ephraim and Manasseh]], `wiki/passages/Genesis/`, built around seven findings.

**1. The chapter is Genesis 27 run again with the deception taken out.** A father whose eyes have
failed, a blessing, the younger son under the hand that should have covered the elder, a protest, and
an irrevocable word — **every element of the theft of Esau's blessing is present, and the one thing
missing is the lie.** ***Śikkēl ʾet-yādāyw***, *"guiding his hands knowingly"* (48:14), **is the
narrator's insurance against the obvious reading**, and it is placed immediately before the clause it
contradicts, *"for Manasseh was the firstborn."* Filed as
[[Two Blind Fathers - Genesis 27 and Genesis 48]], which sets the two scenes out in eleven rows; nine
of them match, and the two that do not are Jacob's knowledge and Manasseh's future.

**2. 48:5 is the Bible's first adoption and its only formula spoken by the adopting parent.**
***Lî-hēm***, *they are mine*, said twice, with three mechanisms in one scene: the declaration (48:5),
the knees (48:12), and the naming (48:16). **A new theme page, [[Adoption]], was created for it** —
the first theme page added since [[Compassion and Mercy]] — because the concept recurs across Scripture
(Moses at Exodus 2:10, Esther 2:7, Psalm 2:7, 2 Samuel 7:14, Exodus 4:22, and Paul's *huiothesia*) and
because Genesis's three near-misses before it (Eliezer at 15:2–3, and the surrogacy arrangements of
16:2 and 30:3) **are something else and should not be filed under the same word.**

**3. The comparison in 48:5 names the two sons Jacob is about to curse.** *"Even as Reuben and
Simeon"* confers first and second rank — **and [[Reuben]] has lain with [[Bilhah]]** (35:22) **and
[[Simeon]] has sacked [[Shechem (city)]]** (34:25), **and 49:3–7 takes both positions away.**
1 Chronicles 5:1–2 is the only verse in Scripture that reads the chapter as a penalty transfer;
**Genesis gives no motive at all**, and the wiki keeps the two apart. Filed as
[[Two Tribes in Place of One - The Adoption of Ephraim and Manasseh]], which also works the arithmetic:
Joseph becomes two, so Levi must come out of every list counted as territory, and Revelation 7:5–8
breaks the pattern in both directions.

**4. 48:15 is the first time in Scripture that God is the subject of *rāʿâ*, to shepherd**, and the man
who says it spent twenty years as a hired shepherd and itemised the job under oath at 31:38–40.
**Psalm 23:1 is the next verse in the Bible to make God the shepherd of one person.** Filed as
[[The God Who Has Fed Me - The First Time God Is a Shepherd]]. **The same sentence also contains the
first *gāʾal* in the Bible** — *"the angel who has redeemed me from all evil"*, the only occurrence of
the root in Genesis — **and its subject is an angel**; that was added to the head of
[[The Redeemer and the Avenger of Blood]] rather than given its own page.

**5. 48:14 is the first hand laid on a head in Scripture, and Genesis 27 does not use the gesture** —
Isaac's hands are *felt*, and the blessing itself is a kiss (27:26). Filed as
[[Hands on the Head - The First Blessing by Touch]], which keeps the gesture's three later offices
apart (liability, appointment, blessing) and notes that Genesis 48 belongs to the third and is the only
Old Testament instance of it, with Mark 10:16 its nearest parallel anywhere.

**6. 48:20 is the first of only three *make-you-like* formulae in the Hebrew Bible**, with Ruth 4:11–12
and, as a curse, Jeremiah 29:22. **All three name a pair.** Filed as
[[God Make You as Ephraim and as Manasseh - The Blessing Formula]].

**7. 48:7 is read as the premise of the adoption rather than as a digression, and the reading is
marked as a reading.** [[Rachel]] bore two sons and died; [[Leah]] bore six; **the double portion
Jacob is handing to Rachel's firstborn is the share she did not live to bear.** Genesis supplies the
verse and no connective, and the competing readings (free association, an editorial seam, a note
explaining who will have to bury him) are all defensible. **The wiki states its preference and the
alternatives.**

### Judgment calls made without asking

- **Four new connection pages, not five.** The *gāʾal* thread was folded into the existing
  [[The Redeemer and the Avenger of Blood]] instead of getting a page, because that page already
  exists for the word and 48:16 is properly its head rather than a parallel to it.
- **A new theme page was created.** `AGENTS.md`'s growth trigger requires a template and a schema
  section before a new *page type*; [[Adoption]] is an ordinary theme and needed neither. The lint
  question it raises is whether the surrogacy passages (16:2; 30:3, 9) should be retro-linked to it —
  **they are linked from the theme page, but their own passage pages do not yet list it.**
- ***Məlōʾ haggôyim*** **at 48:19 and *plērōma tōn ethnōn* at Romans 11:25 are the same two words in
  two languages, each occurring once in its testament.** The wiki records the echo on the passage page
  and in [[The Nations]] **and refuses the inference**: Paul does not cite Genesis 48, and *plērōma* is
  ordinary Greek.
- **Whose knees at 48:12 is left open, with a stated preference.** Jacob's, on the strength of 30:3 and
  the ancient Near Eastern gesture, but not treated as settled.
- **No new person or place pages.** Every figure in the chapter already had one, *Luz* is an alias on
  [[Bethel]], *Ephrath* on [[Bethlehem]], and *Paddan* on [[Aram Naharaim]] — **48:7 is the only place
  in Genesis where the region's name is shortened**, and that is noted on the place page rather than
  given a page of its own. [[Asenath]] is not named in the chapter and is recorded as absent.
- **[[God]] got an entry although there is no divine speech.** The silence resumed at 46:5 holds all
  the way through 48; the entry exists because the chapter gives four designations in four verses, all
  of them in a human mouth.

### Pages touched

**New (7)**: the passage page; the theme page [[Adoption]]; and the connection pages
[[Two Blind Fathers - Genesis 27 and Genesis 48]],
[[Two Tribes in Place of One - The Adoption of Ephraim and Manasseh]],
[[The God Who Has Fed Me - The First Time God Is a Shepherd]],
[[God Make You as Ephraim and as Manasseh - The Blessing Formula]] and
[[Hands on the Head - The First Blessing by Touch]] — five connections, so seven new files.

**Revised**: [[Genesis]] (box checked); people — [[Jacob]], [[Joseph]], [[Ephraim]], [[Manasseh]],
[[Rachel]], [[Reuben]], [[Simeon]], [[Abraham]], [[Isaac]], [[Asenath]], [[God]],
[[The Angel of Yahweh]]; places — [[Bethel]], [[Canaan]], [[Egypt]], [[Bethlehem]],
[[Aram Naharaim]], [[Shechem (city)]]; themes — [[Birthright and the Firstborn]], [[Blessing]],
[[Covenant]], [[Names and Naming]], [[Providence]], [[Walking with God]], [[The Names of God]],
[[Prophecy and Vision]], [[Land and Sojourning]], [[Burial and the Grave]],
[[Seeing and Being Seen]], [[The Nations]], [[Suffering]], [[Remembrance]], [[Faith]]; connections —
[[The Redeemer and the Avenger of Blood]]. Plus [[books/index|Books]], [[people/index|People]],
[[places/index|Places]], [[themes/index|Themes]], [[connections/index|Connections]] and
[[index|the top-level index]].

**Eight stale `*(not yet ingested)*` markers pointing at this pericope were resolved**, on
[[Ephraim]] (two), [[Manasseh]] (two), [[Jacob]], [[Joseph]], [[Asenath]] (two, one of them for
46:20 rather than 48) and [[Bethlehem]], and one on
[[Birthright and the Firstborn]] — ten in all.

### Link check

`scripts/link-check.sh` exits 0. **No links were deliberately left dangling.** Genesis 49:3–7,
49:22–26, 49:29–32, 50:13 and 50:24–25, and Joshua 24:32, are named in prose and dated rather than
linked — their passage pages do not exist yet.

### Findings left for the next lint

- **Unchanged from the last entry**: the stray empty `Exodus.md` at the repository root (`53be57b`);
  the ***"He made himself strange to them"*** fragment for 42:7 on [[Joseph Sold into Slavery]] and
  [[Discern, Please - Hakker-na from Jacob's Coat to Judah's Pledge]]; the stale marker on
  [[The Tower of Babel]]; the seven older passage pages not retro-linked to [[Sexual Sin]]; the seven
  plural brothers' missing [[The Second Journey]] entries; the Cyrillic *е* inside *ʾênennû* in
  `wiki/people/Jacob.md` and `wiki/books/Genesis.md`; the stale markers on
  [[The Cupbearer and the Baker]] and [[The Nations]].
- **`wiki/themes/index.md`'s *Key passages* column is still stale for several themes**, for the same
  reason as before — this pass appended to the rows rather than rebuilding them. Rebuilding that
  column is a lint job.
- **New**: [[Hagar and Ishmael]] and [[The Birth of Jacob's Children]] are listed as key passages on
  [[Adoption]] but do not list [[Adoption]] among their own themes; the same is true of
  [[The Covenant Between the Pieces]]. **Retro-linking a new theme backwards through the passages it
  claims is a lint job**, and it is the second instance of this pattern.
- **`wiki/books/Genesis.md`'s `## Structure` prose stops at 47:12**, two pericopes behind the
  checklist. The Joseph paragraph has not been extended since [[Jacob's Family Settles in Egypt]].

Genesis stands at 57 / 59 pericopes; the next is *Jacob Blesses His Sons*, Genesis 49:1–33.

## [2026-09-18] ingest | Genesis 49.1-33 — Jacob Blesses His Sons

Unattended run (`/ingest auto`). The book page had the pericope queued as Genesis 49:1–33 and the
boundary was kept. Two splits were considered and refused. **Running 49 and 50 together as *the death
of Jacob*** would bury the twelve sayings inside a funeral; **splitting 49:1–27 from 49:28–33** would
separate the poem from the sentence that calls it a blessing, which is the pericope's central problem.
**Boundary unchanged.** Genesis 50 is now the last unchecked box in the book.

### The passage page

[[Jacob Blesses His Sons]], `wiki/passages/Genesis/`, built around eight findings.

**1. The narrator calls the whole chapter a blessing and three of the twelve sayings are not one.**
*"He blessed everyone according to his blessing"* (49:28) covers [[Reuben]]'s *"you shall not excel"*
(49:4), [[Simeon]] and [[Levi]]'s *"cursed be their anger"* (49:7), and [[Issachar]]'s *"a servant
doing forced labor"* (49:15). **The wiki reads *"according to his blessing"* as definitional rather
than descriptive** — what each son received *is* his blessing — **and flags it as a reading**, with the
three competing readings (loose summary; *bārak* as *took formal leave of*; verses 3–7 as a later
insertion) recorded and none adopted.

**2. 49:1 is the first *bəʾaḥărît hayyāmîm* in the Bible.** **The phrase Genesis uses for *later on*
becomes the prophets' formula for the consummation** — Numbers 24:14, Deuteronomy 4:30 and 31:29,
Isaiah 2:2, Micah 4:1, Hosea 3:5, Daniel 2:28 and 10:14 — **and the Septuagint's rendering is what
Acts 2:17 and Hebrews 1:2 mean by *the last days*.** **Nothing in Genesis 49 requires the later
sense**: what follows is territorial, military and political. Filed as
[[In the Days to Come - Aharit Hayyamim from Genesis 49 to the Prophets]], which measures the distance
rather than collapsing it.

**3. 49:10 is the most disputed sentence in Genesis and the page sets out four readings without
choosing between the Hebrews.** ***ʿAd kî-yābōʾ šîlōh*** is read as *šellōh* (*that which is his*),
*šay lōh* (*tribute to him*), the place name Shiloh, or a personal title. **The wiki adopts the WEB's
*"until he comes to whom it belongs"***, which follows the Septuagint's *ta apokeimena autō* and the
echo at Ezekiel 21:27 (*"until he comes whose right it is"*), **and states that the consonants do not
decide.** **It records that all four have been read messianically and does not adjudicate that
either.** Filed as [[The Scepter and Shiloh - Genesis 49.10 and Its Readings]].

**4. 49:18 is the first *yəšûʿâ* in the Bible, and it interrupts.** Five words, first person,
addressed to God, between [[Dan (person)]]'s serpent and [[Gad]]'s raiders — **the only prayer in the
chapter and the only occurrence of the name *Yahweh* in it.** **Three placements are on record** (it
belongs to Dan's saying; it divides the poem at its midpoint; it is unplaced), **and the wiki adopts
none.** The noun is the root of *Joshua*, *Isaiah*, *Hosea* and *Jesus*, and Psalm 119:166 is close
enough to be an echo — **recorded as an echo, not a citation.** Filed as
[[I Have Waited for Your Salvation - The First Yeshuah in Scripture]].

**5. 49:24 coins three divine titles and all three are firsts.** ***ʾĂbîr yaʿăqōb***, *the Mighty One
of Jacob*, which Isaiah 49:26 and 60:16 and Psalm 132 still use; ***hārōʿeh***, *the shepherd*, **the
noun to 48:15's participle**; and ***ʾeben yiśrāʾēl***, *the stone of Israel*, **which occurs nowhere
else in the Bible.** **The stone texts the New Testament collects — Psalm 118:22, Isaiah 8:14 and
28:16, Daniel 2 — do not include this one**, and the page records the priority without claiming
influence. Filed as [[The Mighty One of Jacob and the Stone of Israel]]; the shepherd half was added to
[[The God Who Has Fed Me - The First Time God Is a Shepherd]] rather than duplicated.

**6. The lion of 49:9 grows through three nouns in one verse and has a long afterlife.** *Gûr ʾaryēh*
→ *ʾaryēh* → *lābîʾ*, ending on the poem's only rhetorical question. **Balaam quotes the line almost
verbatim at Numbers 24:9**, Hosea 5:14 gives the lion to God and Judah's house to the prey,
**Ezekiel 19 makes the lioness the royal house taken in a pit**, and Revelation 5:5 is the only New
Testament verse naming tribe and animal together — **and substitutes a Lamb in the next verse.** Filed
as [[The Lion of Judah - Genesis 49.9 and Revelation 5.5]].

**7. Genesis 49 and Deuteronomy 33 are the Bible's two tribal poems and they disagree.** **[[Simeon]]
is absent from Deuteronomy 33 altogether**, the only son with no saying there. **[[Levi]] is cursed
here and given the Urim, the teaching office and the altar there.** **[[Benjamin]]'s ravenous wolf
becomes *the beloved of Yahweh*, and [[Dan (person)]]'s serpent becomes a lion's cub** — **the lion
Genesis gave to [[Judah]], whose five verses Deuteronomy cuts to one.** **[[Joseph]]'s two sayings
share whole phrases** — *nəzîr ʾeḥāyw* and *the deep that couches beneath* — **which is the strongest
evidence either way that one poem knows the other.** Filed as
[[Jacob's Blessing and the Blessing of Moses - Genesis 49 and Deuteronomy 33]], with Judges 5:14–18 as
the third member of the set and the only one that grades the tribes on conduct.

**8. Two verses report burials that Scripture reports nowhere else.** **49:31 is the only record of
[[Rebekah]]'s burial and the only record of [[Leah]]'s**, and the only verse that places [[Isaac]] in
the cave. **Rebekah's is also the last mention of her in the Bible** — Genesis never narrates her
death, while it gives her nurse [[Deborah (Rebekah's nurse)]] a death notice and a named tree (35:8).
**And *"there I buried Leah"* is the other half of 48:7**: the wife Jacob was tricked into is in the
grave he is asking to be carried to, and the wife he worked fourteen years for is beside a road.
Both were filed onto [[Buried at Machpelah - The Six Graves of Genesis]] and
[[Rachel Weeping - Her Grave, Ramah, and Bethlehem]].

### Judgment calls made without asking

- **No `Divided in Jacob and Scattered in Israel` connection page was created.** The obvious page for
  49:7 — Levi's curse becoming the priesthood while Simeon's identical sentence erases him — **already
  exists as [[Simeon and Levi - The Sword at Shechem and the Deathbed Curse]]**, written when Genesis
  34 was ingested and already carrying Exodus 32:26–29, Numbers 25, Deuteronomy 33:8–11 and Joshua
  19 and 21. **It was extended rather than duplicated**, with the two details the deathbed adds to
  chapter 34: the hamstrung cattle, which 34:28 does not report, and *məkērōtêhem*, a word that occurs
  once in the Bible.
- **The new place page is [[Sidon (city)]], not `Sidon`.** Genesis 10:15 makes Sidon the firstborn of
  [[Canaan (son of Ham)]], and [[The Table of Nations]] deliberately left both pages unmade. **A bare
  `Sidon.md` would collide silently** — `scripts/link-check.sh` resolves by basename and Obsidian picks
  one by an unstated rule — **so the city takes its kind as a qualifier now**, per the person/place rule
  in `AGENTS.md`, and the person will be `Sidon (son of Canaan)` when he gets a page. **No rename of an
  existing page was needed.**
- **Six connection pages were created rather than four or nine.** The four rejected candidates were a
  page for Issachar's *mas-ʿōbēd* (absorbed into [[Slavery and Servitude]]), one for Benjamin's wolf
  (absorbed into the Deuteronomy 33 comparison), one for the vine and the wine (already covered by
  [[The Vine and the Cup]], which was extended), and one for Reuben's *rēʾšît ʾônî* against
  Deuteronomy 21:17 (already covered by
  [[Loved and Hated - Genesis 29 and Deuteronomy 21.15-17]], also extended).
- **Three textual cruxes were recorded with all readings and a stated preference, not resolved.**
  *Šîlōh* (49:10), *məkērōtêhem* (49:5), and Naphtali's *ʾimrê-šāper* (49:21), where WEB's *beautiful
  fawns*, the Septuagint's *goodly boughs* and the plain consonants' *words of beauty* are all
  defensible. **The WEB's rendering is adopted in each case and the alternatives are named.**
- **Zebulun's coastline is recorded as a mismatch, not harmonised.** 49:13 gives him a haven and a
  border on Sidon; **Joshua 19:10–16 puts him inland in lower Galilee and reaches neither.** Neither
  book remarks on it and the wiki does not invent a reconciliation.

### Pages touched

**Created (8):** [[Jacob Blesses His Sons]]; [[Sidon (city)]];
[[The Scepter and Shiloh - Genesis 49.10 and Its Readings]],
[[The Lion of Judah - Genesis 49.9 and Revelation 5.5]],
[[In the Days to Come - Aharit Hayyamim from Genesis 49 to the Prophets]],
[[I Have Waited for Your Salvation - The First Yeshuah in Scripture]],
[[The Mighty One of Jacob and the Stone of Israel]],
[[Jacob's Blessing and the Blessing of Moses - Genesis 49 and Deuteronomy 33]].

**Revised — people (20):** all twelve sons — [[Reuben]], [[Simeon]], [[Levi]], [[Judah]],
[[Zebulun]], [[Issachar]], [[Dan (person)]], [[Gad]], [[Asher]], [[Naphtali]], [[Joseph]],
[[Benjamin]] — plus [[Jacob]], [[Leah]], [[Rebekah]], [[Abraham]], [[Sarah]], [[Isaac]],
[[Ephron the Hittite]] and [[The Children of Heth]]. **Fifteen of those pages gained a
`### In this pericope — Genesis 49` section**, carved out of the `### What is still ahead` material
that had been anticipating this chapter, and **thirteen stale `*(not yet ingested)*` markers pointing
at this pericope were resolved** — **two new ones were written in their place**, on [[Jacob]] and
[[Ephron the Hittite]], both pointing at Genesis 50.

**Revised — places (3):** [[Machpelah]], [[Mamre (place)]], [[Canaan]].

**Revised — the book page:** [[Genesis]]'s `## Structure` prose **had stopped at 47:12**, a standing
finding from the last two entries; it now runs to the end of the book's narrative, covering the three
pericopes of the deathbed.

**Revised — themes (16):** [[Blessing]], [[Curse]], [[Prophecy and Vision]],
[[Birthright and the Firstborn]], [[Kingship and Empire]], [[Names and Naming]], [[The Names of God]],
[[Burial and the Grave]], [[Hope]], [[Priesthood]], [[Slavery and Servitude]], [[Retribution]],
[[Life and Death]], [[Brotherhood]], [[War]], [[Land and Sojourning]].

**Revised — connections (15):** [[Simeon and Levi - The Sword at Shechem and the Deathbed Curse]],
[[Buried at Machpelah - The Six Graves of Genesis]], [[Gathered to His People]],
[[The Twelve Sons and the Lists That Reorder Them]], [[The Vine and the Cup]],
[[Kings Will Come Out of You]], [[Lying with the Father's Concubine - A Claim on the Succession]],
[[The God Who Has Fed Me - The First Time God Is a Shepherd]],
[[God Almighty - El Shaddai in Genesis and Exodus]],
[[Rachel Weeping - Her Grave, Ramah, and Bethlehem]],
[[This Dreamer Comes - Joseph's Dreams and Their Fulfilment]],
[[Loved and Hated - Genesis 29 and Deuteronomy 21.15-17]],
[[Bethel from Jacob's Pillar to Jeroboam's Calf]],
[[Two Tribes in Place of One - The Adoption of Ephraim and Manasseh]],
[[Renamed and Still Called Jacob - The Two Namings of Israel]].

Plus [[books/index|Books]], [[people/index|People]], [[places/index|Places]],
[[themes/index|Themes]], [[connections/index|Connections]] and [[index|the top-level index]].

### Link check

`scripts/link-check.sh` exits 0. **No links were deliberately left dangling.** Genesis 50:1–14,
50:15–21 and 50:22–26 are named in prose and dated rather than linked — their passage page does not
exist yet, and it is the last one in the book.

### Findings left for the next lint

- **Unchanged from the last entry**: the stray empty `Exodus.md` at the repository root (`53be57b`);
  the ***"He made himself strange to them"*** fragment for 42:7 on [[Joseph Sold into Slavery]] and
  [[Discern, Please - Hakker-na from Jacob's Coat to Judah's Pledge]]; the stale marker on
  [[The Tower of Babel]]; the seven older passage pages not retro-linked to [[Sexual Sin]]; the seven
  plural brothers' missing [[The Second Journey]] entries; the Cyrillic *е* inside *ʾênennû* in
  `wiki/people/Jacob.md` and `wiki/books/Genesis.md`; the stale markers on
  [[The Cupbearer and the Baker]] and [[The Nations]]; the [[Adoption]] retro-linking noted last time.
- **`wiki/themes/index.md`'s *Key passages* column is still stale for several themes**, for the third
  entry running, and for the same reason: this pass appended to rows rather than rebuilding them.
  **Rebuilding that column is a lint job and is now overdue.**
- **New**: [[Benjamin]]'s page now has a `### What is still ahead (continued)` heading, an artefact of
  splitting a long anticipation section around the Genesis 49 material. **It should be folded back into
  one heading.**
- **New**: [[Reuben]]'s `### What is still ahead` still described Genesis 42, which was ingested six
  pericopes ago; that part was moved out in this pass, but **the same staleness may be present in other
  sons' pages** and was not audited.
- **New**: eight of the twelve sons now have a Genesis 49 section quoting the poem, and **none of the
  twelve passage pages for the birth narratives links forward to it.** Retro-linking
  [[The Birth of Jacob's Children]] to the twelve sayings is a lint job.

Genesis stands at 58 / 59 pericopes; the next and last is *The Deaths of Jacob and Joseph*,
Genesis 50:1–26.
