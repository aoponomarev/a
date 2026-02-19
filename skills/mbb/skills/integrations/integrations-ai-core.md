---
id: integrations-ai-core
title: Integrations AI Provider Architecture
scope: skills-mbb
tags: [#integrations, #ai, #providers, #abstraction]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-19
---

# Integrations: AI Provider Architecture

> **Context**: Abstraction layer for LLM providers (Yandex, Perplexity, etc.).
> **SSOT**: `core/api/ai-provider-manager.js`

## 1. Architecture
- **Base Class**: `BaseAIProvider` defines the contract: `sendRequest(apiKey, model, messages, options)`, `getDefaultModel()`, `getAvailableModels()`, `getName()`, `getDisplayName()`.
- **Implementations**: `YandexProvider` (default), `PerplexityProvider`.
- **Manager**: `AIProviderManager` singleton — provider switching, key management, KV fallback.

## 2. Switching Logic
- **Active Provider**: Stored in `cacheManager` (key `'ai-provider'`).
- **Keys**: Primary storage in `cacheManager` (`'yandex-api-key'`, `'perplexity-api-key'`). On miss, auto-restored from **Cloudflare KV** via `/api/settings`.
- **Models**: Stored in `cacheManager` (`'yandex-model'`, `'perplexity-model'`), with defaults from `provider.getDefaultModel()`.

## 3. Key Recovery (Cloudflare KV Fallback)
When `getApiKey(providerName)` finds no key in local cache:
1. Calls `resolveSettingsToken()` — first checks `localStorage('mbb_github_token')`, then bootstraps from `http://127.0.0.1:3002/api/infra/bootstrap/github-token`.
2. Fetches all settings from `https://mbb-api.ponomarev-ux.workers.dev/api/settings` with the resolved token.
3. Saves recovered keys/settings to `cacheManager` so subsequent calls are instant.

## 4. Key Rules
1. **No Direct Calls**: Components must use `aiProviderManager.sendRequest(messages)`.
2. **CORS Bypass**: All cloud AI calls MUST go through the Cloudflare Proxy (Yandex via Cloud Function, Perplexity via Worker).
3. **Timing**: Components that depend on API keys at startup must wait for key availability (polling pattern, see `app-footer.js`).

## 5. File Map
- `@core/api/ai-provider-manager.js`: The Manager (switching + key recovery).
- `@core/api/ai-providers/base-provider.js`: Abstract interface.
- `@core/api/ai-providers/yandex-provider.js`: Yandex implementation.
- `@core/api/ai-providers/perplexity-provider.js`: Perplexity implementation.
- `@app/components/ai-api-settings.js`: UI for managing provider settings.
