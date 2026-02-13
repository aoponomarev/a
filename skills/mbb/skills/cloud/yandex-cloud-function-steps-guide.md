---
id: cloud-yandex-cloud-function-steps-guide
title: Cloud: Yandex Function Deployment
scope: skills-mbb
tags: [#cloud, #yandex, #deployment, #guide]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Cloud: Yandex Function Deployment

> **Context**: Step-by-step guide for deploying the `yandexgpt-proxy`.

## 1. Setup Steps
1.  **Create Function**: In Yandex Cloud Console -> Cloud Functions.
2.  **Runtime**: Select `Node.js 22` (or latest).
3.  **Code**: Paste content from `cloud-yandex-cloud-function-code.md`.
4.  **Environment**: Add `YANDEX_API_KEY` variable.
5.  **Limits**:
    - Memory: `128MB`.
    - Timeout: `30s`.
6.  **Access**: Enable "Public function" toggle.

## 2. Verification
Test via `curl`:
```bash
curl -X POST https://functions.yandexcloud.net/YOUR_FUNC_ID \
  -H "Content-Type: application/json" \
  -d '{"messages": [{"role": "user", "text": "Hello"}]}'
```

## 3. Troubleshooting
- **403 Forbidden**: Ensure "Public" toggle is ON.
- **504 Gateway Timeout**: Increase timeout to 30s.
- **CORS Error**: Check `OPTIONS` handling in code.

## 4. File Map
- `@cloud/yandex/functions/`: Deployment source.
