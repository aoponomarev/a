---
id: process-better-sqlite3-node-abi-gate
title: "Process: better-sqlite3 Node ABI Gate"
scope: skills-mbb
tags: [#process, #better-sqlite3, #node, #abi]
priority: high
created_at: 2026-02-10
updated_at: 2026-02-15
---

# Process: better-sqlite3 Node ABI Gate

> **Context**: better-sqlite3 is a native module; Node ABI/runtime shifts are the primary risk vector in MBB.
> **SSOT**: `package.json`

## 1. Trigger

- Better-sqlite3 release appears in Sources.
- Node version updated in Docker image or local runtime.
- Package-lock changes affecting native module resolution.

## 2. Execution

1. Keep better-sqlite3 on known-good baseline in root `package.json`.
2. Run read-only sqlite snapshot: `node scripts/sqlite-health-snapshot.js`.
3. Run local smoke command that requires Node runtime and project scripts.
4. Confirm there are no native module load failures.
5. If Node major changed, treat ABI re-check as mandatory before rollout.

## 2.1 What Matters Most

- Node ABI compatibility of prebuilt/native binary.
- Reproducibility with current lockfile and runtime image.
- Zero native load errors across local checks and automation scripts.

## 3. Practical Guardrail

- Treat Node upgrades and better-sqlite3 upgrades as linked changes.
- If Node major changes, re-check better-sqlite3 baseline before deploying workflows depending on local SQLite operations.
- Prefer rollback to last known-good patch line over ad-hoc dependency churn.

