---
id: process-cursor-settings-management
title: Process: Cursor Settings Sync
scope: skills-mbb
tags: [#process, #cursor, #config, #sync]
priority: medium
created_at: 2026-01-30
updated_at: 2026-02-02
---

# Process: Cursor Settings Sync

> **Context**: Managing IDE settings and extensions across Home/Office PCs.
> **Master Skill**: See `process/process-settings-sync` for unified sync protocol.

## 1. Scope
- `settings.json`: Keybindings, UI preferences.
- `extensions`: List of mandatory plugins.

## 2. Sync Strategy
- **Automated Sync**: Use `powershell .\scripts\sync-cursor-settings.ps1 [backup|restore]`.
- **SSOT**: `D:\Clouds\AO\OneDrive\AI\Cursor\User` stores the master copies of `settings.json` and `keybindings.json`.
- **Local Paths**: Defined via environment variables (e.g., `%APPDATA%\Cursor\User`).

## 3. Key Settings
- **`editor.formatOnSave`**: Always `true`.
- **`cursor.cpp.enable`**: Always `true` for MBB.

## 4. Hard Constraints
1.  **No Secrets**: Ensure `settings.json` does not contain sensitive API keys (use `.env` instead).

## 5. File Map
- `@INFRASTRUCTURE_CONFIG.yaml`: Profile-specific paths.
