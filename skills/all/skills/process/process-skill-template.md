---
id: process-skill-template
title: Template: Skill Structure (KM v2.0)
scope: skills
tags: [#template, #structure, #standard, #km-v2]
version: 2.0.0
priority: high
shadow_index: "Standard layout for all Skills in the MBB Knowledge Management v2.0 system. Includes mandatory frontmatter for Graph-RAG and Intent Routing."
created_at: 2026-01-24
updated_at: 2026-02-15
---

# Template: Skill Structure (KM v2.0)

> **Context**: Standard layout for all Skills.
> **SSOT**: `KM_V2_PLAN.md`

## Structure

```markdown
---
id: skill-id-kebab-case
title: Human Readable Title
scope: skills (or skills-mbb)
tags: [#tag1, #tag2]
version: 1.0.0
priority: high|medium|low
shadow_index: "1-2 sentences optimized for vector search and agent intent detection."
relations: [related-skill-id-1, related-skill-id-2]
created_at: YYYY-MM-DD
updated_at: YYYY-MM-DD
---

# Human Readable Title

> **Context**: One-line summary.
> **SSOT**: Path to source code/config.

## 1. Scope / When to Use
- Triggers (e.g., Command `ОМК`, Error `429`).
- Boundaries (When NOT to use).

## 2. Key Rules / Principles
- Rule 1.
- Rule 2.

## 3. Workflow / Architecture
- Step 1.
- Step 2.

## 4. Hard Constraints
- What is forbidden.

## 5. File Map
- `@path/to/file`: Description.
- `// Skill anchor: <reason>`: Mention where anchors are located in code.
```

## Constraints
- **Granularity**: 1-4 screens max.
- **SSOT**: Link, don't duplicate.
- **Shadow Index**: MANDATORY for KM v2.0.
- **Anchors**: If the skill governs code, anchors MUST exist in the code.
