---
id: integrations-perplexity-connect
title: Integrations: Perplexity AI
scope: skills-mbb
tags: [#integrations, #ai, #perplexity, #search]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Integrations: Perplexity AI

> **Context**: Using Perplexity for real-time web search and news analysis.

## 1. Role
Perplexity serves as the secondary AI provider and the primary engine for tasks requiring up-to-date market sentiment.

## 2. Configuration
- **API**: OpenAI-compatible Chat Completions.
- **Endpoint**: `https://api.perplexity.ai/chat/completions`.
- **Model**: `sonar-pro` (Default).

## 3. Workflow
1.  **Key**: User enters key in **Settings -> AI API**.
2.  **Storage**: Key stored in `localStorage` (`perplexity-api-key`).
3.  **Request**: `aiProviderManager.sendRequest()` routes to Perplexity if selected.

## 4. Hard Constraints
1.  **Rate Limits**: Respect Perplexity's tier-based limits.
2.  **Privacy**: Do not send sensitive user portfolio data to Perplexity; use it for public market analysis only.

## 5. File Map
- `@core/api/ai-providers/perplexity-provider.js`: Adapter.
- `@core/config/app-config.js`: Model list.
