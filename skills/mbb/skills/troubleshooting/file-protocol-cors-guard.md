---
id: file-protocol-cors-guard
title: Guard: file:// + CORS for AI providers
scope: skills-mbb
tags: [#troubleshooting, #cors, #file-protocol, #yandex, #ai]
priority: high
created_at: 2026-02-10
updated_at: 2026-02-10
---

# Guard: file:// + CORS for AI providers

> **Context**: MBB often runs from local `index.html` (`origin = null`, protocol `file:`).  
> In this mode, direct browser requests to many external AI APIs are blocked by CORS preflight.

## 1. Non-negotiable rule

Before **any** direct `fetch()` to external AI endpoints, check runtime origin:

- if `window.location.protocol === 'file:'`: do **not** call CORS-restricted endpoint directly from browser;
- use proxy/server route or safe fallback model immediately.

## 2. Symptoms pattern

Classic console signature:

- `Access to fetch ... has been blocked by CORS policy`
- `No 'Access-Control-Allow-Origin' header`
- `net::ERR_FAILED`

If UI keeps working only after fallback, but console is noisy, root cause is usually:  
**direct call is attempted first, fallback second**.

## 3. Canonical fix pattern

1. Detect `file:` mode at provider entrypoint.
2. For models/endpoints known to be CORS-blocked:
   - skip direct call;
   - route through proxy (preferred) or
   - fallback to a foundation model that already works through proxy.
3. Keep rendering path resilient (never return empty data just because assistant endpoint is blocked).

## 4. Yandex-specific recipe (current MBB)

- Assistant API endpoint: `https://rest-assistant.api.cloud.yandex.net/v1/responses`
- In `file://` mode: skip direct assistant fetch.
- Use foundation fallback (`gpt://.../yandexgpt/latest`) through existing proxy path.

## 5. PR / code-review checklist

- [ ] Added explicit `file://` guard before direct external fetch.
- [ ] Verified fallback/proxy path returns valid text for UI.
- [ ] Confirmed no CORS `ERR_FAILED` spam in console.
- [ ] Confirmed footer/news block still renders.

