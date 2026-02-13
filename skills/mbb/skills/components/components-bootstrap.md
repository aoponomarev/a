---
id: components-bootstrap
title: Components: Bootstrap Integration
scope: skills-mbb
tags: [#components, #bootstrap, #ui, #compatibility]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Bootstrap Integration

> **Context**: Ensuring Vue components work seamlessly with Bootstrap 5 JS and CSS.
> **SSOT**: `shared/components/`

## 1. Integration Rules
1.  **JS API**: Initialize via native API (`new bootstrap.Modal(el)`).
2.  **Events**: Listen to native events (`shown.bs.modal`).
3.  **Lifecycle**: Call `.dispose()` in `beforeUnmount()` to prevent memory leaks.
4.  **Data Attrs**: Preserve `data-bs-*` attributes for native functionality.

## 2. Styling Constraints
- **No Custom CSS**: Use Bootstrap utility classes (`d-flex`, `p-2`) first.
- **Themes**: Use CSS variables (`--bs-body-bg`) for automatic Light/Dark mode support.
- **No Inline Styles**: Forbidden unless dynamically calculated (e.g., progress bars).

## 3. API Access
Components should expose the Bootstrap instance via a method:
```javascript
getBootstrapInstance() { return this.bsInstance; }
```

## 4. File Map
- `@shared/components/modal.js`: Implementation example.
- `@shared/components/dropdown.js`: Implementation example.
