---
id: integrations-api-proxy
title: Integrations: API Proxy
scope: skills-mbb
tags: [#integrations, #proxy, #cors, #caching]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Integrations: API Proxy

> **Context**: CORS bypass and response caching at the Edge.
> **SSOT**: `cloud/cloudflare/workers/src/api-proxy.js`

## 1. Purpose
Allows the `file://` frontend to access external APIs (CoinGecko) by routing requests through a Cloudflare Worker that adds CORS headers and hides API keys.

## 2. Supported Routes
- `GET /api/coingecko/*` -> `api.coingecko.com`
- `GET /api/yahoo-finance/*` -> `query1.finance.yahoo.com`
- `GET /api/stooq/*` -> `stooq.com`

## 3. Caching Strategy (KV)
**Namespace**: `API_CACHE`

| Route | TTL |
| :--- | :--- |
| `/coins/markets` | 5 min |
| `/coins/list` | 24 hours |
| `/simple/price` | 1 min |
| Yahoo/Stooq Charts | 1 hour |

## 4. Hard Constraints
1.  **Whitelist Only**: The generic proxy (`/api/proxy`) must validate target URLs against a strict whitelist to prevent abuse.
2.  **Header Stripping**: Sensitive headers (Cookies, Auth) from the client are stripped before forwarding.

## 5. File Map
- `@cloud/cloudflare/workers/src/api-proxy.js`: Implementation.
- `@core/config/cloudflare-config.js`: Client usage.
