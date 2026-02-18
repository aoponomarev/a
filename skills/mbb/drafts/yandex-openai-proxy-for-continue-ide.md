---
id: yandex-openai-proxy-for-continue-ide
title: Yandex OpenAI Proxy for Continue IDE
description_ru: YandexGPT подключен к Continue IDE через OpenAI-совместимый прокси в continue-wrapper. Критично - прокси ОБЯЗАН поддерживать SSE streaming, иначе Continue молча игнорирует ответ. Только модель yandexgpt используется (lite и assistant отключены как бесполезные).
scope: YandexGPT model is accessed from Continue IDE via an OpenAI-compatible SSE streaming proxy in continue-wrapper (server.js). Critical requirement - proxy MUST support SSE streaming (text/event-stream) because Continue always sends stream:true and silently discards non-streaming JSON responses. Only yandexgpt model is enabled (lite and assistant removed as not useful in Continue context).
tags: [yandex, continue, proxy, openai-compat, integration, streaming, sse]
priority: high
created_at: 2026-02-17
updated_at: 2026-02-17
source: mcp:propose_skill
source_refs: [mcp/continue-wrapper/server.js, scripts/sync-continue-commanders.js]
---

# Yandex OpenAI Proxy for Continue IDE

> **Context**: Continue IDE has no native `provider: yandex`. YandexGPT is accessed via a local OpenAI-compatible proxy with **SSE streaming**.
> **SSOT**: `mcp/continue-wrapper/server.js`

## 1. Architecture

The `continue-wrapper` server (port 3002) provides an OpenAI-compatible API that translates requests to Yandex Foundation Models API (`llm.api.cloud.yandex.net`).

**Only `yandexgpt` is used** — `yandexgpt-lite` and `assistant:*` models are removed from Continue config (too limited for coding IDE context).

## 2. Critical: SSE Streaming Requirement

**Continue IDE always sends `stream: true`**. If the proxy returns a regular JSON response instead of SSE chunks, Continue **silently discards** the response. The user sees only the "Agent rule" messages from config but no model output.

The proxy MUST:
1. Detect `stream: true` in the request body
2. Set Yandex API `completionOptions.stream: true`
3. Parse Yandex NDJSON streaming chunks (cumulative text)
4. Compute deltas and emit OpenAI SSE format: `data: {json}\n\n`
5. End with `data: [DONE]\n\n`

### Yandex Streaming Format
Yandex returns NDJSON where each line is a complete JSON with **cumulative text**:
```json
{"result":{"alternatives":[{"message":{"role":"assistant","text":"Hello"},"status":"ALTERNATIVE_STATUS_PARTIAL"}],...}}
{"result":{"alternatives":[{"message":{"role":"assistant","text":"Hello! How are you?"},"status":"ALTERNATIVE_STATUS_FINAL"}],...}}
```

The proxy computes deltas: first chunk emits "Hello", second emits "! How are you?".

### OpenAI SSE Output Format
```
data: {"id":"chatcmpl-xxx","object":"chat.completion.chunk","created":...,"model":"yandexgpt","choices":[{"index":0,"delta":{"role":"assistant","content":"Hello"},"finish_reason":null}]}

data: {"id":"chatcmpl-xxx","object":"chat.completion.chunk","created":...,"model":"yandexgpt","choices":[{"index":0,"delta":{"role":"assistant","content":"! How are you?"},"finish_reason":"stop"}]}

data: [DONE]
```

## 3. Configuration (Continue `config.yaml`)

```yaml
models:
  - name: yandex-gpt
    provider: openai
    model: yandexgpt
    apiBase: http://127.0.0.1:3002/openai/v1
    apiKey: YOUR_YANDEX_API_KEY
    roles:
      - chat
      - edit
```

## 4. Proxy Endpoints

- `GET /openai/v1/models` — Returns available models (only `yandexgpt`).
- `POST /openai/v1/chat/completions` — Chat handler with dual mode:
  - `stream: true` → SSE streaming (required by Continue)
  - `stream: false` → Regular JSON response (for curl/testing)

## 5. Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| Only "Agent rule" shown, no output | Proxy returns non-streaming JSON | Ensure SSE streaming is implemented |
| 404 Not Found | Server not running on port 3002 | Check `CONTINUE_WRAPPER_PORT=3002` in `.env`, restart server |
| Empty response in curl | YANDEX_API_KEY not set | Set in `.env` |
| CORS preflight fails | Missing Authorization header | Ensure `Access-Control-Allow-Headers` includes `Authorization` |

## 6. Limitations

- YandexGPT is significantly weaker than GPT-4/Claude for coding tasks
- Response quality is best with clear, direct prompts (Russian or English)
- `yandexgpt-lite` and `assistant:*` models removed — too limited for IDE use

## Related Skills
- [openrouter-404-versus-v2-fallback-mismatch](./openrouter-404-versus-v2-fallback-mismatch.md)
