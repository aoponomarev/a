---
id: cache-strategy
title: Cache: Architecture & Strategies
scope: skills-mbb
tags: [#cache, #architecture, #performance]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Cache: Architecture & Strategies

> **Context**: Unified caching engine providing abstraction over storage layers.
> **SSOT**: `core/cache/cache-manager.js`

## 1. Storage Layers
- **Hot** (localStorage): `theme`, `timezone`, `ui-state`, `icons-cache`.
- **Warm** (IndexedDB): `coins-list`, `market-metrics`, `api-cache`.
- **Cold** (IndexedDB): `time-series`, `history`, `portfolios`, `strategies`.

## 2. Caching Strategies
- **`cache-first`**: Use for static/slow-changing data (`icons-cache`, `coins-list`).
- **`network-first`**: Use for critical real-time data (`market-metrics`, `api-cache`).
- **`stale-while-revalidate`**: Use for background updates (`time-series`).
- **`cache-only`**: Use for local-first user data (`portfolios`, `settings`).

## 3. TTL Policy
- **Short (5m-1h)**: `api-cache`, `market-metrics`, `icons-cache`.
- **Long (24h+)**: `coins-list`, `history`, `news`.
- **Infinite**: User preferences, API keys, language.

## 4. Troubleshooting
- **Cache Miss on Every Load?**
  - Check if TTL expired.
  - Check if App Version changed (invalidates versioned keys).
  - Check if `localStorage` is full (>5MB).
- **Data Not Saving?**
  - Verify key is in `storage-layers.js`.
  - Check return value of `cacheManager.set()` (must be `true`).

## 5. File Map
- `@core/cache/cache-manager.js`: The Engine.
- `@core/cache/cache-config.js`: Configuration.
- `@core/cache/storage-layers.js`: Layer definitions.
