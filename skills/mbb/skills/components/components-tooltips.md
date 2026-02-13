---
id: components-tooltips
title: Components: Tooltip System
scope: skills-mbb
tags: [#components, #tooltips, #ux, #i18n]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Tooltip System

> **Context**: Standardized hover hints for metrics and controls.
> **SSOT**: `core/config/tooltips-config.js`

## 1. Core Principle
Use **Native Browser Tooltips** (`title` attribute). HTML-based tooltips are forbidden to maintain performance and accessibility.

## 2. Tooltip Structure
1.  **Static Part**: Description from `tooltips-config.js`.
2.  **Separator**: Newline (`\n`).
3.  **Dynamic Part**: Interpretation from `tooltip-interpreter.js` (e.g., "High Volatility").

## 3. Usage
- **Simple**: `tooltipsConfig.getTooltip(key)`.
- **Interpreted**: `window.tooltipInterpreter.getTooltip(key, { value, lang })`.

## 4. Hard Constraints
1.  **UTF-8 Only**: No special binary characters.
2.  **Length**: Keep under 2000 characters to prevent browser truncation.
3.  **No HTML**: Direct text only.

## 5. File Map
- `@core/config/tooltips-config.js`: Dictionary.
- `@shared/utils/tooltip-interpreter.js`: Logic.
