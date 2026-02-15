---
id: process-external-integration-closure
title: "Process: External Integration Closure (Finalization)"
scope: skills-mbb
tags: [#process, #integration, #closure, #sync, #ФИН]
---
version: 1.1.0
priority: high
shadow_index: "Finalization protocol for new infrastructure or architecture layers. Mandatory sync script update and indexing."
relations: [process-settings-sync, process-km-v2-maintenance]
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process: External Integration Closure (Finalization)

> **Context**: Finalizing a new infrastructure block or architectural layer.
> **Trigger**: Command `ФИН` or completion of integration.

## 1. Finalization Checklist

### 1.1. Settings & Sync (CRITICAL)
**Rule**: Every new block containing settings or state MUST be added to the sync script.
1.  **Audit**: Identify all new `.json`, `.yaml`, `.env`, or database files.
2.  **Update Sync Script**: Add the new paths to `D:\Clouds\AO\OneDrive\AI\settings-sync-mbb.ps1`.
3.  **Verify**: Run `powershell .\scripts\sync-cursor-settings.ps1 backup` to ensure the new files are captured.

### 1.2. Documentation & Evolution
1.  **Project Evolution**: Update `docs/project-evolution.txt` with the new integration milestone.
2.  **Infrastructure Map**: If infrastructure changed, update `docs/A_INFRASTRUCTURE.md`.
3.  **KM v2.0 Index**: Run `node scripts/mbb-index-gen.js` to update the manifest and graph.
4.  **Skill Anchors**: Add `// Skill anchor:` comments in the code pointing to relevant skills.

### 1.3. Secrets Hygiene
1.  **Vault**: Ensure no secrets are in Git.
2.  **Backup**: Sync new `.env` keys to `AI/_VAULT/envs/mbb.env`.

## 2. Hard Constraints
- **No Sync, No Closure**: An integration is NOT considered finished until it is covered by the `settings-sync-mbb.ps1` script.
- **SSOT Alignment**: Ensure all paths follow the `ЕИП` (Relative Paths) principle.
