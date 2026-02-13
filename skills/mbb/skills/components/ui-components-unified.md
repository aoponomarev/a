---
id: ui-components-unified
title: Components: Unified Library (Shared)
scope: skills-mbb
tags: [#components, #ui, #shared, #library]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Unified Library (Shared)

> **Context**: The standard UI building blocks.
> **SSOT**: `shared/components/`

## 1. Generic Components (`cmp-*`)
Reusable, logic-agnostic elements.

- **`cmp-button`**: Universal button. Supports icons, loading state, variants.
- **`cmp-dropdown`**: Bootstrap dropdown wrapper.
- **`cmp-combobox`**: Select with search.
- **`cmp-modal`**: Dialog window shell.
- **`cmp-modal-buttons`**: Standard Footer actions (Save/Cancel).
- **`cmp-timezone-selector`**: Timezone picker.

## 2. App Components (`app-*`)
Application-specific layout.

- **`app-header`**: Navigation, Theme Toggle, Auth.
- **`app-sidebar`**: Main menu.
- **`app-footer`**: Status info.

## 3. API Standard
All components MUST document in file header:
- `props`: Input data.
- `emits`: Events.
- `slots`: Content injection.
- `expose`: Public methods (if any).

## 4. File Map
- `@shared/components/`: Source code.
- `@shared/templates/`: HTML structures.
