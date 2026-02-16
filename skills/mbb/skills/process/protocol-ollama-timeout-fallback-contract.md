---
id: protocol-ollama-timeout-fallback-contract
title: Protocol - Ollama Timeout Fallback Contract
scope: skills-mbb
tags: [#protocol, #ollama, #timeout, #fallback, #nodejs]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Protocol - Ollama Timeout Fallback Contract

> **Goal**: Standardize timeout and fallback behavior for local Ollama calls.
> **Skill Anchor**: `scripts/git/preflight-solo.ps1`, `control-plane/src/n8n-client.js`

## 1. Timeout Classes

- **Fast class**: use `OLLAMA_TIMEOUT_FAST_MS`.
- **Heavy class**: use `OLLAMA_TIMEOUT_HEAVY_MS`.
- Never run external local-LLM request without timeout.

## 2. Fallback Semantics

- Local timeout is NOT a rate-limit event.
- On timeout, route to fallback provider path without cooldown-style lockout.
- Keep error codes explicit (`TIMEOUT`, `NETWORK`, `PROVIDER`).

## 3. Reliability Gates

- If Ollama-affecting files changed, run preflight health probe.
- In strict mode (`PRECHECK_OLLAMA_STRICT=1`), failed health probe blocks preflight.
- In default mode, failed probe is warning-only to avoid false blocking.

