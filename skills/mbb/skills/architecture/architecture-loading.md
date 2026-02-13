---
id: architecture-loading
title: Architecture: Loading Strategy
scope: skills-mbb
tags: [#architecture, #loading, #modules, #vue]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Architecture: Loading Strategy

> **Context**: Boot sequence, dependency management, and template injection.
> **SSOT**: `core/module-loader.js`, `core/modules-config.js`

## 1. Critical Boot Sequence
**Invariant**: `x-template` scripts MUST be in DOM **before** Vue initialization.

1.  **Bootstrap JS**: Layout foundations.
2.  **Templates**: `<script type="text/x-template">` injection.
3.  **Vue.js**: Core framework.
4.  **Components**: Registration of global components.
5.  **App Root**: `app-ui-root.js` mount.

## 2. Module Loader System
**Goal**: Async loading with dependency resolution (DAG).

- **Algorithm**: Topological sort (Kahn's algorithm).
- **Features**: Cycle detection, `file://` & `http://` support.
- **Error Handling**: Critical modules halt boot; optional modules log warning.

## 3. Component Boundaries
- **Mount Point**: All Vue components live inside `#app`.
- **Splash Screen**: Blocks interaction until `App` is mounted and `modules-config` is resolved.

## 4. Hard Constraints
1.  **No NPM**: Modules are loaded via native `<script>` injection, not Webpack bundling.
2.  **Strict Order**: Templates -> Vue -> Components -> App. Violation results in "Component not found".

## 5. File Map
- `@core/module-loader.js`: The Engine.
- `@core/modules-config.js`: Dependency Graph.
- `@index.html`: Entry point.
