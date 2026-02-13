---
id: process-workflow-ui
title: Process: WorkFlow UI
scope: skills-mbb
tags: [#process, #ui, #workflow, #curation]
priority: high
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Process: WorkFlow UI (V2)

> **Context**: The visual interface for Knowledge Management and Source Monitoring.
> **SSOT**: `mcp/V2_DASHBOARD.html`, `mcp/V2_logic.js`

## 1. Queues (V2)
1.  **Tasks/Candidates**: From External Sources (Releases/Commits). Action: Confirm/Reject.
2.  **Agents**: Reputation tracking and scoring. Action: Monitor performance.
3.  **Rejected**: Archive of filtered-out proposals. Action: Restore if needed.

## 2. Agent Workflow (V2)
- **Monitor**: Check `SKILL_CANDIDATES.json` via Dashboard API.
- **Suggest**: If new high-score tasks appear -> Notify user for review.

## 3. Status Lifecycle (V2)
`candidate` -> `confirmed` (Ready for manual move) -> `published` (In skills repo).

## 4. File Map (V2)
- `@mcp/V2_DASHBOARD.html`: UI Frontend.
- `@mcp/continue-wrapper/server.js`: Backend API Proxy.
- `OneDrive/AI/Global/LLM/infra-registry.json`: Data SSOT.
