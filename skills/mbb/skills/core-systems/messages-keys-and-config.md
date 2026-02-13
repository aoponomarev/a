---
id: messages-keys-and-config
title: Core: Message Keys & Config
scope: skills-mbb
tags: [#core, #messages, #config, #standards]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Core: Message Keys & Config

> **Context**: Standardized keys for system notifications and errors.
> **SSOT**: `core/config/messages-config.js`

## 1. Key Format (v2)
Use short, dot-notated prefixes for functional areas:
- `e.*`: Errors.
- `i.*`: Info.
- `h.*`: Health/Status.
- `v.*`: Validation.
- `ai.*`: AI/LLM events.

## 2. Message Types
Defined in the config object, not the key:
- `d`: Danger/Error.
- `w`: Warning.
- `i`: Info.
- `s`: Success.

## 3. Legacy Support
`LEGACY_KEY_MAP` handles translation from old long-form keys to v2 format during the transition period.

## 4. Workflow
1.  Add key to `messages-config.js`.
2.  Assign `type` and default RU/EN text.
3.  Access via `messagesConfig.get(key, params)`.

## 5. File Map
- `@core/config/messages-config.js`: The Registry.
