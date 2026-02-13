---
id: integrations-cloudflare-testing
title: Integrations: Cloudflare Testing
scope: skills-mbb
tags: [#integrations, #cloudflare, #testing, #qa]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Integrations: Cloudflare Testing

> **Context**: Verification protocol for Edge services.

## 1. Checklist
- [ ] **Auth**: Does Google Login return a valid JWT?
- [ ] **D1**: Can I save and retrieve a portfolio?
- [ ] **KV**: Is the API Proxy returning cached results (check `cf-cache-status`)?
- [ ] **CORS**: Are preflight `OPTIONS` requests handled by the Worker?

## 2. Tools
- **Wrangler**: `wrangler tail` to see real-time Worker logs.
- **DevTools**: Network tab -> Filter by `workers.dev`.

## 3. File Map
- `@cloud/cloudflare/workers/src/`: Source code to test.
