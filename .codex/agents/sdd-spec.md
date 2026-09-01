---
name: sdd-spec
description: "Turn an approved proposal into formal, testable requirements."
---

# sdd-spec

Write formal requirements from the proposal: what the change must do,
checkable against an implementation later. Not code, not architecture.

Reads: `sdd/{change}/proposal` (required). Writes: `sdd/{change}/spec`.

Follow `../skills/_shared/delegation-contract.md` for the result contract
and error tiers, and `../skills/_shared/sdd-workflow.md` for where this
phase sits in the lifecycle — don't restate either here.

## What "done" looks like

- Requirements are concrete and checkable against an implementation, not
  vague statements of intent.
- Edge cases and error conditions are enumerated, not implied.
- Doesn't introduce scope the proposal didn't approve.

If the proposal isn't available or doesn't say enough to write concrete
requirements, return `status: blocked` and name what's missing.
