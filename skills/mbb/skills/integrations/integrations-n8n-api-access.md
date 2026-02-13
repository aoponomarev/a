---
id: integrations-n8n-api-access
title: Integrations: n8n API & Security
scope: skills-mbb
tags: [#integrations, #n8n, #api, #jwt, #security]
priority: high
created_at: 2026-01-27
updated_at: 2026-02-01
---

# Integrations: n8n API & Security

> **Context**: Programmatic control of n8n workflows and JWT management.

## 1. JWT Secret Derivation
n8n derives its API signing secret from `N8N_ENCRYPTION_KEY`.
**Algorithm**: Take every second character of the encryption key, then SHA256 hash it.

## 2. API Key Management
- **Storage**: Table `user_api_keys` in `database.sqlite`.
- **Format**: Standard JWT.
- **Update**: If `N8N_ENCRYPTION_KEY` changes, all API keys MUST be regenerated.

## 3. Docker Permissions
When copying the SQLite DB into a volume, permissions often break.
**Fix**: Use an Alpine helper to `chmod 666` and `chown 1000:1000` the file.

## 4. Hard Constraints
1.  **No Secrets in Git**: `N8N_ENCRYPTION_KEY` lives only in `.env`.
2.  **Windows Paths**: Use PowerShell for `docker exec` commands to avoid Git Bash path conversion issues.

## 5. File Map
- `@docker-compose.yml`: Service config.
- `@scripts/infra-manager.js`: DB maintenance tools.
