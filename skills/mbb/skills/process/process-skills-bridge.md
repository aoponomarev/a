---
id: process-workflow-ui
title: Process: WorkFlow UI
scope: skills-mbb
tags: [#process, #ui, #workflow, #curation]
priority: high
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Process: Skills Bridge (V2)

> **Context**: The bridge between AI agents and the Knowledge Management UI.
> **SSOT**: `mcp/V2_DASHBOARD.html`, `mcp/V2_logic.js`

## 1. Interaction Protocol (V2)
1.  **Fetch**: Agent calls `v2/tasks` to see what's in the queue.
2.  **Analyze**: Agent reads the Markdown draft from `drafts/tasks/`.
3.  **Act**: Agent performs the task or suggests a refinement.

## 2. UI Synchronization (V2)
- **Real-time**: The Dashboard polls `v2/tasks` to show the latest Swarm output.
- **Feedback**: Agent actions (Confirm/Reject) are immediately reflected in `global/LLM/infra-registry.json`.

## 3. Hard Constraints
1.  **No Direct File Edits**: Agents must not edit `SKILL_CANDIDATES.json` directly; use the Dashboard API.
2.  **Reputation First**: Agents with low ratings in `infra-registry.json` are restricted from critical synthesis tasks.

## 4. File Map (V2)
- `@mcp/V2_DASHBOARD.html`: UI Frontend.
- `n8n/workflows/V2_DASHBOARD_API.json`: API Orchestrator.
- `global/LLM/infra-registry.json`: Reputation & Agent SSOT.
