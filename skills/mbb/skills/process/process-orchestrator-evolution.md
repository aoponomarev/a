---
id: process-orchestrator-evolution
title: Process: Orchestrator Evolution
scope: skills-mbb
tags: [#process, #orchestrator, #cursorrules, #meta]
priority: high
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Process: Orchestrator Evolution

> **Context**: Rules for maintaining and updating `.cursorrules`.

## 1. Role of `.cursorrules`
It is the **Router** and **Constitution**. It should NOT contain granular coding rules (those belong in Skills).

## 2. Evolution Workflow
1.  **Identify**: A new high-level protocol is established (e.g., a new command like `АИС`).
2.  **Update**: Add the command and its linked Skill to the "Command Interface" table in `.cursorrules`.
3.  **Clean**: Remove any legacy instructions that have been successfully migrated to Skills.

## 3. Hard Constraints
1.  **Brevity**: Keep `.cursorrules` under 150 lines.
2.  **Skill-First**: Every rule in `.cursorrules` must reference a supporting Skill file.

## 4. File Map
- `@.cursorrules`: The target file.
