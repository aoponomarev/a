---
id: cloud-yandex-cloud-function-code
title: Cloud: Yandex Function Implementation
scope: skills-mbb
tags: [#cloud, #yandex, #serverless, #javascript]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Cloud: Yandex Function Implementation

> **Context**: Proxying YandexGPT API calls to bypass CORS and secure keys.
> **Runtime**: Node.js 18+.

## 1. Implementation Rules
1.  **Native Fetch**: Use built-in `fetch()`. Do NOT use `node-fetch`.
2.  **CORS Handling**: Must respond to `OPTIONS` requests with `204 No Content` and appropriate headers.
3.  **Secrets**: Read `YANDEX_API_KEY` from `process.env`.
4.  **Validation**: Strictly validate `modelUri` and `messages` array before forwarding.

## 2. Code Pattern (CORS)
```javascript
if (event.httpMethod === 'OPTIONS') {
  return {
    statusCode: 204,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type, Authorization'
    }
  };
}
```

## 3. Hard Constraints
- **Public Access**: Function MUST be set to "Public" in Yandex Console.
- **Timeout**: Set to `30s` to accommodate LLM latency.

## 4. File Map
- `@cloud/yandex/functions/yandexgpt-proxy/`: Source code.
