---
id: process-wf-ui-v2-bootstrap
title: Process: WorkFlow UI V2 Bootstrap Enforcement
scope: skills-mbb
tags: [#ui, #bootstrap, #css, #standards]
priority: high
created_at: 2026-02-04
updated_at: 2026-02-04
---

# Process: WorkFlow UI V2 Bootstrap Enforcement

> **Context**: Ensuring 100% compliance with the "No Custom CSS" rule for WorkFlow UI V2.

## 1. Layout & Grid
- Use `.container-fluid` for full-width dashboards.
- Use `.row` and `.col-*` for all structural alignment.
- Use Flexbox utilities (`d-flex`, `justify-content-between`, `align-items-center`) for internal element positioning.

## 2. Spacing & Typography
- **Margins/Padding**: Only use `m-*`, `p-*` utilities (e.g., `mb-3`, `pe-2`).
- **Text**: Use `text-muted`, `small`, `fw-bold`, `text-truncate`.

## 3. Components
- **Tables**: Always `table table-hover table-sm`.
- **Badges**: Use `badge` with `bg-*` (primary, secondary, success, danger, warning, info, light, dark).
- **Cards**: Use `card border-0 shadow-sm`.

## 4. How to handle "missing" styles
If a design requirement isn't met by a standard Bootstrap class:
1.  **Re-evaluate the design**: Can it be achieved using a combination of existing classes (e.g., `border-start border-4 border-info`)?
2.  **Use CSS Variables**: Only via Bootstrap's own variable overrides if absolutely necessary, but **NEVER** via custom CSS selectors in V2.
3.  **Accept standard look**: Prioritize architectural simplicity over pixel-perfect custom design.

## 5. Standard Component Exceptions
1.  **`.table-v2`**: Encapsulates first/last column anchoring, centered middle columns, and muted headers. This is the ONLY allowed custom CSS class for structural elements in V2 to ensure 50/50 split and centering logic.
