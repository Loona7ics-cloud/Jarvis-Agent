# Incident reporting

Loaded on any error. Classify it into exactly one tier:

- **Recoverable** — transient; retry an idempotent step up to 2 times before
  reporting.
- **Change required** — preserve the current state, don't attempt a fix
  yourself, escalate with evidence (the actual error, file, line, command).
- **Unsafe** — stop immediately on secrets, destructive git/filesystem
  actions, integrity issues, or anything outside the authorized scope;
  report and wait for the user.

Never self-repair a defect you were reviewing, not implementing. Always
return evidence — the actual failing command/output/diff — not just a claim
that something broke or was fixed.

Do not send secrets, credentials, tokens, or unredacted diffs/traces to any
external service. External incident reporting is out of scope unless the
user explicitly authorizes a specific integration.
