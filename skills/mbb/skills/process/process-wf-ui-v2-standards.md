---
id: process-wf-ui-v2-standards
title: Process: WorkFlow UI V2 Standards
scope: skills-mbb
tags: [#architecture, #ui, #v2, #standards]
priority: high
created_at: 2026-02-04
updated_at: 2026-02-04
---

# Process: WorkFlow UI V2 Standards

> **Context**: Rules for building and maintaining the V2 user interface for MBB Orchestrator.
> **SSOT**: `WF_UI_V2_MANIFEST.md`

## 1. Interaction Protocol
1.  **Read-Only by Default**: The UI fetches data from `/api/v2/*` endpoints.
2.  **Action -> Webhook**: Every button click MUST trigger an external webhook (n8n v2 workflow), not a local function.
3.  **No Logic**: If you find yourself writing `if (data.status === 'X') { doSomethingComplex() }` in the UI, move that logic to n8n.

## 2. Component Templating
Use standard HTML5 templates to ensure consistency.

```html
<!-- Example of V2 Row Template -->
<template id="tpl-source-row">
  <tr class="align-middle">
    <td class="fw-semibold text-primary"></td> <!-- Name -->
    <td><span class="badge bg-secondary"></span></td> <!-- Type -->
    <td><span class="badge rounded-pill"></span></td> <!-- Priority -->
    <td class="text-muted small"></td> <!-- Status -->
  </tr>
</template>
```

## 3. Data Flow
- **Orchestrator (n8n)**: Prepares the data, applies filters, determines UI colors (via class names in JSON if needed).
- **UI (Face)**: Clones templates and injects strings.

## 4. Forbidden Patterns
- **NO** inline styles `style="..."`.
- **NO** custom CSS files.
- **NO** browser-side sorting of large datasets.
- **NO** direct file system writes from UI JS.
