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
