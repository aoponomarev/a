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

## Scope

Yandex Cloud API models (yandexgpt, yandexgpt-lite) are accessed from Continue IDE via an OpenAI-compatible proxy in continue-wrapper (server.js). The proxy translates OpenAI chat completions format to Yandex Foundation Models API format. Key facts: (1) assistant:* models are translation-only, use yandexgpt for general-purpose chat; (2) Proxy runs on CONTINUE_WRAPPER_PORT (default 3002); (3) config.yaml uses provider:openai with apiBase pointing to local proxy; (4) GET /openai/v1/models and POST /openai/v1/chat/completions endpoints required.

## Sources
- mcp/continue-wrapper/server.js
- scripts/sync-continue-commanders.js
