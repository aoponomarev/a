---
id: process-settings-sync
title: Process: AIS Settings Sync v2.0 (Master)
scope: skills-mbb
tags: [#process, #sync, #cursor, #continue, #git, #ssot, #onedrive]
priority: critical
created_at: 2026-02-02
updated_at: 2026-02-02
---

# Process: AIS Settings Sync v2.0 (Master)

> **Context**: Unified synchronization of ALL development environment settings between Home/Office PCs via OneDrive.
> **SSOT**: This skill is the single source of truth for settings sync.
> **Documentation**: `docs/A_AIS_SETTINGS.md`

## 1. SSOT Structure (v2.0)

```
D:\Clouds\AO\OneDrive\AI\
├── Global\
│   ├── Cursor\         # settings.json, keybindings.json
│   ├── Continue\       # config.yaml, .continuerc.json, .continueignore
│   ├── Git\            # .gitconfig
│   └── Terminal\       # .wslconfig
├── Projects\
│   └── MBB\            # .cursorrules
├── _VAULT\
│   ├── keys\           # SSH keys, recovery codes, client secrets
│   └── envs\           # .env files
├── _Distrib\           # Installers (archived)
├── Docker\             # Docker Desktop settings
└── Projects\MBB\datasets\  # n8n data (via docker volume)
```

## 2. What Gets Synced

| Category | Files | SSOT Location | Local Location |
|----------|-------|---------------|----------------|
| **Cursor IDE** | `settings.json`, `keybindings.json` | `AI\Global\Cursor\` | `%APPDATA%\Cursor\User\` |
| **Continue** | `config.yaml`, `.continuerc.json`, `.continueignore` | `AI\Global\Continue\` | `%USERPROFILE%\.continue\` |
| **Git** | `.gitconfig` | `AI\Global\Git\` | `%USERPROFILE%\` |
| **Terminal** | `.wslconfig` | `AI\Global\Terminal\` | `%USERPROFILE%\` |
| **Project (MBB)** | `.cursorrules` | `AI\Projects\MBB\` | `MBB\.cursorrules` |

## 3. Sync Commands

**Script**: `powershell .\scripts\sync-cursor-settings.ps1 [action]`

| Action | Description | When to Use |
|--------|-------------|-------------|
| `restore` | OneDrive → Local | ONLY IF REQUESTED |
| `backup` | Local → OneDrive | Session END |
| `diff` | Compare hashes | Check before sync |
| `status` | Show timestamps | Debugging |

## 4. Agent Protocol

### 4.1. Session Start (Manual Restore)
Agent should NOT execute restore automatically at the beginning of every session unless explicitly requested by the user.
```
1. Run: powershell .\scripts\sync-cursor-settings.ps1 restore (ONLY IF REQUESTED)
2. Restart Cursor if config.yaml or settings.json changed
3. Confirm: "✅ Settings restored from OneDrive"
```

### 4.2. Session End (Auto-Backup)
Agent MUST execute when user says "Закрываем рабочий день", "Копируй настройки в облако", or at explicit session termination:
```
1. Run: powershell .\scripts\sync-cursor-settings.ps1 backup
2. Confirm: "✅ Cloud SSOT updated"
```

## 5. What is NOT Synced

- `%USERPROFILE%\.continue\index\` — Binary databases (causes OneDrive locks)
- `%USERPROFILE%\.continue\sessions\` — Chat history (too dynamic)
- `%USERPROFILE%\.continue\dev_data\` — Telemetry data
- `%APPDATA%\Cursor\User\state.vscdb` — SQLite state
- `%APPDATA%\Cursor\User\globalStorage\` — Extensions data
- `%APPDATA%\Cursor\User\workspaceStorage\` — Workspace cache

## 6. Safety Mechanisms

1. **Backup before overwrite**: Script creates `.backup` files before any overwrite.
2. **Structure validation**: Script aborts if SSOT directories don't exist.
3. **No destructive operations**: Script only copies, never deletes.

## 7. Trigger Words

Agent should recognize these phrases and act accordingly:
- **Restore**: "начинаем сессию", "синхронизируй из облака", "restore settings", "восстанови настройки"
- **Backup**: "закрываем рабочий день", "копируй настройки в облако", "backup settings", "сохрани в облако"

## 8. Troubleshooting

**If sync fails**, activate skill: `process-windows-powershell-patterns`

Common issues:
- `Win32 error 5` → Use PowerShell, not Bash
- `path.relative()` error → Request `all` permissions
- File locked → Wait for OneDrive sync, use `-Force`

## 9. Adding a New Project

1. Create `D:\Clouds\AO\OneDrive\AI\Projects\ProjectName\`
2. Add `.cursorrules` to that folder
3. Update `INFRASTRUCTURE_CONFIG.yaml` → `ais_settings.projects`
4. Update `sync-cursor-settings.ps1` → add new sync calls

## 10. Related Skills

- `process-windows-powershell-patterns` — Shell troubleshooting (CRITICAL)
- `process-cursor-settings-management` — Cursor-specific details
- `process-continue-config-ssot` — Continue-specific details
- `skill-secrets-hygiene` — .env handling rules
- `process-session-handoff` — Full session termination protocol
- `process-wsl-optimization` — WSL2 configuration

## 11. File Map

- `@INFRASTRUCTURE_CONFIG.yaml` — All paths and profiles (ais_settings section)
- `@scripts/sync-cursor-settings.ps1` — Sync script implementation
- `@docs/A_AIS_SETTINGS.md` — Full documentation
