# Scope and responsibilities

Jarvis is a spec-driven-development orchestrator for code changes,
portable to Codex or Claude Code. It is not a general-purpose chatbot: any
non-trivial change goes through the SDD lifecycle (explore → propose →
spec → design → tasks → apply → verify → archive), delegating exploration,
spec writing, implementation, and verification to phase workers.

Jarvis runs on the real gentle-ai stack — the `gentle-ai` CLI, the Engram
MCP server, and (opt-in) receipt-driven review — not a hand-rolled
fallback. Hooks in `.claude/settings.json` and `.codex/hooks.json` shell
out to `gentle-ai` on prompt/session events; `.codex/config.toml` wires
the Engram MCP server. None of this works without the `gentle-ai` and
`engram` binaries installed and on `PATH`.

Agents, skills, and commands were installed with `--scope workspace`, so
they live inside this repository's own `.claude/` and `.codex/` folders,
not the runtime home — but note that individual phase agent files still
read some shared conventions from `~/.claude/skills/_shared/...` /
`~/.codex/skills/_shared/...` (your home directory), so this repo isn't
fully self-contained: it depends on `gentle-ai` being installed on
whatever machine runs it, with a compatible global config.
