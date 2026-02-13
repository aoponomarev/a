---
id: process-batch-skills-review
title: Process: Batch Skills Review
scope: skills-mbb
tags: [#process, #skills, #maintenance, #quality]
priority: medium
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Process: Batch Skills Review (V2)

> **Context**: Periodic audit of the knowledge base to prevent rot and ensure V2 consistency.

## 1. Audit Steps
1.  **Dead Links**: Scan all `.md` files for broken relative paths or references to deleted scripts.
2.  **Redundancy**: Identify skills that cover similar topics and `MERGE` them.
3.  **Staleness**: Check `updated_at` dates. Skills older than 90 days need re-validation.
4.  **V2 Alignment**: Ensure no skills reference `skill-watcher.js` or `skill-processor.js`.

## 2. Workflow (V2)
- **Trigger**: Monthly or after major architectural shifts (like the V2 migration).
- **Action**: Use `propose_skill` to suggest updates or archive outdated docs.

## 3. Hard Constraints
1.  **No Orphans**: Every skill MUST be linked from at least one index.
2.  **Consistency**: All skills in a batch must follow the latest `process-skill-template.md`.

## 4. File Map
- `@a/skills/mbb/skills/index/index-mbb.md`: The Map.
- `global/LLM/infra-registry.json`: Source of truth for agent performance during review.
