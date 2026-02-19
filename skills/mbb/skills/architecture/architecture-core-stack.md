---
id: architecture-core-stack
title: Architecture Core Tech Stack
scope: skills-mbb
tags: [#architecture, #stack, #docker, #mcp, #frontend]
priority: emergency
created_at: 2026-01-28
updated_at: 2026-02-19
---

# Architecture: Core Tech Stack (`АИС`)

> **Context**: The foundational technology choices and execution environment.
> **Command**: `АИС` (Architecture/Infrastructure Analysis).

## 1. Execution Environment (Hybrid)

1. **Frontend**: Static SPA (Vanilla JS + Vue 3 Reactivity). Runs on `file://` or GitHub Pages.
2. **Local Backend**:
   - `continue-wrapper` (`server.js`): Node.js HTTP server (raw `http.createServer`, no Express). LLM orchestration, agent management, infra API.
   - `skills-mcp`: Knowledge base server (Model Context Protocol).
   - `n8n`: Workflow automation (news, sources, maintenance).
3. **Edge (Cloudflare)**:
   - API Proxy (CORS Bypass, domain whitelist).
   - Auth (Google OAuth).
   - State (D1 for relational, KV for cache + app settings).
4. **Cloud (Yandex)**:
   - Cloud Function `mbb-api` (PostgreSQL proxy for portfolio sync).
   - Managed PostgreSQL (portfolio persistence, `extra_json JSONB`).

## 2. Tech Stack

### Backend & AI
- **Runtime**: Node.js v20+ (Docker or native).
- **API**: Raw `http.createServer` (continue-wrapper), raw `fetch` handler (Cloudflare Workers).
- **Protocol**: MCP (Stdio/SSE) for Agent Tools.
- **LLM Orchestration**: Multi-provider fallback chain (34+ models) via `infra-registry.json`. Providers: OpenRouter, Mistral, Groq, Yandex.
- **Client AI**: `YandexProvider` (default), `PerplexityProvider` — via `ai-provider-manager.js`.

### Frontend (MBB Core)
- **Framework**: No-Build Vue 3 (Reactivity Only).
- **Components**: Custom `cmp-*` system (No SFCs).
- **Styling**: Bootstrap 5 (Utility-first).
- **Storage**: 3-layer cache (`cacheManager`): Hot (localStorage), Warm/Cold (localStorage-backed stubs with IndexedDB keys). `localStorage` fallback for critical state (`workspaceConfig`).
- **Network**: `fetch` via Cloudflare Proxy.

### Data & Events
- **SSOT**: JSON files in `events/` (Queues, Logs, Caches).
- **Logging**: `logs/skills-events.log` (Unified).
- **Global Registry**: `OneDrive/AI/Global/LLM/infra-registry.json` (agent/model SSOT).

## 3. Hard Constraints
1. **No NPM Build**: The frontend MUST run without `npm install/build`. Dependencies are pre-downloaded in `libs/`.
2. **Secrets Hygiene**: No API keys in client code. Use `.env` for local, Wrangler Secrets for Cloud, Cloudflare KV for user settings backup.
3. **Skills-First**: Code changes must be preceded by Skill updates.

## 4. File Map
- `@docker-compose.yml`: Infrastructure definition.
- `@mcp/continue-wrapper/server.js`: Central Proxy & Control Plane.
- `@mcp/skills-mcp/server.js`: Knowledge server.
- `@core/config/cloudflare-config.js`: Client-side endpoint registry.
- `@docs/A_MASTER.md`: Architecture Root.
