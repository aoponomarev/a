# Skills Backlog (MBB-Specific)

Этот файл служит буфером для новых кандидатов в MBB-специфичные Skills.
Агенты добавляют сюда предложения, а человек (USER) одобряет их и переносит в основной реестр.

## Candidate Pipeline
1. **Capture**: Агент выявляет потребность (Create/Update/Merge/Deprecate).
2. **Draft**: n8n генерирует черновик в папке drafts/.
3. **Review**: Человек (USER) просматривает список.
4. **Promote**: Если одобрено, изменения вносятся в основной реестр, а запись архивируется.

## Action Types
- `create`: создать новый Skill
- `update`: обновить существующий
- `merge`: объединить Skills
- `split`: разделить Skill
- `deprecate`: архивировать Skill
- `move`: перенести Skill между `skills/` и `skills-mbb/`

## Entry Format
`- [action=<action>] [status=pending] title="<Title>" | scope="<Scope>" | skill_id="<existing_id>" | changes="<description>" | tags=[tag1, tag2] | priority="<low|medium|high|critical>" | context="<cursor_context>" | timestamp=<ISO8601>`

---

## 🚀 Candidates (Pending Review)

_Очищено после Batch Review 2026-01-27. Все кандидаты переведены в Approved или Archive._

---

## ✅ Archive (Recently Promoted)

### Batch Review 2026-01-27 (27 -> 11 approved, 3 merged)

#### Architecture (6 скиллов)

- [action=create] [status=drafted] title="SKILLS_ARCHITECTURE_SSOT" | scope="Консолидация документации в единый мастер-документ" | context="Commit fb14138. SSOT для архитектуры. markdown-lint.js" | priority="high" | timestamp=2026-01-27T23:00:00Z

- [action=merge] [status=approved] title="MONITORING_UNIFIED" | scope="Единая система мониторинга: alert-manager + health-check + status-report" | context="Merged c57c0f6 + bcf8af7. Алерты сервисов, проверка здоровья, комплексные отчеты." | priority="high" | timestamp=2026-01-27T23:00:00Z

- [action=create] [status=drafted] title="LLM_FALLBACK_MECHANISM" | scope="Отказоустойчивость: Mistral -> Ollama fallback" | context="Commit a925e9f. Автопереключение при недоступности API." | priority="critical" | timestamp=2026-01-27T23:00:00Z

- [action=merge] [status=approved] title="QUALITY_GATES_UNIFIED" | scope="Контроль качества: валидация + авто-исправление + pipeline automation" | context="Merged 7bb565f + ccc1164. Снижение warnings 132->8." | priority="high" | timestamp=2026-01-27T23:00:00Z

- [action=create] [status=drafted] title="CONTINUE_CLI_MISTRAL_INTEGRATION" | scope="HTTP-обертка Continue CLI + n8n workflows" | context="Commit 7c8cc90. 'Сердце' системы автоматизации." | priority="critical" | timestamp=2026-01-27T23:00:00Z

- [action=create] [status=drafted] title="MCP_SERVER_YAML_PARSING" | scope="MCP сервер для интеграции Skills с Cursor Agent" | context="Commit ce9ddc0. Model Context Protocol + YAML конфигурации." | priority="high" | timestamp=2026-01-27T23:00:00Z

#### Mathematical Models (3 скилла)

- [action=create] [status=drafted] title="COINGECKO_PROVIDER_STABILITY" | scope="Стабилизация провайдера данных CoinGecko" | context="Commit 62b21f9. Обработка ответов API, повторные запросы." | priority="medium" | timestamp=2026-01-27T23:00:00Z

- [action=create] [status=drafted] title="AUTO_COIN_SETS" | scope="Автоматические наборы монет для анализа секторов" | context="Commit d893b54. auto-coin-sets.js + модальные окна." | priority="medium" | timestamp=2026-01-27T23:00:00Z

- [action=create] [status=drafted] title="ASSET_METADATA_STABLECOINS" | scope="Метаданные стейблкоинов и wrapped токенов" | context="Commit 532d4e3. Генератор и загрузчик метаданных." | priority="medium" | timestamp=2026-01-27T23:00:00Z

#### UI (2 скилла)

- [action=merge] [status=approved] title="UI_COMPONENTS_UNIFIED" | scope="Единая система UI: dropdowns, modals, search, favorites" | context="Merged 6 commits: c5aed93, 314264d, e98dac7, 1dbf516, 224f52f, 6abb12f. 2334 lines." | priority="medium" | timestamp=2026-01-27T23:00:00Z

- [action=create] [status=drafted] title="WORKFLOW_UI" | scope="Веб-интерфейс WorkFlow UI для управления процессами" | context="Commit 5106ad5. HTML UI, API endpoints, automated tests." | priority="high" | timestamp=2026-01-27T23:00:00Z

### Rejected as Non-Skills (16 items)

