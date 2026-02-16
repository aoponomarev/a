---
id: process-git-submodule-drift-control
title: Process: Git Submodule Drift Control
scope: skills-mbb
tags: [#git, #submodule, #drift, #reliability, #automation]
priority: high
created_at: 2026-02-16
updated_at: 2026-02-16
---

# Process: Git Submodule Drift Control

> **Context**: Prevents the `skills-core` submodule from falling behind the main `a` repository. Ensures knowledge base consistency.

## 1. The "Zero Drift" Rule
The submodule pointer in the main MBB repo MUST always point to the latest `main` branch of the `a` repository before any major feature commit.

## 2. Detection & Verification
1. **Manual Check**: `git submodule status`. A `+` prefix means the submodule has local changes; a `-` means it's uninitialized.
2. **Drift Check**: 
   ```bash
   cd skills-core && git fetch origin && git status -uno
   ```
   If it says "Your branch is behind 'origin/main'", drift is detected.

## 3. Sync Protocol (The "Solo-Sync" Pack)
To resolve drift safely:
```powershell
# In MBB root
git submodule update --remote --merge
```
Or manually:
```bash
cd skills-core && git pull origin main && cd .. && git add skills-core
```

## 4. Preflight Integration
The `scripts/git/preflight-solo.ps1` should ideally include a submodule check:
- **Trigger**: Any change in `skills-core` or session start.
- **Action**: Warn if `git diff --submodule` shows significant lag.

## 5. Hard Constraints
1. **No Detached HEAD**: Always ensure the submodule is on the `main` branch (`git checkout main`).
2. **Atomic Commits**: If a skill is updated in `a`, the pointer update in `MBB` should follow in the same or next logical commit.
3. **Recursive Clone**: New environments must use `git clone --recursive`.

## 6. Relations
- `process-git-submodule-resilience` (depends_on)
- `protocol-commit` (governs)
