---
id: components-layout-alignment
title: Components: Layout & Alignment
scope: skills-mbb
tags: [#components, #layout, #css, #alignment]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Layout & Alignment

> **Context**: Ensuring consistent height and spacing across the UI.

## 1. Vertical Alignment
- **Rule**: Use vertical padding on the **inner container** based on the size class.
- **Implementation**: `.component-responsive.size-sm > .inner-container`.
- **Avoid**: Fixed `height` or `line-height` for alignment.

## 2. Horizontal Spacing
- **Rule**: Use Bootstrap utility classes (`me-2`, `gap-3`).
- **Standard**: `gap-2` for button groups, `mb-3` for form fields.

## 3. Sizing
- **sm**: Compact (Tables, Sidebars).
- **md**: Default (Forms, Modals).
- **lg**: Prominent (Hero sections).

## 4. File Map
- `@styles/wrappers/`: Component-specific layout overrides.
- `@shared/components/button.js`: Sizing implementation.
