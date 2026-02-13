---
id: components-responsive-visibility
title: Components: Responsive Visibility
scope: skills-mbb
tags: [#components, #responsive, #mobile, #css]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Responsive Visibility

> **Context**: Mobile-first adaptation strategy.
> **Breakpoint**: `576px` (Bootstrap `sm`).

## 1. Logic
Visibility is controlled via **CSS**, not JS. Components render all elements, CSS hides them based on viewport.

## 2. Classes
- `.label`: Visible on desktop.
- `.label-short`: Visible on mobile.
- `.icon`: Always visible (usually).

## 3. Implementation
```css
/* Mobile (Default) */
.label { display: none; }
.label-short { display: block; }

/* Desktop */
@media (min-width: 576px) {
  .label { display: block; }
  .label-short { display: none; }
}
```

## 4. Component Props
- `label`: Full text (Desktop).
- `labelShort`: Abbreviated text (Mobile).
- `icon`: Visual indicator.

## 5. File Map
- `@styles/wrappers/button.css`: Button responsiveness.
- `@shared/components/button.js`: Component logic.
