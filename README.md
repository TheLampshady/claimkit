# claimkit

**Research that backs the work.**

Most research docs rot because they blend two kinds of statement: things a source actually says, and things you decided while reading. A year later nobody can tell which was which, so the whole doc gets treated as either gospel or noise.

Claimkit keeps them apart. Every claim it writes is a **finding** with a citation or a **hypothesis** with the check that would settle it. Actions name their backing, so what you built is traceable to why you believed it would work — and when a hypothesis turns out wrong, the actions resting on it are already listed.

Output goes to `docs/research/<topic>-research.md`. There's no separate database, no ticket integration, and nothing to install into the project being researched.

## Quickstart

**Claude Code** — install from the marketplace in this repo:

```bash
claude plugin marketplace add TheLampshady/claimkit
claude plugin install claimkit@claimkit-marketplace
```

**Antigravity IDE** — the repo root *is* the plugin, so place it in the global plugin dir. Symlinking a clone instead of copying means edits reload live:

```bash
git clone https://github.com/TheLampshady/claimkit.git
ln -sfn "$PWD/claimkit" ~/.gemini/config/plugins/claimkit
```

Restart the IDE, then mention `claimkit` to confirm the skill loads.

**Antigravity CLI** — same clone, installed through `agy`:

```bash
agy plugin install ./claimkit
```

Then ask for research in any of these. **Copilot** also discovers `skills/claimkit/SKILL.md` from the plugin root; on every platform the skill activates from its description, so there's nothing to wire up per project.

## Use it

Just ask. The skill fires on "research X for our project," "get me up to speed on X," "look into X, find me sources," or `/claimkit <topic>` to force it.

```
research vector databases — we're picking one for a 2M-doc corpus
```

It scopes in three questions, researches, then comes back with follow-ups it *couldn't* have asked upfront ("most sources assume 100M+ vectors, are you at that scale?"). That second interview is where the doc stops being a search result and starts being about your situation.

## What it writes

```
## Summary                    Goal / Hypotheses / Findings — ≤200 words, plain
## Key findings               sourced claims only
## Hypotheses                 H1…Hn — permanent IDs, statuses, and checks
## How this applies           interpretation, no new claims
## Actions                    A1…An, each with a Because: line
## Decisions                  what was ruled out, and why
## Sources
## Open questions             no position taken yet
```

The two rules that make it worth keeping:

**Only an external source promotes a hypothesis to a finding.** Running your own experiment gets it to *validated in-project* — real, recorded, and still not a finding, because a finding is something the next reader verifies by clicking a link. Your own argument, however good, promotes nothing.

**Every action names its backing.** An action with an empty `Because:` line means an unwritten belief is doing the work — so it becomes a hypothesis or it doesn't survive. Confidence is read off the backing rather than declared: source-only means build it, any hypothesis in the mix means building it *is* the experiment.

Docs are revised in place, never replaced or forked to a dated copy. Hypotheses accumulate and keep their IDs forever; the Actions list drains as work lands.

## The charter (optional)

A repo can carry `docs/research/CHARTER.md` — what research here is for, what's already ruled out, and what counts as good enough evidence to act on. When it exists, scoping questions mostly disappear and out-of-scope directions get filtered before they cost anything.

```
set up a research charter
```

Three fields are asked, three are drafted for approval. The charter is read for frame and **never cited as a source** — it states the question, so it can't be evidence. Only its Terminology section is ever appended automatically; a hypothesis can't graduate into it, or the next run researches toward its own guesses.

## Structure

| Path | Purpose |
|------|---------|
| `skills/claimkit/SKILL.md` | The skill — entry point, phase flow, output template |
| `skills/claimkit/references/charter-template.md` | Charter field spec and interview, loaded only in charter mode |
| `.claude-plugin/` | Claude plugin manifest + marketplace catalog |
| `plugin.json` | Antigravity plugin manifest (root; separate schema from Claude's) |
| `rules/` | Antigravity markdown rules — guidance, not enforcement |
| `.config/` | pre-commit config and commit message template |

No build system, no compiled code — Markdown, TOML, and JSON only. The deliverable is prose an agent executes, so a change to `SKILL.md` is a behavior change.

## Related

- [repokit](https://github.com/TheLampshady/repokit) — keeps a project's docs in sync with its code, then generates agents from them
- [tikkit](https://github.com/TheLampshady/tikkit) — ticket creation
