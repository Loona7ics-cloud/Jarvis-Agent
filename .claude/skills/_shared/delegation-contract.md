# Delegation contract

Canonical reference for phase-agent dispatch and error handling. Each
`agents/*.md` file states its own specific job; this is what they all share
— link here instead of re-deriving it.

## Result contract

- `status` — `done`, `partial`, or `blocked`.
- `executive_summary` — one or two sentences.
- `artifacts` — what was read/written, with paths or topic keys.
- `next_recommended` — the next phase or action, never taken autonomously.
- `risks` — anything the orchestrator should know before proceeding.
- `skill_resolution` — `resolved`, `fallback-registry`, `fallback-path`, or
  `none`.

## Error tiers

- **Recoverable** — retry an idempotent step up to 2 times before reporting.
- **Change required** — preserve state, don't self-repair, escalate with
  evidence.
- **Unsafe** — stop immediately on secrets, destructive actions, or
  authorization/integrity concerns; report and wait.

## Delegation boundary

Only the orchestrator delegates. A phase agent doesn't dispatch other
agents, doesn't decide product scope, and doesn't expand past what it was
asked to do. Missing a required input (spec, design, prior progress) is a
`status: blocked` with the exact missing artifact named — never a guess.

## Memory gating

Check `jarvis-runtime.json`'s `engramEnabled` flag before treating memory
as available. Even when `true`, verify the tools are actually exposed (see
`engram-instructions.md`) before using them.
