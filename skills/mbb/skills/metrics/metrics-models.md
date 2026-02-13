---
id: metrics-models
title: Metrics: Math Models
scope: skills-mbb
tags: [#metrics, #math, #models]
priority: high
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Metrics: Math Models

> **Context**: The mathematical engines driving market analysis.
> **SSOT**: `core/config/models-config.js`

## 1. Architecture
- **Registry**: `ModelManager` loads classes.
- **Contract**: `BaseModelCalculator` ensures input/output consistency.
- **Inputs**: `NormalizedCoinData` (PVS, Market Cap).
- **Outputs**: `Signal` (Direction, Confidence).

## 2. Active Models
1.  **Median AIR**: Uses median deviation from historical window.
2.  **Volatility Guard**: Filters low-amplitude noise.

## 3. Extensibility
New models must:
1.  Extend `BaseModelCalculator`.
2.  Implement `calculate(snapshot)`.
3.  Register in `models-config.js`.

## 4. File Map
- `@core/metrics/base-model-calculator.js`: Base Class.
- `@core/metrics/model-manager.js`: Registry.
