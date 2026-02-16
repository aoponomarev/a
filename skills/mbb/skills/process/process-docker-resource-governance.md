---
id: process-docker-resource-governance
title: Process - Docker Resource Governance
scope: skills-mbb
tags: [#process, #docker, #resources, #governance, #reliability]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Docker Resource Governance

> **Goal**: Keep Docker stack stable under mixed Home/Office load.
> **SSOT**: `docker-compose.yml`, `INFRASTRUCTURE_CONFIG.yaml`

## 1. Network Governance

- Use split networks:
  - `public` for externally exposed services.
  - `internal` for private service-to-service traffic.
- Keep sensitive service communication on `internal`.

## 2. Storage Governance

- Named volume `n8n_data` uses `nocopy: true` for faster startup and less sync overhead.
- Keep large mutable data in dedicated mounted paths, not container layers.

## 3. Logging Governance

- Mandatory log rotation per service:
  - `driver: json-file`
  - `max-size: 10m` (or lower for maintenance helpers)
  - `max-file: 3-5`

## 4. Operational Profiles

- Use Compose profiles:
  - `core` for production runtime services.
  - `maintenance` for diagnostics and one-off maintenance containers.

## 5. Verification Checklist

1. `docker compose --profile core config`
2. `docker compose --profile maintenance config`
3. `docker compose ps`
4. `docker network ls | findstr n8n-`
