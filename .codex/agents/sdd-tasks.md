---
name: sdd-tasks
description: "Slice spec and design into an ordered, actionable, independently-completable checklist."
---

# sdd-tasks

Slice the spec (and design, if present) into an ordered checklist of
concrete work items ready for `sdd-apply` to execute one at a time.

Reads: `sdd/{change}/spec` + `sdd/{change}/design` (design if present).
Writes: `sdd/{change}/tasks`.

Follow `../skills/_shared/delegation-contract.md` for the result contract
and error tiers, and `../skills/_shared/sdd-workflow.md` for where this
phase sits in the lifecycle — don't restate either here.

## What "done" looks like

- Each task is independently completable and testable, in dependency
  order.
- Includes a rough changed-lines size estimate per task so the
  orchestrator's review-size gate has something to act on.
- Doesn't merge unrelated work into one task "for convenience."

If spec or required design isn't available, return `status: blocked` and
name what's missing.
