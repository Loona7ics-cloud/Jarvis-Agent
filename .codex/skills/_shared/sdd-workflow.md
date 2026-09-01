# SDD workflow

The phase lifecycle for any non-trivial change. Read before dispatching any
`sdd-*` agent. This is a portable, file/memory-only version of the pattern —
no external dispatcher, ledger, or review binary required, by design.

## Dependency graph

```text
init -> explore -> propose -> specs --> tasks -> apply -> verify -> archive
                                ^
                                |
                              design
```

`design` is optional — skip it for changes with no real architectural
decision to make (a straightforward bug fix, a small isolated feature).
`tasks` then reads spec (+ design if present).

## Phases

| Phase | Agent | Reads | Writes | Model |
|---|---|---|---|---|
| Init | `sdd-init` | project files | `sdd-init/{project}` | haiku |
| Explore | `sdd-explore` | nothing (fresh investigation) | `sdd/{change}/explore` | sonnet |
| Propose | `sdd-propose` | explore (optional) | `sdd/{change}/proposal` | opus |
| Spec | `sdd-spec` | proposal (required) | `sdd/{change}/spec` | sonnet |
| Design | `sdd-design` | proposal (required) | `sdd/{change}/design` | opus |
| Tasks | `sdd-tasks` | spec + design (required) | `sdd/{change}/tasks` | sonnet |
| Apply | `sdd-apply` | tasks + spec + design + prior apply-progress | `sdd/{change}/apply-progress` | sonnet |
| Verify | `sdd-verify` | spec + tasks + apply-progress | `sdd/{change}/verify-report` | sonnet |
| Archive | `sdd-archive` | all artifacts | `sdd/{change}/archive-report` | haiku |

Use the listed model as a default `model:` override on the `Agent` call for
that phase; if you don't have access to it, fall back to `sonnet`.

## Session preflight

Before the first SDD phase in a session for a given change, resolve and
cache:

1. **Execution mode** — `interactive` (summarize after each phase, wait to
   continue) or `auto` (chain phases, but still gate each one — see below).
   Default `auto` if the user doesn't say.
2. **Artifact store** — `engram` (default when its tools are verified
   available), `openspec` (plain files under `openspec/changes/<name>/`,
   use when the user wants file-based artifacts or Engram isn't available),
   or `none` (inline only, explain the persistence limitation).

Ask both in one grouped question if the runtime supports it; otherwise ask
in one message. Don't ask about PR-splitting strategy or review-line
budgets up front — raise that only if `sdd-tasks` actually forecasts a
large change (see Review size below).

## Init guard

Before any SDD phase, check whether init has run for this project:
search the artifact store for `sdd-init/{project}`. If found, proceed. If
not, run `sdd-init` first — it detects the stack, test command, and whether
Strict TDD mode applies, and every later phase depends on that.

## Automatic-mode gate

In `auto` mode, validate every phase result before launching the next:

- `status` is not `partial`/`blocked` without you having decided how to
  handle that.
- The declared artifact is actually readable in the active store.
- No claimed file, symbol, or command in the result is fabricated — spot
  check at least one.
- The phase didn't drift from what its inputs said (e.g. `tasks` matches
  `spec`, not something adjacent to it).
- `next_recommended` matches the dependency graph.

On a gate failure, re-run that same phase once with specific corrective
feedback. If it fails again, stop the chain and report to the user — don't
push forward into a dependent phase on shaky ground.

## Review size

After `sdd-tasks`, look at its size estimate. If the change looks like it
will produce a large diff (rule of thumb: >400 changed lines, or the task
list itself says so), stop before `sdd-apply` and ask the user: proceed as
one change, or split it into smaller sequential changes? Don't invoke any
external chaining tool to decide this — it's a conversation with the user,
not an automated policy.

## Result contract

Every phase agent returns: `status` (`done`/`partial`/`blocked`),
`executive_summary`, `artifacts`, `next_recommended`, `risks`,
`skill_resolution`. See `CLAUDE.md` / `AGENTS.md` for the full field
meanings — don't restate them per phase file, that's what this shared doc
and the root file are for.

## Strict TDD

If `sdd-init/{project}`'s result says `strict_tdd: true`, forward this to
`sdd-apply` and `sdd-verify`: "Strict TDD is active. Test runner:
`{test_command}`. Write the failing test first, then the minimal
implementation, then verify it passes — don't write implementation before a
test exists for it."

## Apply-progress continuity

Before launching `sdd-apply` on a change that already has prior progress,
tell it to read `sdd/{change}/apply-progress` first, merge new work into
it, and save the combined result — never overwrite a batch's history.

## Archive handoff

When launching `sdd-archive`, forward any final-state facts that happened
after the last `apply-progress`/`verify-report` save (a verify warning
fixed in a later commit, a task finished after verify ran) — those two
artifacts are snapshots, not the final truth; the archive report should
reflect what's actually true at close.

## Topic keys

| Artifact | Topic key |
|---|---|
| Project context | `sdd-init/{project}` |
| Explore | `sdd/{change}/explore` |
| Proposal | `sdd/{change}/proposal` |
| Spec | `sdd/{change}/spec` |
| Design | `sdd/{change}/design` |
| Tasks | `sdd/{change}/tasks` |
| Apply progress | `sdd/{change}/apply-progress` |
| Verify report | `sdd/{change}/verify-report` |
| Archive report | `sdd/{change}/archive-report` |

Retrieve with `mem_search(query: "{topic_key}", project: "{project}")`, then
`mem_get_observation(id)`. Under `openspec`, read
`openspec/changes/<change>/` instead. Under `none`, nothing persists —
carry the artifact forward in the conversation yourself.

## Context protocol

Sub-agents start with fresh context — you control what they get. Forward:
the exact topic keys or file paths they need to read, any prior-phase
summary that matters, and the resolved `model` alias. Don't paste entire
prior artifacts into the prompt when a topic key/path reference will do —
that's the main token-efficiency lever in this whole workflow, so use it by
default, not as an afterthought.

## Recovery

- `engram` → `mem_search` → `mem_get_observation`.
- `openspec` → read `openspec/changes/<change>/` state and artifacts.
- `none` → nothing persisted; ask the user to re-paste what's needed.
