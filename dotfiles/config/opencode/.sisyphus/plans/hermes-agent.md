# Add Hermes — Git Workflow Agent

## TL;DR

> **Quick Summary**: Add a new "hermes" agent to oh-my-opencode for handling full git workflow operations (commit, rebase, squash, cherry-pick, branch management) with safety guardrails.
> 
> **Deliverables**:
> - Updated `oh-my-opencode.json` with hermes agent entry
> - Updated `AGENTS.md` with hermes-specific guidelines and safety rules
> 
> **Estimated Effort**: Quick
> **Parallel Execution**: YES — 2 waves (2 parallel tasks + 1 verification)
> **Critical Path**: Task 1 + Task 2 (parallel) → Task 3 (verification)

---

## Context

### Original Request
User wants to add a dedicated agent for git operations — committing, rebasing, squashing, cherry-picking, and branch management.

### Interview Summary
**Key Discussions**:
- **Name**: "hermes" — fits Greek mythology convention (messenger god → delivers code to repos)
- **Model**: `github-copilot/claude-haiku-4.5` — fast, lightweight; git ops don't need heavy reasoning
- **Scope**: Full git workflow — not just commits, also rebase, squash, cherry-pick, branch management
- **Skill**: Load `git-master` skill for specialized git knowledge (atomic commits, rebase, history search)
- **Safety**: Guardrails against destructive operations (force push, hard reset, rebase on shared branches)
- **Commit style**: Follow existing AGENTS.md conventions (conventional commits + emojis)

### Metis Review
**Identified Gaps** (addressed):
- **"Never stage new files" conflict**: AGENTS.md line 19 says "Never stage new files." Hermes needs to stage files. Resolution: hermes section explicitly clarifies hermes CAN stage files as part of its git workflow
- **Schema validation**: `hephaestus` and `atlas` already work without being in the schema's explicit properties — `hermes` will too
- **skills field in config**: No existing agents use `skills` in JSON config. Including it anyway; if it doesn't auto-load at runtime, the AGENTS.md section documents it as a dispatch-time requirement
- **Tool/permission restrictions**: Decided against adding tool restrictions or bash scoping — git-master skill already handles safety; over-restricting may break legitimate rebase conflict resolution

---

## Work Objectives

### Core Objective
Add a hermes agent entry to the oh-my-opencode configuration and document its behavior, scope, and safety guardrails in AGENTS.md.

### Concrete Deliverables
- `oh-my-opencode.json` — new `hermes` entry in `agents` object
- `AGENTS.md` — new `## Hermes` section with full git workflow guidelines

### Definition of Done
- [x] `oh-my-opencode.json` is valid JSON with hermes entry using `github-copilot/claude-haiku-4.5`
- [x] All 11 agents present in config (10 existing + hermes)
- [x] `AGENTS.md` contains hermes section with safety guardrails
- [x] Existing config and guidelines unchanged

### Must Have
- Hermes agent with model `github-copilot/claude-haiku-4.5`
- Git-master skill reference
- Safety guardrails (no force push, no hard reset shared branches, no rebase main/master)
- Conventional commit + emoji style (following existing AGENTS.md conventions)
- Clarification that hermes CAN stage files (overriding generic rule)

### Must NOT Have (Guardrails)
- DO NOT modify existing agent entries in `oh-my-opencode.json`
- DO NOT modify the existing "Commit Guidelines" section of `AGENTS.md` — hermes section is additive
- DO NOT add tool restrictions (`write: false`, `edit: false`) — keep config minimal
- DO NOT add `prompt_append` or custom system prompts — all rules go in AGENTS.md
- DO NOT add permissions scoping — rely on git-master skill's built-in safety

---

## Verification Strategy (MANDATORY)

> **ZERO HUMAN INTERVENTION** — ALL verification is agent-executed. No exceptions.

### Test Decision
- **Infrastructure exists**: N/A (config files, not code)
- **Automated tests**: None (JSON + Markdown edits)
- **Framework**: None

### QA Policy
Every task includes agent-executed QA scenarios. Evidence saved to `.sisyphus/evidence/task-{N}-{scenario-slug}.{ext}`.
- **Config validation**: Use Bash (python3/jq) to parse and assert JSON structure
- **Content verification**: Use Bash (grep) to verify AGENTS.md content

---

## Execution Strategy

### Parallel Execution Waves

