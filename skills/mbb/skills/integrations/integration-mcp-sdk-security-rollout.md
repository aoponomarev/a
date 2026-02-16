---
id: integration-mcp-sdk-security-rollout
title: Integration - MCP SDK Security Rollout
scope: skills-mbb
tags: [#integration, #mcp, #security, #dependencies]
priority: high
created_at: 2026-02-10
updated_at: 2026-02-15
---

# Integration: MCP SDK Security Rollout

> **Context**: MCP SDK security must be consistent across all active MCP servers (`skills-mcp`, `agents-mcp`, `control-plane`).
> **SSOT**: package manifests in `mcp/*` and `control-plane/package.json`

## 1. When to Apply

- After release detection for MCP SDK.
- Before recruiting or scaling new MCP-driven agents.
- During infra hardening and dependency review.

## 2. Required Actions

1. Keep `@modelcontextprotocol/sdk` on a hardened v1 baseline (`>=1.26.0`) across all MCP servers.
2. Run dependency health endpoint:
   - `GET /api/infra/dependency-health`
3. Run drift check:
   - `node scripts/mcp-sdk-drift-check.js`
4. Rebuild/restart `continue-cli` container after dependency updates.
5. Verify `/health` and `/api/health-check` return success.

## 2.1 What Matters Most

- Server-side isolation and response-scope correctness.
- Consistent schema/runtime behavior across MCP servers.
- No partial upgrade drift in SDK/zod dependencies.

## 3. Why It Matters

- Prevents drift between `skills-mcp`, `agents-mcp`, and `control-plane`.
- Reduces risk of keeping vulnerable MCP runtime behavior in one server while fixing only the other.
- Keeps recursive agent orchestration on a consistent SDK baseline.

## 4. Fast Validation

- `node scripts/mcp-sdk-drift-check.js` -> `ok: true`.
- `GET /api/infra/dependency-health` -> `@modelcontextprotocol/sdk` should be `ok` for all MCP-related package files.
- V2 tabs `Skills & Tasks` and `Watch` load without MCP-side regressions.

