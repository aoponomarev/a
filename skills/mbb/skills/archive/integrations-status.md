---
title: integrations-status
tags:
  - "#mbb-spec"
  - "#integrations"
dependencies: []
mcp_resource: true
updated_at: 2026-01-24
---

# integrations-status

> Источник: `docs/integration-status-report.md`

## Реализовано

- Google OAuth через Cloudflare Workers
- YandexGPT через Yandex Cloud Functions
- Cloudflare D1 для пользователей и портфелей
- GitHub Pages хостинг + CDN libs
- Perplexity AI как фолбэк

## Частично

- Централизованная конфигурация провайдеров
- Облачное кэширование (KV/R2) — не интегрировано

## Требуется реализация (высокий приоритет)

- Integration Manager
- Фолбэк Workers AI между YandexGPT и Perplexity
- Бэкап D1 в Object Storage
