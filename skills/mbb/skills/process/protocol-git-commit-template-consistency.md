---
id: protocol-git-commit-template-consistency
title: Protocol - Git Commit Template Consistency
scope: skills-mbb
tags: [#protocol, #git, #commit, #template, #solo]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Protocol - Git Commit Template Consistency

> **Goal**: Prevent commit-flow breakage caused by `commit.template` and `.gitmessage` mismatch.
> **SSOT**: repo `.gitmessage` and local `git config --get commit.template`.

## 1. Core Rule

- If `commit.template` points to `.gitmessage`, the file must exist and stay in sync with active commit protocol.
- Do not keep strict legacy requirements in template if current workflow is solo-lightweight.

## 2. Mandatory Checks

1. `git config --get commit.template`
2. `git status --short` (ensure `.gitmessage` is not accidentally deleted)
3. Read `.gitmessage` and verify:
   - concise imperative subject
   - `Why` block available
   - `Skills/FINS` optional, not mandatory

## 3. Drift Handling

- If template path exists but file missing: restore `.gitmessage` first.
- If file exists but content conflicts with active protocol: update file, do not change global git behavior.

## 4. Safety

- Never force commit metadata that increases solo workflow friction without clear ROI.

