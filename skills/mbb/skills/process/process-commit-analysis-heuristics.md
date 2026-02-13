---
id: process-commit-analysis-heuristics
title: Process: Commit Analysis Heuristics
scope: skills-mbb
tags: [#process, #heuristics, #git, #filtering]
priority: medium
created_at: 2026-02-01
updated_at: 2026-02-01
---

# Process: Commit Analysis Heuristics (V2)

> **Context**: Rules for determining if a commit is worth analyzing for skill extraction.
> **SSOT**: `n8n/workflows/V2_SOURCES_MANAGER.json` (Discovery Logic)

## 1. Worthiness Decision Tree (V2)

The decision tree is implemented within n8n nodes or delegated LLM passes.

```
Commit / Release
  │
  ├─ Lines > 1500? ──────────────────► REJECT (too_large)
  │
  ├─ Files > 15? ────────────────────► REJECT (too_many_files)
  │
  ├─ All files are .md or docs/? ────► REJECT (docs_only)
  │
  ├─ Has keyword in subject? ────────► ACCEPT (keyword_match)
  │   (implement, integrate, refactor, fix, add, create, auth, api, cache)
  │
  └─ Otherwise ──────────────────────► ACCEPT if Swarm analysis confirms value
```

## 2. Noise Patterns (Always Filtered)

These files are excluded from analysis:
- `package-lock.json` — Generated dependency tree
- `node_modules/` — External code
- `*.sqlite`, `*.sqlite-*` — Binary databases
- `*.min.js`, `*.min.css` — Minified assets
- `workflows_export.json` — n8n backup dumps

## 3. Tuning Parameters (V2)

Heuristics are now controlled via the Swarm prompt or n8n global constants.

## 4. File Map (V2)

- `n8n/workflows/V2_SOURCES_MANAGER.json`: Entry filter
- `n8n/workflows/V2_NEWS_Swarm.json`: Final value judgement
- `@events/V2_RELEASE_REGISTRY.json`: Tracks scanned versions/commits
