---
id: process-disaster-recovery
title: Process: Infrastructure Disaster Recovery
scope: skills-mbb
tags: [#process, #recovery, #docker, #infrastructure, #automation]
priority: high
created_at: 2026-01-31
updated_at: 2026-02-01
---

# Process: Infrastructure Disaster Recovery

> **Critical Process**: Step-by-step restoration of the MBB environment after failure or on a clean machine.
> **SSOT**: `INFRASTRUCTURE_CONFIG.yaml`, `docker-compose.yml`

## 1. Prerequisites

### External Data (OneDrive)
Ensure the Datasets folder is synced:
- **Path**: `D:\Clouds\AO\OneDrive\AI\Projects\MBB\datasets` (See `INFRASTRUCTURE_CONFIG.yaml`).
- **Content**: `/n8n` (DB, workflows, logs).

### Secrets
- `MISTRAL_API_KEY`, `CONTINUE_API_KEY`, `N8N_ENCRYPTION_KEY` must be available in Password Manager.

## 2. Recovery Steps

### Phase 0: Automated Recovery (Try This First)
For partial failures (container down, service hung):
1.  **Check Status**: `node scripts/infra-manager.js status`.
2.  **Recover**: `node scripts/infra-manager.js recover`.

### Phase 1: Clean Slate
If the system is corrupted:
1.  **Stop**: `docker compose down --remove-orphans`.
2.  **Verify WSL**: Ensure WSL 2 backend is active in Docker Desktop.

### Phase 2: Configuration
1.  **Env**: `copy .env.example .env` and populate secrets.
2.  **Mounts**: Verify `docker-compose.yml` points to the correct `${DATASETS_ROOT}`.

### Phase 3: Launch
1.  **Build**: `docker compose build continue-cli` (Required for `env-subst.js`).
2.  **Start**: `node scripts/infra-manager.js start`.
3.  **Verify**: `docker logs continue-cli` should show "Config substitution complete".

## 3. Troubleshooting
- **API Keys Missing**: Rebuild image with `--no-cache`.
- **Database Locked (n8n)**: Stop container, wait for OneDrive sync to finish, then restart.
- **Network Missing**: `docker network create n8n-network`.

## 4. File Map
- `@scripts/infra-manager.js`: Recovery tool.
- `@docker-compose.yml`: Service definitions.
