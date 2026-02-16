---
id: protocol-node-mcp-development
title: Protocol - Node MCP Development
scope: skills-mbb
tags: [#protocol, #nodejs, #mcp, #control-plane]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Protocol - Node MCP Development

> **Goal**: Standardize development of Node-based MCP services for safe operations.
> **Skill Anchor**: `control-plane/server.js`, `mcp/*/server.js`

## 1. Architecture Rules

- Use official MCP SDK and stdio transport for local integration.
- Validate tool inputs with `zod`.
- Keep tool handlers null-safe (`params || {}`).

## 2. Safety Rules

- Side-effecting tools must support dry-run and explicit confirmation gates.
- Logger failures must never crash tool execution.
- Expose at least one health-check operation for dependency visibility.

## 3. Connectivity Rules

- External requests must use timeout + abort pattern.
- Normalize and validate external URLs before request.
- Classify and surface response errors consistently.

## 4. Solo Validation Path

1. `node --check control-plane/server.js`
2. `node control-plane/scripts/self-test.js`
3. `curl http://127.0.0.1:3002/health`
