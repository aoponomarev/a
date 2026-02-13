---
id: integrations-postgres
title: Integrations: PostgreSQL & Sync
scope: skills-mbb
tags: [#integrations, #postgres, #database, #sync]
priority: medium
created_at: 2026-01-25
updated_at: 2026-02-01
---

# Integrations: PostgreSQL & Sync

> **Context**: Managed PostgreSQL in Yandex Cloud for heavy data and analytics.

## 1. Architecture
- **Client**: `postgres-client.js` (REST wrapper via Cloud Functions).
- **Manager**: `postgres-sync-manager.js` handles delta-updates between local state and DB.
- **Server**: Yandex Cloud Function acting as a secure gateway.

## 2. Key Rules
1.  **No Direct Connection**: Frontend MUST NOT connect to Postgres port 5432. Use the HTTPS API.
2.  **Batching**: Sync operations should be batched to minimize Function invocations.
3.  **Schema SSOT**: The database schema is defined in `cloud/yandex/db/schema.sql`.

## 3. Hard Constraints
1.  **Transactional**: All financial record updates must use SQL transactions.
2.  **Secrets**: DB credentials live only in Yandex Cloud Function environment variables.

## 4. File Map
- `@core/api/postgres-sync-manager.js`: Logic.
- `@core/config/postgres-config.js`: Endpoints.
