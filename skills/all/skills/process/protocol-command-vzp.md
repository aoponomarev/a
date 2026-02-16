---
id: protocol-command-vzp
title: Protocol: Command ВЗП (Planned Execution)
scope: skills
tags: [#protocol, #command, #planning, #autonomy, #ВЗП]
---
version: 1.2.0
priority: high
shadow_index: "Default autonomous execution protocol (ВЗП). Enforces step-by-step planning, console verification, skill anchoring, and mandatory ФИН closure."
relations: [process-external-integration-closure, process-skill-code-loop-anchors, process-project-evolution-aggregation]
updated_at: 2026-02-15
---

# Protocol: Command `ВЗП` (Planned Execution)

> **Command**: `ВЗП` (Выполни Задание Планово).
> **Goal**: High-reliability autonomous task execution with zero technical debt.

## 1. Core Principles

1.  **Detailed Planning**: Create a comprehensive plan with checkboxes before any action.
2.  **Step-by-Step Console Verification**: **MANDATORY**. Run tests or syntax checks after *every* code change. Never assume code works.
3.  **Skill Anchoring**: Every new pattern or architectural decision must be documented in a skill and linked via `// Skill anchor:` in the code.
4.  **Mandatory ФИН**: Every `ВЗП` session MUST end with the `ФИН` (Finalization) protocol.
5.  **Autonomous Correction**: Fix errors independently using logs and diagnostics.

## 2. Execution Workflow

### Step 1: Planning
- Draft a multi-step plan addressing the request.
- Define verification commands for each step.

### Step 2: Iterative Execution
- **Execute**: Perform one atomic change.
- **Verify**: Run console commands (e.g., `node --check`, `npm test`, `curl`).
- **Anchor**: Add `// Skill anchor: <id>` to affected files.
- **Fix**: If verification fails, diagnose and fix before proceeding.

### Step 3: Finalization (ФИН)
After all steps are completed, execute the **ФИН 2.1** protocol:
1.  **Sync**: Update `settings-sync-mbb.ps1`.
2.  **Discovery**: Perform F-I-N-S analysis (for L2/L3 tasks).
3.  **Indexing**: Run `node scripts/mbb-index-gen.js --use-obsidian`.
4.  **Evolution**: Update `docs/project-evolution.txt` using single-date aggregation rules (no duplicate date records).

## 3. Hard Constraints

- **No Blind Edits**: Every edit must be followed by a verification tool call.
- **No Orphan Skills**: Skills without anchors in the code are considered incomplete.
- **No Unfinished Sessions**: `ВЗП` is not done until `ФИН` is executed.

---
*MBB KM v2.0 | Principle: Reliability First*
