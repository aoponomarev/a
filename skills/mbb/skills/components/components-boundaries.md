---
id: components-boundaries
title: Components: Composition Boundaries
scope: skills-mbb
tags: [#components, #architecture, #vue, #bootstrap]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Components: Composition Boundaries

> **Context**: Deciding when to use raw Bootstrap vs. Vue wrappers.

## 1. The Principle
Use **Raw Bootstrap** (HTML + Classes) for static layout. Create **Vue Wrappers** ONLY when dynamic logic is required.

## 2. When to Wrap
- **Search/Filter**: e.g., `cmp-combobox`.
- **Dynamic Lists**: e.g., `cmp-dropdown` with async items.
- **Complex State**: e.g., `cmp-modal` with validation.
- **Reusability**: If the same complex HTML structure repeats in 3+ places.

## 3. Boundary Rules
- **Internal Elements**: Wrap the *items* and *logic*, not necessarily the outer container.
- **Control**: The container (`.modal`, `.dropdown`) should remain accessible to Bootstrap's native JS.

## 4. Library Priority
Before coding a wrapper, check `libs/` for existing Vue-compatible UMD libraries.

## 5. File Map
- `@shared/components/`: Wrapper implementations.
- `@shared/templates/`: HTML structures.
