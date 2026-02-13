---
id: autonomous-skill-synthesis
title: Process: Autonomous Skill Synthesis
scope: skills-mbb
tags: [#process, #skills, #automation, #ai]
priority: high
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Process: Autonomous Skill Synthesis

> **Context**: How the system automatically transforms raw logs into structured knowledge.

## 1. The Pipeline (V2)
1.  **Watcher**: n8n `V2_SOURCES_MANAGER` scans external releases and Git for updates.
2.  **Swarm**: n8n `V2_NEWS_Swarm` (Commander agent) analyzes the content.
3.  **Synthesis**: LLM generates a candidate (JSON or MD) for the Dashboard.

## 2. Selection Heuristics
A change is "Skill-worthy" if it:
- Fixes a recurring architectural bug.
- Introduces a new integration pattern.
- Defines a new naming convention.
- Solves a complex environment issue (Docker/WSL).

## 3. Hard Constraints (V2)
1.  **Human Gate**: No skill is published without approval via the V2 Dashboard.
2.  **Context Limit**: Analysis passes use optimized context windows (~1500 tokens).

## 4. File Map (V2)
- `n8n/workflows/V2_SOURCES_MANAGER.json`: The Orchestrator.
- `n8n/workflows/V2_NEWS_Swarm.json`: The Analysis Engine.
