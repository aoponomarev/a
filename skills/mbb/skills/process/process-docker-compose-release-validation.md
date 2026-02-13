---
id: process-docker-compose-release-validation
title: "Process: Docker Compose Release Validation"
scope: skills-mbb
tags: [#process, #docker-compose, #devops, #validation]
priority: medium
created_at: 2026-02-10
updated_at: 2026-02-10
---

# Process: Docker Compose Release Validation

> **Context**: Docker Compose releases can affect watch mode, healthchecks, and service orchestration behavior used by V2 stack.
> **SSOT**: `docker-compose.yml`

## 1. Trigger

- New Docker Compose release in Sources.
- Any anomalies in container restart/healthcheck behavior.

## 2. Validation Path

1. `docker compose config` must pass.
2. Restart `continue-cli` and `n8n`.
3. Validate:
   - `GET /health`
   - `GET /api/health-check`
   - `GET /api/skills/news/sources`
4. Confirm V2 tabs still load and workflow webhooks respond.

## 2.1 Release Notes That Matter (v5.0.2)

Prioritize verification when release notes mention:
- watch-mode file change handling fixes,
- `healthcheck.disable: true` handling,
- terminal/progress UI and env-file path parsing fixes.

These are runtime-adjacent to our Compose-operated `continue-cli` and `n8n` services.

## 3. Noise Control

- Use official release notes only.
- Ignore generic ecosystem commentary; capture only concrete behavior changes impacting this compose stack.

