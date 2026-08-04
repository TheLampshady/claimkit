# Research charter — field spec and template

Loaded only in **charter mode**. The charter lives at `docs/research/CHARTER.md` in the repo being researched, not in this skill.

A charter is a *static frame*. It is not a tracker, a roadmap, or a log — no statuses, no dates, no history, and nothing that describes what is being worked on right now. Anything that changes run to run belongs in the request, not in the charter. Its job is to make every later research run start already knowing the goals, the rails, and the bar.

It is also checked-in agent context, so it rots. **Terminology** rots fastest — it is the field most likely to be wrong a few months from now.

Six fields, split by who can answer them:

| Ask the user, one at a time | Draft it, user corrects |
|---|---|
| 1. Mandate | 4. Constraints — from the repo, or the default below |
| 2. Objectives | 5. Standard of evidence — offer the default below |
| 3. Out of scope | 6. Terminology — from existing docs |

Fields 1–3 are **intent** and cannot be derived from a repo. Fields 4–6 can be drafted, so never ask them cold — propose and let the user edit.

---

## The interview — four steps

**Step 1 — read the repo before asking anything.** `CLAUDE.md`/`AGENTS.md`, the README, `package.json` or equivalent, the license, and the existing `docs/` tree. Everything after this is either informed by what you found or drafted from it. Asking questions a five-minute read would have answered is the fastest way to make this feel like paperwork.

**Step 2 — ask fields 1–3 progressively, one question at a time, each carrying your recommendation.** Lead with a proposed answer drawn from Step 1 so the user edits rather than composes, and let each answer shape the next question — Objectives should follow from the Mandate they just confirmed, not be asked in parallel with it. Push hardest on **Out of scope**; it prevents the most wasted research and users rarely volunteer it unprompted.

**Step 3 — draft fields 4–6 without asking.** Constraints from the repo, falling back to the default below. Standard of evidence: offer the default below. Terminology from existing docs and settled naming.

**Step 4 — show the whole charter filled in, and take corrections in one pass.** All six fields, complete, as the file would actually be written — not a summary of what you plan to write. The user should be approving text, not a description of text. Then write it.

**If a charter already exists,** don't rewrite it. Show what you'd change, field by field, and confirm.

---

## The six fields

Each field earns its place by answering something the skill would otherwise have to ask, guess, or re-derive on every run.

### 1. Mandate

One or two lines: why research happens in this repo at all. Not a description of the codebase — the reason someone goes looking for outside evidence.

> Bad: "A CLI tool for syncing documentation." (That's an overview. The README has it.)
> Good: "We're deciding how much context tooling to build versus recommend. Research exists to keep those calls evidence-backed rather than intuition-backed."

### 2. Objectives

What research is *for* — the decisions it feeds. Three to five bullets. Lets a run judge relevance instead of reporting everything it found.

### 3. Out of scope

What is already ruled out, and ideally one clause of why. **The single highest-value field in the charter** — it stops whole categories of research before they're commissioned, and stops recommendations that were never going to be accepted.

> "No retrieval layer — maps, graphs, and symbol servers are commodity; we wrap or recommend, never build."

This field also absorbs deliberately-unused *mechanisms* ("we don't ship hooks"). What tooling a project *does* use is derivable from its manifests — an agent reads those anyway — so only the deliberate exclusions are worth writing down.

### 4. Constraints

The rails a recommendation has to fit inside — not what to research, but what shape an acceptable answer takes. License, platform, format, budget, policy. Disclosure rules go here so every research doc inherits them without being told again.

Draft from the repo: license file, package manifests, `CLAUDE.md`/`AGENTS.md`, platform manifests.

**Default when the repo says nothing:**

> Open source and free only. Anonymize sensitive and client-identifying material. Project-specific information stays in the project.

### 5. Standard of evidence

What a claim must clear before the doc treats it as actionable, and what to do when nothing clears it. Answer four things: which source types count and in what order; whether a single vendor blog is enough to recommend on; whether absence of evidence blocks a recommendation or just gets labeled; how hard to verify the load-bearing claims.

Not derivable — but don't ask cold. Offer this and let the user edit:

> Practitioner consensus, upgraded by benchmarks and skeptical reports wherever they exist. A single vendor blog is a lead, not a basis. Absence of evidence gets labeled as an absence claim, not treated as a negative finding.

Without this stated once, every run re-picks the bar and the bar drifts between docs.

### 6. Terminology

Settled words and decided naming, with a one-line gloss each. Keeps research using the project's vocabulary instead of coining synonyms, and keeps decided naming questions from being re-litigated in a later doc.

Draft from `CLAUDE.md`, `FOUNDATIONS.md`, `PRINCIPLES.md`, and existing doc headings.

**Rot-prone.** Terms get renamed and redefined. Additive by default; a rename is a conflict, not an edit (see below).

---

## What is deliberately not a field

Cut on purpose. Don't reintroduce these — each was tried and removed for a reason that still holds.

| Not a field | Why |
|---|---|
| **Current focus** / what we're working on now | Changes run to run, so it belongs in the request. As a stored field it rots immediately and steers research wrong. Objectives and Out of scope already do the steering. |
| **Means available** / available mechanisms | Derivable by reading the repo's manifests, which the agent does anyway. Writing down the derivable is the overview trap. Deliberate exclusions go in Out of scope. |
| **Audience** / who reads the output | Identical in every repo, so it lives in the skill's doc template as per-section rules, not in a charter the user has to author each time. |

---

## Write discipline

Phase 5 may append to **Terminology** and nothing else. Every other field is hand-edited by the user.

> Every automated edit is additive. Any deletion, rename, or redefinition is a **conflict** — surfaced to the user, never edited automatically.

Two properties fall out. Nothing can quietly remove a rail, because every subtraction routes to a human. And nothing can quietly *add* one either: a new non-goal ends a line of inquiry permanently, and since nobody ever sees the research that didn't happen, that suppression has to be a deliberate human choice. Research reports the dead end; the user decides whether it becomes a rail.

Growth is expected — a glossary is supposed to grow. If **Terminology** ever gets long enough to be a real token cost, that's the signal to split it into its own file.

---

## Skeleton

```markdown
# Research Charter

**Mandate** — <one or two lines: why research happens here>

## Objectives

- <decision or problem research feeds>
- <...>

## Out of scope

- <ruled out, and one clause of why>
- <...>

## Constraints

- <license / platform / format / budget>
- <disclosure and anonymization rules>

## Standard of evidence

<what a claim must clear to be actionable, and what to do when nothing does>

## Terminology

- **<term>** — <one-line gloss, and what it is *not*>

<!-- rot-prone: additive; a rename is a conflict, not an edit -->
```
