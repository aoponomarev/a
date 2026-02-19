---
id: integrations-cloudflare-core
title: Integrations Cloudflare Core
scope: skills-mbb
tags: [#integrations, #cloudflare, #workers, #d1, #kv, #cache, #settings]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-19
---

# Integrations: Cloudflare Core

> **Context**: Edge infrastructure for API Proxy, Auth, Settings, and State.
> **SSOT**: `core/config/cloudflare-config.js`

## 1. Infrastructure Map
- **Workers**: `cloud/cloudflare/workers/src/` (The Logic).
- **D1 (SQL)**: `mbb-database` (Users, Portfolios, Coin Sets).
- **KV (NoSQL)**:
  - `API_CACHE` — ephemeral API response caching.
  - `SETTINGS` — persistent app settings (API keys, provider config, folder IDs).
- **Base URL**: `https://mbb-api.ponomarev-ux.workers.dev`.

## 2. Route Map (index.js)
| Path | Handler | Purpose |
|:-----|:--------|:--------|
| `/auth/*` | `auth.js` | Google OAuth flow |
| `/api/portfolios/*` | `portfolios.js` | Portfolio CRUD (D1) |
| `/api/coin-sets/*` | `coin-sets.js` | Coin set CRUD (D1) |
| `/api/datasets/*` | `datasets.js` | Dataset storage (D1) |
| `/api/coingecko/*` | `api-proxy.js` | CoinGecko proxy + KV cache |
| `/api/yahoo-finance/*` | `api-proxy.js` | Yahoo Finance proxy |
| `/api/stooq/*` | `api-proxy.js` | Stooq proxy |
| `/api/proxy` | `api-proxy.js` | Generic proxy (domain whitelist) |
| `/api/settings` | `settings.js` | App settings CRUD (KV `SETTINGS`) |
| `/health` | inline | Health check |

## 3. Component Bindings (wrangler.toml)
- **DB**: D1 Binding `mbb-database`.
- **API_CACHE**: KV Binding for ephemeral API responses.
- **SETTINGS**: KV Binding for persistent app settings.
- **GOOGLE_CLIENT_SECRET**: Wrangler Secret (Auth).
- **JWT_SECRET**: Wrangler Secret (Session signing).
- **SETTINGS_TOKEN**: Wrangler Secret (Bearer token for `/api/settings` authorization).

## 4. Security
- **Generic Proxy Whitelist**: `/api/proxy` only forwards to domains in `GENERIC_PROXY_ALLOWED_HOSTS` set (`assets.coingecko.com`, `coin-images.coingecko.com`, `s2.coinmarketcap.com`, `raw.githubusercontent.com`, etc.). All other domains are blocked with `403`.
- **Settings Auth**: All `/api/settings` requests require `Authorization: Bearer <token>` matching `SETTINGS_TOKEN`. Without the secret, the endpoint returns `403` (fail-safe).

## 5. KV Cache Key Limit (CRITICAL)
Cloudflare KV has a **512-byte key length limit**. Long API URLs easily exceed this.
- **Solution**: `generateCacheKey()` in `api-proxy.js` hashes query strings via SHA-256 when key > 480 bytes.
- **Symptom**: `KV GET failed: 414 UTF-8 encoded length of N exceeds key length limit of 512`.
- **Key format**: Short keys stay readable, long keys use hash (`api-cache:coingecko:/coins/markets?h=<sha256hex>`).

## 6. Deployment
```bash
cd cloud/cloudflare/workers
npx wrangler deploy
```
Auth: OAuth token linked to `ponomarev.ux@gmail.com`. Check with `npx wrangler whoami`.

## 7. File Map
- `@cloud/cloudflare/workers/wrangler.toml`: Config (bindings, secrets, routes).
- `@cloud/cloudflare/workers/src/index.js`: Router.
- `@cloud/cloudflare/workers/src/api-proxy.js`: CoinGecko/Yahoo/Stooq/Generic proxy with KV caching + domain whitelist.
- `@cloud/cloudflare/workers/src/settings.js`: App settings CRUD (KV SETTINGS).
- `@cloud/cloudflare/workers/src/auth.js`: Google OAuth.
- `@cloud/cloudflare/workers/src/portfolios.js`: Portfolio CRUD (D1).
- `@cloud/cloudflare/workers/src/coin-sets.js`: Coin set CRUD (D1).
- `@cloud/cloudflare/workers/src/datasets.js`: Dataset storage (D1).
- `@core/config/cloudflare-config.js`: Client-side endpoint registry.
