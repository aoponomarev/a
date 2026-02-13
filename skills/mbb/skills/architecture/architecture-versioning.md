---
id: architecture-versioning
title: Architecture: App Versioning & Cache
scope: skills-mbb
tags: [#architecture, #versioning, #cache, #invalidation]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Architecture: App Versioning & Cache

> **Context**: Cache invalidation strategy based on application version.
> **SSOT**: `core/config/app-config.js`

## 1. Versioning Logic
**Goal**: Automatically invalidate stale data structures when code changes.

- **Mechanism**: `appVersionHash` (Git Commit Hash or Manual Version).
- **Scope**: CSS classes, Cache Keys.

## 2. Implementation
1.  **CSS**: Body class `app-version-{hash}` allows version-specific styling overrides.
2.  **Cache Keys**: Prefix `v:{hash}:` ensures isolation.
    - Example: `v:a1b2c3:market-metrics`

## 3. Cache Categorization

### Versioned (Auto-Clear)
*Dependent on code structure.*
- `icons-cache`
- `coins-list`
- `api-cache`
- `market-metrics`

### Permanent (User Data)
*Must survive updates.*
- `settings` (Theme, Timezone).
- `favorites`.
- `auth-token`.
- `portfolios` (Local Drafts).

## 4. API
- `appConfig.getVersionHash()`
- `cacheManager.getVersionedKey(key)`
- `cacheManager.clearOldVersions()`

## 5. Hard Constraints
1.  **Boot Cleanup**: App must scan and delete `v:{old_hash}:*` keys on startup to free space.
2.  **User Data Safety**: Never version keys containing user preferences or secrets.

## 6. File Map
- `@core/cache/cache-manager.js`: Logic.
- `@core/config/app-config.js`: Version definition.
