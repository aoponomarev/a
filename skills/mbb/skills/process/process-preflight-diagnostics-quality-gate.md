---
id: process-preflight-diagnostics-quality-gate
title: Process - Preflight Diagnostics Quality Gate
scope: skills-mbb
tags: [#process, #preflight, #diagnostics, #reliability, #sqlite]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Preflight Diagnostics Quality Gate

> **Goal**: Keep preflight diagnostics accurate and avoid false failures that block safe rollout.
> **SSOT**: `scripts/git/preflight-solo.ps1`, runtime diagnostic scripts (e.g. sqlite snapshot, MCP SDK drift check).

## 1. Problem Pattern

- A check can be syntactically valid but semantically wrong (example: readonly mode on SQLite `:memory:`).
- False negatives reduce trust and create unnecessary rollback pressure.

## 2. Gate Rules

- Diagnostics must be read-only and deterministic.
- Each diagnostic path must be runnable in isolation from CLI.
- New diagnostics require one positive test and one failure-path test.
- Dependency drift diagnostics (SDK/schema) must verify both baseline and cross-package consistency.

## 3. Acceptance Checklist

1. Check runs in default mode without side effects.
2. Output is machine-readable (`JSON` or stable text markers).
3. Strict mode behavior is explicit and documented.
4. Warnings vs blocking failures are clearly separated.

## 4. Integration Rule

- Any change to `preflight-solo.ps1` must be followed by:
  1. direct script execution
  2. at least one related runtime self-test
  3. lint/diagnostic check on touched files

