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