_Промежуточные коммиты, тривиальные изменения или дубликаты, перекрытые более поздними скиллами:_

- 069466f: Documentation & Logging (перекрыт 5106ad5)
- 9ac1fed: add N8N_API_KEY to .env (тривиально)
- d7a65bb: Протокол Взаимодействия Агентов (перекрыт 7c8cc90)
- 1ef3775: Remove n8n runtime files (чистка мусора)
- 7fca700: n8n migration status (устаревшая документация)
- 4c3f49d: Local n8n Setup + Backlog Watcher (перекрыт WorkFlow UI)
- b430f54: Docker and n8n Community (промежуточный)
- 4877f81: n8n Community prepare #2 (промежуточный)
- 6cd6467: Correcting links of Skills (массовый рефакторинг ссылок)
- a2cad1a: Перелинковка Skills для шапок (дубликат 6cd6467)
- 10272c3: Quality Baseline & Standard (перекрыт 7bb565f)
- 01c225c: Яндекс и Perplexity (архивная документация)
- c39b055: Initial Russian Skills (начальный этап)
- 99091a9: SKILLS (первый коммит, устарел)

---

## 📋 Legacy Archive

### Quality Audit Tasks (COMPLETED: 132 -> 8 warnings)

- [action=update] [status=completed] skill_id="architecture-*" | changes="Added ## Scope and ## When to Use sections" | priority="medium" | context="Quality audit: 6 files fixed" | timestamp=2026-01-27T15:00:00Z
- [action=update] [status=completed] skill_id="cache-*" | changes="Added ## Scope and ## When to Use sections" | priority="medium" | context="Quality audit: 3 files fixed" | timestamp=2026-01-27T15:00:00Z
- [action=update] [status=completed] skill_id="components-*" | changes="Added ## Scope and ## When to Use sections" | priority="medium" | context="Quality audit: 10 files fixed" | timestamp=2026-01-27T15:00:00Z
- [action=update] [status=completed] skill_id="integrations-*" | changes="Added ## Scope and ## When to Use sections" | priority="medium" | context="Quality audit: 11 files fixed" | timestamp=2026-01-27T15:00:00Z
- [action=update] [status=completed] skill_id="libs-*" | changes="Added ## Scope and ## When to Use sections" | priority="medium" | context="Quality audit: 4 files fixed" | timestamp=2026-01-27T15:00:00Z
- [action=update] [status=completed] skill_id="metrics-*" | changes="Added ## Scope and ## When to Use sections" | priority="medium" | context="Quality audit: 3 files fixed" | timestamp=2026-01-27T15:00:00Z
- [action=update] [status=completed] skill_id="ux-*" | changes="Added ## Scope and ## When to Use sections" | priority="medium" | context="Quality audit: 1 file fixed" | timestamp=2026-01-27T15:00:00Z

### Previously Promoted

- [status=promoted] title="integrations-overview" | action="merge" | source="integrations-status, integrations-strategy" | priority="medium" | timestamp=2026-01-26T17:30:00Z
- [status=promoted] title="integrations-n8n-local-setup" | action="create" | source="n8n-migration" | priority="medium" | timestamp=2026-01-26T12:50:46Z
- [status=promoted] title="integrations-data-providers" | scope="Единый интерфейс и конфигурация провайдеров данных" | priority="medium" | timestamp=2026-01-25T14:10:00.000Z
- [status=promoted] title="integrations-rate-limiting" | scope="Централизованное ограничение запросов к API" | priority="medium" | timestamp=2026-01-25T14:10:00.000Z
- [status=promoted] title="integrations-postgres" | scope="Интеграция и синхронизация с PostgreSQL" | priority="medium" | timestamp=2026-01-25T14:10:00.000Z
- [status=promoted] title="libs-metadata-generation" | scope="Генерация и загрузка метаданных монет" | priority="medium" | timestamp=2026-01-25T14:10:00.000Z
- [status=promoted] title="components-icon-manager" | scope="Единый источник URL иконок" | priority="medium" | timestamp=2026-01-25T14:10:00.000Z
- [status=promoted] title="core-systems-auto-coin-sets" | scope="Автоматическое формирование наборов монет" | priority="medium" | timestamp=2026-01-25T14:10:00.000Z
- [status=promoted] title="core-systems-workspace-config" | scope="ЕИП для настроек рабочей зоны" | priority="medium" | timestamp=2026-01-25T14:10:00.000Z
- [action=create] [status=drafted] title="feat(core): Advanced Error Recovery & Self-Healing System" | category="Architecture" | scope="feat(core): Advanced Error Recovery & Self-Healing System" | context="Commit abc123d: feat(core): Advanced Error Recovery & Self-Healing System. Files: core/errors/error-recovery.js, core/errors/self-healing-manager.js, core/state/recovery-state.js, scripts/health-monitor.js. Lines: +847. Batch Review Auto-Approve" | priority="medium" | timestamp=2026-01-27T20:48:21.225Z
