---
id: integrations-data-providers
title: Integrations: Data Providers
scope: skills-mbb
tags: [#integrations, #data-providers, #coingecko, #yahoo, #file-protocol, #fallback]
priority: high
created_at: 2026-01-25
updated_at: 2026-02-12
---

# Integrations: Data Providers

> **Context**: Unified interface for market data ingestion.
> **SSOT**: `core/config/data-providers-config.js`

## 1. Architecture
- **Abstract Base**: `BaseDataProvider` defines the contract (`getTopCoins`, `searchCoins`).
- **Implementations**: `CoinGeckoProvider`, `YahooProvider` (future).
- **Manager**: `DataProviderManager` handles provider switching and API key injection.

## 2. Key Rules
1.  **Normalization**: All provider responses MUST be normalized to the MBB internal schema via `normalizeCoinData()`.
2.  **No Direct Calls**: UI components must use `dataProviderManager.getTopCoins()`, never fetch from the provider directly.
3.  **Proxying**: `buildUrl()` method automatically routes requests through Cloudflare Worker when on `file://`.

## 3. Workflow
1.  **Add**: Create `core/api/data-providers/{name}-provider.js`.
2.  **Register**: Add to `data-provider-manager.js`.
3.  **Config**: Define limits and URLs in `data-providers-config.js`.

## 4. File Map
- `@core/api/data-provider-manager.js`: The Switcher.
- `@core/api/data-providers/base-provider.js`: The Interface.
- `@core/api/data-providers/coingecko-provider.js`: The Implementation.

## 5. file:// Top-N Runbook (CoinGecko)
Use this recipe when loading large default sets (for example, Top-250 by market cap or volume) on `file://`.

1. **Chunk large requests**  
   - For large `count`, split into pages (safe baseline: `50` per chunk).
   - Keep one provider entrypoint (`getTopCoins`) and fetch chunks internally.

2. **Show progressive UX**  
   - Pass `onProgress` from UI to provider (`start` -> `chunk` -> `retry` -> `done`).
   - Render percent + status text in the modal while chunks are loading.

3. **Respect 429 semantics**  
   - Parse `Retry-After` header first.
   - If missing, use bounded exponential backoff and a small inter-chunk delay.
   - Propagate HTTP status from provider error (`error.status`) so manager/registry can react correctly.

4. **Fallback chain**  
   - Primary: live CoinGecko via proxy.
   - Secondary: local infra cache (continue-wrapper) when available.
   - Last resort: stale cache in browser (stale-while-revalidate behavior).

5. **Cache policy guard**  
   - Do not hard-delete cache before refresh attempts.
   - Keep stale data readable when live refresh fails.

## 6. Merge Rule for Multiple Coin Sets
When user loads one default set and then merges another:

1. **Union the actual coins**  
   - `this.coins` is the source of truth for loaded objects.
   - `activeCoinSetIds` must be rebuilt from `this.coins.map(c => c.id)` after merge.

2. **Never overwrite active IDs by last set only**  
   - Anti-pattern: assign `activeCoinSetIds = coinIdsFromLastLoad`.
   - Symptom: success toast says merged count, table counter stays at previous value.

3. **Avoid redundant refetching**  
   - Prefer `coinSet.coins` already returned by loader.
   - Call `loadCoinsByIds` only for truly missing IDs.

## 7. Regression Checklist
- After first load (Top-250): `coins == activeCoinSetIds == totalCoinsCount`.
- After merge with another Top-250 set: all counters reflect union size.
- `missingLen`/unresolved coins are `0` for the happy path.
- Progress bar and fallback states remain visible during long loads.

## 8. Code Anchor Policy
When this skill is updated, place or refresh inline code anchors in risk branches (retry/fallback/merge), not only in file headers.
See: `a/skills/mbb/skills/process/process-skill-code-loop-anchors.md`
