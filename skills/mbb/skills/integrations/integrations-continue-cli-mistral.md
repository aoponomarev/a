---
id: integrations-continue-cli-mistral
title: Integrations: Continue CLI & Mistral
scope: skills-mbb
tags: [#integrations, #continue-cli, #mistral, #llm, #automation]
priority: high
created_at: 2026-01-27
updated_at: 2026-02-01
---

# Integrations: Continue CLI & Mistral

> **Context**: Headless LLM orchestration for automated tasks.
> **SSOT**: `mcp/continue-wrapper/server.js`

## 1. Architecture
- **Trigger**: n8n or Cron.
- **Wrapper**: Node.js Express server (`server.js`) exposing an HTTP API.
- **CLI**: `cn` (Continue CLI) running in a Docker container.
- **Primary LLM**: Mistral Small (Cloud).
- **Fallback LLM**: Ollama Qwen (Local).

## 2. Configuration (`config.yaml`)
The config uses placeholders like `${MISTRAL_API_KEY}` which are patched at container startup via `env-subst.js`.

## 3. Key Endpoints
- `POST /prompt`: Executes a single prompt and returns the text.
- `POST /save`: Writes generated content to a specified file path.
- `GET /health`: Checks if the CLI and models are responsive.

## 4. Hard Constraints
1.  **Timeout**: LLM generation can take 60s+. Set HTTP timeouts to `200s`.
2.  **No Secrets**: Never commit the patched `config.yaml`. Use the template.
3.  **Isolation**: Continue CLI runs as `root` inside the container for file access.

## 5. File Map
- `@mcp/continue-wrapper/server.js`: API Wrapper.
- `@.continue/config.yaml`: Template config.
- `@docker/continue-cli/Dockerfile`: Build spec.
