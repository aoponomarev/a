---
id: process-infrastructure-maintenance
title: Process: Infrastructure Maintenance
scope: skills-mbb
tags: [#process, #infrastructure, #devops, #docker, #recovery]
priority: high
created_at: 2026-01-29
updated_at: 2026-02-01
---

# Process: Infrastructure Maintenance

> **Context**: Routine checks, updates, and recovery procedures for the Docker-based infrastructure.
> **SSOT**: `INFRASTRUCTURE_CONFIG.yaml`

## 1. Migration Protocol (Home <-> Office)
1.  **Sync Paths**: Update `INFRASTRUCTURE_CONFIG.yaml` `profiles` if paths differ.
2.  **Secrets**: Copy `.env` from secure storage (OneDrive).
3.  **Volume**: `docker volume create n8n_data`.
4.  **Verify**: Run `node scripts/health-check.js`.

## 2. Routine Maintenance
- **Daily**: Check `health-check.js`. All Critical services MUST be `HEALTHY`.
- **Logs**: Review `logs/skills-events.log` for anomalies.
- **Updates**: `docker compose pull` to get latest base images.

## 3. Recovery Procedure
If a service fails:
1.  **Auto-Recover**: `node scripts/infra-manager.js recover`.
2.  **Manual Restart**: `docker restart continue-cli`.
3.  **Rebuild**: `docker compose build --no-cache continue-cli && docker compose up -d`.

## 4. Hard Constraints
1.  **No Secrets in Git**: `.env` is gitignored. Use `env-subst.js` for runtime injection.
2.  **Sanitization**: All file-handling endpoints must sanitize inputs (basename only).
3.  **Health Check**: Always run `health-check.js` before and after changes.

## 5. File Map
- `@scripts/health-check.js`: Diagnostic tool.
- `@scripts/infra-manager.js`: Recovery tool.
- `@INFRASTRUCTURE_CONFIG.yaml`: Configuration source.
