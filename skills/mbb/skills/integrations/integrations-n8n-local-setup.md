---
id: integrations-n8n-local-setup
title: Integrations: n8n Local Setup
scope: skills-mbb
tags: [#integrations, #n8n, #docker, #setup]
priority: high
created_at: 2026-01-27
updated_at: 2026-02-01
---

# Integrations: n8n Local Setup

> **Context**: Configuring n8n Community Edition for local automation.

## 1. Prerequisites
- Docker Desktop installed.
- `.env` file with `N8N_ENCRYPTION_KEY`.

## 2. Setup Steps
1.  **Volume**: `docker volume create n8n_data`.
2.  **Launch**: `docker compose up -d n8n`.
3.  **Verify**: Access `http://localhost:5678`.

## 3. Key Environment Variables
- `N8N_ENCRYPTION_KEY`: Master secret for credentials.
- `N8N_API_KEY`: JWT for programmatic access.
- `N8N_RUNNERS_ENABLED=false`: Required for Code Nodes to access host modules.

## 4. Hard Constraints
1.  **Isolation**: Keep the n8n network separate from the public internet where possible.
2.  **Sync**: n8n must have read/write access to `../skills` and `../skills-mbb` for the Backlog Watcher.

## 5. File Map
- `@docker-compose.yml`: Service definition.
- `@.env`: Secrets storage.
