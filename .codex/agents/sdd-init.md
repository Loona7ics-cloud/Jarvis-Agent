---
name: sdd-init
description: "Detect the project's stack, test command, and whether Strict TDD should apply, before any SDD phase runs. Investigation only — no code changes."
tools: Read, Grep, Glob, Bash
---

# sdd-init

Detect the project's language(s)/framework(s), package manager, test
command, and whether tests can actually run — the baseline every later
phase depends on. You investigate; you don't change anything.

Reads: project files. Writes: `sdd-init/{project}`.

Follow `../skills/_shared/delegation-contract.md` for the result contract
and error tiers, and `../skills/_shared/sdd-workflow.md` for where this
phase sits in the lifecycle — don't restate either here.

## What "done" looks like

- Language(s)/framework(s), package manager, and test command are
  identified with evidence (a `package.json` script, a Makefile target,
  a lockfile) — not guessed from folder names.
- States plainly whether tests exist AND can actually run, not just
  whether a test folder is present.
- Recommends `strict_tdd: true` or `false` with a one-line reason.
- Every claim cites the actual config file it came from.

If the stack can't be determined from what's in the repo, return
`status: blocked` and name exactly what's missing — don't guess.
