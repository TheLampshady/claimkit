# Review mode — procedure

Loaded only in **review mode**. Re-checks an existing doc's claims against the world without doing new research.

A research run asks *what is true about this topic*. A review asks *is this doc still right* — a different and much cheaper question, and one nobody performs unprompted because a doc that was correct when written gives off no signal when it stops being correct.

Two passes, and they answer different questions:

| Pass | Question | What can change |
|---|---|---|
| **Findings** | Does the cited source still exist, still say this, and is it still the best available? | link status, supersession, demotion to hypothesis |
| **Hypotheses** | Has anything been published that settles this? | promotion to finding, a new `Cuts against:`, removal to Decisions |

Review mode never writes a new claim. If the sweep turns up something genuinely new about the topic rather than about a claim already in the doc, that is a research run — say so and stop.

---

## Scope

Default to what carries weight, because a full sweep on a large doc is dozens of fetches:

- **Findings named in an action's `Because:`** — the ones the work rests on.
- **Every hypothesis at *open*** — the promotion search is the whole reason to run this, and it's cheap.

Say which claims were skipped. "Reviewed 6 of 14 findings (the load-bearing ones) and all 9 open hypotheses" is a real answer; silently reviewing a subset reads as reviewing everything. A full sweep happens only when asked for.

---

## Pass 1 — findings

For each finding in scope, fetch its cited source and answer three questions in order. Stop at the first that fails.

**1. Does the link resolve?**
If not, try an archived copy. An archived version that supports the claim keeps the finding — swap the citation to the archive and note the original is gone. If nothing resolves, the claim fails the definition of a finding: a reader can no longer check it by clicking. **Move it to Hypotheses** with a new ID, status *open*, and an `Unsourced because:` line recording the dead source and what was searched for a replacement. This is the one demotion in the skill, and it is not a judgment — it is the definition applying itself.

**2. Does the source still say what the bullet claims?**
Living pages get edited, papers get revised, docs get versioned. If the source no longer supports the bullet, rewrite the bullet to what the source actually says. If it now says the opposite, that is a contradiction — **report it, do not write it** (see below).

**3. Is there newer work that supersedes it?**
One search per load-bearing finding. Newer work that *replaces* the basis for the claim gets appended inline, in the same voice as the doc's other caveats:

```markdown
- **<the claim>** ([source](url)) — <explanation>. **Superseded 2026-08-06** by
  [newer work](url), which <what changed>.
```

Keep the original bullet. A superseded finding is part of the record — deleting it hides that the doc once rested on it, and the next reader who finds the old source needs to know it was already considered.

---

## Pass 2 — hypotheses

For each hypothesis at *open*, run the promotion search: has external work appeared that settles this position? This is the same search Phase 2 performs, run on its own.

Four outcomes:

- **Nothing found** — leave it. Extend `Unsourced because:` with what was searched this time, so the next review doesn't repeat it. This is the common case and it is a real result.
- **A source asserts it** — promote. Move the claim to Key findings with its citation, leave the one-line pointer, mark the entry *promoted to finding*. The source must **assert** the claim, not imply it: if you have to derive the position from the source, that derivation is your reasoning, and reasoning does not promote.
- **A source bears on it without settling it** — add a `Cuts against:` or extend `Builds on:`. Partial evidence has a home now; it does not belong in prose.
- **A source settles it against** — it is no longer a hypothesis. Move it to Decisions with the citation and the reason. Do not leave it sitting at *open* with a contradiction noted underneath.

Statuses other than *open* are skipped. *Validated in-project* is a record of what was run, not a claim awaiting evidence, and re-litigating it is how a settled thing gets quietly reopened.

---

## What review mode writes, and what it only reports

Writes, because these are facts about evidence rather than judgments about claims:

- a swapped or archived citation, and a dead-link note
- a supersession note appended to a finding
- a promotion, with its citation
- a new `Builds on:` / `Cuts against:` line
- a hypothesis moved to Decisions, with the source that killed it
- a demotion caused by an unreachable source
- the **Last updated** stamp

Reports without writing:

- **any contradiction** — a source that now says the opposite of a bullet, or newer work that reverses a finding the actions depend on. State it plainly in the response, above the file-path line. A reversal is the most valuable thing a review produces and burying it in a diff wastes it.
- **anything that would change an action.** Review touches claims, never the Actions queue. If a superseded finding leaves an action with no backing, say so and let the user decide whether the action survives.
- **a claim that now needs research rather than review** — the sweep found a live debate the doc doesn't know about.

Never grade a source. "This 2019 benchmark is weak now" is a strength rating; "superseded by a 2026 replication that reports the opposite" is a provenance fact. The second is the job.

---

## The report

Lead with contradictions, then changes, then the null result — the null result matters and gets stated rather than omitted:

```
Reviewed 6 of 14 findings (load-bearing) and all 9 open hypotheses.

Contradicts the doc — <claim>: <source> now reports <X>. Not written; your call.
Promoted — H4 → Key findings, [source](url).
Superseded — <claim>, by [newer](url).
Dead link — <claim>; archived copy supports it, citation swapped.
Unchanged — 4 findings, 8 hypotheses. Searches recorded on their entries.

Wrote: docs/research/<slug>-research.md
```
