---
id: yandex-openai-proxy-for-continue-ide
title: "Yandex OpenAI Proxy for Continue IDE"
description_ru: "Yandex Cloud API models (yandexgpt, yandexgpt-lite) are accessed from Continue IDE via an OpenAI-compatible proxy in continue-wrapper (server.js). The proxy translates OpenAI chat completions format to Yandex Foundation Models API format. Key facts: (1) assistant:* models are translation-only, use yandexgpt for general-purpose chat; (2) Proxy runs on CONTINUE_WRAPPER_PORT (default 3002); (3) config.yaml uses provider:openai with apiBase pointing to local proxy; (4) GET /openai/v1/models and POST /openai/v1/chat/completions endpoints required."
scope: "Yandex Cloud API models (yandexgpt, yandexgpt-lite) are accessed from Continue IDE via an OpenAI-compatible proxy in continue-wrapper (server.js). The proxy translates OpenAI chat completions format to Yandex Foundation Models API format. Key facts: (1) assistant:* models are translation-only, use yandexgpt for general-purpose chat; (2) Proxy runs on CONTINUE_WRAPPER_PORT (default 3002); (3) config.yaml uses provider:openai with apiBase pointing to local proxy; (4) GET /openai/v1/models and POST /openai/v1/chat/completions endpoints required."
tags: [#yandex, #continue, #proxy, #openai-compat, #integration]
priority: high
created_at: 2026-02-17
updated_at: 2026-02-17
source: "mcp:propose_skill"
source_refs: ["mcp/continue-wrapper/server.js", "scripts/sync-continue-commanders.js"]
---

# Yandex OpenAI Proxy for Continue IDE

> **Context**: Continue IDE (v1.2.x) has limited native support for `provider: yandex`. To enable YandexGPT and Yandex Assistant models, a local OpenAI-compatible proxy is used.
> **SSOT**: `mcp/continue-wrapper/server.js`

## 1. Architecture

The `continue-wrapper` server (port 3002) provides an OpenAI-compatible API that translates requests to Yandex Cloud APIs.

- **General Chat**: `yandexgpt` / `yandexgpt-lite` models are routed to the Foundation Models API (`llm.api.cloud.yandex.net`).
- **Translation**: `assistant:*` models are routed to the Assistant API (`rest-assistant.api.cloud.yandex.net`).

## 2. Configuration (Continue `config.yaml`)

To use Yandex models in Continue, configure them as `provider: openai` pointing to the local proxy.

```yaml
models:
  - name: yandex-gpt
    provider: openai
    model: yandexgpt
    apiBase: http://127.0.0.1:3002/openai/v1
    apiKey: YOUR_YANDEX_API_KEY
```

## 3. Proxy Endpoints

- `GET /openai/v1/models`: Returns the list of available Yandex models for discovery.
- `POST /openai/v1/chat/completions`: Handles chat requests, converts messages to Yandex format `{role, text}`, and returns an OpenAI-compatible response.

## 4. Model Capabilities

- **YandexGPT**: General-purpose coding and chat. Supports `system` messages and `max_tokens`.
- **Yandex Assistant**: Specialized for translation. Returns empty results for general coding queries.

## 5. Troubleshooting

- **404 Not Found**: Ensure `CONTINUE_WRAPPER_PORT=3002` is set in `.env` and the server is running.
- **Empty Response**: Check if you are using an `assistant:*` model for a non-translation task. Switch to `yandexgpt`.
- **CORS Errors**: The proxy bypasses CORS restrictions when running from `file://` protocol.

## Related Skills
- [integrations-continue-mcp-setup](../integrations/integrations-continue-mcp-setup.md)
- [openrouter-404-versus-v2-fallback-mismatch](./openrouter-404-versus-v2-fallback-mismatch.md)
