---
id: components-modal-buttons
title: Components: Modal Action Manager
scope: skills-mbb
tags: [#components, #modals, #ui, #api]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Modal Action Manager

> **Context**: Unified API for managing buttons in `cmp-modal`.
> **SSOT**: `shared/components/modal.js`

## 1. Architecture
`cmp-modal` provides `modalApi` via `provide/inject`. Buttons register themselves to appear in the Header or Footer.

## 2. API Methods
- `registerButton(id, config)`: Add a button.
- `updateButton(id, updates)`: Change label, icon, or loading state.
- `removeButton(id)`: Cleanup.

## 3. Standard Layout
- **Cancel**: Footer, left-aligned (`me-auto`).
- **Save/Action**: Footer, right-aligned.
- **Close**: Header, right-aligned (default).

## 4. Hard Constraints
1.  **Cleanup**: Buttons MUST be removed in `beforeUnmount()`.
2.  **Safety**: Always check if `modalApi` exists before calling (optional injection).

## 5. File Map
- `@shared/components/modal.js`: The Provider.
- `@shared/components/modal-buttons.js`: The Consumer.
