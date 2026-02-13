---
id: integrations-ai-core
title: Integrations: AI Provider Architecture
scope: skills-mbb
tags: [#integrations, #ai, #providers, #abstraction]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Integrations: AI Provider Architecture

> **Context**: Abstraction layer for LLM providers (Yandex, Perplexity, etc.).
> **SSOT**: `core/api/ai-provider-manager.js`

## 1. Architecture
- **Base Class**: `BaseAIProvider` defines the `prompt()` and `translate()` interface.
- **Implementations**: `YandexProvider`, `PerplexityProvider`.
- **Manager**: Singleton handling provider switching and key management.

## 2. Switching Logic
- **Active Provider**: Stored in `CacheManager` (`ai-provider`).
- **Keys**: Stored in `localStorage` (`yandex-api-key`, etc.).
- **Models**: Configured per provider in `app-config.js`.

## 3. Key Rules
1.  **Normalization**: All provider responses must be parsed into a standard internal format.
2.  **No Direct Calls**: Components must use `aiProviderManager.prompt()`.
3.  **CORS Bypass**: All cloud AI calls MUST go through the `Cloudflare Proxy`.

## 4. File Map
- `@core/api/ai-provider-manager.js`: The Switcher.
- `@core/api/ai-providers/`: Provider implementations.
