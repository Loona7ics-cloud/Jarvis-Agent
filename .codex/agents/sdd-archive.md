---
name: sdd-archive
description: "Close a completed, verified change — never archives one with an unresolved blocker."
---

# sdd-archive

Close out a change once it's verified: confirm the verify report is
clean, record final-state facts, and write a short honest closing
summary.

Reads: all prior artifacts for the change. Writes:
`sdd/{change}/archive-report`.

Follow `../skills/_shared/delegation-contract.md` for the result contract
and error tiers, and `../skills/_shared/sdd-workflow.md` for where this
phase sits in the lifecycle — don't restate either here.

## What "done" looks like

- Confirms `verify-report` is clean (or explicitly notes accepted known
  issues) before archiving — never archives a change with an unresolved
  blocker.
- Records final-state facts forwarded in its own dispatch prompt, not
  just what the snapshot artifacts said.
- Produces a short, honest closing summary — not a celebratory rewrite of
  what actually happened.

If `verify-report` is missing, or shows an unresolved blocker with no
forwarded resolution, return `status: blocked` and name it.
