---
id: continue-cli-mcp-integration-nuances
title: Integrations: Continue CLI & MCP Nuances
scope: skills-mbb
tags: [#integrations, #continue-cli, #mcp, #docker, #troubleshooting]
priority: high
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Integrations: Continue CLI & MCP Nuances

> **Context**: Ensuring AI Agents correctly use tools in headless mode.

## 1. Critical Flags
- **`--auto`**: Mandatory. Without it, Continue CLI blocks tool calls in print mode.
- **`--config`**: Explicitly point to `/root/.continue/config.yaml` to ensure project-specific MCP servers are loaded.

## 2. Prompt Injection
Models (e.g., Mistral Small) may ignore System Messages.
**Rule**: Inject "Always use list_skills before responding" at the start of every user prompt in `server.js`.

## 3. Flexible Search
Standard substring search is too rigid.
**Fix**: Split query into words and ensure ALL words exist in `id` or `title`.

## 4. Logging
MCP `stderr` is often swallowed by Docker.
**Fix**: Write debug logs to a physical file inside the container (`/workspace/mbb/logs/mcp-debug.log`).

## 5. File Map
- `@mcp/continue-wrapper/server.js`: CLI caller.
- `@mcp/skills-mcp/server.js`: Tool implementation.