```
Wave 1 (Start Immediately — both tasks are independent):
├── Task 1: Add hermes entry to oh-my-opencode.json [quick]
└── Task 2: Add hermes section to AGENTS.md [quick]

Wave 2 (After Wave 1 — verification):
└── Task 3: Verify config validity and no regressions [quick]

Wave FINAL (After ALL tasks):
└── Task F1: Scope fidelity check [quick]

Critical Path: Task 1 + Task 2 (parallel) → Task 3 → F1
Parallel Speedup: ~50% faster than sequential
Max Concurrent: 2 (Wave 1)
```

### Dependency Matrix

| Task | Depends On | Blocks |
|------|-----------|--------|
| 1    | —         | 3      |
| 2    | —         | 3      |
| 3    | 1, 2      | F1     |
| F1   | 3         | —      |

### Agent Dispatch Summary

- **Wave 1**: 2 tasks — T1 → `quick`, T2 → `quick`
- **Wave 2**: 1 task — T3 → `quick`
- **FINAL**: 1 task — F1 → `quick`

---

## TODOs

 - [x] 1. Add hermes agent entry to oh-my-opencode.json

  **What to do**:
  - Open `/home/dcavaliere/.config/opencode/oh-my-opencode.json`
  - Add a `"hermes"` entry inside the `"agents"` object, after the `"atlas"` entry (line 39)
  - Set `"model": "github-copilot/claude-haiku-4.5"`
  - Set `"skills": ["git-master"]`
  - Ensure the JSON remains valid (proper comma placement after atlas entry)

  **Must NOT do**:
  - Do NOT modify any existing agent entries
  - Do NOT change categories section
  - Do NOT add `tools`, `permission`, `prompt`, or `prompt_append` fields

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Simple JSON edit — add one object property with two fields
  - **Skills**: []
    - No specialized skills needed for a JSON edit

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1 (with Task 2)
  - **Blocks**: Task 3
  - **Blocked By**: None (can start immediately)

  **References**:

  **Pattern References** (existing code to follow):
  - `/home/dcavaliere/.config/opencode/oh-my-opencode.json:3-39` — Existing agents object structure. Follow the exact pattern: `"name": { "model": "...", ... }`. Note the atlas entry on line 38-39 — add hermes after it with a comma after atlas's closing brace.

  **External References**:
  - Schema: `https://raw.githubusercontent.com/code-yeongyu/oh-my-opencode/master/assets/oh-my-opencode.schema.json` — Reference for valid agent fields (model, variant, skills, etc.)

  **WHY Each Reference Matters**:
  - The oh-my-opencode.json file is the single config file. The exact JSON structure matters — wrong comma placement or nesting breaks everything.
  - The schema confirms `skills` is a valid array field on agent entries.

  **Acceptance Criteria**:

  **QA Scenarios (MANDATORY):**

  ```
  Scenario: JSON is valid and hermes entry exists with correct model
    Tool: Bash (python3)
    Preconditions: oh-my-opencode.json exists at /home/dcavaliere/.config/opencode/
    Steps:
      1. Run: python3 -c "import json; c=json.load(open('/home/dcavaliere/.config/opencode/oh-my-opencode.json')); h=c['agents']['hermes']; assert h['model']=='github-copilot/claude-haiku-4.5', f'Wrong model: {h[\"model\"]}'; assert 'git-master' in h.get('skills',[]), 'Missing git-master skill'; print('PASS: hermes configured correctly')"
      2. Assert: Output contains "PASS: hermes configured correctly"
    Expected Result: Script exits 0, prints PASS message
    Failure Indicators: AssertionError, KeyError, json.JSONDecodeError
    Evidence: .sisyphus/evidence/task-1-hermes-json-valid.txt

  Scenario: All existing agents preserved (no regressions)
    Tool: Bash (python3)
    Preconditions: Same file
    Steps:
      1. Run: python3 -c "import json; c=json.load(open('/home/dcavaliere/.config/opencode/oh-my-opencode.json')); expected=['sisyphus','hephaestus','oracle','librarian','explore','multimodal-looker','prometheus','metis','momus','atlas','hermes']; missing=[a for a in expected if a not in c['agents']]; assert not missing, f'Missing: {missing}'; print(f'PASS: all {len(expected)} agents present')"
      2. Assert: Output contains "PASS: all 11 agents present"
    Expected Result: All 11 agents found in config
    Failure Indicators: AssertionError listing missing agent names
    Evidence: .sisyphus/evidence/task-1-all-agents-present.txt
  ```

  **Commit**: YES
  - Message: `feat(opencode): add hermes git workflow agent ✨`
  - Files: `oh-my-opencode.json`
  - Pre-commit: `python3 -c "import json; json.load(open('/home/dcavaliere/.config/opencode/oh-my-opencode.json'))"`

 - [x] 2. Add hermes section to AGENTS.md

  **What to do**:
  - Open `/home/dcavaliere/.config/opencode/AGENTS.md`
  - Append a new `## Hermes — Git Workflow Agent` section at the end of the file
  - Include the following subsections:
    - **Purpose**: Full git workflow agent — committing, rebasing, squashing, cherry-picking, branch management
    - **Skill**: Always loads `git-master` skill
    - **Scope boundaries**:
      - ✅ CAN: stage files, commit, rebase, squash, cherry-pick, branch create/switch/delete, merge, resolve git-level conflicts, blame, bisect, log analysis
      - ❌ CANNOT: modify source code files, run tests/builds, create PRs/changelogs, write documentation
    - **Safety Guardrails**:
      - NEVER `git push --force` — always use `--force-with-lease`
      - NEVER `git reset --hard` on shared branches without explicit user confirmation
      - NEVER rebase `main`/`master`
      - NEVER skip hooks (`--no-verify`) unless user explicitly requests
      - ALWAYS run `git status` before any destructive operation
      - ALWAYS check if branch has been pushed before rebasing
    - **Commit Style**: Follow the existing conventional commits + emoji conventions defined above in this file
    - **Staging Override**: Hermes MAY stage new files as part of its git workflow (overrides the generic "Never stage new files" guideline which applies to non-git-specialist agents)

  **Must NOT do**:
  - Do NOT modify the existing "Code Implementation Guidelines" section (lines 1-8)
  - Do NOT modify the existing "Commit Guidelines" section (lines 10-45)
  - Do NOT remove any existing content — this is purely additive

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Appending a markdown section to an existing file — straightforward writing task
  - **Skills**: []
    - No specialized skills needed for markdown editing

  **Parallelization**:
  - **Can Run In Parallel**: YES
  - **Parallel Group**: Wave 1 (with Task 1)
  - **Blocks**: Task 3
  - **Blocked By**: None (can start immediately)

  **References**:

  **Pattern References** (existing content to follow):
  - `/home/dcavaliere/.config/opencode/AGENTS.md:1-46` — Full existing file. Hermes section goes AFTER line 46 (end of file). Follow the heading style (`##`) used by existing sections.
  - `/home/dcavaliere/.config/opencode/AGENTS.md:10-45` — Existing commit guidelines. Hermes section should REFERENCE these conventions, not duplicate them.

  **WHY Each Reference Matters**:
  - The existing AGENTS.md structure shows the heading level and formatting style to match.
  - The commit guidelines are what hermes should follow — reference them instead of restating.

  **Acceptance Criteria**:

  **QA Scenarios (MANDATORY):**

  ```
  Scenario: AGENTS.md contains hermes section with required content
    Tool: Bash (grep)
    Preconditions: AGENTS.md exists at /home/dcavaliere/.config/opencode/
    Steps:
      1. Run: grep -c "## Hermes" /home/dcavaliere/.config/opencode/AGENTS.md
      2. Assert: Output is "1" (exactly one hermes section)
      3. Run: grep -c "force-with-lease" /home/dcavaliere/.config/opencode/AGENTS.md
      4. Assert: Output is >= "1" (safety guardrail present)
      5. Run: grep -c "git-master" /home/dcavaliere/.config/opencode/AGENTS.md
      6. Assert: Output is >= "1" (skill reference present)
      7. Run: grep -c "MAY stage" /home/dcavaliere/.config/opencode/AGENTS.md
      8. Assert: Output is >= "1" (staging override documented)
    Expected Result: All grep counts match expected values
    Failure Indicators: Count is 0 for any required content, or > 1 for hermes section heading
    Evidence: .sisyphus/evidence/task-2-agents-md-content.txt

  Scenario: Existing AGENTS.md content unchanged
    Tool: Bash
    Preconditions: AGENTS.md modified
    Steps:
      1. Run: head -46 /home/dcavaliere/.config/opencode/AGENTS.md | md5sum
      2. Compare against pre-modification hash (compute before editing)
      3. Assert: Hash matches — first 46 lines untouched
    Expected Result: First 46 lines identical to original
    Failure Indicators: Hash mismatch — existing content was modified
    Evidence: .sisyphus/evidence/task-2-no-regression.txt
  ```

  **Commit**: YES (group with Task 1)
  - Message: `feat(opencode): add hermes git workflow agent ✨`
  - Files: `AGENTS.md`
  - Pre-commit: `grep -c "## Hermes" /home/dcavaliere/.config/opencode/AGENTS.md`

 - [x] 3. Verify config validity and no regressions

  **What to do**:
  - Run all QA scenarios from Tasks 1 and 2 as a final sweep
  - Verify JSON validity of `oh-my-opencode.json`
  - Verify all 11 agents present
  - Verify hermes has correct model and skills
  - Verify AGENTS.md has hermes section with safety guardrails
  - Verify existing content in both files is untouched

  **Must NOT do**:
  - Do NOT modify any files — this is verification only

  **Recommended Agent Profile**:
  - **Category**: `quick`
    - Reason: Running validation commands only — no file modifications
  - **Skills**: []
    - No specialized skills needed

  **Parallelization**:
  - **Can Run In Parallel**: NO
  - **Parallel Group**: Wave 2 (sequential after Wave 1)
  - **Blocks**: F1
  - **Blocked By**: Tasks 1, 2

  **References**:

  **Pattern References**:
  - `/home/dcavaliere/.config/opencode/oh-my-opencode.json` — Verify hermes entry exists with correct fields
  - `/home/dcavaliere/.config/opencode/AGENTS.md` — Verify hermes section exists with required content

  **WHY Each Reference Matters**:
  - Both files are the deliverables. This task validates they were correctly modified.

  **Acceptance Criteria**:

  **QA Scenarios (MANDATORY):**

  ```
  Scenario: Full validation sweep
    Tool: Bash (python3 + grep)
    Preconditions: Tasks 1 and 2 completed
    Steps:
      1. Run: python3 -c "import json; c=json.load(open('/home/dcavaliere/.config/opencode/oh-my-opencode.json')); h=c['agents']['hermes']; assert h['model']=='github-copilot/claude-haiku-4.5'; assert 'git-master' in h.get('skills',[]); expected=['sisyphus','hephaestus','oracle','librarian','explore','multimodal-looker','prometheus','metis','momus','atlas','hermes']; missing=[a for a in expected if a not in c['agents']]; assert not missing; print('PASS: JSON config valid')"
      2. Assert: "PASS: JSON config valid"
      3. Run: grep -c "## Hermes" /home/dcavaliere/.config/opencode/AGENTS.md
      4. Assert: Output is "1"
      5. Run: grep -c "force-with-lease" /home/dcavaliere/.config/opencode/AGENTS.md
      6. Assert: Output >= "1"
    Expected Result: All checks pass
    Failure Indicators: Any assertion failure
    Evidence: .sisyphus/evidence/task-3-full-validation.txt
  ```

  **Commit**: NO (verification only)

