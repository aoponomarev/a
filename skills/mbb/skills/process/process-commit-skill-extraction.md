---
id: process-commit-skill-extraction
title: Process: Commit Skill Extraction Protocol
scope: skills-mbb
tags: [#process, #extraction, #llm, #commits]
priority: high
created_at: 2026-02-01
updated_at: 2026-02-01
---

# Process: Commit/Release Skill Extraction Protocol (V2)

> **Context**: Structured protocol for extracting actionable skills from git commits and external technology releases.
> **SSOT**: `n8n/workflows/V2_NEWS_Swarm.json` (Swarm Prompt)

## 1. Extraction Filters (V2)

Analysis passes use context windows of ~1500 tokens. Multi-topic releases are decomposed into separate candidates if possible, or prioritized by the Commander agent.

## 2. Response Format (Strict JSON)

The Swarm must return exactly one JSON object:

```json
{
  "type": "skill|task|none",
  "title_ru": "Краткое название",
  "description_ru": "Описание ЧТО и КАК",
  "score": 0-100,
  "rationale_ru": "Обоснование полезности"
}
```

## 3. Quality Criteria

A valid candidate MUST be:
1. **Actionable** — Agent can follow concrete steps.
2. **Reusable** — Applies beyond this specific update.
3. **Focused** — One pattern or one implementation task.
4. **Traceable** — Linked to source and version.

## 4. File Map (V2)

- `n8n/workflows/V2_NEWS_Swarm.json`: Extraction Logic & Prompting
- `@events/SKILL_CANDIDATES.json`: Extraction results (JSON)
- `a/skills/mbb/drafts/tasks/*.md`: Extraction results (Markdown)
