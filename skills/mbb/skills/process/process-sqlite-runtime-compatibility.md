---
id: process-sqlite-runtime-compatibility
title: "Process: sqlite3 Runtime Compatibility Gate (>=5.1.7)"
scope: skills-mbb
tags: [#process, #sqlite3, #n8n, #runtime]
priority: high
created_at: 2026-02-10
updated_at: 2026-02-10
---

# Process: sqlite3 Runtime Compatibility Gate (>=5.1.7)

> **Context**: sqlite3 release 5.1.7 improves runtime behavior and packaging. In our stack it impacts n8n-side scripts and chat watcher flows that touch SQLite databases.
> **SSOT**: `n8n/package.json`

## 1. Trigger

- New sqlite3 release detected in Sources.
- Any errors around sqlite bindings, prebuilds, or package install in n8n container.

## 2. Gate Checklist

1. Ensure `sqlite3 >= 5.1.7` in `n8n/package.json`.
2. Run `GET /api/infra/dependency-health` and confirm sqlite3 status is `ok`.
3. Restart `n8n` container and run a workflow using SQLite access (Cursor watch scan is enough smoke test).
4. Check no binding/runtime errors in n8n logs.

## 2.1 Release Notes That Matter (v5.1.7)

- Bundled SQLite updated to `3.44.2`.
- Packaging switched from `@mapbox/node-pre-gyp` to `prebuild` + `prebuild-install`.
- Reported community bundling issues addressed.
- `RowToJS` performance improvements.

These changes matter for our watcher/analysis flows that rely on stable SQLite binaries in containerized runtime.

## 3. Rollback Rule

- If workflow fails after upgrade, keep the major line but pin to last known good patch in the same major.
- Do not downgrade below baseline without recording reason in infra log.

