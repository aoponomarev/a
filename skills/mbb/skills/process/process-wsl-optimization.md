---
id: process-wsl-optimization
title: Process: WSL2 & Docker Optimization
scope: skills-mbb
tags: [#wsl, #docker, #optimization, #windows, #hardware]
priority: medium
created_at: 2026-01-31
updated_at: 2026-02-01
---

# Process: WSL2 & Docker Optimization

> **Context Aware**: WSL settings depend on the active hardware profile in `INFRASTRUCTURE_CONFIG.yaml`.

## 1. Hardware-Specific Config (`.wslconfig`)
File location: `C:\Users\[User]\.wslconfig`.

### Profile: Home (High Performance)
*Target: 16 threads / 64GB RAM*
```ini
[wsl2]
processors=12
memory=32GB
swap=8GB
guiApplications=false

[experimental]
autoMemoryReclaim=gradual
dnsTunneling=true
autoDiskShrink=true
```

### Profile: Office (Standard)
*Target: 8 threads / 16-32GB RAM*
```ini
[wsl2]
processors=4
memory=8GB
swap=4GB
```

## 2. Docker Desktop Settings
- **WSL Integration**: Enable for `Ubuntu-22.04`.
- **Resource Saver**: Set to `Auto` for 64GB setups.
- **Features**: Enable `containerd` and `Beta Features / Docker MCP Toolkit`.
- **Kubernetes**: **DISABLE** to save resources.

## 3. Applying Changes
1.  **Shutdown**: `wsl --shutdown` in PowerShell.
2.  **Restart**: Launch Docker Desktop.
3.  **Verify**: Run `free -h` and `nproc` inside the Ubuntu terminal.

## 4. File Map
- `@INFRASTRUCTURE_CONFIG.yaml`: Profile source.
- `@process-disaster-recovery.md`: Environment setup.
