---
id: integrations-n8n-docker-internals
title: Integrations: n8n Docker Internals
scope: skills-mbb
tags: [#integrations, #n8n, #docker, #sqlite, #troubleshooting]
priority: medium
created_at: 2026-01-27
updated_at: 2026-02-01
---

# Integrations: n8n Docker Internals

> **Context**: Internal structure and database management for n8n in Docker.
> **SSOT**: `/home/node/.n8n/` (Container Path)

## 1. Data Structure
- `database.sqlite`: Core DB (Workflows, Credentials, Users).
- `config`: JSON containing `encryptionKey`.
- `binaryData/`: Workflow execution artifacts.

## 2. Named Volumes
**Rule**: Always use Named Volumes (`n8n_data`) instead of Bind Mounts on Windows to avoid permission issues.

## 3. SQLite Access
To inspect or backup the database:
1.  **Stop**: `docker stop n8n-mbb` (Ensures consistency).
2.  **Copy**: `docker cp n8n-mbb:/home/node/.n8n/database.sqlite ./backup.sqlite`.
3.  **Start**: `docker start n8n-mbb`.

## 4. Hard Constraints
1.  **Permissions**: After `docker cp` into a volume, always reset ownership to `node:node` (UID 1000).
2.  **WAL Files**: When restoring, delete `database.sqlite-shm` and `database.sqlite-wal`.
3.  **Encryption**: Credentials cannot be decrypted without the `N8N_ENCRYPTION_KEY` from `.env`.

## 5. File Map
- `@docker-compose.yml`: Volume definitions.
