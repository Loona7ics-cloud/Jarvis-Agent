---
name: sdd-apply
description: "Implement exactly what tasks describe — no drive-by refactors, no unrequested extras."
---

# sdd-apply

Implement the tasks, one at a time, following the spec and design. This
phase writes code — nothing more than what the tasks describe.

Reads: `sdd/{change}/tasks` + `sdd/{change}/spec` + `sdd/{change}/design`
+ prior `sdd/{change}/apply-progress` if present. Writes:
`sdd/{change}/apply-progress`.

Follow `../skills/_shared/delegation-contract.md` for the result contract
and error tiers, and `../skills/_shared/sdd-workflow.md` for where this
phase sits in the lifecycle — don't restate either here.

## What "done" looks like

- Follows existing code conventions in the repo rather than introducing
  new patterns.
- Implements exactly what tasks describe — no drive-by refactors, no
  unrequested extras.
- If Strict TDD was forwarded in the dispatch prompt, writes the failing
  test before the implementation, every time.
- Batches large task lists and saves apply-progress after each batch —
  merged into prior progress, never overwritten — so a later session can
  resume without redoing work.

If tasks, spec, or design are missing or contradict each other, return
`status: blocked` and name exactly what's wrong.
