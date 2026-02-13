---
id: integrations-auth-worker-restore
title: Integrations: Auth Worker Deployment
scope: skills-mbb
tags: [#integrations, #auth, #cloudflare, #deployment]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Integrations: Auth Worker Deployment

> **Context**: Protocol for deploying or restoring the Cloudflare Worker responsible for OAuth.
> **Scope**: Secrets management, bindings verification, and deployment.

## 1. Prerequisites
- **Wrangler CLI**: Installed and authenticated (`wrangler login`).
- **Account ID**: Cloudflare Account ID available.
- **Secrets**: `GOOGLE_CLIENT_SECRET` and `JWT_SECRET` ready.

## 2. Deployment Steps
1.  **Verify Bindings**: Check `wrangler.toml` for `DB` (D1) and `API_CACHE` (KV).
2.  **Upload Secrets**:
    ```bash
    wrangler secret put GOOGLE_CLIENT_SECRET
    wrangler secret put JWT_SECRET
    ```
3.  **Deploy**:
    ```bash
    wrangler deploy
    ```
4.  **Health Check**: Visit `https://mbb-api.ponomarev-ux.workers.dev/health`.

## 3. Client Config
Update `core/config/auth-config.js` with the correct `clientId` and `redirectUri`.

## 4. File Map
- `@cloud/cloudflare/workers/wrangler.toml`: Infrastructure config.
- `@cloud/cloudflare/workers/src/auth.js`: Auth logic.
