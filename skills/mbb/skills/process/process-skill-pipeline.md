---
id: process-skill-pipeline
title: Process: Automated Skill Pipeline
scope: skills-mbb
tags: [#process, #skills, #automation, #llm]
priority: high
created_at: 2026-01-27
updated_at: 2026-02-01
---

# Process: Automated Skill Pipeline (V2)

> **Context**: Converting external/internal signals into Skill/Task candidates via n8n Swarm.
> **SSOT**: `n8n/workflows/V2_NEWS_Swarm.json`

## 1. Architecture (V2)
Signal (Commit/Release) -> `V2_SOURCES_MANAGER` -> `V2_NEWS_Swarm` -> Dashboard (confirm/reject)

## 2. Workflow (V2)
1.  **Trigger**: n8n detects a new release or significant commit.
2.  **Process**: Commander agent analyzes the content and assigns a Scout.
3.  **Generate**: LLM constructs a JSON candidate or Markdown task.
4.  **Save**: Data is stored in `SKILL_CANDIDATES.json` or `drafts/tasks/`.

## 3. Why n8n Swarm?
The standalone `skill-processor.js` was replaced by n8n to:
- Centralize all AI operations in one orchestrator.
- Implement agent reputation and feedback loops.
- Provide a visual audit trail of all AI decisions.

## 4. Hard Constraints (V2)
1.  **Traceability**: Every proposal must have `suggested_by` agent ID.
2.  **Language**: All user-facing text (Title, Description) must be in Russian.
3.  **Review**: Humans MUST confirm usefulness via Dashboard.

## 5. File Map (V2)
- `n8n/workflows/V2_NEWS_Swarm.json`: The Engine.
- `OneDrive/AI/Global/LLM/infra-registry.json`: Reputation & Agent SSOT.
- `a/skills/mbb/drafts/tasks/`: Markdown Output.
