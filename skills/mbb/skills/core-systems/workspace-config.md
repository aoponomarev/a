---
id: workspace-config
title: Core Workspace Configuration
scope: skills-mbb
tags: [#core, #config, #workspace, #persistence]
priority: medium
created_at: 2026-01-25
updated_at: 2026-02-19
---

# Core: Workspace Configuration

> **Context**: Persistent workspace state — active model, active coins, table & metrics settings.
> **SSOT**: `core/config/workspace-config.js`

## 1. Scope
Manages **persistent user workspace state** that must survive across page reloads:
- `activeModelId` — current math model (e.g. `'Median/AIR/260101'`).
- `activeCoinSetIds` — array of active coin IDs displayed in the main table.
- `mainTable` — table presentation state: `selectedCoinIds`, `sortBy`, `sortOrder`, `coinSortType`, `showPriceColumn`.
- `metrics` — calculation parameters: `horizonDays`, `mdnHours`, `activeTabId`, `agrMethod`.

## 2. Storage Contract
- **Primary**: `cacheManager.get/set('workspaceConfig')` (IndexedDB via cache-manager).
- **Fallback**: `localStorage` key `'workspaceConfig'` — used when cacheManager is unavailable or fails (e.g. first load, IndexedDB quota exceeded).
- Both stores hold the same JSON structure; fallback is transparent to callers.

## 3. Key API
- `saveWorkspace(patch)` — merges partial update into current state, writes to both layers.
- `loadWorkspace()` — reads from cacheManager first, falls back to localStorage.
- `mergeWorkspace(partial)` — deep-merge utility for partial updates.
- `resolveDefaultModelId()` / `resolveDefaultParams()` — derive defaults from `modelsConfig`.

## 4. Key Rules
1. **Single Source**: All components MUST read workspace settings via `workspaceConfig` methods.
2. **Partial Updates**: Always use `saveWorkspace({ field: value })`, never replace the entire object.
3. **Fallback Resilience**: After saving to cacheManager, always write a parallel copy to localStorage.

## 5. File Map
- `@core/config/workspace-config.js`: The Source.
- `@core/config/models-config.js`: Default model resolution.
