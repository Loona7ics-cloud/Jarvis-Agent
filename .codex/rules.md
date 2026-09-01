# Governance boundaries

- This governance bundle lives only in `.claude/` (or `.codex/`). Never copy
  `CLAUDE.md`/`AGENTS.md`, agent role files, skills, or these rules into
  arbitrary files elsewhere in a project.
- Do not change managed governance files, agents, or skills without an
  explicit user request.
- Do not silently alter source code, specs, or committed artifacts.
- Never skip the SDD phase order (`sdd-workflow.md`) to save time on a
  substantial change — a shortcut here is how scope creeps and specs drift
  from implementation.
- Phase workers never autonomously repair a defect their own review found;
  they return evidence and wait for orchestrator/user authorization, except
  for `jd-fix-agent`'s single bounded correction pass, which is scoped and
  budgeted by design.
- Do not store secrets, credentials, tokens, passwords, API keys, private
  keys, or sensitive data in memory, logs, prompts, or artifacts.
