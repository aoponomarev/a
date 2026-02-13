---
id: skill-based-playbooks
title: Architecture: Skills as Playbooks
scope: skills-mbb
tags: [#architecture, #agentic, #playbooks]
priority: medium
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Architecture: Skills as Playbooks

> **Context**: Philosophy of modular intelligence.
> **Analogy**: Skills are "Cartridges" loaded into the Agent.

## 1. Principles
1.  **File-Centric**: Knowledge lives in Markdown files, not vectors/DBs. Easy to edit/version.
2.  **Portability**: Skills are self-contained "How-To" guides.
3.  **Agent-Readable**: Structured metadata + Clear instructions.

## 2. Workflow
1.  **Load**: Agent searches and reads `skill-*.md`.
2.  **Act**: Agent follows the `Steps` section.
3.  **Verify**: Agent checks `Validation` criteria.

## 3. Structure
- **Scope**: What this is for.
- **When to Use**: Triggers.
- **Steps**: Imperative instructions.
- **Constraints**: What NOT to do.

## 4. File Map
- `@skills-mbb/skills/`: The Library.
