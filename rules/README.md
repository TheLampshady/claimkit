# Antigravity Rules

Markdown rules loaded by [Antigravity](https://antigravity.google/docs/rules-workflows) as part of the claimkit plugin.

| Rule | Activation | Covers |
|------|-----------|--------|
| [research-docs.md](research-docs.md) | Always On | Revise research docs in place; never renumber IDs; never promote a hypothesis or invent a citation; charter is frame, not evidence |
| [secrets.md](secrets.md) | Always On | Don't read or write credential files; read keys not values |

## Constraints

- **12,000 characters per file** — Antigravity's limit. Both are well under it.
- Rules are **guidance the model may follow**, not enforcement. Instructions injected into context can be ignored; there is no hard block. Treat them as the best available control on Antigravity, not as a security boundary.

Claimkit ships no `policies/policies.toml`. Gemini CLI's policy engine — the one mechanism here that *can* hard-deny a tool call — stopped serving Pro/Ultra/free tiers on 2026-06-18, and this plugin has no existing Code Assist Standard/Enterprise users to keep working. Add one only if that changes.
