# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Repo Is

Claimkit's premise: **research is only useful later if you can still tell what was evidence and what was a guess.** One skill enforces that split and keeps it honest as the doc is revised.

Every claim it writes is a **finding** (cites an external primary source) or a **hypothesis** (doesn't — a position developed with the user, carrying the check that would settle it). Every action names its backing. Promotion is source-gated and one-directional: only an external verified source moves a hypothesis into findings. A successful in-project experiment gets *validated in-project*, which is a status change, not a promotion — a finding is something the next reader verifies by clicking a link, and these docs are barred from citing each other. One doc can *import* another's position, but only back into hypotheses — never as evidence.

That asymmetry is the whole design. Loosen it and the skill degrades into a summarizer that launders its own guesses into evidence, which is the failure it exists to prevent.

This repo distributes one skill as a **Claude plugin**, an **Antigravity plugin**, and a **Copilot plugin**. There is no build system and no compiled code — Markdown, TOML, and JSON only. `pyproject.toml` carries metadata; the only Python dependency is pre-commit. **The deliverable is prose an agent will execute**, so a change to `SKILL.md` is a behavior change: read the surrounding phases before editing one, because they reference each other by number.

## Directory Map

| Path | Purpose |
|------|---------|
| `skills/claimkit/SKILL.md` | The whole skill — phases 1–5, the output template, output principles |
| `skills/claimkit/references/charter-template.md` | Charter field spec + interview; loaded only in charter mode |
| `skills/claimkit/references/review-mode.md` | Two-pass re-check of an existing doc's claims; loaded only in review mode |
| `skills/claimkit/references/chat-output.md` | Repo locations mapped to chat equivalents (Markdown artifact, Project knowledge); loaded only when there's no user project to write into |
| `.claude-plugin/` | Claude plugin metadata (`plugin.json`) and marketplace catalog (`marketplace.json`) |
| `plugin.json` | **Antigravity** plugin manifest (root) — separate file and schema from `.claude-plugin/plugin.json` |
| `rules/` | Antigravity markdown rules (guidance, not enforcement) |
| `.config/` | `.pre-commit-config.yaml` and `.commit-message-template` (installed as `commit.template` by `make hooks`) |
| `GEMINI.md` | Workspace context file — read by Antigravity |

Generated and gitignored, so never hand-edit: `.gemini/`, `.claude/settings.local.json`.

**No `agents/` directory, and don't add one.** Claimkit distributes no agents.

## Development Commands

```bash
make claude           # Reinstall this repo as a Claude plugin (local scope)
make hooks            # Install pre-commit hooks + commit template
make check            # Run all pre-commit hooks on all files (also: check-json / check-toml / check-yaml)
make clean            # Remove pre-commit cache
make help             # List all targets
```

`make hooks` uses `uv tool install` when uv is present, else pip.

**`make claude` reinstalls at local scope and is safe to re-run.** Uninstall is `|| true` so a first run doesn't fail on "not found"; `marketplace add` is idempotent (it prints "already on disk" and exits 0), so the marketplace only ever registers once. `claude plugin install` takes a plugin *name* resolved through configured marketplaces — `claude plugin install .` fails with "not found in any configured marketplace", which is why the marketplace step exists at all. Installing *copies* the repo into `~/.claude/plugins/cache/claimkit-marketplace/claimkit/<version>/`, and Claude loads that copy, so a `SKILL.md` edit needs a re-run; `marketplace update` re-validates the directory source first. Restart Claude Code to pick up the new copy.

**User install commands stay in the README.** Don't add `make antigravity` / `make claude-project` style targets back — a user shouldn't need `make` to install a plugin, and two copies of the install steps drift.

**There is no test suite.** Validation is pre-commit (JSON/YAML syntax, EOF, trailing whitespace, private-key detection). Behavior is verified by installing the plugin and running the skill on a real topic in a real repo — a syntactically valid `SKILL.md` can still be wrong.

When testing locally, check whether `~/.claude/skills/concept-research/` is still installed. That user-level skill is claimkit's predecessor and carries identical trigger phrases, so leaving both in place means two skills competing for the same requests.

## The Skill

### Phase flow

Phases 1–5 in `SKILL.md`: scope (≤3 questions) → research → **alignment interview** → write → charter reconciliation. Phase 3 is the one that can't be moved or skipped: its questions are only askable *after* research, because you don't know the axes of variation until you've read the sources. Cut it and the output is a Wikipedia page.

Phase 5 runs strictly after the doc is on disk. A charter edit made first would change what the doc says, entangling the frame with the conclusion.

### The output template is the contract

Eight required sections, one owner per fact. Overlap is what let earlier generations of these docs state the same thing four times in four voices, so *each section owns exactly one thing* is a hard rule, not a style note:

`Summary` restates and originates nothing · `Key findings` sourced claims · `Hypotheses` unsourced positions · `How this applies` interpretation, no new claims · `Actions` build steps, no argument · `Decisions` what was ruled out · `Sources` · `Open questions` no position taken yet.

An empty section says "None" and why — never delete the heading. A missing section is invisible; a stated absence is a fact. That's the whole reason the structure check at the end of Phase 4 exists: a section quietly dropped is exactly how an earlier version of this skill lost its action roll-up across three docs without anyone noticing.

### Invariants — don't relax these while editing

- **Hypotheses are required and permanent.** IDs assigned once, never renumbered, never reused.
- **Promotion is source-gated.** See "What This Repo Is". This is the load-bearing invariant; any change that lets the skill promote on its own reasoning breaks the plugin's reason to exist.
- **Every action carries a non-empty `Because:`.** Empty means an unwritten belief is doing the work.
- **Docs are revised in place.** No replace, no dated fork. The accumulated hypotheses are the record.
- **The doc stands alone.** It never cites another doc in `docs/research/` — those are conclusions, not sources, and they're revised in place, so a pointer rots unseen. Mine them for leads, then cite the primary. A position from an earlier doc may be **imported** (restated in full as a new local hypothesis, new ID, status *open*, origin credited, its citations chased to their own primaries) — that's how reasoning existing nowhere else survives without creating a dependency. Imports arrive as hypotheses and stay hypotheses.
- **Never invent a citation, and never invent rationale.** A fabricated reference is unfalsifiable to every later reader. If a claim can't be sourced, it's a hypothesis; if a reason isn't known, it stays absent.

### Progressive disclosure

`SKILL.md` is always loaded; `references/` is pulled in only when a mode needs it. New detail belongs in a named `references/` file, not inlined — growing the entry point taxes every invocation, including the ones that never reach that mode. `charter-template.md` is the model: the charter interview lives there because it only matters in charter mode.

## Plugin Structure

The repo root **is** the plugin for every platform. Two manifests coexist because each platform reads a different file:

| Platform | Manifest | Notes |
|----------|----------|-------|
| Claude | `.claude-plugin/plugin.json` + `.claude-plugin/marketplace.json` | Marketplace `source` must be `"./"` (trailing slash) |
| Antigravity (IDE + CLI) | `plugin.json` (root) | Minimal schema — `{"name": "claimkit"}`. Optional siblings: `hooks.json`, `rules/`. **Two products, one plugin:** IDE installs by folder placement (`~/.gemini/config/plugins/`), CLI via `agy plugin install` (`~/.gemini/antigravity-cli/plugins/`). Contents identical; only install differs |

**Do not consolidate `plugin.json` and `.claude-plugin/plugin.json`.** Different files, different schemas, different readers. Claude's carries version/author/homepage/license; Antigravity's takes `name` and nothing else is required.

**No Gemini CLI support, deliberately.** Gemini CLI stopped serving Pro/Ultra/free tiers on 2026-06-18. Repokit keeps `gemini-extension.json` and `policies/policies.toml` for existing Code Assist Standard/Enterprise users; claimkit has none to keep working, so it ships neither. Don't add them by analogy with repokit.

**Real files must stay in `skills/`.** Don't add a `.agents/skills` symlink — Claude's remote plugin fetch doesn't resolve symlinks. (`.agents/` *is* Antigravity's canonical consumer-workspace path; that's a different thing.)

**Antigravity path gotcha:** Antigravity's *global* config stayed under `~/.gemini/` — `~/.gemini/config/plugins/`, `~/.gemini/GEMINI.md`. Don't "correct" those to `~/.agents/`.

## Rules

`rules/*.md` are Antigravity markdown **guidance** injected into context — the model may or may not comply. Don't describe them as enforcement. Coverage: research-doc integrity (revise in place, ID stability, no self-promotion, no invented citations, charter is frame not evidence) and secrets (deny reading credential files; read keys not values).

## Skill Frontmatter Format

```yaml
---
name: claimkit
description: 'Trigger phrases and what this skill does. Use when asked to: ...'
user-invocable: true
argument-hint: "[topic | charter]"
---
```

Keep `description` under 1024 characters. It's the only thing loaded before the skill fires, so it is the whole activation surface on all three platforms — the trigger phrases ("research X", "look into X", "get up to speed on X") are what actually fire it, and none of them need to be the plugin's name.

## Extra Rules

1) No tombstones. No "previous versions ..."
2) Don't update installed copies of skills that live in this repo. Edit them here.
