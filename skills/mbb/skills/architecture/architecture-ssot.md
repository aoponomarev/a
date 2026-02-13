---
id: architecture-ssot
title: Architecture: Single Source of Truth (SSOT)
scope: skills-mbb
tags: [#architecture, #ssot, #еип, #config]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Architecture: Single Source of Truth (SSOT)

> **Context**: Data normalization and configuration centralization.
> **Command**: `ЕИП` (Verify SSOT).

## 1. Core Principle
**No Duplication**: If a value (text, config, setting) appears in two places, it must be extracted to a single source.

## 2. Configuration Hubs
- `core/config/app-config.js`: API, Limits, Feature Flags.
- `core/config/messages-config.js`: System Messages, Error Codes.
- `core/config/modals-config.js`: Modal Titles, Icons.
- `core/config/tooltips-config.js`: Localization (RU/EN).
- `core/cache/cache-config.js`: TTL, Keys.

## 3. Rules of Engagement
1.  **Getters**: Use accessor functions (`getConfig('key')`), not direct object access.
2.  **Localization**: All UI text MUST come from `tooltips-config.js`. No hardcoded strings in templates.
3.  **Shared Components**: Reusable UI logic lives in `shared/components/`.

## 4. Hard Constraints
1.  **Don't Repeat Yourself (DRY)**: Violations of SSOT are treated as architectural bugs.
2.  **Reactive Config**: Changing a value in SSOT must update the UI immediately (Vue Reactivity).

## 5. File Map
- `@core/config/`: Configuration directory.
- `@shared/components/`: Reusable UI.
