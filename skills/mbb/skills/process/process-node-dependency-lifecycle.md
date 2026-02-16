---
id: process-node-dependency-lifecycle
title: Process - Node Dependency Lifecycle
scope: skills-mbb
tags: [#process, #nodejs, #dependencies, #lifecycle]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Node Dependency Lifecycle

> **Goal**: Keep Node dependencies reproducible, secure, and compatible with current runtime policy.
> **Skill Anchor**: `package.json`, `control-plane/package.json`

## 1. Baseline Rules

- Keep lockfiles versioned for deterministic installs.
- Use `engines.node` in service packages that have strict runtime requirements.
- Prefer explicit minor/patch updates over unbounded upgrade waves.

## 2. ABI and Native Dependency Rules

- For native packages (`better-sqlite3`), validate ABI compatibility before rollout.
- When Node major version changes, run ABI gate checks first.
- Align Docker image Node version and service engine policy.

## 3. Security and Stability Rules

- Run dependency checks in local preflight for touched package zones.
- Treat security upgrade as controlled rollout, not blind mass update.
- Avoid adding new dependencies without clear runtime ROI.

## 4. Solo Validation

1. `node control-plane/scripts/self-test.js`
2. `npm run env:check`
3. `npm run index:gen`
