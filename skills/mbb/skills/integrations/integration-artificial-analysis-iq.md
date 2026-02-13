---
id: integration-artificial-analysis-iq
title: "Integration: Artificial Analysis IQ Scoring"
scope: skills-mbb
tags: [#integration, #benchmarks, #artificial-analysis, #iq, #agents]
priority: high
created_at: 2026-02-09
updated_at: 2026-02-09
---

# Integration: Artificial Analysis IQ Scoring

> **Context**: Every agent added to the system is automatically scored via Artificial Analysis API benchmarks.
> **SSOT**: `scripts/benchmark-service.js`

## 1. Scope / When to Use

- Adding a new model via UI form (`/api/infra/model/add`)
- Recruiting an agent via API (`/api/agents/recruit`)
- Bulk re-scoring all agents (`/api/benchmarks/sync`)
- Displaying agent quality in the Productivity tab

## 2. Architecture

```
User adds model
       |
       v
server.js: /api/infra/model/add or /api/agents/recruit
       |
       v
benchmarkService.lookupCodingScoreAsync(modelId)
       |
       +-- Cache hit? -> return cached score
       |
       +-- Cache miss? -> fetchBenchmarks() from API
               |
               v
       https://artificialanalysis.ai/api/v2/data/llms/models
               |
               v
       Parse response, build slug-indexed cache
               |
               v
       EXPLICIT_MAP + slug normalization -> match model
               |
               v
       extractScore: livecodebench*100 > coding_index > intelligence_index > 50
```

## 3. Key Rules

- **API Key**: `ARTIFICIAL_ANALYSIS_API_KEY` in `.env`. Free tier: 1000 req/day.
- **Fallback**: If no API key or API down, `DEFAULT_IQ = 50`.
- **Score priority**: `livecodebench * 100` (most accurate for coding) > `coding_index` > `intelligence_index`.
- **Fuzzy matching**: Model IDs like `deepseek/deepseek-r1-0528:free` are normalized to slugs and matched against `EXPLICIT_MAP` + cache entries.
- **EMA blending**: On `/api/benchmarks/sync`, existing agent scores are blended with fresh benchmark data: `new_iq = 0.3 * benchmark + 0.7 * current` (preserves agent's operational history).
- **Response contract**: Both `/api/infra/model/add` and `/api/agents/recruit` return `{ iq_score, origin, benchmark_match }`.

## 4. Origin Auto-Detection

`detectOrigin(modelId, provider)` in `server.js` maps model ID prefixes to domains:
- `anthropic`, `claude` -> `anthropic.com`
- `google`, `gemini`, `gemma` -> `google.com`
- `meta-llama`, `llama` -> `meta.com`
- `mistral` -> `mistral.ai`
- `deepseek` -> `deepseek.com`

Used for `trusted_origins` security policy enforcement when `origin` is not explicitly provided.

## 5. UI Display (Productivity Tab)

IQ scores are color-coded in the table:
- **> 89**: Green (`#198754`) -- top-tier
- **> 74**: Cyan (`#0dcaf0`) -- strong
- **> 49**: Muted blue (`#3a7ca5`) -- acceptable
- **<= 49**: Gray (`#6c757d`) -- weak

Hovering over IQ shows tooltip with raw benchmark values (AA Coding, LiveCodeBench, AA Intelligence).

## 6. Hard Constraints

- NEVER add a model without IQ lookup -- both endpoints enforce this.
- NEVER trust IQ=50 as "real" -- it means "no benchmark data found" (default fallback).
- ALWAYS run `detectOrigin` if no explicit origin -- security policy depends on it.

## 7. File Map

- `@scripts/benchmark-service.js`: API client, cache, matching logic.
- `@scripts/benchmark-cache.json`: Cached data (395+ models).
- `@mcp/continue-wrapper/server.js`: Endpoints that call benchmark service.
- `@mcp/V2_logic.js`: UI rendering of IQ scores, tooltips.
