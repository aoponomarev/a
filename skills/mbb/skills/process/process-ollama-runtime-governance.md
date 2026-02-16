---
id: process-ollama-runtime-governance
title: Process - Ollama Runtime Governance
scope: skills-mbb
tags: [#process, #ollama, #runtime, #reliability, #solo]
priority: high
created_at: 2026-02-15
updated_at: 2026-02-15
---

# Process - Ollama Runtime Governance

> **Goal**: Keep local Ollama integration stable as a fallback layer for MBB.
> **SSOT**: `.env` (Ollama section), `docker-compose.yml`, `scripts/git/preflight-solo.ps1`

## 1. Runtime Policy

- Ollama is a fallback layer, not the primary provider path.
- Use pinned model profiles:
  - `OLLAMA_MODEL_FAST`
  - `OLLAMA_MODEL_HEAVY`
- Keep local concurrency low (`OLLAMA_MAX_CONCURRENCY`) to prevent host saturation.

## 2. Timeout Policy

- Fast tasks use `OLLAMA_TIMEOUT_FAST_MS`.
- Heavy tasks use `OLLAMA_TIMEOUT_HEAVY_MS`.
- Timeout behavior must be explicit and observable.

## 3. Warm Pool Policy

- Keep at least one warm model in `OLLAMA_WARM_MODELS`.
- Warm pool should be compact to avoid memory bloat.

## 4. Verification

1. `docker compose --profile core config`
2. `powershell -ExecutionPolicy Bypass -File .\scripts\git\preflight-solo.ps1`
3. `curl http://127.0.0.1:3002/health`
