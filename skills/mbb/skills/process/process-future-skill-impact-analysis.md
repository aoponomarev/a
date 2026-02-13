---
id: process-future-skill-impact-analysis
title: Process: Skill Impact Analysis
scope: skills-mbb
tags: [#process, #skills, #planning, #impact]
priority: medium
created_at: 2026-01-30
updated_at: 2026-02-01
---

# Process: Skill Impact Analysis

> **Context**: Evaluating how a new feature or change affects the existing knowledge base.

## 1. Analysis Steps
1.  **Search**: Find all skills related to the target module.
2.  **Conflict Check**: Does the new change violate any "Hard Constraints" in those skills?
3.  **Update Requirement**: List which skills will need `action=update` after the code change.
4.  **New Skill**: Determine if the change introduces a new pattern worth capturing.

## 2. Decision Gate
If a change impacts >5 skills, it is considered a **Major Architectural Shift** and requires a dedicated `A_` document update.

## 3. Hard Constraints
1.  **No Orphan Rules**: Never implement a feature that contradicts a Skill without updating the Skill first.

## 4. File Map
- `@skills/index/`: For discovery.
