---
id: agentic-self-correction
title: Process: Agentic Self-Correction
scope: skills-mbb
tags: [#process, #agentic, #quality, #meta]
priority: high
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Process: Agentic Self-Correction

> **Context**: Protocol for Agents to identify and fix their own errors or outdated rules.

## 1. The Loop
1.  **Detect**: Agent encounters a rule that contradicts reality or causes a failure.
2.  **Propose**: Agent uses `propose_skill` with `action=update` to flag the discrepancy.
3.  **Halt**: If the error is critical, Agent stops and asks for clarification.

## 2. Triggers
- **Broken Links**: Relative paths that lead to 404s.
- **Stale Configs**: Rules referencing files that have been renamed or deleted.
- **Logic Gaps**: Missing edge cases in a documented workflow.

## 3. Hard Constraints
1.  **No Silent Fixes**: Do NOT edit a Skill file directly to fix a logic error without notifying the user.
2.  **V2 Protocol**: All corrections must be logged via the V2 Dashboard or proposed as new tasks in `drafts/tasks/`.

## 4. File Map (V2)
- `a/skills/mbb/drafts/tasks/`: The correction queue.
- `global/LLM/infra-registry.json`: Reputation tracking for self-correcting agents.
