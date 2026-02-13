---
id: process-windows-powershell-patterns
title: Process: Windows PowerShell Patterns for AI Agents
scope: skills-mbb
tags: [#process, #powershell, #windows, #bash, #onedrive, #cursor, #troubleshooting]
priority: critical
created_at: 2026-02-02
updated_at: 2026-02-03
---

# Process: Windows PowerShell Patterns for AI Agents

> **Context**: AI agents (Cursor, Continue) running on Windows frequently encounter shell errors when executing file operations. This skill provides patterns to avoid common pitfalls.

---

## ⛔ HARD BAN: NO BASH IN CURSOR

**CRITICAL RULE — VIOLATING THIS CAUSES SYSTEM FAILURES**

```
┌─────────────────────────────────────────────────────────────────┐
│  NEVER use Bash shell when executing commands in Cursor IDE.   │
│  Git Bash + Cursor = "Win32 error 5" (Access Denied)           │
│  This is a KNOWN BUG with NO FIX.                              │
└─────────────────────────────────────────────────────────────────┘
```

### What Happens If You Use Bash:
```
bash (XXXXX) C:\Program Files\Git\bin\..\usr\bin\bash.exe: 
*** fatal error - couldn't create signal pipe, Win32 error 5
```

### Root Cause:
- Windows Defender blocks Unix pipe creation
- Cursor spawns bash in a way that triggers this
- OneDrive file locks compound the issue
- **Bash itself is NOT broken** — only Cursor→Bash integration

### MANDATORY ALTERNATIVES:

| Instead of... | Use... |
|---------------|--------|
| `bash -c "command"` | `powershell -Command "command"` |
| Shell tool default | Explicit `powershell -Command` wrapper |
| Unix commands (`ls`, `cat`, `mkdir`) | PowerShell equivalents (see table below) |

### Quick Check Before Any Shell Command:
1. Does command start with `bash`? → **STOP. Rewrite for PowerShell.**
2. Using Unix syntax (`&&`, `|`, `>`)? → **Wrap in `powershell -Command`**
3. Path uses forward slashes? → **Convert to backslashes for PowerShell**

---

## 1. Trigger Conditions

**ACTIVATE THIS SKILL when:**
- Working with files in **OneDrive** paths (`D:\Clouds\...`)
- Creating/copying/moving files **outside the workspace root**
- Encountering `Win32 error 5` in Git Bash
- Encountering `path should be a 'path.relative()'d string` errors
- Any file operation fails with "Access Denied" or "Path not found"
- Running `mkdir`, `cp`, `mv`, `rm` on Windows with absolute paths
- Syncing settings between machines
- Working with paths containing spaces or special characters

## 2. Known Errors & Solutions

### 2.1. Git Bash Signal Pipe Error
```
bash (XXXX) C:\Program Files\Git\bin\..\usr\bin\bash.exe: 
*** fatal error - couldn't create signal pipe, Win32 error 5
```

**Cause**: Git Bash conflicts with OneDrive file locking or antivirus.

**Solution**: Use PowerShell instead of Bash for file operations.
```powershell
# Instead of bash commands, use:
powershell -Command "Your-Command-Here"
```

### 2.2. Cursor Shell Path Restriction
```
Error: Command failed to spawn: path should be a `path.relative()`d string, 
but got "D:/Clouds/AO/OneDrive/AI/..."
```

**Cause**: Cursor's shell sandbox restricts absolute paths outside workspace.

**Solution**: Wrap commands in PowerShell or request `all` permissions.
```powershell
# Wrap the command:
powershell -Command "New-Item -ItemType Directory -Force -Path 'D:\Clouds\AO\OneDrive\AI\folder'"

# Or request permissions in tool call:
required_permissions: ["all"]
```

### 2.3. OneDrive File Locking
```
The process cannot access the file because it is being used by another process.
```

**Cause**: OneDrive sync daemon has file locked.

**Solution**: 
1. Wait for OneDrive sync to complete (check tray icon).
2. Use `-Force` flag in PowerShell.
3. For SQLite files: NEVER sync them via OneDrive (use copy instead).

## 3. Command Translation Table

| Bash Command | PowerShell Equivalent |
|--------------|----------------------|
| `mkdir -p "path"` | `New-Item -ItemType Directory -Force -Path 'path'` |
| `cp -r src dest` | `Copy-Item -Path 'src' -Destination 'dest' -Recurse -Force` |
| `mv src dest` | `Move-Item -Path 'src' -Destination 'dest' -Force` |
| `rm -rf path` | `Remove-Item -Path 'path' -Recurse -Force` |
| `cat file` | `Get-Content -Path 'file'` |
| `ls -la` | `Get-ChildItem -Force` |
| `test -f file` | `Test-Path 'file'` |

## 4. Correct Patterns for AI Agents

### 4.1. Creating Directories in OneDrive
```powershell
# BAD (will fail in Cursor sandbox):
mkdir -p "D:/Clouds/AO/OneDrive/AI/Global/Cursor"

# GOOD:
powershell -Command "New-Item -ItemType Directory -Force -Path 'D:\Clouds\AO\OneDrive\AI\Global\Cursor'"
```

### 4.2. Copying Files with Backup
```powershell
# BAD:
cp -r "D:/Clouds/AO/OneDrive/AI/Cursor" "D:/Clouds/AO/OneDrive/AI/Cursor_backup"

# GOOD:
powershell -Command "Copy-Item -Path 'D:\Clouds\AO\OneDrive\AI\Cursor' -Destination 'D:\Clouds\AO\OneDrive\AI\Cursor_backup' -Recurse -Force"
```

### 4.3. Multiple Operations in One Command
```powershell
# Chain with semicolons:
powershell -Command "New-Item -ItemType Directory -Force -Path 'path1', 'path2', 'path3'"

# Or chain separate commands:
powershell -Command "Copy-Item 'src1' 'dest1' -Force; Copy-Item 'src2' 'dest2' -Force"
```

### 4.4. Conditional Operations
```powershell
powershell -Command "if (Test-Path 'source') { Copy-Item 'source' 'dest' -Force; Write-Host 'Copied' } else { Write-Host 'Not found' }"
```

## 5. Path Format Rules

| Context | Format | Example |
|---------|--------|---------|
| PowerShell `-Path` | Backslash, single quotes | `'D:\Clouds\AO\OneDrive\AI'` |
| PowerShell inline | Backslash, escaped | `"D:\\Clouds\\AO\\OneDrive\\AI"` |
| Git Bash | Forward slash | `/d/Clouds/AO/OneDrive/AI` |
| Docker volume mount | Forward slash | `D:/Clouds/AO/OneDrive/AI:/data` |

## 6. Permissions in Cursor Shell Tool

When calling Shell tool for operations outside workspace:
```yaml
required_permissions: ["all"]  # Disables sandbox
working_directory: "D:\Clouds\AO\OneDrive\Portfolio-CV\Refactoring\ToDo\Statistics\MBB"
```

## 7. Debugging Checklist

When a file operation fails:
1. **Check OneDrive status** — Is file syncing? (blue arrows in Explorer)
2. **Check antivirus** — Is it scanning the path?
3. **Check path format** — Backslashes for PowerShell, forward for Bash
4. **Check permissions** — Request `all` if sandbox error
5. **Check file locks** — Close apps that might have file open

## 8. Related Skills

- `process-windows-docker-paths` — Docker-specific path issues
- `process-settings-sync` — Settings synchronization (uses these patterns)
- `process-wsl-optimization` — WSL2 configuration
- `process-disaster-recovery` — Environment setup

## 9. File Map

- `@scripts/sync-cursor-settings.ps1` — Example of correct PowerShell usage
- `@INFRASTRUCTURE_CONFIG.yaml` — Path definitions
- `@docs/A_AIS_SETTINGS.md` — Settings sync documentation
