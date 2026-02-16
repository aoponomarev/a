---
id: process-git-foundation-reliability
title: Process - Git Foundation Reliability
scope: skills-mbb
tags: [#process, #git, #reliability, #solo]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Git Foundation Reliability

> **Goal**: Keep Git workflow stable for solo development without unnecessary team overhead.
> **SSOT**: `git status`, `.gitmodules`, local hooks scripts.
> **Replacement note**: Replaces legacy `protocol-git-ai-collaboration` rules (mandatory ROI-per-commit, git notes metadata, agent branches/PR as default).

## 1. Solo Baseline

- Prefer one active branch for runtime work unless a risky experiment is isolated.
- Always inspect `git status --short` before and after each iteration.
- Use staged-only checks to reduce noise and speed up cycles.
- Commit messages follow `.gitmessage` in lightweight mode (`Why` required, `FINS` optional).

## 2. Reliability Gates

1. **Submodule drift gate**
   - Validate `skills-core` pointer before commit/push.
2. **Secrets gate**
   - Scan staged diff for tokens/keys before commit.
3. **Targeted runtime gate**
   - If Docker files changed: run `docker compose config`.
   - If control-plane files changed: run `node control-plane/scripts/self-test.js`.

## 3. Stash Hygiene

- Use stash only for short-lived context switching.
- Add meaningful message in stash name.
- Keep a compact stash catalog with creation date and intent.
- Drop stale stash entries after successful integration.

## 4. Minimum Command Set

```bash
git status --short
git submodule status
git stash list
powershell -ExecutionPolicy Bypass -File .\scripts\git\preflight-solo.ps1
```

