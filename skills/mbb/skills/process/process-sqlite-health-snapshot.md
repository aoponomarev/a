---
id: process-sqlite-health-snapshot
title: Process - SQLite Health Snapshot
scope: skills-mbb
tags: [#process, #sqlite, #health, #snapshot, #preflight]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - SQLite Health Snapshot

> **Goal**: Provide lightweight operational visibility for SQLite health in MBB.
> **SSOT**: `scripts/sqlite-health-snapshot.js`

## 1. Trigger

- Node/runtime dependency changes.
- Docker compose / volume / path changes.
- SQLite-related incident symptoms (timeouts, lock errors, slow workflows).

## 2. Command

```bash
node scripts/sqlite-health-snapshot.js
```

## 3. Expected Output

- JSON summary with detected SQLite files.
- WAL/SHM and DB size signals.
- better-sqlite3 load check result.

## 4. Preflight Integration

- Script is used by staged-only preflight when SQLite-risk zones are touched.
- Strict mode can be activated via env gates in CI/local policy.

