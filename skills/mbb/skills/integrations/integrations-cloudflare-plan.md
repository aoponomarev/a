---
id: integrations-cloudflare-plan
title: Integrations: Cloudflare Roadmap
scope: skills-mbb
tags: [#integrations, #cloudflare, #roadmap]
priority: low
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Integrations: Cloudflare Roadmap

> **Context**: Status of Edge infrastructure integration.

## 1. Completed Phases
1.  **Infrastructure**: Workers, D1, KV setup.
2.  **Auth**: Google OAuth 2.0 flow.
3.  **Proxy**: API Proxy for CoinGecko/Yahoo.
4.  **Storage**: Portfolios CRUD via D1.

## 2. Pending Phases
- **R2 Storage**: Object storage for datasets (requires payment method).
- **Edge Analytics**: Tracking API usage per user.

## 3. Hard Constraints
- **Local-First Fallback**: App must remain functional via `localStorage` if Cloudflare is unreachable.

## 4. File Map
- `@docs/A_CLOUDFLARE.md`: Architecture spec.
