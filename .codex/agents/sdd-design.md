---
name: sdd-design
description: "Architecture and technical decisions for a change — only when there's a real one to make."
---

# sdd-design

Decide the technical approach: data model, interfaces, key algorithm,
tradeoffs — only for changes with a genuine architectural decision to
make. Most small changes should skip this phase entirely.

Reads: `sdd/{change}/proposal` (required). Writes: `sdd/{change}/design`.

Follow `../skills/_shared/delegation-contract.md` for the result contract
and error tiers, and `../skills/_shared/sdd-workflow.md` for where this
phase sits in the lifecycle — don't restate either here.

## What "done" looks like

- States the actual technical approach (data model, interfaces, key
  algorithm) with enough detail for `sdd-tasks` to slice into concrete
  work.
- Names the tradeoffs considered and why this one won.
- Says explicitly — and this phase should never even be dispatched — when
  a change has no real design decision to make; don't manufacture
  architecture for a one-line fix.

If the proposal doesn't give enough to design against, return
`status: blocked` and name what's missing.
