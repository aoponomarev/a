# Recipe: Portfolio Engine MVP Hardening (MBB)

> **References**:
> - Doc: `MBB/docs/A_PORTFOLIO_SYSTEM.md`
> - Engine: `MBB/core/domain/portfolio-engine.js`
> - Validation: `MBB/core/domain/portfolio-validation.js`
> - General skill: `skills/recipe-portfolio-engine-mvp-hardening.md`

## Problem

Refactor portfolio logic without inheriting legacy bugs from UI-centric implementation.

## Target guarantees

- strict `sum=100` and `min=1`
- disable in rebalance means fixed `1%`, not deletion
- long-only and short-only valid
- repeated lock/unlock operations remain deterministic
- `file://` runtime should degrade gracefully on provider failures

## Implementation blueprint

1. Introduce canonical domain contract (`PortfolioDraft`, `DraftAsset`).
2. Move balancing to pure engine module.
3. Keep compatibility facade in config layer for legacy callers.
4. Add validator module and enforce before save.
5. Add adapter module for Cloudflare/PostgreSQL payload shaping.

## Critical fix pattern

In normalization logic:

- initialize disabled assets first: `weight = minWeight`
- compute mutable assets as `!isDisabledInRebalance`
- redistribute overflow/remainder only across mutable assets
- keep deterministic priority order per mode

This prevents "disabled asset changed during rebalance" regressions.

## Sync pattern (production-safe)

- Cloudflare: primary online persistence in save flow.
- PostgreSQL: optional secondary sync only.
- PostgreSQL guards:
  - feature flag (`appConfig.features.postgresSync`)
  - UI toggle (`uiState.cloud.postgres.enabled`)
  - explicit skip reason for `missing baseUrl/CORS`

## Test protocol

- Domain smoke: `node core/domain/portfolio-engine-smoke.js`
- UI smoke (file mode): `node scripts/smoke-test-portfolio.js`
- Accept only when both are PASS and no critical console errors.
