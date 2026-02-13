---
id: process-model-registry-maintenance
title: Process: Unified LLM Management (LLM-Orchestrator)
scope: skills-mbb
tags: [#process, #maintenance, #llm, #ssot, #orchestrator]
priority: high
created_at: 2026-01-30
updated_at: 2026-02-04
---

# Process: Unified LLM Management (LLM-Orchestrator)

> **Context**: Unified management of LLM models across config, registry, and statistics using the `llm-manager.js` controller.
> **SSOT**: `.continue/config.yaml` (Technical Source of Truth).

## 1. Unified Controller: `llm-manager.js`
All operations with LLM models MUST be performed through the `llm-manager.js` controller to ensure consistency across all tracking points.

### Commands:
- `node scripts/llm-manager.js --list`: View all models and their protection status.
- `node scripts/llm-manager.js --add '<json>'`: Add or update a model.
- `node scripts/llm-manager.js --remove "<name>"`: Remove a model (fails for protected models).
- `node scripts/llm-manager.js --sync`: Force sync between config, registry, and stats.

## 2. Protected Models (Safety Lock)
The following models are CRITICAL for system stability and cannot be removed via automated scripts:
- `mistral-small` (Main scoring and logic engine)
- `groq-llama-3.3-70b` (Primary high-speed fallback)

## 3. Maintenance Flow
1. **Automated Discovery**: n8n workflows discover new models (e.g., via OpenRouter API).
2. **Testing**: `scripts/test-llm-models.js` evaluates performance.
3. **Registration**: If successful, the model is added via `llm-manager.js --add`.
4. **Health Monitoring**: `server.js` tracks real-time failures and updates `logs/llm-model-stats.json`.
5. **Sync**: `llm-manager.js --sync` updates the human-readable `logs/llm-models-registry.md`.

## 4. Hard Constraints
1. **No Manual Config Edits**: Avoid editing `config.yaml` manually; use the controller to prevent parsing errors.
2. **Registry Consistency**: `logs/llm-models-registry.md` is updated automatically from stats and config.
3. **Fallback Chain**: `server.js` uses the order in `config.yaml` for its fallback logic.

## 5. File Map
- `@.continue/config.yaml`: Technical Source.
- `@scripts/llm-manager.js`: Unified Controller.
- `@logs/llm-models-registry.md`: Human-readable Registry.
- `@logs/llm-model-stats.json`: Real-time Health Stats.
- `@mcp/continue-wrapper/server.js`: Runtime API & Health Tracking.
