---
id: protocol-node-async-safety
title: Protocol - Node Async Safety
scope: skills-mbb
tags: [#protocol, #nodejs, #async, #reliability]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Protocol - Node Async Safety

> **Goal**: Keep Node runtime stable under async failures and high-latency integrations.
> **Skill Anchor**: `control-plane/server.js`, `control-plane/src/n8n-client.js`

## 1. Async Failure Rules

- Wrap all top-level `await` boundaries in `try/catch`.
- Never leave promise chains without `.catch()` in service code.
- Use structured error codes where possible (`N8N_HTTP_*`, `ENV_*`).

## 2. Parallel Execution Rules

- Use `Promise.allSettled` for independent checks (health, diagnostics).
- Use `Promise.all` only when one branch failure should fail the full operation.

## 3. Timeout and Abort Rules

- External I/O must support timeout via `AbortController`.
- Timeout values must be centralized in config where possible.
- Timeout errors should be classified as retryable vs non-retryable.

## 4. Solo Verification Path

1. `node control-plane/scripts/self-test.js`
2. `docker compose --profile core config`
3. `curl http://127.0.0.1:3002/health`
