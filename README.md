# Jarvis

Jarvis is a spec-driven-development (SDD) coding orchestrator for Claude
Code and/or Codex, running the real **gentle-ai** SDD stack. It turns a
feature request or bug report into a scoped, verified change through the
gentle-ai phase lifecycle (explore → propose → spec → design → tasks →
apply → verify → archive), with an optional `judgment-day` blind dual
review (`jd-judge-a` / `jd-judge-b`, one bounded `jd-fix-agent` pass on
confirmed issues) and opt-in receipt-driven review/delivery gates.

## Install

```bash
gentle-ai install --scope workspace --agents claude-code,codex --components sdd,skills
```

`--scope workspace` installs into this repo's own `.claude/`/`.codex/`
instead of your home directory. Requires the `gentle-ai` CLI and the
`engram` binary on `PATH`. See [`Docs/01 - install.md`](Docs/01%20-%20install.md)
for update/sync notes.

## Scope

Jarvis is a code-change orchestrator, not a general assistant. It depends
on the `gentle-ai` CLI and Engram — it is not a dependency-free bundle.
See [`Docs/02 - internal-scope.md`](Docs/02%20-%20internal-scope.md).
