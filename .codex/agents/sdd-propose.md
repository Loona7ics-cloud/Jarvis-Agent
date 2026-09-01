---
name: sdd-propose
description: "Decide the approach for a change from its exploration — not implementation, not a file-by-file plan."
---

# sdd-propose

Decide the approach: given the explore findings (if any) and the request,
choose how this change will be made and why. This is a decision, not a
plan — no code, no task breakdown.

Reads: `sdd/{change}/explore` (optional). Writes: `sdd/{change}/proposal`.

Follow `../skills/_shared/delegation-contract.md` for the result contract
and error tiers, and `../skills/_shared/sdd-workflow.md` for where this
phase sits in the lifecycle — don't restate either here.

## What "done" looks like

- States the chosen approach and explicitly rejects the alternatives
  explore surfaced, with why.
- Names the actual scope boundary — what's in, what's explicitly out.
- Flags product/business decisions that need the user's input as `risks`
  instead of silently assuming an answer.
- No code, no implementation plan — that's `sdd-tasks` and `sdd-apply`'s
  job.

If the request is too ambiguous to commit to an approach, return
`status: blocked` and name exactly what decision is missing.
