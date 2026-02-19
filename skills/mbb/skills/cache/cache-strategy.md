---
id: cache-strategy
title: Cache Architecture and Strategies
scope: skills-mbb
tags: [#cache, #architecture, #performance]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-19
---

# Cache: Architecture & Strategies

> **Context**: Unified caching engine providing abstraction over storage layers.
> **SSOT**: `core/cache/cache-manager.js`

## 1. Storage Layers
- **Hot** (localStorage): `settings`, `favorites`, `ui-state`, `active-tab`, `theme`, `icons-cache`.
- **Warm** (localStorage-backed stub, `idb_warm_` prefix): `coins-list`, `market-metrics`, `api-cache`, `top-coins`, `top-coins-by-market-cap`, `top-coins-by-volume`, `vix-index`, `fear-greed-index`, `stablecoins-list`, `crypto-news-state`.
- **Cold** (localStorage-backed stub, `idb_cold_` prefix): `time-series`, `history`, `portfolios`, `strategies`, `correlations`.

> **Implementation note**: Warm and Cold layers use localStorage stubs with prefixed keys, not actual IndexedDB. This is a pragmatic choice for `file://` environments where IndexedDB reliability varies.

## 2. Caching Strategies
- **`cache-first`**: Use for static/slow-changing data (`icons-cache`, `coins-list`).
- **`network-first`**: Use for critical real-time data (`market-metrics`, `api-cache`).
- **`stale-while-revalidate`**: Use for background updates (`time-series`, `top-coins`).
- **`cache-only`**: Use for local-first user data (`portfolios`, `settings`).

## 3. TTL Policy
- **Short (5m-1h)**: `api-cache`, `market-metrics`, `icons-cache`.
- **Long (24h+)**: `coins-list`, `history`, `news`, `top-coins`.
- **Infinite**: User preferences, API keys, language.

## 4. App-Version Key System
- Keys are versioned: `v:{appVersionHash}:{key}`.
- `getVersionedKey()` generates versioned keys automatically.
- `clearOldVersions()` removes keys from previous app versions on startup.
- `cache-migrations.js` handles schema evolution across versions.

## 5. Troubleshooting
- **Cache Miss on Every Load?**
  - Check if TTL expired.
  - Check if App Version changed (invalidates versioned keys).
  - Check if `localStorage` is full (>5MB).
- **Data Not Saving?**
  - Verify key is in `storage-layers.js`.
  - Check return value of `cacheManager.set()` (must be `true`).

## 6. File Map
- `@core/cache/cache-manager.js`: The Engine.
- `@core/cache/cache-config.js`: Configuration (strategies, TTLs).
- `@core/cache/storage-layers.js`: Layer definitions (hot/warm/cold key assignments).
- `@core/cache/cache-migrations.js`: Schema evolution.
- `@core/cache/cache-cleanup.js`: Stale data cleanup.
- `@core/cache/cache-indexes.js`: Index management.
