---
id: architecture-client-vs-cloud
title: Architecture: Client vs Cloud Responsibility
scope: skills-mbb
tags: [#architecture, #client, #cloud, #responsibility]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Architecture: Client vs Cloud Responsibility

> **Context**: Separation of concerns between the static frontend (Client) and the dynamic backend (Cloud/Edge).
> **SSOT**: `core/config/app-config.js` (Client), `INFRASTRUCTURE_CONFIG.yaml` (Cloud)

## 1. Core Principle
**Version-Bound vs. User-Bound**:
- **Client**: Functionality tied to the *application version*. Deterministic, static, immutable per deploy.
- **Cloud**: Data tied to the *user*. Persistent, mutable, version-independent.

## 2. Client Responsibility (Local)
*Code, Logic, and Config that travels with the JS bundle.*

- **App Config**: API endpoints, limits, feature flags (`core/config/app-config.js`).
- **Business Logic**: Validation rules, math calculators (`core/api/market-metrics.js`).
- **UI Components**: Templates, styles, local state (`core/state/ui-state.js`).
- **System Messages**: Error text, labels (`core/config/messages-config.js`).
- **Cache Config**: TTL, strategies (`core/cache/cache-config.js`).
- **Versioned Cache**: Data structures that depend on the current code schema.

## 3. Cloud Responsibility (Remote)
*Data that survives application updates.*

- **Cloudflare D1**:
  - User Profiles & Auth.
  - Portfolios (Assets, Settings).
  - User Preferences (Theme, Layout).
- **Cloudflare R2** (Future):
  - Custom Math Models (JSON).
  - Historical Datasets (Time Series).
  - Calculation Snapshots (Reports).

## 4. Hard Constraints
1.  **No Logic in Cloud**: Cloudflare Workers should route and auth, not calculate business metrics (unless heavy compute).
2.  **No Config in DB**: App configuration (timeouts, colors) MUST NOT be stored in the database. It belongs in the code.
3.  **Versioning**: Client cache keys MUST include `appVersionHash` to prevent schema collisions after updates.

## 5. File Map
- `@core/config/app-config.js`: Client configuration.
- `@core/api/cloudflare/`: Cloud interaction layer.
