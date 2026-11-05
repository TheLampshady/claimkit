---
name: claimkit
description: 'Research a concept thoroughly by doing web searches and interviewing the user to align findings with their specific goal, then write a structured reference doc (docs/research/ in a repo, a Markdown artifact in chat). Use whenever the user asks to: research X, look into X, get up to speed on X, learn about X for a project, write up findings on X, find sources on X, or do homework on a topic. Especially trigger when the request is open-ended and the user has a specific situation (scale, stack, constraints, deadline) the findings need to align with — that alignment work is the point. Also has a charter setup mode — use when asked to set up a research charter, define research goals or scope or rails for a repo, or update the charter — and a review mode, for: recheck the sources, is this doc still accurate, has anything been proven since. Skip for one-shot "what is X" questions you can answer directly without sources, and skip for library-API lookups where a documentation lookup alone is sufficient.'
user-invocable: true
argument-hint: "[topic | charter | review]"
---

# claimkit

The user wants to **understand a concept well enough to act on it**. The output is a doc at `docs/research/<slug>-research.md` where nothing is asserted without saying what it rests on.

One rule generates the rest: **a claim is sorted by its backing, and only backing moves it.**

- **Claim** — a proposition. Backed by an external source it's a **finding**; backed by nothing it's a **hypothesis**, and it carries the check that would settle it.
- **Action** — a build step, not a claim. It can't be true or false, so it names the claims that make it worth taking.

Your reasoning is not backing. The user's own experiment is not backing. Another doc in `docs/research/` is not backing. Keeping that sort honest as the doc is revised over months is the job — and the value is aligning findings to *this* user's goal, never a Wikipedia-style summary.

## When to use

Triggers:
- "Research X for our project"
- "Get me up to speed on X — we're considering it for Y"
- "Look into X, find me sources"
- "Do some homework on X"

Skip when:
- "What is X?" — just answer directly, no doc needed
- "Show me the API for X" — a docs lookup, not a research task
- "Find a library that does X" — search-and-recommend, not a deep concept dive

## Where the doc lives

Everything below is written for a repo. The doc is `docs/research/<slug>-research.md`, the charter is `docs/research/CHARTER.md`, and sibling docs are the other files in that folder. When you're working in the user's project, meaning a directory they opened that you can write into, follow it as written.

When there's no such project, as in a claude.ai chat (a code-execution sandbox doesn't count), **read `references/chat-output.md` before Phase 1.** It maps each repo location to its chat equivalent, starting with the doc itself, which becomes a Markdown artifact. Nothing else changes: same template, same rules, same checks.

## The charter (optional, per-repo)

A repo may carry a research charter at `docs/research/CHARTER.md` — a static frame doc stating what research here is *for*, what's already ruled out, which rails to work in, and what counts as good enough evidence to act on. Charters are authored per-repo; this skill is user-level and ships only the instructions and the field spec at `references/charter-template.md`.

**Read a charter for frame; never cite it as a source.** It states the question, so it is not evidence: it never appears in the Sources table and never grounds a claim. It is not importable as a hypothesis either — the import rule carries positions across docs, and the charter holds no positions. The stand-alone rule under Output principles is unaffected.

When there's no charter, say so once and carry on. Never block research to create one.

## Charter mode (setup)

Triggered by "set up a research charter", "define our research goals / scope / rails", "update the charter" — or by the user acting on the Phase 1 note.

This mode writes `docs/research/CHARTER.md` and does nothing else. Don't fold a research request into it; if the user asked for both, write the charter, confirm it, then begin the research run fresh against it.

**Read `references/charter-template.md` before asking anything.** It carries the six fields, the four-step interview, the defaults for the drafted fields, and the three fields that were deliberately cut. Don't improvise the interview from this section — the procedure lives there because it only matters here, and getting the ask-three/draft-three split right is most of the value.

## Review mode

Triggered by "review the research doc", "recheck the sources", "is this still accurate", "has anything been proven since", "check for newer findings".

Re-checks an existing doc's claims against the world instead of researching the topic again: do the cited sources still exist and still say this, and has anything been published that settles an open hypothesis? A doc that stops being correct gives off no signal, so nobody performs this unprompted — which is the reason it's a mode rather than a suggestion.