---

## Final Verification Wave

 - [x] F1. **Scope Fidelity Check** — `quick`
  Read both modified files end-to-end. Verify: (a) hermes entry in JSON has ONLY `model` and `skills` fields — no extra fields like `tools`, `permission`, `prompt_append`, (b) AGENTS.md hermes section does NOT duplicate the existing commit guidelines — it references them, (c) existing content in both files is byte-for-byte unchanged, (d) no scope creep — nothing beyond what was specified was added.
  Output: `Files [2/2 compliant] | Scope [CLEAN/issues] | VERDICT: APPROVE/REJECT`

---

## Commit Strategy

- **Wave 1**: `feat(opencode): add hermes git workflow agent ✨` — `oh-my-opencode.json`, `AGENTS.md`

---

## Success Criteria

### Verification Commands
```bash
# JSON is valid
python3 -c "import json; json.load(open('/home/dcavaliere/.config/opencode/oh-my-opencode.json'))"
# Expected: exits 0, no output

# Hermes exists with correct config
python3 -c "import json; c=json.load(open('/home/dcavaliere/.config/opencode/oh-my-opencode.json')); print(c['agents']['hermes'])"
# Expected: {'model': 'github-copilot/claude-haiku-4.5', 'skills': ['git-master']}

# All agents present
python3 -c "import json; c=json.load(open('/home/dcavaliere/.config/opencode/oh-my-opencode.json')); print(f'{len(c[\"agents\"])} agents')"
# Expected: 11 agents

# Hermes section in AGENTS.md
grep "## Hermes" /home/dcavaliere/.config/opencode/AGENTS.md
# Expected: ## Hermes — Git Workflow Agent
```

### Final Checklist
 - [x] All "Must Have" present (hermes entry, git-master skill, safety guardrails, commit style, staging override)
 - [x] All "Must NOT Have" absent (no tool restrictions, no prompt_append, no modified existing content)
 - [x] JSON is valid
 - [x] All 11 agents present
