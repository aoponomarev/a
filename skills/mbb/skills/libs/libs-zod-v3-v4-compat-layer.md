---
id: libs-zod-v3-v4-compat-layer
title: Libs - Zod v3 v4 Compatibility Layer
scope: skills-mbb
tags: [#libs, #zod, #migration, #compatibility, #mcp]
priority: medium
created_at: 2026-02-16
updated_at: 2026-02-16
---

# Libs - Zod v3 v4 Compatibility Layer

> **Goal**: Prepare safe gradual migration path from Zod v3 to v4 without breaking MCP runtime.
> **Current policy**: Production baseline remains on Zod v3.

## 1. Why a Compatibility Layer

- MCP servers share validation patterns and must stay behavior-consistent.
- Full migration in one shot is high-risk for runtime contracts.
- Compatibility adapters reduce migration blast radius.

## 2. Layer Responsibilities

- Wrap Zod error formatting into a stable internal shape.
- Centralize helper methods that may differ between v3 and v4 behavior.
- Prevent direct spread of version-specific quirks into tool handlers.

## 3. Activation Criteria

- Keep layer implementation ready before any v4 rollout.
- Activate migration only when:
  - preflight drift checks are green,
  - all MCP servers pass self-tests,
  - no contract regressions in tool input validation.