**Read `references/review-mode.md` before touching anything.** It carries the two passes, the default scope, the notation for a superseded or dead-linked finding, and the split between what review may write and what it must only report. Don't improvise it: the whole mode turns on writing provenance changes while never grading a source, and that line is easy to cross by accident.

Never fold a review into a research run. If the sweep turns up something new about the *topic* rather than about a *claim already in the doc*, that's research — say so and stop.

## Workflow

### Phase 1 — Scope it (≤3 questions, skip any already answered)

**First, check for `docs/research/CHARTER.md`.**

- **Present** — read it. It answers the Purpose-level questions outright, so skip whatever it covers; often only Depth is left to ask. Carry three of its fields into Phase 2 as filters: don't research something under **Out of scope**, don't coin a synonym for a settled entry in **Terminology**, and hold sources to its **Standard of evidence**. Treat **Constraints** as a filter on recommendations — an answer that breaks them isn't an answer.
- **Absent** — state one line, then keep going without waiting for a reply:

  > No `docs/research/CHARTER.md` found — I'll frame this from our conversation. Ask me to set up a charter if you want future runs to skip the scoping questions.

Then ask only what the user hasn't already given:

1. **Purpose** — what decision, problem, or thing-to-build is this serving?
2. **Depth** — quick overview to orient, or deeper dive with tradeoffs and edge cases?
3. **Current understanding** — what do they already know? Any specific terms, angles, or sources they've already seen?

Three questions max. If their initial request already tells you the answer to one, skip it. Long upfront interrogations kill momentum.

### Phase 2 — Research

Use **WebSearch** for discovery and **WebFetch** for reading the most promising results. If the topic involves a library, framework, or SDK, fetch its official documentation directly — it's more current and authoritative than write-ups about it.

Quality over quantity. Aim for 5–8 strong sources rather than 20 shallow ones. Prefer:
- Official docs and specifications
- Well-regarded practitioner blog posts (look for credentialed authors, working examples)
- Conference talks and papers (foundational concepts)
- Well-maintained open-source examples

