# Research Charter

**Mandate** — Claimkit's design calls are all about how evidence and guesswork stay separated in a document that lives for months. Research exists so those calls are grounded in prior art that already solved parts of this — argumentation models, analytic tradecraft, decision records, sourcing policy — rather than invented here and found wrong later.

## Objectives

The first one is the point; the rest are how it gets served.

- **A reader can always tell what's established from what's merely written down.** Claimkit reaches truth by never asserting it — it exposes what every claim rests on and lets the reader adjudicate. A doc that reads as authoritative is the failure mode, not the goal, because the fluent unsourced sentence is indistinguishable from the sourced one at the moment it gets acted on.
- **The claim ontology** — what kinds of backing exist, how a claim moves between them, what a stable claim identity is worth, and what it costs.
- **What makes a claim checkable by the next reader** — how other disciplines define verifiability, and where that comes apart from truth.
- **How an action names its backing** — so the doc drives the work without becoming a record of it.
- **The section split** — which sections a general reader needs versus which serve the author months later, and where an overlap lets one claim get stated twice in two voices.
- **Where a months-old doc goes stale** — which of those failures the format can catch, and which it can only surface.

## Out of scope

- **Judging a claim is not this tool's job.** Claimkit's responsibility ends at sorting a claim by its backing and naming what's missing. Whether the claim is any good is the reader's call — so no confidence scores, certainty tiers, or strength ratings, on sourced and unsourced claims alike. Recording that a check ran is reporting; grading the result is judging.
- **No tracking work.** The doc is not a tracker. No progress state, no burn-down, no record of what got built — anything that changes as the user works belongs in the request, not in the doc.
- **No tool or product integration.** Claimkit ships Markdown an agent executes. Another tool's *ideas* are fair game as prior art; adopting, wrapping, or integrating the tool is not.
- **No agent or orchestration design.** Claimkit distributes no agents. Research that would make the skill spawn work instead of writing a doc is out.

Provenance is not judgment. A claim gaining a source, losing one, or being superseded by a newer one is a fact about the evidence — none of the rails above block recording it.

## Constraints

- Open source and free only.
- Anonymize sensitive and client-identifying material. Project-specific information stays in the project.
- Recommendations ship as Markdown, TOML, or JSON. There is no build step and no runtime — an answer that needs code to execute is not an answer here.
- An answer must hold on all three distribution targets (Claude, Antigravity, Copilot), or name the one it excludes and why.
- Anything added to `SKILL.md` is paid for on every invocation, including the ones that never reach it. New detail goes in a named `references/` file unless every run needs it.

## Standard of evidence

Prefer the primary statement of a model — the original paper, spec, or policy text — over any summary of it; these get flattened badly secondhand, and the flattening usually removes the part that made the model work. Below that: practice documented by the people who ran it at scale, then credentialed practitioner write-ups. A single vendor blog is a lead, not a basis.

Verify the load-bearing claims against the primary text itself, not against a description of it. Prior art recalled from memory is a lead, not a source — it gets checked or it gets labeled.

Absence of evidence is labeled as an absence claim, never treated as a negative finding.

## Terminology

Only terms `skills/claimkit/SKILL.md` does not already define. It is loaded on every run, so restating its vocabulary here would create a second definition of the same invariant, free to drift from the first. One term, one file.

- **claim** — a proposition the doc asserts, and the supertype: every claim is a finding or a hypothesis. An action is an imperative, not a claim — it can be unwise, but never false.
- **backing** — what a reader can check a claim against. The discriminator that sorts every claim, and the only thing this repo sorts on. Not a measure of how good the claim is, and **not Toulmin's *backing***, which supports the warrant rather than the claim — the nearest term in that model is *grounds*. The collision is known and the local sense wins; say which one you mean when talking to anyone who knows the model.

<!-- rot-prone: additive; a rename is a conflict, not an edit -->
