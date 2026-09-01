# Installation

Jarvis runs on the real gentle-ai SDD stack, installed with the `gentle-ai`
CLI — there is no bundle-specific installer script anymore.

```bash
gentle-ai install --scope workspace --agents claude-code,codex --components sdd,skills
```

`--scope workspace` places the agents, skills, commands, hooks, and MCP
wiring inside this repository's own `.claude/` and `.codex/` folders
instead of your home directory. Omit `--dry-run` once you're happy with
the plan it prints.

To bring an existing installation up to date after the `gentle-ai` CLI
itself is upgraded:

```bash
gentle-ai sync --agents claude-code,codex
```

Note: `gentle-ai sync` only ever touches your home-directory install
(`$HOME/.claude`, `$HOME/.codex`), never a workspace-scoped one. To update
a workspace install, re-run `gentle-ai install --scope workspace ...` —
it will not overwrite files that already exist, so delete the stale ones
first if you need a clean refresh (this is exactly how the Codex
`agents/` mismatch in this repo's history got fixed).

Restart Claude Code / Codex after installing or syncing so hooks and MCP
config get picked up.
