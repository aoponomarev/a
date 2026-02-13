---
id: integration-mcp-sdk-security-rollout
title: "Integration: MCP SDK Security Rollout (>=1.26.0)"
scope: skills-mbb
tags: [#integration, #mcp, #security, #dependencies]
priority: high
created_at: 2026-02-10
updated_at: 2026-02-10
---

# Integration: MCP SDK Security Rollout (>=1.26.0)

> **Context**: MCP SDK 1.26.0 includes security-related fixes and should be treated as baseline for `skills-mcp` and `agents-mcp`.
> **SSOT**: `mcp/skills-mcp/package.json`, `mcp/agents-mcp/package.json`

## 1. When to Apply

- After release detection for MCP SDK.
- Before recruiting or scaling new MCP-driven agents.
- During infra hardening and dependency review.

## 2. Required Actions

1. Keep `@modelcontextprotocol/sdk` at `>=1.26.0` in both MCP servers.
2. Run dependency health endpoint:
   - `GET /api/infra/dependency-health`
3. Rebuild/restart `continue-cli` container after dependency updates.
4. Verify `/health` and `/api/health-check` return success.

## 2.1 Release Notes That Matter (v1.26.0)

- Security advisory fix: cross-client response data leak risk (`GHSA-345p-7cg4-v4c7`).
- Backported dependency vulnerability fixes (`npm audit` related changes).
- Backported client credentials scopes support fix.

These are directly relevant because `skills-mcp` and `agents-mcp` share SDK/transport behavior and run in the same orchestrated environment.

## 3. Why It Matters

- Prevents drift between `skills-mcp` and `agents-mcp`.
- Reduces risk of keeping vulnerable MCP runtime behavior in one server while fixing only the other.
- Keeps recursive agent orchestration on a consistent SDK baseline.

## 4. Fast Validation

- `GET /api/infra/dependency-health` -> `@modelcontextprotocol/sdk` should be `ok` for both package files.
- V2 tabs `Skills & Tasks` and `Watch` load without MCP-side regressions.

