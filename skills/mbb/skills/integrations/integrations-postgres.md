---
id: integrations-postgres
title: Integrations: PostgreSQL & Sync
scope: skills-mbb
tags: [#integrations, #postgres, #database, #sync, #migration]
priority: medium
created_at: 2026-01-25
updated_at: 2026-02-14
---

# Integrations: PostgreSQL & Sync

> **Context**: Managed PostgreSQL in Yandex Cloud for heavy data and analytics.

## 1. Architecture
- **Client**: `postgres-client.js` (REST wrapper via Cloud Functions).
- **Manager**: `postgres-sync-manager.js` handles delta-updates between local state and DB.
- **Server**: Yandex Cloud Function `mbb-api` (`d4e4884229p96ea4kt1e`) acting as a secure gateway.
- **API Gateway**: `d5dl2ia43kck6aqb1el5.k1mxzkh0.apigw.yandexcloud.net`

## 2. Key Rules
1.  **No Direct Connection**: Frontend MUST NOT connect to Postgres port 5432. Use the HTTPS API.
2.  **Batching**: Sync operations should be batched to minimize Function invocations.
3.  **Schema SSOT**: `cloud/yandex/schema-postgres.sql` (primary), deployment copies in `cloud/yandex/deployments/`.
4.  **Extensibility**: Use `extra_json JSONB` column for provider-specific or future fields instead of adding rigid columns. This avoids schema migrations for every new data point.

## 3. Hard Constraints
1.  **Transactional**: All financial record updates must use SQL transactions.
2.  **Secrets**: DB credentials live only in Yandex Cloud Function environment variables. Backup copy in `do-overs/Secrets/yandex-postgres.env` (outside repo).
3.  **No `rank` in domain**: `market_cap_rank` is CoinGecko provider metadata, NOT a portfolio domain field. Never persist it as a top-level column.

## 4. Schema Migration Pattern
When schema changes are needed:
1.  Write migration SQL in `cloud/yandex/migrations/YYYY-MM-DD-description.sql`.
2.  Update `cloud/yandex/schema-postgres.sql` (canonical schema).
3.  Update Cloud Function code if INSERT/SELECT statements change.
4.  Deploy function with temporary admin endpoint to execute migration.
5.  Verify via health check and smoke tests.
6.  Remove admin endpoint, redeploy clean version.
7.  Always use `IF EXISTS` / `IF NOT EXISTS` guards in DDL.

## 5. File Map
- `@core/api/postgres-sync-manager.js`: Sync logic.
- `@core/domain/portfolio-adapters.js`: Payload shaping (includes `extra_json`).
- `@cloud/yandex/schema-postgres.sql`: Canonical schema.
- `@cloud/yandex/migrations/`: Migration scripts.
- `@cloud/yandex/functions/mbb-api/index.js`: Cloud Function code.
