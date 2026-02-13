---
id: cache-versioning
title: Cache: Versioning & Invalidation
scope: skills-mbb
tags: [#cache, #versioning, #invalidation]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Cache: Versioning & Invalidation

> **Context**: Preventing stale data issues after application updates.
> **Mechanism**: Prefixing keys with `v:{hash}:`.

## 1. Versioned Keys (Auto-Invalidate)
*Data that depends on the current code schema or API parsing logic.*
- `icons-cache`
- `coins-list`
- `api-cache`
- `market-metrics`
- `crypto-news-state`

## 2. Permanent Keys (Never Invalidate)
*User-generated content and critical settings.*
- `settings`, `theme`, `timezone`, `favorites`, `ui-state`.
- API keys (`yandex-api-key`, etc.).
- `portfolios`, `strategies`.

## 3. Decision Rules
**Version it if:**
- Structure is parsed from external APIs.
- Old data format would cause JS errors.
- Data is easily refetchable.

**Do NOT version if:**
- It is user-created data (use `cache-migrations.js` instead).
- It is a persistent auth token.

## 4. Implementation
- `cacheManager.getVersionedKey(key)`: Wraps key with current version hash.
- `cacheManager.clearOldVersions()`: Scans storage and deletes keys with mismatched hashes.

## 5. File Map
- `@core/cache/cache-manager.js`: Invalidation logic.
- `@core/config/app-config.js`: Version hash source.
