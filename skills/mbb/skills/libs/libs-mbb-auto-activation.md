---
id: libs-mbb-auto-activation
title: Libs: Auto Activation
scope: skills-mbb
tags: [#libs, #automation, #loader]
priority: low
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Libs: Auto Activation

> **Context**: Dynamic dependency resolution logic.
> **SSOT**: `core/lib-loader.js`

## 1. Logic
1.  **Check Local**: Look for file in `libs/`.
2.  **Fallback**: If missing, fetch from CDN (jsdelivr).
3.  **Alert**: Notify developer to download the file to `libs/` for offline support.

## 2. Constraints
- **Auto-Download**: The browser cannot write to disk. The user must run `download-libs.sh` manually.
- **Version Lock**: `LIB_SOURCES` config in `lib-loader.js` is the SSOT for versions.

## 3. File Map
- `@core/lib-loader.js`: Activation logic.
