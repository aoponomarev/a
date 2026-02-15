---
id: process-external-integration-closure
title: "Process: External Integration Closure (ФИН 2.0)"
scope: skills-mbb
tags: [#process, #integration, #closure, #discovery, #ФИН]
---
version: 2.1.0
priority: high
shadow_index: "Advanced finalization protocol (ФИН). Includes Autonomous Web Discovery based on 'Sources' context and ROI-based filtering."
relations: [process-settings-sync, architecture-ssot, process-km-v2-maintenance]
updated_at: 2026-02-15
---

# Process: External Integration Closure (ФИН 2.0)

> **Goal**: Finalize tasks while identifying high-value growth opportunities (F-I-N-S) using autonomous web intelligence, strictly filtered by ROI and architectural fit.

## 1. Trigger & Thresholds

Command `ФИН` initiates a two-phase process: **Closure** (mandatory) and **Discovery** (conditional).

| Level | Type | Scope | Discovery Depth |
| :--- | :--- | :--- | :--- |
| **L1** | Routine | Bugfixes, minor edits | **Disabled** (Closure only) |
| **L2** | Module | New scripts, local logic | **Local** (Settings/Skills only) |
| **L3** | System | New "Sources", MCP, APIs | **Full + Web Intelligence** |

## 2. Phase 1: Standard Closure (Mandatory)

1.  **Sync**: Add new config/state paths to `settings-sync-mbb.ps1`.
2.  **Docs**: Update `docs/project-evolution.txt` and `docs/A_INFRASTRUCTURE.md`.
3.  **Indexing**: Run `node scripts/mbb-index-gen.js` (optionally with `--use-obsidian`).
4.  **Secrets**: Sync new `.env` keys to `.env.example` and vault.
5.  **Anchors**: Add `// Skill anchor:` in code pointing to relevant skills.

## 3. Phase 2: Intelligent Discovery (Ф-И-Н-С)

Only for **L2/L3** tasks. For **L3**, the agent MUST perform **Autonomous Web Discovery**.

### 3.1. Web Intelligence (L3 Only)
The agent must use `web_search` to find best practices and "hidden gems" for the specific source, using the following space:
- **Context**: MBB Architecture (Docker, n8n, Node.js, MCP, Obsidian).
- **Search Patterns**:
    - `"[Source Name] integration best practices for automation"`
    - `"[Source Name] performance hacks for Node.js/Docker"`
    - `"[Source Name] hidden features for developers 2026"`
    - `"[Source Name] MCP server implementation patterns"`

### 3.2. F-I-N-S Analysis

#### [Ф] Фичи (Features)
- Search for "game-changer" features enabled by this integration.
- **Constraint**: Must simplify the current architecture or eliminate manual steps.

#### [И] Интеграции (Integrations)
- Identify connectivity opportunities for performance or reliability.
- **Constraint**: **Zero-Cost Policy**. Only free, reliable, and community-standard solutions.

#### [Н] Настройки (Settings)
- Find "must-have" settings or performance tweaks discovered via web intelligence.
- **Constraint**: Must have a clear data circulation path.

#### [С] Навыки (Skills)
- Propose "Glue Skills" that bind the new block into the MBB ecosystem.

## 4. ROI Filter (Utility vs. Cost)

Before proposing any discovery item, the agent MUST verify:
1.  **Necessity**: Does data actually need to circulate through this new path?
2.  **Maintenance**: Will the gain exceed the cost of future audits? (ROI > 1.5x).
3.  **Stability**: Avoid "fragile" or unmaintained dependencies.

**Rule**: If ROI < 1.5x (estimated), the item is discarded.

## 5. Discovery Report Format

If Discovery is active, append to the final report:
```
### ФИН Discovery (Level: L3)
- [Web Intelligence]: <Summary of search findings>
- [Ф] Feature: <Description> | ROI: <High/Med>
- [И] Integration: <Description> | ROI: <High/Med>
- [Н] Setting: <Description> | ROI: <High/Med>
- [С] Skill: <Propose ID>
```
---
*MBB KM v2.0 | Principle: Reliability & Evolution*
