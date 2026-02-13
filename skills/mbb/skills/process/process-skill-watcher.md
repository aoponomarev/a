---
id: process-skill-watcher
title: Process: Skill Watcher (Git)
scope: skills-mbb
tags: [#process, #automation, #git, #discovery]
priority: medium
created_at: 2026-01-31
updated_at: 2026-02-02
---

# Process: Skill Watcher (V2 / n8n)

> **Context**: Analyzing external updates and internal commits to discover hidden knowledge.
> **SSOT**: `n8n/workflows/V2_SOURCES_MANAGER.json`

## 1. Architecture (V2)

```
Check Updates ──► V2_SOURCES_MANAGER ──► V2_NEWS_Swarm ──► SKILL_CANDIDATES.json
(manual/timer)          (n8n)                (n8n)
```

## 2. Pipeline Stages (V2)

| Stage | Input | Output | Skill Reference |
|-------|-------|--------|-----------------|
| 1. Scan | Release/Git | Release Notes/Diff | — |
| 2. Filter | Content | Worthy/None | `process-commit-analysis-heuristics` |
| 3. Extract | Text | Structured JSON | `process-commit-skill-extraction` |
| 4. Validate | JSON | Valid skill/task | `process-skill-quality-validation` |
| 5. Store | MD/JSON | File/Registry | — |

## 3. Legacy (Removed)
The standalone script `scripts/skill-watcher.js` has been decommissioned. All discovery logic is now centralized in n8n for better observability and agentic control.

## 4. Hard Constraints (V2)

1. **Size Limits**: MAX 1500 tokens for analysis pass.
2. **Registry**: `V2_RELEASE_REGISTRY.json` tracks processed versions.
3. **Structured Output**: Swarm must return strictly defined JSON schema.
4. **Reputation**: Agents are scored based on the usefulness of their findings.

## 5. Related Skills

- `process-commit-analysis-heuristics` — Worthiness rules
- `process-commit-skill-extraction` — LLM Prompting
- `process-skill-quality-validation` — Output Gate
- `process-wf-ui-v2-standards` — Dashboard interaction

## 6. File Map (V2)

- `n8n/workflows/V2_SOURCES_MANAGER.json`: Discovery Orchestrator
- `n8n/workflows/V2_NEWS_Swarm.json`: Analysis Engine
- `@events/SKILL_CANDIDATES.json`: Output queue
- `OneDrive/AI/Global/n8n/processed_registry.json`: State tracking (globalized)
- `OneDrive/AI/Global/LLM/infra-registry.json`: Agent reputations (SSOT)
