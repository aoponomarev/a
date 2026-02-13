---
id: architecture-mcp-ui-interaction
title: MCP-UI Interaction Architecture
description_ru: Архитектурный мост между пользовательским интерфейсом (UI) и сервером MCP, обеспечивающий согласованное взаимодействие через API.
scope: architecture, ui, integrations
tags: [architecture, UI, integration, MCP, bridge]
priority: high
created_at: 2026-02-01
updated_at: 2026-02-01
---

# MCP-UI Interaction Architecture

## Overview
This skill defines the interaction protocol between the frontend (WorkFlow UI) and the backend MCP services. It ensures a reactive, state-aware interface for complex AI-driven tasks like commit scanning and skill curation.

## Core Interactions

### 1. The Scan Flow (V2)
- **Request**: UI triggers `/webhook/v2/check-updates` (or specific commit scan).
- **Backend**: n8n `V2_SOURCES_MANAGER` orchestrates the scan.
- **Response**: Returns summary of findings.
- **UI Update**: Dynamically updates the sources or task list.

### 2. The Approve/Curation Flow (V2)
- **User Action**: Clicking "OK" on Dashboard triggers `v2/confirm`.
- **Backend**: API updates agent reputation and status.
- **Drafter**: Drafting is now part of the `V2_NEWS_Swarm` initial pass.

### 3. The Log Synchronization
- **Polling**: UI fetches `/api/logs` to show real-time events.
- **Aggregation**: Consecutive events (like `PROCESSOR_STARTED`) are collapsed in UI for readability.

## Guidelines

1. **State Management**: Use `data-hash` attributes in DOM to map UI elements to backend entities.
2. **Error Handling**: Always provide visual feedback (spinners, alerts) for long-running LLM tasks.
3. **Optimistic UI**: Fade out rejected or skipped items immediately while waiting for server confirmation.

## Validation
1. **End-to-End Test**: Trigger a scan, verify the modal appears, click approve, and check for the draft.
2. **Reactivity Check**: Ensure that multiple overlapping calls (e.g., status polling + scan) don't deadlock the server.
