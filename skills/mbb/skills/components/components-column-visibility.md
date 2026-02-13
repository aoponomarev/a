---
id: components-column-visibility
title: Components: CSS-Driven Column Visibility
scope: skills-mbb
tags: [#components, #css, #tables, #performance]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: CSS-Driven Column Visibility

> **Context**: Toggling table columns without re-rendering the DOM.
> **SSOT**: `styles/table-columns.css`

## 1. Architecture
- **State**: `columnVisibilityConfig` in `app-ui-root.js`.
- **Mixin**: `column-visibility-mixin.js` computes classes based on active tab.
- **Application**: Classes applied to `<col>`, `<th>`, and `<td>`.

## 2. Logic
Visibility is controlled via `display: none` in CSS, triggered by a parent class on the table or body.
**Benefit**: Instant switching, preserves scroll position.

## 3. Edge Case: Bootstrap Radio Buttons
Native `@change` on `<input class="btn-check">` fails in Vue when the input is hidden.
**Fix**: Bind `@click` to the `<label>` to trigger the change manually.

## 4. File Map
- `@shared/utils/column-visibility-mixin.js`: Logic.
- `@styles/table-columns.css`: Visibility rules.
