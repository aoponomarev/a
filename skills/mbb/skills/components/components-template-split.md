---
id: components-template-split
title: Components: Template Externalization
scope: skills-mbb
tags: [#components, #templates, #x-template, #architecture]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Template Externalization

> **Context**: Moving HTML from JS files to standalone template files.
> **Mechanism**: `x-template` script tags.

## 1. Directory Structure
- `shared/templates/{name}-template.js`: Global components.
- `app/templates/{name}-template.js`: Application-specific components.

## 2. Implementation Pattern
Each template file exports a `TEMPLATE` string and registers itself in the DOM:
```javascript
export const TEMPLATE = `<div>...</div>`;
const script = document.createElement('script');
script.id = 'my-component-template';
script.type = 'text/x-template';
script.text = TEMPLATE;
document.body.appendChild(script);
```

## 3. Boot Sequence
**CRITICAL**: Templates MUST be loaded and injected into the DOM **before** Vue initializes the components that use them.

## 4. Hard Constraints
1.  **Unique IDs**: Template script IDs must match the `template` property in the Vue component definition.
2.  **No Logic**: Templates should contain only HTML and Vue directives. No complex JS.

## 5. File Map
- `@core/module-loader.js`: Handles injection order.
- `@shared/templates/`: Reusable HTML.
