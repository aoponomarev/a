---
id: process-bug-resolution-protocol
title: Process: Bug Resolution Protocol
scope: skills-mbb
tags: [#process, #bugs, #workflow, #quality]
priority: high
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Process: Bug Resolution Protocol

> **Context**: Standardized approach to fixing errors and documenting them.

## 1. Resolution Steps
1.  **Reproduce**: Confirm the bug with a log or screenshot.
2.  **Trace**: Find the root cause in the code.
3.  **Fix**: Apply the code change.
4.  **Log**: Add an entry to `logs/fixes-tracking.md`.
5.  **Skill Check**: Should this fix be a new Skill? If yes -> `propose_skill`.

## 2. Logging Format
In `fixes-tracking.md`:
- **Date**: YYYY-MM-DD.
- **Issue**: Short description.
- **Root Cause**: Why it happened.
- **Solution**: What was changed.

## 3. Hard Constraints
1.  **No Ghost Fixes**: Every code change that fixes a bug MUST be logged.
2.  **Verify First**: Run `health-check.js` before and after the fix.

## 4. File Map
- `@logs/fixes-tracking.md`: The Log.
- `@scripts/health-check.js`: Verification.
