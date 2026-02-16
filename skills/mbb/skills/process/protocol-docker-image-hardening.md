---
id: protocol-docker-image-hardening
title: Protocol - Docker Image Hardening
scope: skills-mbb
tags: [#protocol, #docker, #security, #build]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Protocol - Docker Image Hardening

> **Goal**: Keep images reproducible, fast, and safer by default.
> **SSOT**: `docker/continue-cli/Dockerfile`

## 1. Baseline Rules

- Use stable LTS base image (`node:20-slim` currently accepted).
- Keep layer count minimal and deterministic.
- Install only required OS packages (`--no-install-recommends`).

## 2. Build Performance Rules

- Use BuildKit cache in Compose build:
  - `cache_from: type=local,src=.buildx-cache`
  - `cache_to: type=local,dest=.buildx-cache-new,mode=max`
- Reuse package manifests before full source copy for better cache hits.

## 3. Runtime Safety Rules

- Use `init: true` in Compose services to handle zombie processes and clean signal propagation.
- Rotate logs (`json-file`, `max-size`, `max-file`) to prevent disk exhaustion.
- Use `tmpfs` for `/tmp` when possible to reduce disk I/O pressure.

## 4. Verification

1. `docker compose config`
2. `docker compose build continue-cli`
3. `docker compose up -d continue-cli`
4. `curl http://127.0.0.1:3002/health`
