# Bundled skills

Skills are discovered natively from their `description` field — no
generated index needed. Everything below was installed by
`gentle-ai install --scope workspace --agents claude-code,codex --components sdd,skills`
and is kept current with `gentle-ai sync`.

## SDD lifecycle

`sdd-init`, `sdd-explore`, `sdd-propose`, `sdd-spec`, `sdd-design`,
`sdd-tasks`, `sdd-apply`, `sdd-verify`, `sdd-archive`, `sdd-onboard` — the
phase skills, plus `_shared` (not invokable) with the shared conventions
and orchestrator workflow every phase reads.

## Review

`judgment-day` — blind dual-model review with up to two bounded fix/
re-judgment rounds. `rdd-defect-workflow` — receipt-driven development
(review authority, lineage, corrections, the delivery kill switch).

## Dev workflow

`branch-pr`, `chained-pr`, `comment-writer`, `issue-creation`,
`work-unit-commits`, `systemic-issue-triage`, `cognitive-doc-design`,
`go-testing`, `gentle-ai-bench`.

## Meta

`skill-creator`, `skill-improver`, `skill-registry` — author, audit, and
index skills.

Not bundled, expected to come from the target environment instead:

- Language/framework-specific linting, formatting, or test-running skills
  beyond `go-testing` — delegate to whatever the project's own tooling is.
- Document-format skills (`docx`, `pdf`, `pptx`, `xlsx`) — use whatever the
  target environment already provides.
