---
id: process-ollama-node-integration-checks
title: Process - Ollama Node Integration Checks
scope: skills-mbb
tags: [#process, #ollama, #nodejs, #preflight, #integration]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Ollama Node Integration Checks

> **Goal**: Ensure Node/MCP edits do not silently break Ollama fallback paths.
> **SSOT**: `scripts/git/preflight-solo.ps1`

## 1. Trigger Scope

Run Ollama checks when staged files include:
- `.continue/*`
- `mcp/*`
- `docker-compose*.yml`
- `.env.example`

## 2. Required Checks

1. Preflight run:
   - `powershell -ExecutionPolicy Bypass -File .\scripts\git\preflight-solo.ps1`
2. Control-plane sanity:
   - `node control-plane/scripts/self-test.js`
3. Wrapper reachability:
   - `curl http://127.0.0.1:3002/health`

## 3. Acceptance

- No preflight failures.
- No unexpected timeout/cooldown behavior for local-provider checks.
- Core runtime remains healthy after checks.

