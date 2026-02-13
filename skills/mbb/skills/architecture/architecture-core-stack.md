---
id: architecture-core-stack
title: Architecture: Core Tech Stack
scope: skills-mbb
tags: [#architecture, #stack, #docker, #mcp, #frontend]
priority: emergency
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Architecture: Core Tech Stack (`АИС`)

> **Context**: The foundational technology choices and execution environment.
> **Command**: `АИС` (Architecture/Infrastructure Analysis).

## 1. Execution Environment (Hybrid)

1.  **Frontend**: Static SPA (Vanilla JS + Vue 3 Reactivity). Runs on `file://` or GitHub Pages.
2.  **Local Backend (Docker)**:
    - `continue-cli`: Node.js Express wrapper for LLM.
    - `skills-mcp`: Knowledge base server (Model Context Protocol).
    - `n8n`: Workflow automation (Legacy/Support).
3.  **Edge (Cloudflare)**:
    - API Proxy (CORS Bypass).
    - Auth (Google OAuth).
    - State (D1/KV).

## 2. Tech Stack

### Backend & AI
- **Runtime**: Node.js v20+ (Dockerized).
- **API**: Express.js (Wrapper), Hono (Cloudflare Workers).
- **Protocol**: MCP (Stdio/SSE) for Agent Tools.
- **LLM**: Mistral Small (Primary), Ollama (Local), Groq (Fast).

### Frontend (MBB Core)
- **Framework**: No-Build Vue 3 (Reactivity Only).
- **Components**: Custom `cmp-*` system (No SFCs).
- **Styling**: Bootstrap 5 (Utility-first).
- **Storage**: `localStorage` (Versioned).
- **Network**: `fetch` via `Cloudflare Proxy`.

### Data & Events
- **SSOT**: JSON files in `events/` (Queues, Logs).
- **Logging**: `logs/skills-events.log` (Unified).

## 3. Hard Constraints
1.  **No NPM Build**: The frontend MUST run without `npm install/build`. Dependencies are pre-downloaded in `libs/`.
2.  **Secrets Hygiene**: No API keys in client code. Use `env-subst.js` for Docker and Wrangler Secrets for Cloud.
3.  **Skills-First**: Code changes must be preceded by Skill updates.

## 4. File Map
- `@docker-compose.yml`: Infrastructure definition.
- `@mcp/skills-mcp/server.js`: Knowledge server.
- `@docs/A_MASTER.md`: Architecture Root.
