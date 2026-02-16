---
id: process-node-foundation-reliability
title: Process - Node Foundation Reliability
scope: skills-mbb
tags: [#process, #nodejs, #reliability, #runtime]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Node Foundation Reliability

> **Goal**: Maintain a stable Node foundation for MBB services and scripts.
> **SSOT**: `control-plane/package.json`, root `package.json`, `docker/continue-cli/Dockerfile`

## 1. Runtime Baseline

- Node LTS baseline must be consistent across host checks and container runtime.
- Service packages with strict requirements must declare `engines.node`.
- Native dependency changes must pass ABI compatibility checks.

## 2. Reliability Gates

- Async external calls require timeout and abort support.
- Critical Node services must have self-test entrypoints.
- Runtime errors must use stable, machine-readable categories.

## 3. Integration Gates

- If MCP service changed -> run control-plane self-test.
- If compose/docker changed -> run compose config validation.
- If env/governance changed -> run env key check.

## 4. Solo Command Pack

```bash
node control-plane/scripts/self-test.js
docker compose --profile core config
npm run env:check
```

