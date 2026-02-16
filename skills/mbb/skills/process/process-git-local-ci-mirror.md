---
id: process-git-local-ci-mirror
title: Process - Git Local CI Mirror
scope: skills-mbb
tags: [#process, #git, #ci, #local-validation]
priority: medium
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Git Local CI Mirror

> **Goal**: Run only high-value local checks before commit/push in solo mode.
> **SSOT**: `scripts/git/preflight-solo.ps1`

## 1. Trigger

- Before commit.
- Before push.
- After large infra or control-plane edits.

## 2. Checks

1. **Staged file map**
   - Identify which areas changed.
2. **Docker checks**
   - Run `docker compose --profile core config` only when compose files changed.
3. **MCP checks**
   - Run `node control-plane/scripts/self-test.js` only when control-plane changed.
4. **Secrets checks**
   - Fail if staged diff looks like secret leakage.

## 3. Success Criteria

- No secret-like strings in staged diff.
- Compose config is valid (if compose touched).
- Control-plane self-test passes (if control-plane touched).
- Working runtime remains healthy.

