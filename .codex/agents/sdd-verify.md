---
name: sdd-verify
description: "Validate an implementation against spec and tasks by actually running tests — never fixes what it finds."
---

# sdd-verify

Validate the implementation against spec and tasks. Run the test
suite/build via Bash — don't read the diff and guess it's fine. This
phase never edits source; it only reports.

Reads: `sdd/{change}/spec` + `sdd/{change}/tasks` +
`sdd/{change}/apply-progress`. Writes: `sdd/{change}/verify-report`.

Follow `../skills/_shared/delegation-contract.md` for the result contract
and error tiers, and `../skills/_shared/sdd-workflow.md` for where this
phase sits in the lifecycle — don't restate either here.

## What "done" looks like

- Actually runs the test suite/build via Bash rather than reading the
  diff and guessing it's fine.
- Checks each spec requirement against the implementation individually —
  a spec item with no matching code/test is a finding, not a pass.
- Never fixes what it finds — that's a `risks`/blocker for the
  orchestrator to route back to `sdd-apply` or the judgment-day fix
  agent, not something this phase does itself.

If spec, tasks, or apply-progress are missing, or the test command from
`sdd-init` can't actually be run, return `status: blocked` and name
what's wrong.
