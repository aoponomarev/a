---
id: cache-keys
title: Cache: Key Management
scope: skills-mbb
tags: [#cache, #storage, #keys]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Cache: Key Management

> **Context**: Logic for adding and configuring cache keys.
> **SSOT**: `core/cache/storage-layers.js`

## 1. Storage Layer Selection
- **Hot** (`localStorage`): <100KB, frequent access, simple objects (e.g., `settings`).
- **Warm** (`IndexedDB`): 100KB–10MB, frequent access, structured data (e.g., `coins-list`).
- **Cold** (`IndexedDB`): >10MB, rare access, large blobs (e.g., `time-series`).

## 2. Decision Matrix
| Feature | Rule | Action |
| :--- | :--- | :--- |
| **Versioning** | Depends on App Version? | Add to `versionedKeys` in `cache-manager.js`. |
| **Persistence** | User Data? | No TTL, No Versioning. |
| **Freshness** | External API? | Define `TTL` in `cache-config.js`. |
| **Rate Limits** | CoinGecko/API? | Use **Preload Strategy** (fetch once, slice from cache). |

## 3. Implementation Workflow
1.  **Register Key**: Add to `LAYERS.{layer}.keys` in `storage-layers.js`.
2.  **Set TTL**: Define in `cache-config.js` -> `TTL`.
3.  **Set Strategy**: Define in `cache-config.js` -> `STRATEGIES` (e.g., `cache-first`).
4.  **Migration**: If schema changes, update `VERSIONS` and `cache-migrations.js`.

## 4. File Map
- `@core/cache/storage-layers.js`: Key registry.
- `@core/cache/cache-config.js`: TTL & Strategies.
