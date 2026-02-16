---
id: process-external-integration-closure
title: "Process: External Integration Closure (ФИН 2.5)"
scope: skills-mbb
tags: [#process, #integration, #closure, #discovery, #ФИН]
---
version: 2.5.0
priority: high
shadow_index: "Consumer-oriented finalization protocol (ФИН). Ranked multi-variant F-I-N-S discovery with clear recommended selection and per-block argumentation."
relations: [process-settings-sync, architecture-ssot, process-km-v2-maintenance, process-project-evolution-aggregation]
updated_at: 2026-02-15
---

# Process: External Integration Closure (ФИН 2.5)

> **Goal**: Finalize tasks while identifying high-value growth opportunities (F-I-N-S) using ranked multi-variant analysis focused on delivering clear, persuasive utility to the user.

## 1. Trigger & Thresholds

Command `ФИН` initiates a two-phase process: **Closure** (mandatory) and **Discovery** (conditional).

| Level | Type | Scope | Discovery Depth |
| :--- | :--- | :--- | :--- |
| **L1** | Routine | Bugfixes, minor edits | **Disabled** (Closure only) |
| **L2** | Module | New scripts, local logic | **Local** (Settings/Skills only) |
| **L3** | System | New "Sources", MCP, APIs | **Full + Web Intelligence** |

## 2. Phase 1: Standard Closure (Mandatory)

1.  **Sync**: Add new config/state paths to `settings-sync-mbb.ps1`.
2.  **Docs**: Update `docs/project-evolution.txt` and `docs/A_INFRASTRUCTURE.md`; apply date-level aggregation so each date appears once in evolution log.
3.  **Indexing**: Run `node scripts/mbb-index-gen.js` (optionally with `--use-obsidian`).
4.  **Secrets**: Sync new `.env` keys to `.env.example` and vault.
5.  **Anchors**: Add `// Skill anchor:` in code pointing to relevant skills.

## 3. Phase 2: Multi-Variant Discovery (Ф-И-Н-С)

Only for **L2/L3** tasks. The goal is to provide a ranked spectrum of high-value options, ensuring no "hidden gems" are missed.

### 3.1. Web Intelligence (L3 Only)
Use `web_search` with MBB-specific patterns (Docker, n8n, MCP, Obsidian) to find best practices.

### 3.2. F-I-N-S Analysis & Ranking Rules
- **Ranking**: Order items by **significance/impact** (most important first).
- **Filtering**: Show only high-value items that pass the ROI filter (>1.5x).
- **Format**: Numbered list. Each item starts with the **Idea Name** in bold.
- **Persuasive Description**: Follow the idea name with 2-3 sentences that clearly explain the **benefit and utility** to the user in a consumer-oriented language. Remove explicit "Description:" or "ROI:" labels.
- **Recommended Selection (Mandatory for L2/L3)**: After main variants, provide one compact default selection that is safest for immediate implementation.
- **KAИ + Skills Recalibration (Mandatory for L2/L3)**: Apply this as internal filtering/ranking logic (not as a separate user choice block).
- **Argumentation Blocks (Mandatory for L2/L3)**: After each category selection (Ф/И/Н/С), provide a concise, clear, low-jargon verdict explaining why this exact subset is recommended.

#### [Ф] Фичи (Features)
Killer features or "game-changers" that simplify architecture or eliminate manual steps.

#### [И] Интеграции (Integrations)
Connectivity opportunities for performance or reliability. **Zero-Cost Policy** (Free/Open Source only).

#### [Н] Настройки (Settings)
Performance tweaks or "must-have" configurations with a clear data circulation path.

#### [С] Навыки (Skills)
"Glue Skills" binding the block into the MBB ecosystem.

## 4. ROI Filter & Selection Rules

1.  **Utility Filter**: Only show items where gain exceeds audit/support costs (ROI > 1.5x).
2.  **KAИ Coherence Filter**: Keep only variants compatible with active architecture constraints (paths, runtime model, MCP topology, env governance).
3.  **Skills-Array Filter**: Prefer variants that either (a) reuse existing high-priority skills, or (b) add clearly missing glue with explicit integration path.
4.  **No Opposing Choice Blocks**: Do not present KAИ/skills recalibration as an alternative selectable block.
5.  **User Selection Format**: User selects variants using the **Default Selection Format**:
    - Format: `[Category Letter][Variant Numbers]` (e.g., `И12` means Integrations 1 and 2 are selected).
    - Combined example: `И12, Н1, С2` or `И12 Н1 С2`.

## 5. Discovery Report Format (Consumer-Oriented)

```
### ФИН Discovery (Level: L3)
**[Web Intelligence]**: <Summary>
**[Ф] Features**:
1. **<Idea Name>**. <Persuasive utility description sentence 1>. <Persuasive utility description sentence 2>.
2. **<Idea Name>**. <Persuasive utility description sentence 1>. <Persuasive utility description sentence 2>.
**[И] Integrations**:
1. **<Idea Name>**. <Persuasive utility description sentence 1>. <Persuasive utility description sentence 2>.
**[Н] Settings**:
1. **<Idea Name>**. <Persuasive utility description sentence 1>. <Persuasive utility description sentence 2>.
**[С] Skills**:
1. **<Idea Name>**. <Persuasive utility description sentence 1>. <Persuasive utility description sentence 2>.
**[Рекомендуемый выбор]**:
- <Compact subset like Ф13 И12 Н12 С12>
**[Аргументация: Ф]**:
- <Clear verdict for chosen feature subset, no jargon overload>.
**[Аргументация: И]**:
- <Clear verdict for chosen integrations subset, no jargon overload>.
**[Аргументация: Н]**:
- <Clear verdict for chosen settings subset, no jargon overload>.
**[Аргументация: С]**:
- <Clear verdict for chosen skills subset, no jargon overload>.
```
---
*MBB KM v2.0 | Principle: Consumer-Oriented Value*
