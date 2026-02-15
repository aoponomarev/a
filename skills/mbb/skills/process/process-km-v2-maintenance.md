---
id: process-km-v2-maintenance
title: Process: KM v2.0 Maintenance
scope: skills-mbb
tags: [#process, #km-v2, #maintenance, #indexer]
version: 1.0.0
priority: high
shadow_index: "Protocol for maintaining the Knowledge Management v2.0 system. Includes running the indexer and updating frontmatter."
relations: [process-skill-template, process-external-integration-closure]
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process: KM v2.0 Maintenance

> **Context**: Keeping the skills manifest and graph in sync with the codebase.
> **SSOT**: `scripts/mbb-index-gen.js`

## 1. Trigger Events
- **New Skill Created**: Run indexer immediately.
- **Skill Updated**: Update `updated_at` and `version`, then run indexer.
- **Integration Closure (`ФИН`)**: Indexer run is mandatory.
- **Session End**: Recommended to run indexer if skills were touched.

## 2. Maintenance Workflow

### Step 1: Frontmatter Audit
Ensure every new or modified skill has:
- `id` (kebab-case)
- `version` (semver)
- `priority` (high|medium|low)
- `shadow_index` (Search-optimized summary)
- `relations` (List of related skill IDs)

### Step 2: Run Indexer
```bash
node scripts/mbb-index-gen.js
```
Verify that `skills-manifest.json` and `docs/skills-graph.md` are updated.

### Step 3: Skill Anchors
If a skill governs specific code logic, ensure an anchor exists in the code:
```javascript
// Skill anchor: <reason/description>
```

## 3. Hard Constraints
- **No Manual Manifest Edits**: `skills-manifest.json` is strictly generated.
- **Shadow Index Quality**: Must be descriptive enough for vector search to distinguish it from similar skills.

## 5. File Map
- `@scripts/mbb-index-gen.js`: The indexer engine.
- `@skills-manifest.json`: The search index.
- `@docs/skills-graph.md`: Visual representation of knowledge.
