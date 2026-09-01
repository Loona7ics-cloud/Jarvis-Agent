# Jarvis

Jarvis is a spec-driven-development (SDD) coding orchestrator for Claude
Code and/or Codex, running the real **gentle-ai** SDD stack. It turns a
feature request or bug report into a scoped, verified change through the
gentle-ai phase lifecycle (explore → propose → spec → design → tasks →
apply → verify → archive), with an optional `judgment-day` blind dual
review (`jd-judge-a` / `jd-judge-b`, one bounded `jd-fix-agent` pass on
confirmed issues) and opt-in receipt-driven review/delivery gates.

## Prerequisites (new machine)

This repo is **not** a self-contained drop-in — cloning it is not enough.
Phase agents read shared conventions from `~/.claude/skills/_shared/...`
and `~/.codex/skills/_shared/...` (your home directory, not the repo), and
Engram is wired through your machine's global Claude/Codex config, not
anything committed here. Before opening this repo, the machine needs:

1. **The `gentle-ai` CLI** on `PATH` (`gentle-ai --version` should work).
   Check [`Gentleman-Programming/gentle-ai`](https://github.com/Gentleman-Programming/gentle-ai)
   for how to install it on that platform — this repo doesn't ship it.
2. **The `engram` binary**, installed and registered with Claude Code
   and/or Codex (`gentle-ai install` normally does this step for you —
   see below).
3. **Claude Code and/or Codex** installed.

Once those three are in place, clone the repo and run the same install
gentle-ai already ran here, scoped to this workspace:

```bash
gentle-ai install --scope workspace --agents claude-code,codex --components sdd,skills
```

`--scope workspace` writes agents/skills/commands into this repo's own
`.claude/`/`.codex/` — but it still expects the home-directory pieces
above (`gentle-ai`, `engram`, the global skill catalog) to already exist
on that machine. See [`Docs/01 - install.md`](Docs/01%20-%20install.md)
for update/sync notes and [`Docs/02 - internal-scope.md`](Docs/02%20-%20internal-scope.md)
for why it's wired this way.

## Scope

Jarvis is a code-change orchestrator, not a general assistant. It depends
on the `gentle-ai` CLI and Engram — it is not a dependency-free bundle.
See [`Docs/02 - internal-scope.md`](Docs/02%20-%20internal-scope.md).
