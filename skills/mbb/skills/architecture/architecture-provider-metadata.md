---
id: architecture-provider-metadata
title: Architecture - Provider Metadata vs Domain Data
scope: skills-mbb
tags: [#architecture, #coingecko, #postgres, #domain]
priority: medium
created_at: 2026-02-14
updated_at: 2026-02-14
---

# Architecture: Provider Metadata vs Domain Data

> **Context**: Clear boundary between external API data and portfolio domain invariants.

## 1. Principle
**Provider-specific fields (e.g., `market_cap_rank`) are metadata, not domain data.**

They MUST NOT:
- Appear as top-level columns in domain tables (`asset_snapshots`, `portfolios`).
- Be used in allocation/rebalance math (`portfolio-engine.js`).
- Be displayed as if they are portfolio properties (no `#rank` in UI).

They MAY:
- Be stored in `extra_json JSONB` for analytics or future use.
- Be used transiently for sorting/display in market data views.
- Be passed through CoinGecko API responses without persistence.

## 2. CoinGecko Specifics
- `market_cap_rank`: rank by market cap. Volatile, provider-defined. Not a universal "rating".
- `/coins/markets` supports explicit `order` parameter (`market_cap_desc`, `volume_desc`, `id_asc`). Use this for deterministic sorting instead of relying on rank.
- `/search` results are pre-sorted by market cap. Tie-breaking should use `name` then `id`, not `market_cap_rank`.

## 3. Schema Pattern: JSONB Extensibility
Instead of adding a column for every provider field:
```sql
ALTER TABLE asset_snapshots ADD COLUMN IF NOT EXISTS extra_json JSONB DEFAULT '{}'::jsonb;
```
This allows storing arbitrary metadata without schema migrations:
```javascript
extra_json: { market_cap_rank: 5, market_cap_rank_with_rehypothecated: 4 }
```

## 4. Migration History
- **2026-02-14**: `rank INTEGER` column dropped from `asset_snapshots`. `extra_json JSONB` added.
- Migration script: `cloud/yandex/migrations/2026-02-14-drop-rank-add-extra-json.sql`.

## 5. File Map
- `@core/domain/portfolio-adapters.js`: Payload shaping (uses `extra_json`).
- `@core/config/portfolio-config.js`: Domain model (no `rank`).
- `@core/api/data-providers/coingecko-provider.js`: Search sorting (deterministic, no rank dependency).
- `@docs/A_PORTFOLIO_SYSTEM.md`: Asset Snapshot Contract Notes.
- `@docs/A_CORE_DATA_LOGIC.md`: Sorting Semantics section.
