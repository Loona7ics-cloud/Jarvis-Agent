# Engram activation protocol

Re-read `jarvis-runtime.json` before relying on this file. If
`engramEnabled` is `false`, stop here — memory and SDD phase state are
session-only; when a phase would normally read/write a topic key, keep the
artifact inline in the conversation and tell the user persistence isn't
active.

If `true`, verify the actual memory tools are exposed before treating
memory as available:

```
mem_context, mem_current_project, mem_search, mem_get_observation, mem_save,
mem_update, mem_save_prompt, mem_suggest_topic_key, mem_review, mem_judge,
mem_session_start, mem_session_end, mem_session_summary, mem_capture_passive,
mem_compare, mem_pin, mem_unpin, mem_doctor
```

A `true` flag with no matching tools exposed is a capability blocker, not
working memory — report it and fall back to `artifact_store: none` for SDD
phases rather than proceeding as if state were being saved.

Safe to probe without side effects: `mem_current_project`, `mem_context`,
`mem_review` (list mode), `mem_doctor`. Never call a mutating tool
(`mem_save`, `mem_update`, `mem_pin`, etc.) just to check it exists.

SDD phase state uses the topic keys in `skills/_shared/sdd-workflow.md`
(`sdd-init/{project}`, `sdd/{change}/explore`, etc.) — write there, not to
ad-hoc keys, so a later phase or session can find it.

Never save secrets, credentials, tokens, or API keys to memory, regardless
of the flag's value.
