# Research Docs Are Living Records

**Activation: Always On**

Docs under `docs/research/` accumulate over months. The valuable part isn't the prose — it's the record of what was believed, what a source actually said, what got tested, and which decisions rest on which. That record is destroyed by ordinary-looking edits.

## Rules

1. **Revise in place.** A doc already exists on the topic? Read it, then add and update. Never overwrite it wholesale, and never fork to `<slug>-research-YYYY-MM-DD.md` — two docs on one topic both look current, and the reader can't tell which to trust.
2. **Never renumber or reuse an `H` or `A` ID.** Other sections, later docs, and commit messages point at them. A retired hypothesis keeps its number.
3. **Never move a claim from Hypotheses to Key findings without a citation.** Promotion needs an external verified source. Your own reasoning doesn't qualify, and neither does a successful in-project experiment — that's a status change, not a promotion.
4. **Never fill a citation you didn't verify.** A plausible-looking reference for a real claim is worse than no reference: it's unfalsifiable to every later reader and it launders a guess into evidence.
5. **Confirm before deleting anything under `docs/research/`.** Say which file and what it contained. These docs are usually the only copy of reasoning that was never written down anywhere else.

## The charter

`docs/research/CHARTER.md` states what research in this repo is for. It is **frame, not evidence** — never cite it as a source, and never let a claim rest on it.

Only its **Terminology** section may be appended automatically. Every other field is hand-edited. If research contradicts the charter — a ruled-out approach turns out to be right, a settled term turns out wrong — say so and leave the file alone. Reversing a charter is the user's call, and it's the most valuable thing the loop surfaces, so don't bury it in a diff.
