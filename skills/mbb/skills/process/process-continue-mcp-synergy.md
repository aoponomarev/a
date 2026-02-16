---
id: process-continue-mcp-synergy
title: "Process: Continue AI & MCP Synergy"
scope: skills-mbb
tags: [#continue, #mcp, #synergy, #orchestration]
---
version: 1.0.0
priority: high
shadow_index: "Master guidelines for using Continue AI with the 5-server MCP stack (skills, agents, control-plane, obsidian, github)."
relations: [protocol-command-vzp, architecture-hybrid-bridge]
updated_at: 2026-02-15
---

# Process: Continue AI & MCP Synergy

> **Goal**: Maximize the effectiveness of AI assistance by correctly orchestrating the 5-server MCP stack.

## 1. The Synergy Chain

Every complex task must follow this "Thinking Chain" using MCP tools:

1.  **Context (@codebase / @terminal)**: Gather current state. Use `@terminal` to see the last error.
2.  **Rules (skills-mcp)**: Verify the plan against existing skills. **MANDATORY**.
3.  **Knowledge (obsidian-mcp)**: Use for deep graph analysis or finding related concepts if `skills-mcp` is insufficient.
4.  **Action (control-plane / agents-mcp)**: Execute side-effects (n8n workflows) or manage long-running agent tasks.
5.  **Cloud (github-mcp)**: Use for L3 planning or cross-repo impact analysis.

## 2. Terminal Context Loop (И1)

- **Pattern**: `Run Command` -> `Error` -> `@terminal` -> `Fix`.
- **Rule**: Never copy-paste terminal errors manually. Use the `@terminal` context provider to let the agent see the full buffer.

## 3. Obsidian Graph Sync (И2)

- **Usage**: When using `@codebase`, the agent should supplement results with `obsidian-mcp` tools to understand logical dependencies not visible in the file system.

---
*MBB KM v2.0 | Principle: Orchestrated Intelligence*
