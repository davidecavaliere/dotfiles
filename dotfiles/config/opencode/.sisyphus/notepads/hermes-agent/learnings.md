# Hermes Agent Plan — Learnings

Append-only notes about patterns, conventions, and successful approaches.

## Task 2: Appended Hermes Section to AGENTS.md

- Successfully appended comprehensive Hermes — Git Workflow Agent section to AGENTS.md (line 47-82)
- Key guardrails documented:
  - `--force-with-lease` explicitly required (never bare `--force`)
  - No `--no-verify` unless explicitly requested
  - Always run `git status` and `git log --oneline -n 5` before destructive ops
  - No hard resets on shared history
  - No rebasing on main/master
  - **Staging override documented:** Hermes MAY stage new files during batch git operations (exception to global "never stage" rule)
- References Commit Guidelines section to avoid duplication
- Original lines 1-46 preserved (pure append at EOF)
- Verification: 1 occurrence each of "Hermes MAY stage new files" and "force-with-lease" ✅

## Task 1: JSON Config Insert
- **Key gotcha**: Atlas had no trailing comma; adding hermes required comma after atlas entry and before closing brace.
- **Final hermes object**: `{ "model": "github-copilot/claude-haiku-4.5", "skills": ["git-master"] }` — minimal config with only required model and skills fields.
- **Validation**: Both QA assertions passed (JSON valid + all 11 agents present including hermes).
