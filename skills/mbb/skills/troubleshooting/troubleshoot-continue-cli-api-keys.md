---
id: troubleshoot-continue-cli-api-keys
title: Troubleshooting: Continue CLI API Keys
scope: skills-mbb
tags: [#troubleshooting, #continue-cli, #api-keys, #docker]
priority: high
created_at: 2026-01-31
updated_at: 2026-02-01
---

# Troubleshooting: Continue CLI API Keys

> **Context**: API Key updates in `.env` not reflecting in Container.

## 1. Problem
Container uses old key cached in shell or image layer.

## 2. Root Cause
`config.yaml` does not natively support `${VAR}` substitution at runtime.

## 3. Solution
We use `env-subst.js` entrypoint script.

1.  **Update**: Change `.env`.
2.  **Recreate**:
    ```bash
    docker compose up -d --force-recreate continue-cli
    ```
3.  **Verify**:
    ```bash
    docker exec continue-cli grep apiKey /root/.continue/config.yaml
    ```

## 4. File Map
- `@mcp/continue-wrapper/env-subst.js`: The Fix.
