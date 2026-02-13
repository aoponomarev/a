---
id: libs-mbb-config
title: Libs: Configuration & Structure
scope: skills-mbb
tags: [#libs, #config, #structure]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Libs: Configuration & Structure

> **Context**: Layout of the vendor repository.
> **Repo**: `github.com/aoponomarev/libs`

## 1. Directory Structure
```text
libs/
├── vue/
│   └── 3.4.0/vue.global.js
├── chartjs/
│   └── 4.4.0/chart.umd.js
└── assets/
    └── coins/ (Images)
```

## 2. Load Priority
1.  **GitHub Pages**: `https://aoponomarev.github.io/libs/` (Primary for Web).
2.  **CDN**: `cdn.jsdelivr.net` (Backup).
3.  **Local**: `file://.../libs/` (Primary for Dev/Offline).

## 3. Usage
```javascript
await window.libLoader.load('vue', '3.4.0');
```

## 4. File Map
- `@libs/`: Root directory.
