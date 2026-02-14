---
id: integrations-cloudflare-core
title: Integrations: Cloudflare Core
scope: skills-mbb
tags: [#integrations, #cloudflare, #workers, #d1, #kv, #cache]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-14
---

# Integrations: Cloudflare Core

> **Context**: Edge infrastructure for API Proxy, Auth, and State.
> **SSOT**: `core/config/cloudflare-config.js`

## 1. Infrastructure Map
- **Workers**: `cloud/cloudflare/workers/src/` (The Logic).
- **D1 (SQL)**: `mbb-database` (Users, Portfolios).
- **KV (NoSQL)**: `API_CACHE` (Proxy caching).
- **Base URL**: `https://mbb-api.ponomarev-ux.workers.dev`.

## 2. Component Bindings
- **DB**: D1 Binding for relational data.
- **API_CACHE**: KV Binding for ephemeral API responses.
- **GOOGLE_CLIENT_SECRET**: Wrangler Secret (Auth).
- **JWT_SECRET**: Wrangler Secret (Session signing).

## 3. KV Cache Key Limit (CRITICAL)
Cloudflare KV has a **512-byte key length limit**. Long API URLs (e.g., `/coins/markets?ids=50+coins`) easily exceed this.
- **Solution**: `generateCacheKey()` in `api-proxy.js` hashes query strings via SHA-256 when key > 480 bytes.
- **Symptom**: `KV GET failed: 414 UTF-8 encoded length of N exceeds key length limit of 512`.
- **Key format**: Short keys stay readable (`api-cache:coingecko:/coins/markets?vs_currency=usd&ids=bitcoin`), long keys use hash (`api-cache:coingecko:/coins/markets?h=<sha256hex>`).

## 4. Deployment
```bash
cd cloud/cloudflare/workers
npx wrangler deploy
```
Auth: OAuth token linked to `ponomarev.ux@gmail.com`. Check with `npx wrangler whoami`.

## 5. File Map
- `@cloud/cloudflare/workers/wrangler.toml`: Config.
- `@cloud/cloudflare/workers/src/index.js`: Router.
- `@cloud/cloudflare/workers/src/api-proxy.js`: CoinGecko/Yahoo/Stooq proxy with KV caching.
- `@core/config/cloudflare-config.js`: Client-side endpoint registry.
