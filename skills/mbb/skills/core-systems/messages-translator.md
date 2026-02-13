---
id: messages-translator
title: Core: Message Translation (i18n)
scope: skills-mbb
tags: [#core, #messages, #i18n, #translation]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Core: Message Translation (i18n)

> **Context**: Dynamic translation of system messages using AI or local cache.
> **SSOT**: `core/api/messages-translator.js`

## 1. Translation Format
Messages are stored/transmitted as: `KEY|TEXT|DETAILS`.

## 2. Storage
- **Cache**: `localStorage` key `tr-{lang}`.
- **Structure**: Array `[text, details]`.

## 3. Workflow
1.  **Init**: `messagesTranslator.init(lang)` loads cache.
2.  **Request**: If key missing in cache, request translation from active AI Provider.
3.  **Parse**: Extract text and details from AI response.
4.  **Update**: `updateDisplayedMessages()` triggers Vue reactivity to refresh UI.

## 4. Hard Constraints
1.  **Placeholders**: AI MUST NOT translate or modify `{name}` or `{value}` placeholders.
2.  **Async**: Translation is non-blocking; UI shows "Translating..." or default text.

## 5. File Map
- `@core/api/messages-translator.js`: Logic.
- `@core/config/tooltips-config.js`: Fallback source.
