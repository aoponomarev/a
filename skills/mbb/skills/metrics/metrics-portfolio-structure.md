---
id: metrics-portfolio-structure
title: Metrics: Portfolio Structure
scope: skills-mbb
tags: [#metrics, #portfolio, #structure]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Metrics: Portfolio Structure

> **Context**: Data shape for portfolio objects.
> **SSOT**: `core/api/cloudflare/portfolios-client.js`

## 1. Schema
```javascript
{
  id: "YYMMDD-hhmm",
  name: "Mixed Alpha",
  coins: [
    {
      coinId: "bitcoin",
      ticker: "BTC",
      portfolioPercent: 50,
      delegatedBy: { modelId: "median-air" }
    }
  ],
  settings: { horizon: 30 }
}
```

## 2. Storage
- **Local**: `localStorage` key `mbb-portfolios`.
- **Cloud**: Cloudflare D1 table `portfolios`.

## 3. Invariant
- **Delegation**: Every coin MUST have a `delegatedBy` field pointing to a valid Model ID.

## 4. File Map
- `@core/api/cloudflare/portfolios-client.js`: Data Access Object.
