---
id: ux-principles
title: UX: Design Principles
scope: skills-mbb
tags: [#ux, #principles, #consistency]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# UX: Design Principles

> **Context**: Rules for consistent user experience.

## 1. Consistency
- **Titles**: Modal title MUST match the button that opened it.
- **Colors**: Green = Profit/Success, Red = Loss/Danger, Grey = Neutral.
- **Feedback**: Every action (Save, Delete) implies a System Message (Toast).

## 2. Interaction
- **Non-Blocking**: Async operations show a spinner, not a frozen UI.
- **Reversible**: Critical actions (Delete) require confirmation.

## 3. SSOT
- **Titles**: `modalsConfig.getModalTitle(id)`.
- **Messages**: `messagesConfig.get(key)`.

## 4. File Map
- `@core/config/modals-config.js`: Modal metadata.
