---
id: workspace-config
title: Core: Workspace Configuration
scope: skills-mbb
tags: [#core, #config, #workspace, #ui]
priority: medium
created_at: 2026-01-25
updated_at: 2026-02-01
---

# Core: Workspace Configuration

> **Context**: Centralized settings for the application layout and behavior.
> **SSOT**: `core/config/workspace-config.js`

## 1. Scope
Manages UI-specific constants that don't belong in business logic:
- Default tabs.
- Grid layouts.
- Feature visibility flags.
- Chart defaults.

## 2. Key Rules
1.  **Single Source**: All components MUST read workspace settings from this config.
2.  **Reactivity**: Use `workspaceConfig` getter within Vue computed properties.

## 3. Workflow
1.  Define new setting in `workspace-config.js`.
2.  Provide a sensible default.
3.  Import and use in `app-ui-root.js` or components.

## 4. File Map
- `@core/config/workspace-config.js`: The Source.
