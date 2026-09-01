# Bundled skills

Skills are discovered natively from their `description` field — no
generated index needed.

Bundled here:

- `_shared` — not a skill; shared SDD workflow and delegation reference
  used by every agent in this bundle.
- `judgment-day` — blind dual-model review with one bounded fix round.

Not bundled, expected to come from the target environment instead:

- Language/framework-specific linting, formatting, or test-running skills —
  Jarvis delegates to whatever the project's own tooling is; it doesn't
  ship its own.
- Document-format skills (`docx`, `pdf`, `pptx`, `xlsx`) — use whatever the
  target environment already provides; Jarvis is code-focused.
