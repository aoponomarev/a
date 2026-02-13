---
id: process-better-sqlite3-node-abi-gate
title: "Process: better-sqlite3 Node ABI Gate (>=12.6.2)"
scope: skills-mbb
tags: [#process, #better-sqlite3, #node, #abi]
priority: high
created_at: 2026-02-10
updated_at: 2026-02-10
---

# Process: better-sqlite3 Node ABI Gate (>=12.6.2)

> **Context**: better-sqlite3 12.6.2 includes compatibility updates for Node ABI/package ecosystem. We use it in root runtime tooling.
> **SSOT**: `package.json`

## 1. Trigger

- Better-sqlite3 release appears in Sources.
- Node version updated in Docker image or local runtime.

## 2. Execution

1. Keep `better-sqlite3 >= 12.6.2` in root `package.json`.
2. Run dependency health endpoint and verify `ok`.
3. Run local smoke command that requires Node runtime and project scripts.
4. Confirm there are no native module load failures.

## 2.1 Release Notes That Matter (v12.6.2)

- Build fix: `node-abi` dependency updated to `^4.25.0`.

For our stack this is not a feature-level change, but a compatibility hardening change. It is useful exactly as a runtime safety gate tied to Node upgrades.

## 3. Practical Guardrail

- Treat Node upgrades and better-sqlite3 upgrades as linked changes.
- If Node major changes, re-check better-sqlite3 baseline before deploying workflows depending on local SQLite operations.

