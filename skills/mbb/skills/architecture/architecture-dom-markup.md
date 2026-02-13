---
id: architecture-dom-markup
title: Architecture: DOM Markup & Hashing
scope: skills-mbb
tags: [#architecture, #dom, #css, #hashing]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Architecture: DOM Markup & Hashing

> **Context**: Automated identification of DOM elements for debugging, styling, and AI context awareness.
> **SSOT**: `shared/utils/auto-markup.js`

## 1. Automated Container Markup
**Goal**: Mark significant containers with `avto-{hash}` for DevTools navigation and Agent visibility.

- **Format**: `avto-{Base58_8char}` (e.g., `avto-Xy7z9A2b`).
- **Logic**: Deterministic hash based on DOM path. Stable across reloads.
- **Scope**: Major sections, headers, wrappers.
- **Exclusion**: Inside Vue components, minor wrappers, elements with IDs.

## 2. Component Instance Hashing
**Goal**: Unique ID for Vue component instances to enable scoped styling without SFC.

- **Implementation**: `computed: { instanceHash }`.
- **Generator**: `shared/utils/hash-generator.js`.
- **Usage**: `<div :class="['my-component', instanceHash]">`.

## 3. Layout Synchronization
**Goal**: Auto-adjust `body` padding to match fixed Header/Footer height.

- **Implementation**: `shared/utils/layout-sync.js`.
- **Mechanism**: `ResizeObserver` + `MutationObserver`.
- **API**: `window.layoutSync.start()`, `.stop()`, `.update()`.

## 4. Hard Constraints
1.  **No CSS Dependency**: Classes `avto-*` are for identification ONLY. Do not bind functional CSS to them.
2.  **Deterministic**: Hashing algorithm must produce the same hash for the same DOM structure.

## 5. File Map
- `@shared/utils/auto-markup.js`: DOM Observer.
- `@shared/utils/hash-generator.js`: Hashing logic.
- `@shared/utils/layout-sync.js`: Layout engine.
