---
id: process-docker-disaster-recovery
title: Process - Docker Disaster Recovery
scope: skills-mbb
tags: [#process, #docker, #recovery, #reliability]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Docker Disaster Recovery

> **Goal**: Restore MBB Docker stack without losing working state.
> **SSOT**: `docker-compose.yml`, `datasets/`, `.env`

## 1. Fast Health Triage

1. `docker compose ps`
2. `docker compose logs --tail=100 n8n continue-cli`
3. `docker stats --no-stream`

If containers are healthy and API endpoints respond, stop here.

## 2. Safe Recovery (No Destructive Steps First)

1. Validate config: `docker compose config`
2. Restart only affected service:
   - `docker compose restart n8n`
   - or `docker compose restart continue-cli`
3. Re-check:
   - `curl http://127.0.0.1:5678/`
   - `curl http://127.0.0.1:3002/health`

## 3. Controlled Recreate

Only if restart failed:

1. `docker compose up -d --force-recreate --no-deps n8n`
2. `docker compose up -d --force-recreate --no-deps continue-cli`
3. Validate UI and MCP flow.

## 4. Data Protection Rule

- Never remove named volumes before backup.
- For incident capture, use:
  - `powershell -ExecutionPolicy Bypass -File .\scripts\docker-event-obsidian-bridge.ps1 -Once`
