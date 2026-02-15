---
id: process-skills-curation-intelligence
title: Process: Skills Curation Intelligence
scope: skills-mbb
tags: [#process, #curation, #meta, #refactoring]
priority: high
created_at: 2026-01-29
updated_at: 2026-02-01
---

# Process: Skills Curation Intelligence

> **Context**: Meta-protocol for deciding *how* to modify the knowledge base.
> **Goal**: Prevent duplication and rot.

## 1. The Algorithm
**Before creating a skill:**
1.  **Deep Search**: `list_skills(query)` with synonyms.
2.  **Decision Matrix**:
    - **Update**: Covers >60%? -> Edit existing.
    - **Synthesize**: Overlaps multiple? -> Merge into one.
    - **Decompose**: Too big (>150 lines)? -> Split.
    - **Create**: Unique? -> New file.

## 2. Coherence Check
- **Indices**: Update `index-mbb.md`.
- **Cross-Links**: Add `[See also: ...]` references.
- **Cleanup**: Delete obsolete files after synthesis.

## 3. Hard Constraints
1.  **Search First**: Never create without searching.
2.  **Reasoning**: Agent must state *why* it chose Update vs Create.
3.  **Size Limit**: Skills > 150 lines are candidates for decomposition.

## 4. File Map
- `@../a/skills/mbb/skills/index/index-mbb.md`: The Index.
