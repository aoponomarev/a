---
id: integrations-llm-providers-config
title: Integrations: LLM Provider Setup
scope: skills-mbb
tags: [#integrations, #llm, #continue, #ssot]
priority: high
created_at: 2026-01-30
updated_at: 2026-02-01
---

# Integrations: LLM Provider Setup

> **Context**: Proven patterns for connecting external LLM APIs to Continue.

## 1. OpenAI Compatibility
**Rule**: Always use `provider: openai` for external APIs (OpenRouter, SiliconFlow, Groq). This is the most stable protocol in Continue.

## 2. Provider Specifics

### OpenRouter
- **Model IDs**: Use the exact slug from the OpenRouter URL (e.g., `deepseek/deepseek-r1`).
- **Gotcha**: Some models fail with `:free` suffix. Try the base name first.

### Groq (High Speed)
- **Role**: Best for daily coding and quick refactors.
- **Limit**: Free tier has low TPM (Tokens Per Minute). Use 70B models for larger contexts.

## 3. Configuration SSOT
- **Primary**: `${CONTINUE_HOME}/config.yaml`.
- **Sync**: Changes in `config.yaml` MUST be reflected in `logs/llm-models-registry.md`.

## 4. Hard Constraints
1.  **No `config.ts`**: Delete `config.ts` if it exists; it overrides `config.yaml` and causes confusion.
2.  **Explicit Keys**: Continue does NOT support env var interpolation in `config.yaml`. Keys must be hardcoded there (but the file is gitignored).

## 5. File Map
- `@.continue/config.yaml`: Active config.
- `@logs/llm-models-registry.md`: Human-readable registry.
