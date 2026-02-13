---
id: yandex-cors-troubleshooting
title: Troubleshooting: Yandex CORS
scope: skills-mbb
tags: [#troubleshooting, #yandex, #cors, #functions, #file-protocol]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-10
---

# Troubleshooting: Yandex CORS

> **Context**: "Preflight request failed" errors.

## 1. Checklist
1.  **Public**: Function must be Public (invoke permission for `allUsers` or handled via Gateway).
2.  **OPTIONS**: Code MUST handle `httpMethod === 'OPTIONS'` and return 200 with headers.
3.  **Headers**:
    - `Access-Control-Allow-Origin: *`
    - `Access-Control-Allow-Headers: Content-Type, Authorization`

## 2. Debug
Use `curl` to test preflight:
```bash
curl -X OPTIONS https://.../func -i
```

## 3. Critical MBB note: file:// mode

MBB frequently runs from `index.html` directly (`file://`, `origin = null`).
In this mode, direct browser calls to many cloud AI endpoints are expected to fail with CORS.

Mandatory behavior for providers:

1. Detect `window.location.protocol === 'file:'` before direct external fetch.
2. Skip CORS-restricted direct call.
3. Use proxy/server endpoint, or safe fallback model, so UI rendering does not break.

Related recipe: `file-protocol-cors-guard`.
