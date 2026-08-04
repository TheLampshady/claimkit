---
name: claimkit
description: 'Research a concept thoroughly by doing web searches and interviewing the user to align findings with their specific goal, then write a structured reference document at docs/research/<concept>-research.md. Use this skill whenever the user asks to: research X, look into X, get up to speed on X, learn about X for a project, write up findings on X, find sources on X, or do homework on a topic. Especially trigger when the request is open-ended and the user has a specific situation (scale, stack, constraints, deadline) the findings need to align with — that alignment work is the point. Also has a charter setup mode — use when asked to set up a research charter, define research goals or scope or rails for a repo, or update the charter. Skip for one-shot "what is X" questions you can answer directly without sources, and skip for library-API lookups where a documentation lookup alone is sufficient.'
user-invocable: true
argument-hint: "[topic | charter]"
---

# claimkit

The user wants to **understand a concept well enough to act on it**. The output is a structured doc at `docs/research/<slug>-research.md` that backs the actions they intend to take with either a cited source or an explicit, checkable hypothesis.

Every claim in that doc is one of two things, and the difference is load-bearing: a **finding** cites an external primary source, and a **hypothesis** doesn't — it's a position developed with the user, unmeasured, carrying the check that would settle it. Only an external source promotes the second into the first. Sorting claims that way, and keeping the sort honest as the doc is revised over months, is what this skill is for. The value comes from the *alignment* between general findings and the user's particular goal, never from a generic Wikipedia-style summary.

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

## The charter (optional, per-repo)

A repo may carry a research charter at `docs/research/CHARTER.md` — a static frame doc stating what research here is *for*, what's already ruled out, which rails to work in, and what counts as good enough evidence to act on. Charters are authored per-repo; this skill is user-level and ships only the instructions and the field spec at `references/charter-template.md`.

**Read a charter for frame; never cite it as a source.** It states the question, so it is not evidence: it never appears in the Sources table and never grounds a claim. The stand-alone rule under Output principles is unaffected.

When there's no charter, say so once and carry on. Never block research to create one.

## Charter mode (setup)

Triggered by "set up a research charter", "define our research goals / scope / rails", "update the charter" — or by the user acting on the Phase 1 note.

This mode writes `docs/research/CHARTER.md` and does nothing else. Don't fold a research request into it; if the user asked for both, write the charter, confirm it, then begin the research run fresh against it.

**Read `references/charter-template.md` before asking anything.** It carries the six fields, the four-step interview, the defaults for the drafted fields, and the three fields that were deliberately cut. Don't improvise the interview from this section — the procedure lives there because it only matters here, and getting the ask-three/draft-three split right is most of the value.

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

<Short and plain — ≤200 words across all three subsections. This is the only section allowed to restate what's below it, and it originates nothing: no claim, position, or action appears here for the first time. A reader who stops here knows what this is for, what's believed, and what's known. No undefined terms, no citations, no evidence talk.>

### Goal

<One or two sentences: the decision or thing-to-build this run serves. Plain language. Narrower than the charter's Objectives, which cover the whole repo; if the two read the same, the goal isn't specific enough yet. If it needs more than two sentences or splits into genuinely separate parts, it's two research docs.>

### Hypotheses

<One line each, by ID: "**H1** — <the position>". Nothing else; the entries live below.>

### Findings

<One line each. Nothing else; the citations live below.>

## Key findings

Sourced claims only. Every bullet cites an external primary source — a bullet with nothing to cite is a hypothesis and belongs in the next section.

- **<Short claim>** ([source](url)) — 1–3 sentences explaining the finding.
- **<Short claim>** ([source](url)) — ...
- **<Short claim, no source exists>** *(absence claim)* — "no published benchmark exists"; uncitable by nature, so label it rather than leaving it bare.

## Hypotheses

Positions developed with the user rather than found in literature: unmeasured, and the reason the Actions below are worth taking. IDs are permanent — assigned once, never renumbered, never reused. New ones append.

**H1 — <the position, one sentence>** · *open* · added YYYY-MM-DD
- **Unsourced because:** <what you searched and didn't find, from Phase 2. "No literature on the ratio" is a real answer; "didn't look" is not.>
- **Check:** <the concrete thing that would validate or refute it — specific enough to run.>

**H2 — <the position>** · *validated in-project YYYY-MM-DD* · added YYYY-MM-DD
- **Unsourced because:** <...>
- **Check:** <what was run> → <what happened.>

Three statuses, and only three:

- ***open*** — untested.
- ***validated in-project*** / ***refuted in-project*** — the check ran; record what happened. This does **not** make it a finding. A finding is something a reader verifies by clicking a link, and the stand-alone rule means the next doc can't cite this one.
- ***promoted to finding*** — an external verified source turned up. Move the claim into Key findings with its citation and leave a one-line pointer here. Only an external source can do this.

