---
id: process-logging-strategy
title: Process: Logging & Tracking
scope: skills-mbb
tags: [#process, #logging, #tracking, #debug]
priority: medium
created_at: 2026-01-31
updated_at: 2026-02-01
---

# Process: Logging & Tracking

> **Context**: Unified logging strategy for transparency and debugging.
> **Location**: `logs/` directory.

## 1. Log Types

### Tracking (Git Tracked)
*Permanent project history.*
- `changelog.md`: Releases and major features.
- `fixes-tracking.md`: Bug fixes log.
- `issues-backlog.md`: Known issues queue.

### Operational (Agent Context)
*Session handoff.*
- `session-report.md`: Summary of current session.
- `handoff-note.md`: Instructions for next agent.

### Runtime (Git Ignored)
*Machine logs.*
- `skills-events.log`: Unified event stream (Node/MCP).
- `infra-manager.log`: Docker status changes.
- `mcp-debug.log`: RPC traffic.

## 2. Agent Workflow
1.  **Start**: Read `handoff-note.md` + `issues-backlog.md`.
2.  **Error**: Check `skills-events.log` (tail 50).
3.  **Success**: Update `fixes-tracking.md`.
4.  **End**: Write `session-report.md`.

## 3. Hard Constraints
1.  **Lowercase Files**: All log filenames must be lowercase/kebab-case.
2.  **No Secrets**: Logs must NOT contain API keys or tokens.
3.  **Reverse Chronology**: Markdown logs should have newest entries at top.

## 4. File Map
- `@logs/skills-events.log`: Main debug file.
- `@scripts/status-report.js`: Report generator.
