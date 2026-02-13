---
id: integrations-cloudflare-core
title: Integrations: Cloudflare Core
scope: skills-mbb
tags: [#integrations, #cloudflare, #workers, #d1]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
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

## 3. Deployment
```bash
cd cloud/cloudflare/workers
wrangler deploy
```

## 4. File Map
- `@cloud/cloudflare/workers/wrangler.toml`: Config.
- `@cloud/cloudflare/workers/src/index.js`: Router.
- `@core/config/cloudflare-config.js`: Client-side endpoint registry.