A hypothesis with no Action pointing at it doesn't belong in this section — you hold a position but have no stake in it. That's an Open question.

## How this applies to your request

<Interpretation only: what the findings and hypotheses mean for the user's situation, against the constraints, scale, or priorities from Phase 1 and Phase 3. No new claims — those are findings or hypotheses — and no build steps, which are Actions. This is the reasoning that connects the two, and it's what makes the doc worth more than a search.>

## Actions

<What to do to meet the Goal. Written for an agent implementing from this section alone: name the file or component and state the change.>

- **A1 — <the change; name the file or component>** · *proposed*
  **Because:** H1, [source](url)
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

**Before you report the path, check the structure.** Five checks, all mechanical:

1. All eight `##` headings present, in order, plus the Summary's three subsections. An empty one says "None" and why.
2. Every action has a non-empty `Because:`.
3. Every hypothesis is named by at least one action's `Because:`. If not, it moves to Open questions.
4. Nothing in Key findings lacks a citation or an absence-claim label.
5. No claim, position, or action appears in two sections. The Summary is the exception — it restates by design.

### Phase 5 — Charter reconciliation

Skip entirely if there is no charter. Stay silent if nothing changed — no "the charter still looks right" chatter.

Runs *after* the doc is on disk, never before. A charter edit made first would change what the doc says, entangling its frame with its conclusions; and if the user declines the edit, the deliverable is already safe.

**One field is in scope: Terminology.** Propose an addition when the research settled or introduced a term the charter doesn't carry. Additive only — appending a gloss is cheap and self-correcting, because a wrong term shows up in the next doc where the user will see it.

**Everything else is reported, not written.** Findings that bear on Objectives, Constraints, or scope go in the doc's *Open questions*, where the user reads them and decides. That matters most for scope: a non-goal added to a charter silently ends a line of inquiry forever, and nobody ever sees the research that didn't happen. Suppression that invisible has to be a human's choice, so surface the dead end and let them add the rail.

**The gate — sourced findings only.** A term that emerged from a claim clearing the charter's evidence bar may be proposed. A term coined inside a hypothesis may not, and *validated in-project* doesn't lift the bar: graduating unmeasured positions into the frame means the next run reads them as settled and researches *toward* them. The findings/hypotheses split already in the doc is the gate — if the term's definition lives under Hypotheses, it stays there.

**Conflicts are never edits.** If the research contradicts the charter — a ruled-out approach turns out to be right, or a settled term is wrong — state it plainly in your response, above the file-path line, and leave the file alone. A charter reversal is the user's decision, and it's the most valuable thing this loop can surface, so don't bury it in a diff.

## Output principles

- **Cite inline.** Every claim derived from research links to its source. The reader should be able to verify any specific point in one click.
- **Separate findings from hypotheses, and only a source moves one across.** Every claim either cites an external primary source or lives in the Hypotheses section as a position developed with the user — unmeasured, to be validated. Never let the two blend: a fluent unsourced claim reads as fact and will be treated as one by every future reader, human or agent. Absence-of-evidence claims ("no published benchmark exists") are uncitable by nature — label them as absence claims rather than leaving them bare. **Promotion is one-directional and source-gated:** a hypothesis becomes a finding only when an external verified source turns up. The user's own experiment doesn't promote it — that's *validated in-project*, which stays in Hypotheses, because a finding is something the reader checks by clicking and the stand-alone rule bars the next doc from citing this one.
- **Each section owns exactly one thing.** Overlap is what let the last generation of these docs say the same thing four times in four voices. *Key findings* owns sourced claims. *Hypotheses* owns unsourced positions. *How this applies* owns interpretation — no new claims, no build steps. *Actions* owns build steps — no argument, no evidence. *Decisions* owns what was ruled out. *Open questions* owns what has no position yet. *Summary* may restate anything and originates nothing. When a sentence would fit two sections, it belongs to the narrower one and the other section points at it by ID.
- **The doc must stand alone.** Never cite other research docs previously written in this project — they are conclusions, not sources: possibly unverified, and liable to be deleted or rewritten, leaving dangling references. Mine them for *leads*, then chase each lead to its primary source and cite that. If the primary can't be verified, the claim inherits hypothesis or absence-claim status.
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
- Don't promote a hypothesis on the strength of your own reasoning, however good the argument. Only an external verified source moves it to Key findings; a plausible mechanism argued from first principles is exactly what these markers exist to contain.
- Don't replace or fork an existing research doc on the same topic. Revise in place — the accumulated hypotheses and their statuses are the record, and a dated copy just creates two docs that both look current.
- Don't renumber H or A IDs, ever. Other sections, later docs, and commit messages point at them.
- Don't block research on a missing charter. The Phase 1 note is one line and needs no answer — say it and keep moving. Offering to build a charter mid-request is a detour, not a service.
- Don't graduate a hypothesis into the charter. Phase 5 accepts sourced findings only; a position the research invented does not become the frame the next research reads.
