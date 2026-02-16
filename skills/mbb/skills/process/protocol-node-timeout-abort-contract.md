---
id: protocol-node-timeout-abort-contract
title: Protocol - Node Timeout Abort Contract
scope: skills-mbb
tags: [#protocol, #nodejs, #timeout, #abortcontroller]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Protocol - Node Timeout Abort Contract

> **Goal**: Prevent hanging I/O and improve failure predictability in Node integrations.
> **Skill Anchor**: `control-plane/src/n8n-client.js`, `control-plane/server.js`

## 1. Contract Rules

- Every external HTTP call must define timeout behavior.
- Use `AbortController` for cancellable requests.
- Timeout errors must be mapped to explicit reason code (`TIMEOUT` or equivalent).

## 2. Error Mapping Rules

- Keep HTTP status mapping stable (`N8N_HTTP_<status>` style).
- Differentiate transport failure, timeout, and provider business error.
- Do not swallow errors without telemetry/log context.

## 3. Verification Rules

- Any timeout-related change requires:
  1. `node control-plane/scripts/self-test.js`
  2. `curl http://127.0.0.1:3002/health`
  3. `docker compose --profile core config`

