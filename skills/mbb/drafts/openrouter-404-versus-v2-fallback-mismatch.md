---
id: openrouter-404-versus-v2-fallback-mismatch
title: OpenRouter 404 versus V2 fallback mismatch
description_ru: Диагностика расхождения между рабочим V2 и ошибкой Continue по OpenRouter
scope: mbb
tags: [#troubleshooting, #openrouter, #continue, #fallback, #ssot]
priority: high
created_at: 2026-02-17
updated_at: 2026-02-17
source: mcp_propose_skill_plus_manual_enrichment
source_refs: ["scripts/sync-continue-commanders.js", "n8n/workflows/V2_NEWS_Swarm.json", "mcp/continue-wrapper/server.js"]
---

# OpenRouter 404 versus V2 fallback mismatch

## Scope

Когда модель в Continue падает с `404 No endpoints found`, но в V2 кажется рабочей.

## Problem Pattern

- Continue вызывает модель напрямую из `config.yaml` и показывает реальную ошибку провайдера.
- V2 может отработать успешно, потому что workflow использует fallback-цепочку провайдеров.
- Из-за этого возникает ложный вывод "модель рабочая везде", хотя реально сработал другой провайдер.

## Verified Root Causes

- OpenRouter модель `tngtech/deepseek-r1t2-chimera:free` отсутствует в каталоге `/api/v1/models`.
- Нормализованная модель `tngtech/deepseek-r1t2-chimera` существует, но может быть заблокирована data policy: `No endpoints found matching your data policy`.
- В `V2_NEWS_Swarm` при ошибке OpenRouter запрос автоматически уходит в fallback и возвращает контент от другой модели.

## 60-Second Diagnosis Protocol

1. Проверить реальную доступность модели в OpenRouter:
   - `GET https://openrouter.ai/api/v1/models`
   - `POST https://openrouter.ai/api/v1/chat/completions` с целевой моделью.
2. Проверить, какой моделью реально был создан результат в V2:
   - `a/skills/mbb/drafts/tasks/*.md` поля `master_llm` и `suggested_by`.
3. Проверить, что Continue использует тот же model id, что и в каталоге провайдера.

## Guardrails

- Не трактовать успех V2 как доказательство доступности конкретной OpenRouter-модели.
- Ввести `shadow-index` в `infra-registry` (`_model_index.shadow`) и исключать `active=true` модели из Score и ротации.
- `Sync IQ` обязан пробовать ВСЕ активные модели (включая shadow) прямым вызовом без fallback-маскировки.
- При успехе в `Sync IQ` модель автоматически реабилитируется (`active=false`), при ошибке — остаётся/попадает в shadow.
- Всегда публиковать диагностику провайдера в API-ответах синка, чтобы видеть `ok/status/reason`.

## Current Implementation Notes

- В `server.js` добавлен постоянный shadow-index:
  - статус `SHADOW` в `/api/v2/init` и `/api/llm/list`;
  - shadow-модели скрываются на вкладке `Score` через `/api/productivity`;
  - shadow-модели исключаются из free-role rebalance.
- В `Sync IQ` (`/api/benchmarks/sync`) добавлен `shadow_probe`:
  - проверяет все модели из fallback-chain;
  - пишет причины (`no_endpoints`, `timeout`, `auth_error`, `runtime_error`);
  - поддерживает авто-реабилитацию.
- В `sync-continue-commanders.js`:
  - shadow-модели не попадают в Continue;
  - `deepseek-r1t2-chimera:free` нормализуется к `deepseek-r1t2-chimera`;
  - постоянная модель `yandex-assistant` добавляется в Continue config.

## Strict Sources Mode

- Workflow `V2_NEWS_Swarm` переведен в strict single-model execution:
  - fallback-цепочка удалена;
  - при недоступности выбранной модели workflow завершаетcя с `success=false` и прозрачной причиной ошибки;
  - подмены модели в `Sources` больше не происходит.
- Live workflow обновляется через n8n API (`PUT /api/v1/workflows/{id}`), иначе локальный JSON может расходиться с реально исполняемой версией.

## Continue Assistant Visibility

- Для Continue (где `provider: yandex` может не отображаться в списке моделей) добавлен OpenAI-совместимый прокси:
  - `POST /openai/v1/chat/completions` в `continue-wrapper`;
  - принимает `assistant:*` модели и проксирует в `https://rest-assistant.api.cloud.yandex.net/v1/responses`.
- В `config.yaml` модель `yandex-assistant` публикуется как:
  - `provider: openai`
  - `model: assistant:fvtj79pcagqihmvsaivl`
  - `apiBase: http://127.0.0.1:3002/openai/v1`

## Expected Signals

- `openrouter_diagnostics[].ok=true` -> модель доступна для текущего ключа/политики.
- `reason=no_endpoints` -> модель не должна считаться рабочей для Continue без ручной корректировки policy или роли.
- `master_llm` в V2 не совпадает с ожидаемой моделью -> был fallback.

## Sources
- scripts/sync-continue-commanders.js
- n8n/workflows/V2_NEWS_Swarm.json
- mcp/continue-wrapper/server.js
