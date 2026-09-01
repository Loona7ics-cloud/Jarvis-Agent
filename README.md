# Jarvis

Jarvis is a lean, portable spec-driven-development (SDD) coding
orchestrator for Claude Code and/or Codex. It turns a feature request or
bug report into a scoped, verified change through a fixed phase lifecycle:

```text
init -> explore -> propose -> specs --> tasks -> apply -> verify -> archive
                                ^
                                |
                              design
```

`design` is optional — skipped for changes with no real architectural
decision to make. Every phase is a separate delegated worker with its own
scoped `Reads`/`Writes` and a shared result contract (`status`,
`executive_summary`, `artifacts`, `next_recommended`, `risks`,
`skill_resolution`); the full phase table, dependency graph, and topic keys
live in `.claude/skills/_shared/sdd-workflow.md` (mirrored at
`.codex/skills/_shared/sdd-workflow.md`).

On top of the lifecycle, `judgment-day` runs an optional blind dual review
of a stable diff: two independent workers (`jd-judge-a` on correctness,
`jd-judge-b` on security/consistency) review the same candidate without
seeing each other's output, and a confirmed, agreed-upon issue gets exactly
one bounded fix pass — never a review loop.

## A deliberately lean fork

Jarvis is adapted from a richer pattern used elsewhere: some real-world SDD
systems wire this same lifecycle to an external dispatcher/attempt-ledger
binary and a review service for extra automation and safety rails —
tracked attempt history, enforced review gates, cross-session state outside
the runtime's own memory. Jarvis intentionally drops that layer. It has no
external binary dependency and assumes nothing beyond what a Claude Code or
Codex session already has: file tools, subagent dispatch, and optionally
the Engram MCP tools. That's a deliberate trade — less automation, in
exchange for being a portable prompt/governance bundle that runs anywhere
without installing or wiring anything else up.

## Token efficiency

The bundle is designed to stay cheap to run:

- Shared contracts (`_shared/delegation-contract.md`,
  `_shared/sdd-workflow.md`) are referenced by every phase agent, never
  restated per file.
- Sub-agents are dispatched with topic-key or file-path references to prior
  artifacts (`sdd/{change}/spec`, etc.), not the full artifact body pasted
  into the prompt — the orchestrator's context protocol treats this as the
  default, not an afterthought.
- Each agent file is intentionally short: a role paragraph, a `Reads`/
  `Writes` line, and "what done looks like" — the error tiers and result
  contract live once in the shared docs.

## Install

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -Target Codex
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -Target Claude
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -Target Both
```

Omit `-Target` for an interactive `1) Codex / 2) Claude / 3) Both` prompt.
The installer is clean-install only — it copies the bundle into
`$HOME\.codex` and/or `$HOME\.claude` and refuses to run if any bundle-managed
path already exists there. It never edits `config.toml` or `settings.json`.
See `Docs/01 - install.md` for details.

## Scope

Jarvis is a code-change orchestrator, not a general assistant. See
`Docs/02 - internal-scope.md`.
