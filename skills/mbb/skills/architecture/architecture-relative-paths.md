---
id: architecture-relative-paths
title: Architecture: Relative Paths (`ЕИП`)
scope: skills-mbb
tags: [#architecture, #еип, #ssot, #infrastructure]
priority: high
created_at: 2026-01-30
updated_at: 2026-02-01
---

# Architecture: Relative Paths (`ЕИП`)

> **Context**: Portability principle ensuring the project runs on any machine (Home/Office) without config changes.
> **Rule**: `ЕИП` (Single Source of Truth / Portable Paths).

## 1. Core Principle
All paths MUST be **relative** to the project root or the current file.
**FORBIDDEN**: Absolute paths (`C:\`, `D:\`, `/Users/...`) in configs or code.

## 2. Implementation Rules

### Infrastructure (`INFRASTRUCTURE_CONFIG.yaml`, `.env`)
- Use `.` for current dir, `..` for parent.
- Bad: `D:\Projects\MBB`
- Good: `./MBB` (relative to root).

### Scripts (`*.js`, `*.py`)
- **Standard**: Use `scripts/path-resolver.js` to resolve project and global roots.
- Resolve project root dynamically:
  ```javascript
  const pathResolver = require('./scripts/path-resolver');
  const root = pathResolver.getProjectRoot();
  ```
- Do not hardcode drive letters.

### Documentation (`*.md`)
- Links must be relative: `[Link](../folder/file.md)`.
- Runnable examples should use env vars (`$PROJECT_ROOT`, `$GLOBAL_ROOT`) or `path-resolver.js`.

### Docker
- Volume mappings must use environment variables resolved via `path-resolver.js`:
  ```yaml
  volumes:
    - ${SKILLS_ROOT}:/workspace/skills
    - ${GLOBAL_ROOT}:/workspace/global
  ```

## 3. Why?
1.  **Portability**: Works on any drive/OS (Windows/Docker/WSL).
2.  **Sync**: Seamless OneDrive sync between devices.
3.  **Safety**: Prevents accidental writes to wrong absolute paths.

## 4. Verification
Command `ЕИП` triggers a scan for absolute paths in the codebase. `path-resolver.js` is the primary tool for maintaining this principle.
