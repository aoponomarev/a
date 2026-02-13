---
id: messages-ui-and-lifecycle
title: Core Systems: Messages UI & Lifecycle
scope: skills-mbb
tags: [#core-systems, #messages, #ui, #lifecycle]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Core Systems: Messages UI & Lifecycle

> **Context**: Global system for displaying notifications, errors, and status updates.
> **SSOT**: `core/utils/messages-store.js` (AppMessages)

## 1. Lifecycle
1.  **Creation**: `messagesConfig.get(key, params)` -> Raw Message Object.
2.  **Dispatch**: `AppMessages.push({ ...msg, scope: 'global' })`.
3.  **Translation**: Async translation via `messagesTranslator` (if needed).
4.  **Display**: Reactive list rendered by `cmp-system-messages`.
5.  **Removal**: Auto-dismiss (TTL) or manual close.

## 2. Hard Constraints
1.  **Key Preservation**: Every message object MUST retain its `key` property. This allows re-translation if the user switches language while the message is visible.
2.  **Spread Operator**: When modifying messages, use `{ ...msg }` to preserve internal properties (id, timestamp).
3.  **Local Registration**: `cmp-system-message` is registered locally within `cmp-system-messages`, not globally.

## 3. UI Component Structure
- **`cmp-system-messages`**: Container/List. Handles positioning (Top-Right/Center).
- **`cmp-system-message`**: Individual Item. Handles animations and styling.

## 4. File Map
- `@core/utils/messages-store.js`: Reactive Store.
- `@shared/components/system-messages.js`: List Component.
- `@shared/components/system-message.js`: Item Component.
