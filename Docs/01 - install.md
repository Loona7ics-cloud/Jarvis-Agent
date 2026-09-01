# Installation

Run the installer only against a clean home for the chosen target(s). It
copies the bundle payload into `$HOME\.codex` (Codex), `$HOME\.claude`
(Claude Code), or both, and refuses to run if any bundle-managed path
already exists at the destination. It does not edit `config.toml` (Codex)
or `settings.json` (Claude Code), migrate an existing installation, or
delete files.

Choose the target with `-Target Codex|Claude|Both`. Omit `-Target` and the
installer prompts interactively with a `1) Codex`, `2) Claude`, `3) Both`
menu.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -Target Codex -WhatIf
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -Target Codex
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -Target Claude
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1 -Target Both
```

`-WhatIf` reports what would be copied without writing anything.

Before copying, the installer verifies the source bundle is complete (the
required top-level files for the chosen target) and that none of the
managed paths — `AGENTS.md`/`CLAUDE.md`, `rules.md`, `jarvis-runtime.json`,
`engram-instructions.md`, `incident-reporting.md`, `bundled-skills.md`,
`agents/`, `skills/` — already exist at the destination home. If any do, it
throws instead of overwriting, migrating, or pruning; move or back up the
existing home first, or install to a fresh one.

After installation, restart Codex and/or Claude Code so the runtime picks
up the new home contents. Wiring the runtime to actually load
`AGENTS.md`/`CLAUDE.md` on session start, and any hooks or MCP server
configuration (e.g. Engram), is configured separately — the installer only
places the files.
