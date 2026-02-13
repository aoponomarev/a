---
id: libs-metadata-generation
title: Libs: Metadata Generation
scope: skills-mbb
tags: [#libs, #metadata, #coins, #automation]
priority: medium
created_at: 2026-01-25
updated_at: 2026-02-01
---

# Libs: Metadata Generation

> **Context**: Creating the `coins.json` registry from CoinGecko.
> **SSOT**: `libs/assets/data/coins.json`

## 1. Process
1.  **Fetch**: `coins-metadata-generator.js` pulls coin list from CoinGecko.
2.  **Filter**: Selects top N coins + specific watchlist.
3.  **Map**: Associates symbols with icon URLs.
4.  **Save**: Writes to `coins.json`.

## 2. Loader Logic
`coins-metadata-loader.js` reads `coins.json` at runtime to hydrate the `IconManager`.

## 3. Hard Constraints
- **Validation**: Generated JSON must match the schema expected by `IconManager`.
- **No Stale Data**: Regeneration should happen periodically (via n8n or script).

## 4. File Map
- `@core/api/coins-metadata-generator.js`: The Generator.
- `@core/api/coins-metadata-loader.js`: The Consumer.
