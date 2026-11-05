# claimkit skill

Research a concept, then write it down so it's still trustworthy a year later.

| | |
|---|---|
| **Output** | `docs/research/<topic>-research.md` in a repo · a Markdown artifact in chat |
| **Modes** | research (default) · charter setup |
| **Triggers** | "research X", "look into X", "get me up to speed on X", "find sources on X", `/claimkit <topic>` |
| **Skip when** | "what is X?" (just answer) · "show me the API for X" (docs lookup) · "find a library that does X" |

## Phases

1. **Scope** — ≤3 questions, skipping anything the request already answered. Reads `docs/research/CHARTER.md` if present, which usually answers most of them.
2. **Research** — WebSearch + WebFetch, official docs first for anything library-shaped. 5–8 strong sources, not 20 shallow ones. Load-bearing claims get verified against the actual source, not a summary of it.
3. **Alignment interview** — 2–5 follow-ups that only make sense *after* research, because that's when the real axes of variation are known. This phase is why the output isn't a search result.
4. **Write** — the eight-section template, then a six-point structure check.
5. **Charter reconciliation** — Terminology additions only, and only after the doc is on disk.

## The claim split

Everything the doc asserts is one of two things:

- **Finding** — cites an external primary source. Verifiable in one click.
- **Hypothesis** — doesn't. A position developed with the user, carrying `Unsourced because:` (what was searched and not found) and `Check:` (what would settle it).

A hypothesis moves to findings **only** when an external verified source turns up. Running the check yourself gets it to *validated in-project* — recorded, real, still not a finding. Nothing the skill or the user reasons their way to promotes anything.

No doc cites a sibling. A position from an earlier doc can be **imported** — restated in full as a new local hypothesis crediting the origin, starting at *open* — so reasoning that exists nowhere else isn't lost. It arrives as a hypothesis and stays one; a sibling doc can never put a claim in Key findings.

## Actions

The spine of the doc. Each has a permanent ID and a `Because:` line naming its backing — sources, hypothesis IDs, or both mixed.

- Empty `Because:` → an unwritten belief is doing the work. Write the hypothesis or drop the action.
- Doesn't serve the Goal → scope creep, or the Goal was understated.
- Source-only backing → build it. Any hypothesis in the backing → building it *is* the experiment.

Actions are a queue, not a record: they leave the list once built and resolved, and the memory lives on the hypothesis entry. Dropped ones move to Decisions with a reason.

## Files

- `SKILL.md` — the whole skill; always loaded
- `references/charter-template.md` — six fields, four-step interview, drafted defaults; loaded only in charter mode
- `references/chat-output.md` — repo locations mapped to chat (artifact, Project knowledge); loaded only with no repo
