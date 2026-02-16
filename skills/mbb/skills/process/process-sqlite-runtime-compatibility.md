---
id: process-sqlite-runtime-compatibility
title: "Process: sqlite3 Runtime Compatibility Gate"
scope: skills-mbb
tags: [#process, #sqlite3, #n8n, #runtime]
priority: high
created_at: 2026-02-10
updated_at: 2026-02-15
---

# Process: sqlite3 Runtime Compatibility Gate

> **Context**: sqlite3 runtime stability in MBB is primarily an operational concern (n8n/local scripts), not only a release-tracking concern.
> **SSOT**: `n8n/package.json`

## 1. Trigger

- New sqlite3 release detected in Sources.
- Any errors around sqlite bindings, prebuilds, or package install in n8n container.
- Any infrastructure change that can affect SQLite files (Docker volume/path/runtime).

## 2. Gate Checklist

1. Ensure sqlite3 baseline in `n8n/package.json` remains on known-good line.
2. Run `GET /api/infra/dependency-health` and confirm sqlite3 status is `ok`.
3. Run read-only snapshot: `node scripts/sqlite-health-snapshot.js`.
4. Run a workflow using SQLite access (smoke path is enough).
5. Check no binding/runtime errors in n8n logs.

## 2.1 What Matters Most

- Binary compatibility inside current runtime/container.
- Stability of file paths and mounted volumes.
- Predictable behavior of WAL/SHM files under concurrency.
- Read-only diagnostics first, recovery actions second.

## 3. Rollback Rule

- If workflow fails after upgrade, keep the major line but pin to last known good patch in the same major.
- Do not downgrade below baseline without recording reason in infra log.
- Prefer read-only evidence collection before any destructive/rebuild action.

