---
id: components-icon-manager
title: Components: Icon Manager
scope: skills-mbb
tags: [#components, #icons, #assets, #cdn]
priority: medium
created_at: 2026-01-25
updated_at: 2026-02-01
---

# Components: Icon Manager

> **Context**: Resolving coin URLs with caching and fallbacks.
> **SSOT**: `core/api/icon-manager.js`

## 1. Logic
1.  **Primary**: Local/Repo Assets (`libs/assets/coins/`).
2.  **Fallback**: External CDN (CoinGecko).
3.  **Alias**: Map weird symbols to known filenames (e.g. `WETH` -> `ETH`).

## 2. Versioning
URLs include `?v={appVersionHash}` to bust browser cache on update.

## 3. API
```javascript
// Get URL
const url = IconManager.getIconUrl('BTC');

// Preload (Optional)
IconManager.preload(['BTC', 'ETH']);
```

## 4. Hard Constraints
1.  **No 404s**: Component `coin-block.js` must handle load errors and show a generic placeholder.
2.  **Lowercase**: Files on disk are strictly lowercase (`btc.png`).

## 5. File Map
- `@core/api/icon-manager.js`: Resolution logic.
- `@libs/assets/coins/`: Icon storage.
