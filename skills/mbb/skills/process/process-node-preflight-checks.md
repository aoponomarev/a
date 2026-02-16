---
id: process-node-preflight-checks
title: Process - Node Preflight Checks
scope: skills-mbb
tags: [#process, #nodejs, #preflight, #git]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Node Preflight Checks

> **Goal**: Run staged-only Node checks before commit to reduce regressions.
> **SSOT**: `scripts/git/preflight-solo.ps1`

## 1. Trigger

- Before commit when staged files include:
  - `control-plane/*`
  - `mcp/*`
  - `package.json` / lockfiles
  - `docker-compose*.yml`

## 2. Checks

1. Secret leakage scan on staged diff.
2. Compose config validation if compose changed.
3. Control-plane self-test if control-plane changed.
4. Root env schema check if env governance changed.
5. MCP SDK drift check when MCP/control-plane/dependency manifests are touched.
6. Zod baseline check is included in MCP drift check (major line + consistency).

## 3. Acceptance

- Preflight exits with code `0`.
- No secret-like tokens in staged diff.
- Runtime health endpoints remain available after checks.
- MCP SDK baseline is consistent across MCP servers.

