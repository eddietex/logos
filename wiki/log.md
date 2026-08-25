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
