---
id: components-class-manager
title: Components: Class Manager
scope: skills-mbb
tags: [#components, #css, #classes, #utility]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Class Manager

> **Context**: Logic for merging, adding, and removing CSS classes in components.
> **SSOT**: `shared/utils/class-manager.js`

## 1. Mechanism
Helper `window.classManager.processClassesToString(base, add, remove)` handles the logic.

## 2. Props API
All components accept:
- **`classesAdd`** `{Object}`: Classes to append.
- **`classesRemove`** `{Object}`: Classes to strip.

## 3. Element Keys
Keys map to internal DOM nodes:
- `root`: Main container.
- `icon`: Icon element.
- `label`: Text element.
- `button`: Inner button (if wrapper).
- `menu`: Dropdown menu container.

## 4. Usage Example
```javascript
// Component Logic
const classes = computed(() => classManager.processClassesToString(
  { root: ['btn', 'btn-primary'] },
  props.classesAdd,
  props.classesRemove
));
```

## 5. Hard Constraints
1.  **No String Concatenation**: Do not manually build class strings. Use the helper.
2.  **Fixed Keys**: Component MUST define valid keys in docblock.

## 6. File Map
- `@shared/utils/class-manager.js`: Utility implementation.
