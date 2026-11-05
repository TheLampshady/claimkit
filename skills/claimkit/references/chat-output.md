# Chat output — where things live without a repo

Loaded only when there is **no user project to write into**: a chat such as claude.ai, with no working directory the user opened. A code-execution sandbox doesn't count. It isn't the user's project, nobody sees what's written there, and it's gone when the chat ends.

Only *where things live* changes. The template, the IDs, the claim split, the Phase 4 structure check, and every rule in `SKILL.md` apply unchanged. In a repo the files persist between runs on their own. In chat the user carries them, so each repo location below maps to something the user hands you or keeps.

| In a repo | In chat |
|---|---|
| The doc, `docs/research/<slug>-research.md` | A **Markdown artifact** titled `<slug>-research.md` |
| An existing doc on the topic, found on disk | A doc the user attaches, pastes, or keeps in the Project's knowledge |
| `docs/research/CHARTER.md` | A `CHARTER.md` in Project knowledge or attached, or a charter in the Project instructions |
| Sibling docs in `docs/research/` | Other `*-research.md` files attached or in Project knowledge |
| "After the doc is on disk" (Phase 5) | After the artifact is delivered |
| `Wrote: docs/research/<slug>-research.md` | `Wrote: <slug>-research.md (artifact)`, plus where to keep it |

Use whatever web search and fetch tools the environment provides wherever `SKILL.md` names WebSearch and WebFetch.

---

## The doc is Markdown, not HTML

Write the template exactly as `SKILL.md` gives it, with the explicit `<a id>` anchors, as a Markdown artifact. Don't render it as HTML:

- **The template is the contract.** An HTML rendering is a second template, and two templates drift.
- **The doc has to come back.** Revising in place in chat means the user hands the doc back next session. Markdown round-trips cleanly, so IDs, anchors and `Because:` lines read back exactly as written. HTML returns wrapped in markup.
- **It moves into a repo unchanged.** A doc started in chat can be dropped into `docs/research/` later and revised from there, with no conversion.

If the user asks for an HTML view, make it *in addition*, and say that the Markdown is the record and the one to bring back.

---

## Revise in place — the user holds the record

In a repo you find an existing doc by looking. In chat you can't, and if you miss it you write a fresh doc with fresh IDs, which is exactly the fork `SKILL.md` forbids.

- **Look first.** Check attachments, pasted text, and Project knowledge for a `*-research.md` on the topic.
- **If there isn't one, ask once, in Phase 1.** Fold it into *Current understanding* ("Is there an earlier claimkit doc on this? If so, attach it"). It doesn't count as a fourth question. If the user says no, or doesn't answer, write a new doc.
- **Deliver the whole revised doc.** Re-emit the full doc as the artifact under the same title. Never send a diff or only the changed sections, because the user's copy is replaced wholesale.
- **Tell the user to replace, not add.** If the old copy is in Project knowledge, it gets swapped for the new one. Two copies there are two docs that both look current.

A doc you recall from earlier in the conversation is not a substitute for the user's copy if they have edited it since. When they attach one, revise that.

---

## Charter

- **Phase 1 lookup.** Check Project knowledge and attachments for `CHARTER.md`, and the Project instructions for a charter. When there's none, the absent note becomes:

  > No research charter in this conversation or Project — I'll frame this from our conversation. Ask me to set up a charter if you want future runs to skip the scoping questions.

- **Charter mode.** Run the interview from `charter-template.md` unchanged. Deliver the charter as its own Markdown artifact titled `CHARTER.md`, and tell the user to add it to the Project's knowledge, which is where the next run looks.
- **Phase 5.** You can't append to a file the user holds. Give the exact Terminology lines to add, under a one-line heading, after the doc artifact. The gate and the conflict rules are unchanged.

The charter is still frame and never a source, wherever it lives.

---

## Sibling docs and imports

Other `*-research.md` files in attachments or Project knowledge are siblings. Mine them for leads and import positions under the same rules: a new local ID, status *open*, the origin credited by filename, and citations chased to their primaries. Structure check 7 still applies, so every import must read correctly with the origin file gone.

---

## Review mode

Review needs the doc itself. If none is attached or in Project knowledge, ask for it and stop there. Never reconstruct a doc from memory to review it, because a review of a reconstruction checks claims the doc may not make.

Deliver the reviewed doc as a full artifact, under the same rules as a revision.

---

## The closing line

End with `Wrote: <slug>-research.md (artifact)`, then one line on where to keep it:

> Save this to your Project's knowledge (replacing any earlier copy) or to `docs/research/` in a repo — the next run revises it from there.

Never report a `docs/research/` path in chat. A path that doesn't exist is a pointer to nothing, the same failure as an invented citation. If you wrote a file into a sandbox along the way, the artifact is still the deliverable.
