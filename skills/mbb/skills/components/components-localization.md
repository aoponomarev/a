---
id: components-localization
title: Components: Localization
scope: skills-mbb
tags: [#components, #localization, #i18n, #text]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Localization

> **Context**: Reactive text switching (RU/EN).
> **SSOT**: `core/config/tooltips-config.js`

## 1. Architecture
- **State**: `uiState.tooltips.currentLanguage` (Reactive).
- **Source**: `tooltips-config.js` (Dictionary).
- **Access**: `tooltipsConfig.getTooltip(key)`.

## 2. Rules
1.  **Computed Dependency**: Always reference `currentLanguage` in computed properties to trigger reactivity.
    ```javascript
    const label = computed(() => {
      const lang = uiState.tooltips.currentLanguage; // Dependency
      return tooltipsConfig.getTooltip('ui.save');
    });
    ```
2.  **No Hardcode**: Templates MUST NOT contain text literals.
3.  **Symmetry**: Adding a key requires both `ru` and `en` values.

## 3. File Map
- `@core/config/tooltips-config.js`: Dictionary.
- `@core/state/ui-state.js`: Language state.
