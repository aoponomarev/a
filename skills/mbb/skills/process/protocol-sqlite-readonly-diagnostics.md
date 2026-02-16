---
id: protocol-sqlite-readonly-diagnostics
title: Protocol - SQLite Readonly Diagnostics
scope: skills-mbb
tags: [#protocol, #sqlite, #diagnostics, #readonly, #reliability]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Protocol - SQLite Readonly Diagnostics

> **Goal**: Collect SQLite evidence without risking data integrity.
> **SSOT**: `scripts/sqlite-health-snapshot.js`

## 1. Rule

- First step is read-only snapshot.
- Do not run destructive cleanup/rebuild before diagnostics.

## 2. Required Command

```bash
node scripts/sqlite-health-snapshot.js
```

## 3. Evidence Checklist

- Presence/size of `database.sqlite`.
- WAL/SHM size and growth behavior.
- better-sqlite3 loadability and reported sqlite version.

## 4. Escalation

- If snapshot shows severe anomalies, continue with controlled recovery protocol.
- Recovery steps should be explicit and reversible where possible.