Skip:
- SEO content farms and listicles
- AI-recycled summaries (you'll see the same paragraphs verbatim across sites)
- Sources that contradict the consensus without evidence

Take notes as you go: URL, the key claim, and your confidence in the source.

**Verify the load-bearing claims.** Identify the 2–3 claims the conclusion will rest on and confirm them against their primary sources — not a summary of the source, the source itself. If you could only confirm an abstract or a secondhand account, keep the citation but mark it inline ("paper-body detail, not independently verified here"). This is claim verification, not hypothesis testing — it needs no building, just reading, and it's what catches fabricated or drifted citations before they become load-bearing.

**Check whether the user's hypotheses are already tested.** Before a working position gets marked **(project hypothesis)**, spend one search seeing if the literature already validates or refutes it. If it does, it's not a hypothesis — it's a finding (or a dead idea), cited like any other, and the user just saved an experiment. Record what you searched: it becomes the hypothesis's **Unsourced because** line.

On a re-run against an existing doc, do this for the hypotheses already sitting at *open* too. That search is the only thing that can promote one to a finding, so it's the highest-value few minutes of a repeat run.

**Mine sibling docs for positions, never for evidence.** Other docs under `docs/research/` can hold hypotheses developed with the user that exist nowhere else — read them for leads, and for positions worth importing under the rules in the Hypotheses section. Every citation in them is a lead too: chase it to its primary and cite that. Nothing in a sibling doc is evidence.

### Phase 3 — Alignment interview (questions informed by what you found)

After research, the gap between "general findings" and "what applies *here*" surfaces. Ask 2–5 follow-ups grounded in your actual findings:

- "I found three common approaches (X, Y, Z). Your [stated constraint] rules out Z — does it also rule out Y?"
- "Most sources assume [scale]. Are you at that scale or smaller?"
- "There's a real tradeoff between [A] and [B]. Which matters more for your situation?"

These questions only make sense *after* research. That's the entire point of Phase 3 — you can't ask them upfront because you don't yet know what the relevant axes of variation are. Don't skip this phase; without it the doc reads like a Wikipedia page and the user gets nothing they couldn't have googled themselves.

### Phase 4 — Write the doc

Path: `docs/research/<slug>-research.md`. The slug is kebab-case derived from the topic ("prompt caching" → `prompt-caching-research.md`).

- Always write to `docs/research/`. Create the directory (and `docs/` if needed) without asking — that's the canonical location for this skill's output.
- **If a doc already exists on this topic, revise it in place.** These docs are living: Hypotheses accumulate and Actions carry status, so the existing record is the most valuable thing in the file. Read it first, then add findings, append new hypotheses with fresh IDs, update statuses, drain finished actions, and stamp **Last updated**. Never renumber or reuse an H or A ID. Don't offer replace, and don't fork to a dated filename — both split the record into two docs that each look authoritative. If the new research contradicts what's there, say so in your response and let the user decide; a contradiction is the most valuable thing a re-run surfaces.

Use this template. Every section is required — an empty one says "None" and why, because a missing section is invisible and a stated absence isn't:

```markdown
# <Concept> — Research

**Written:** YYYY-MM-DD
**Last updated:** YYYY-MM-DD  <add this line only once the doc has been revised>
**Original request:** <one-line restatement of what the user asked>
**Charter:** <`docs/research/CHARTER.md` — a pointer only. Omit the line entirely if the repo has none.>
**Provenance:** <one line, only when the doc carries hypotheses: "Sourced claims cite primary sources inline; everything under Hypotheses is unmeasured. This doc stands alone.">

## Summary

<Short and plain across both subsections. This is the only section allowed to restate what's below it, and it originates nothing: no claim, position, or action appears here for the first time. A reader who stops here knows what this is for, what's believed, and what's known. **Labels carry the vocabulary; prose explains it.** The title, the tagline, and the claim-group names are handles — what someone searches for, cites in a commit message, and remembers the doc by — so they should use the topic's own terms, and a title that dodges the term is harder to find and says less. Everything that *isn't* a label is plain: no word the doc coins further down, no citations, no evidence talk. A term first appears in a label and is explained in the sentence beneath it, which is the one place in the doc where naming and defining sit together.>

### Goal

<One or two sentences: the decision or thing-to-build this run serves. Plain language. Narrower than the charter's Objectives, which cover the whole repo; if the two read the same, the goal isn't specific enough yet. If it needs more than two sentences or splits into genuinely separate parts, it's two research docs.>

### Claims

<Totals first on their own line — "6 findings, 4 hypotheses" — then one **Markdown list item** per claim, every claim in the body appearing exactly once:

**<Theme>** — <1–3 short sentences on what this group is about.>

*Findings (sourced):*
- [<the sourced claim>](#f-<slug>)

*Hypotheses (unsourced):*
- [**H1**](#h1) — <the position>

**Every roll-up line links to its entry below.** The Summary is read first and travels on its own, so it doubles as the doc's index: each line is an anchor link to the full entry, and a reader who wants the caveats is one click from them rather than scanning a section of twenty. Link the ID for a hypothesis and the claim text for a finding.

**Every H-ID in the doc is a link, not just the ones in the roll-up.** `Builds on:`, `Cuts against:`, an action's `Because:`, a table cell, a bare mention in interpretation prose — all of them, one rule with no exceptions to remember, and the terse references are the ones a reader most needs to resolve. **A-IDs are the deliberate exception:** actions drain out of the doc when they're built, so an action anchor is a dangling link waiting to happen, while a hypothesis ID is permanent by invariant and can always be pointed at.

**Anchor on the entry, never on a heading.** Place an explicit `<a id="..."></a>` on each entry in the body. Heading-derived anchors are generated from the entry's full text, so the first time a statement is sharpened — which is what a revision run does — every link to it breaks silently, and a broken in-doc link is exactly as invisible as the stale pointer this skill bans between docs. A hypothesis anchors on its ID (`#h1`), which is permanent by invariant and so is already the right handle. A finding has no ID, so it anchors on a short slug from its distinctive term (`#f-recall-over-precision`); once written the slug is a link target, not a title — leave it alone when the claim's wording changes.

**Group by theme first, then split by backing inside the group.** The theme heading is what the reader navigates by; the two sub-lists under it are what tells them how much of that theme is evidence and how much is position. A group showing one finding against five hypotheses says something a doc-wide findings list hides — splitting *within* the theme keeps that visible while dropping a per-line tag off every bullet. The hard sort still lives in the body's two sections; this is the reader's view of what the doc says.

**Both labels appear in every group, even when one side is empty** — write `*Findings (sourced):* none.` A theme with no findings under it is the most useful thing this section can tell a reader, and an omitted label is invisible where a stated absence is a fact. An **absence claim** goes under Findings keeping its inline *(absence claim)* tag: a checked and recorded absence is finding-shaped, not a position.

**Say sourced, not known.** The split is about backing, not certainty — findings include practitioner claims and single-vendor blog posts, and labelling that column "known" launders sourcing into truth, which is the one failure this whole structure exists to prevent.

**The group name may carry the topic's terms; the sentence under it may not.** Name the group in the doc's own vocabulary — it's a handle, and a vague one makes the group unfindable. Then explain it in words a reader meeting the topic for the first time already knows, so the sentence carries any term the name just introduced. Say what the group is about and stop: no counts (the sub-lists already show backing) and no grading, because "weakly grounded" is a strength rating this skill doesn't make.

A list, not consecutive bold lines: bare lines collapse into one paragraph when rendered.>

## Key findings

Sourced claims only. Every bullet cites an external primary source — a bullet with nothing to cite is a hypothesis and belongs in the next section.

A citation is **necessary but not sufficient**. It buys the reader a way to check, not a guarantee the claim is right: a badly-sourced claim cited faithfully is still a badly-sourced claim, and it sits here looking exactly like a well-sourced one. That gap is what Phase 2's verification pass exists to close, so carry its caveats inline — "paper-body detail, not independently verified here" belongs in the bullet, not in your head.

- <a id="f-slug"></a>**<Short claim>** ([source](url)) — 1–3 sentences explaining the finding.
- <a id="f-slug"></a>**<Short claim>** ([source](url)) — ...
- <a id="f-slug"></a>**<Short claim, no source exists>** *(absence claim)* — "no published benchmark exists"; uncitable by nature, so label it rather than leaving it bare.

## Hypotheses

Positions developed with the user rather than found in literature: unmeasured, and the reason the Actions below are worth taking. IDs are permanent — assigned once, never renumbered, never reused. New ones append.

**One hypothesis per distinct check.** Granularity is a real choice and permanence makes it irreversible, so use the check as the test: if two positions would be settled by the same experiment, they are one hypothesis with a longer statement, not two. Writing "*Check:* same as H3" means the split was wrong. Err toward fewer — a corollary folded into its parent still gets read, but a doc with thirty IDs has a roll-up nobody finishes.

**A split that turns out to be wrong gets merged, not left.** Fold the vaguer statement into the sharper one — the survivor has to carry both positions, so it usually gets longer, and it keeps the ID whose `Check:` was the real experiment. The vacated ID stays in place as a single line: `**H5 — Retired YYYY-MM-DD, merged into H18.** <what it stated, and why it was never separate.>` That line is required by ID permanence, not kept as history — an ID deleted outright reads as a numbering slip to the next reader and invites reuse. Then strip the dead ID from every `Because:` and `Builds on:` that named it, and from the Summary roll-up: two IDs behind one action read as two supports when there was only ever one.

**State the theory, not the task.** A hypothesis is a proposition about how something works, readable by someone who has never opened this repo. "Add `Extend by:` and `Doesn't cover:` fields to FOUNDATIONS entries" is an Action; the hypothesis under it is the reason — *a component doc that only describes what exists cannot tell an agent where building something new is correct.* One is checkable by anyone; the other is checkable by looking at whether you did it. Project nouns and file names belong in Actions, which are written for an agent with the repo open. Diagnostic: **if the `Check:` tests something more general than the statement, the statement is too narrow** — rewrite the statement up to meet it.

**Group them once there are more than about eight.** Thematic `###` subheadings inside this section, mirrored in the Summary roll-up. IDs stay globally sequential in order of assignment, so they will *not* run in order within a group — that is correct, and it's what permanence costs. Never renumber to tidy it.

<a id="h1"></a>**H1 — <the position, one sentence>** · *open* · added YYYY-MM-DD
- **Builds on:** <optional — the finding this position extends, cited, or the linked H-ID it specialises. Omit when it stands on its own. Provenance, not ranking: it records what the position was assembled from, which is what stops the two halves being welded into one composite sentence where half is checkable and half isn't.>
- **Cuts against:** <optional — a finding or H-ID this position is in tension with. Evidence that *undercuts without settling* has to live somewhere, or it leaks into interpretation prose; two hypotheses that can't both be right have to say so, or the doc quietly holds a contradiction. Not a refutation and not a score. If a source **settles** it against, the position isn't a hypothesis any more — move it to Decisions with the citation and the reason.>
- **Unsourced because:** <what you searched and didn't find, from Phase 2. "No literature on the ratio" is a real answer; "didn't look" is not.>
- **Check:** <the concrete thing that would validate or refute it — specific enough to run.>

**H2 — <the position>** · *validated in-project YYYY-MM-DD* · added YYYY-MM-DD
- **Unsourced because:** <...>
- **Check:** <what was run> → <what happened.>

Three statuses, and only three:

- ***open*** — untested.
- ***validated in-project*** / ***refuted in-project*** — the check ran; record what happened. A result is not backing, so the status changes and the claim stays here.
- ***promoted to finding*** — an external verified source turned up. Move the claim into Key findings with its citation and leave a one-line pointer here.

A retired ID carries no status, because it is no longer a claim.

**Imported positions.** A position developed in an earlier doc under `docs/research/` exists nowhere else, so carry it into this one rather than losing it — but carry the *content*, not a pointer:

**H7 — <the position, restated here in full — never "see the position in the other doc">** · *open* · added YYYY-MM-DD
- **Unsourced because:** Position developed in `<origin-slug>-research.md` (H3); searched <what> for external work on it, found none.
- **Check:** <the concrete check> — ran there → <outcome>; not re-run in this context.

Three constraints keep the import honest. It gets a **new ID in this doc's sequence** — never the origin's number, since IDs are local and permanent. Its status **starts at *open***: the origin's outcome is history recorded on the `Check:` line, not a status this doc asserts, so two copies can't drift into two live statuses. And its **citations don't come along** — chase those to their primaries. That an import stays a hypothesis needs no fourth rule: the origin doc isn't backing, however long it has said otherwise.

An ***open*** hypothesis with no Action pointing at it doesn't belong in this section — you hold a position but have no stake in it. That's an Open question.

## How this applies to your request

<Interpretation only: what the findings and hypotheses mean for the user's situation, against the constraints, scale, or priorities from Phase 1 and Phase 3. No new claims — those are findings or hypotheses — and no build steps, which are Actions. This is the reasoning that connects the two, and it's what makes the doc worth more than a search.>

## Actions

<What to do to meet the Goal. Written for an agent implementing from this section alone: name the file or component and state the change.>

- **A1 — <the change; name the file or component>** · *proposed*
  **Because:** [H1](#h1), [source](url)
- **A2 — <the change>** · *building*
  **Because:** [source](url)

Every action carries a `Because:` line naming its backing — source links, H-IDs, or both, mixed freely. An action with nothing to put there rests on a belief that hasn't been written down: either it becomes a hypothesis, or the action doesn't survive. An action that doesn't serve the Goal is scope creep or an understated goal — resolve which.

Confidence is read off the backing, never declared. Source-only backing means build it. Any H in the backing means building it *is* the experiment, and that H's check is what tells you whether you were right.

Actions are a queue, not a record. Once an action is built and its hypothesis has resolved, it leaves this list — the memory lives on the H entry, and restating what the code now shows is waste. An action decided against moves to Decisions with its reason. Nothing stays here annotated as done or abandoned.

## Decisions (deliberately not doing)

<Things ruled out, one line each with the reason: positions rejected, actions dropped, approaches the research killed. The one section where recording a non-choice is the point — it's what stops the next run re-proposing something already settled.>

## Sources

| Source | Type | Why it matters |
|--------|------|----------------|
| [Title](url) | Official spec / blog / talk / paper | Brief annotation — what this contributed |

## Open questions

<Gaps you couldn't close, contested claims between sources, follow-ups worth pursuing later. This is the home for questions you hold no position on — take a position and it's a hypothesis; act on it and it's an action. Honesty here is more valuable than fake completeness.>
```

**Before you report the path, check the structure.** Seven checks, all mechanical:

1. All eight `##` headings present, in order, plus the Summary's Goal and Claims subsections. An empty one says "None" and why. Every claim in the body appears once in the Claims roll-up — a compressed roll-up is a second, quieter doc — and every roll-up link resolves to an `<a id>` that exists, since a dangling one sends the reader to the top of the file with no error.
2. Every action has a non-empty `Because:`.
3. Every ***open*** hypothesis is named by at least one action's `Because:`, or by another hypothesis's `Builds on:`. If neither, it moves to Open questions. A thesis-level position earns its place by carrying children, not by being built directly. Resolved ones stay put — their action has already drained, and the entry is the record.
4. Nothing in Key findings lacks a citation or an absence-claim label.
5. No claim, position, or action appears in two sections. The Summary is the exception — it restates by design.
6. No two ***open*** hypotheses resolve on the same check. A `Check:` that defers to another ID ("see H18") or restates it verbatim is one position wearing two numbers — merge it. Borrowing another check's *setup* and adding an arm is fine: that experiment has an outcome the other one doesn't read. This is the check most likely to fail on a revision run, because a position gets sharpened into a new ID while the older, vaguer one stays behind.
7. Nothing depends on a sibling doc. A sibling may be named in exactly two places — the attribution inside an imported hypothesis's `Unsourced because:` and `Check:` lines — and nowhere else: not in Sources, not in a Key finding, not in an action's `Because:`, and never as a Markdown link. (The header's **Charter:** pointer is the one exception, and it backs nothing.) Every import must read correctly with the origin file deleted.

### Phase 5 — Charter reconciliation

Skip entirely if there is no charter. Stay silent if nothing changed — no "the charter still looks right" chatter.

Runs *after* the doc is on disk, never before. A charter edit made first would change what the doc says, entangling its frame with its conclusions; and if the user declines the edit, the deliverable is already safe.

**One field is in scope: Terminology.** Propose an addition when the research settled or introduced a term the charter doesn't carry. Additive only — appending a gloss is cheap and self-correcting, because a wrong term shows up in the next doc where the user will see it.

**Everything else is reported, not written.** Findings that bear on Objectives, Constraints, or scope go in the doc's *Open questions*, where the user reads them and decides. That matters most for scope: a non-goal added to a charter silently ends a line of inquiry forever, and nobody ever sees the research that didn't happen. Suppression that invisible has to be a human's choice, so surface the dead end and let them add the rail.

**The gate — sourced findings only.** A term that emerged from a claim clearing the charter's evidence bar may be proposed. A term coined inside a hypothesis may not, and *validated in-project* doesn't lift the bar: graduating unmeasured positions into the frame means the next run reads them as settled and researches *toward* them. The findings/hypotheses split already in the doc is the gate — if the term's definition lives under Hypotheses, it stays there.

**Conflicts are never edits.** If the research contradicts the charter — a ruled-out approach turns out to be right, or a settled term is wrong — state it plainly in your response, above the file-path line, and leave the file alone. A charter reversal is the user's decision, and it's the most valuable thing this loop can surface, so don't bury it in a diff.

## Output principles

- **Cite inline.** Every claim derived from research links to its source. The reader should be able to verify any specific point in one click.
- **Keep the sort visible on the page.** A fluent unsourced claim reads as fact and will be treated as one by every future reader, human or agent — the sort protects nobody unless it's legible claim by claim. Absence-of-evidence claims ("no published benchmark exists") have no source by nature: label them as absence claims rather than leaving them bare.
- **Each section owns exactly one thing.** Overlap is what let the last generation of these docs say the same thing four times in four voices. *Key findings* owns sourced claims. *Hypotheses* owns unsourced positions. *How this applies* owns interpretation — no new claims, no build steps. *Actions* owns build steps — no argument, no evidence. *Decisions* owns what was ruled out. *Open questions* owns what has no position yet. *Summary* may restate anything and originates nothing. When a sentence would fit two sections, it belongs to the narrower one and the other section points at it by ID.
- **The doc must stand alone.** Never cite other research docs previously written in this project — they are conclusions, not sources: possibly unverified, and revised in place, so a pointer to one goes stale without anyone seeing it. A prior doc never appears in the Sources table and never backs a Key finding. Two things follow. **Never relay its citations:** mine it for *leads*, chase each lead to its primary source, cite that. If the primary can't be verified, the claim inherits hypothesis or absence-claim status. **Import its original positions instead of pointing at them:** a hypothesis developed with the user exists nowhere but that doc, so restate it here in full as a new local hypothesis naming the origin as attribution, never as a dependency. Delete the origin and this doc still reads correctly — that's the test for whether it stands alone.
- **The Actions section is the spine, not the appendix.** The research exists to back the actions the user wants to take; everything else is that backing. Write the doc so Actions could be lifted out and executed, and so every other section is traceable to something in it.
- **Sections have different readers, so they have different rules.** *Summary* travels on its own — complete without the rest of the doc, plain, and short enough to read in a minute. *Actions* is read by an agent doing the work — name the file, state the change. *Key findings, Hypotheses, Sources, Open questions* are for the author later — keep the full nuance, the caveats, and the contested bits; do not simplify these for an imagined general reader. This is a rule about self-containment and precision, not tone: no section gets vaguer than the evidence it rests on, and the Summary's plainness never softens a claim the body states sharply.
- **Don't pad.** Four well-supported findings beat seven thin ones. Filler signals weak research.
- **Be honest about gaps.** "Sources disagree on this" or "I couldn't find authoritative info on X" is more useful than fabricated certainty.
- **Date stamp old sources.** If a useful source is from 2018 and the field has moved, note that inline so the reader knows the context.
- **Anonymize field material.** Real-world observations from client or employer projects are often the strongest evidence in the doc — use them, but scrubbed: no project or client names, no identifying combinations of vendor + stack + module paths, no verbatim quotes from client artifacts (paraphrase instead). Cite as "a production project (user-supplied, anonymized)." The doc should be safe to show anyone without a second pass.
- **Report the file path.** End your final message with `Wrote: docs/research/<slug>-research.md` so the user can find it.

## What not to do

- Don't skip Phase 3. Without alignment, the doc reads like a Wikipedia summary and the user gets no value beyond what they could have searched themselves.
- Don't over-interview in Phase 1. Three questions max; fewer if the user's request already answered them.
- Don't fabricate sources. If WebSearch returns nothing useful, say so plainly and ask the user where to look (papers they've seen, internal docs, specific authors).
- Don't take a pasted or prior research doc's citations at face value — verify the load-bearing ones against the actual sources. LLM-generated research in particular can carry plausible, fully fabricated references (specific paper titles, quantitative findings, org attributions); the most confident-looking citation is sometimes the fake one.
- Don't ship a doc full of `[TODO]` markers. If a section has nothing in it, write "None" and one line saying why — never delete the heading. A missing section is invisible; a stated absence is a fact.
- Don't leave an action with an empty `Because:` line. It means an unwritten belief is doing the work. Write the hypothesis or drop the action.
- Don't promote a hypothesis on the strength of your own reasoning, however good the argument. A plausible mechanism argued from first principles is exactly what these markers exist to contain.
- Don't replace or fork an existing research doc on the same topic. Revise in place — the accumulated hypotheses and their statuses are the record, and a dated copy just creates two docs that both look current.
- Don't renumber H or A IDs, ever. Other sections, later docs, and commit messages point at them.
- Don't cross-link research docs. Importing a prior doc's position means restating it in full as a new local hypothesis; a live pointer to `<other>-research.md` breaks the next time that doc is revised in place, and the claim is then resting on nothing.
- Don't block research on a missing charter. The Phase 1 note is one line and needs no answer — say it and keep moving. Offering to build a charter mid-request is a detour, not a service.
- Don't graduate a hypothesis into the charter. Phase 5 accepts sourced findings only; a position the research invented does not become the frame the next research reads.
