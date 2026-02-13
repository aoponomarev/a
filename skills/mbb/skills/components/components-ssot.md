---
id: components-ssot
title: Components: Single Source of Truth
scope: skills-mbb
tags: [#components, #ssot, #dry, #config]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Single Source of Truth

> **Context**: Centralizing repeated UI patterns and data.

## 1. Core Rule
If a UI element (label, icon, logic) repeats in **2 or more** places, it MUST be extracted to SSOT.

## 2. Extraction Targets
- **Titles/Icons**: `core/config/modals-config.js`.
- **API Endpoints**: `core/config/app-config.js`.
- **Cache Rules**: `core/cache/cache-config.js`.
- **UI Text**: `core/config/tooltips-config.js`.

## 3. Decision Matrix
| Scenario | Action |
| :--- | :--- |
| Repeated HTML | Create a `shared/component`. |
| Repeated Options | Create a `core/config` file. |
| Repeated Logic | Create a `shared/utility`. |

## 4. File Map
- `@core/config/`: Configuration hub.
- `@shared/components/`: Reusable UI hub.
