---
id: process-zod-schema-governance
title: Process - Zod Schema Governance
scope: skills-mbb
tags: [#process, #zod, #mcp, #validation, #governance]
priority: high
created_at: 2026-02-16
updated_at: 2026-02-16
---

# Process - Zod Schema Governance

> **Goal**: Keep Zod validation behavior consistent across all MCP servers.
> **SSOT**: `mcp/*/server.js`, `control-plane/server.js`

## 1. Core Rules

- Use explicit Zod schemas for every tool input.
- Do not mix incompatible validation patterns across servers.
- Keep schema naming consistent (`<toolName>Schema`).

## 2. Contract Rules

- Error shape should be normalized across servers:
  - stable error code
  - human-readable message
  - optional details map for debug
- Validation failure must be fail-fast before tool execution starts.

## 3. Drift Prevention

- Any MCP package or schema change requires:
  1. `node scripts/mcp-sdk-drift-check.js`
  2. `node control-plane/scripts/self-test.js`
- Changes that increase divergence between servers are blocked until reconciled.

