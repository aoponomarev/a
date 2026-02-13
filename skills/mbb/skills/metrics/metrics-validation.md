---
id: metrics-validation
title: Metrics: Validation
scope: skills-mbb
tags: [#metrics, #validation, #schema]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Metrics: Validation

> **Context**: Ensuring data integrity before calculation.
> **SSOT**: `core/validation/`

## 1. Layers
1.  **Schema**: `validator.js` checks JSON structure (types, required fields).
2.  **Math**: `math-validation.js` checks value ranges (e.g., price > 0, percent within 0-100).
3.  **Sanity**: `normalizer.js` fixes common errors (string to float).

## 2. Hard Constraints
- **No NaNs**: Any `NaN` in input throws an error or defaults to 0 (safely).
- **Arrays**: `pvs` array must have exactly 6 elements.

## 3. File Map
- `@core/validation/validator.js`: Generic validator.
- `@core/validation/math-validation.js`: Domain logic.
