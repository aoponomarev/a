---
id: process-unified-mcp-orchestration
title: "Unified MCP Orchestration"
description_ru: "Стратегия использования единых MCP-серверов для кодинга (Cursor) и автоматизации (n8n), исключающая дублирование логики интеграций."
scope: architecture, mcp, n8n
tags: [architecture, mcp, n8n, integration]
priority: high
created_at: 2026-02-02
updated_at: 2026-02-02
---

# Unified MCP Orchestration

## Overview
Этот навык определяет стандарт использования Model Context Protocol (MCP) как единого слоя абстракции для всех агентов системы MBB. Вместо написания отдельных "HTTP Request" нод в n8n и отдельных тулов для Cursor, мы создаем один MCP-сервер, который подключается к обоим потребителям.

## Context
С выходом n8n v2.7.0 и поддержкой MCP в Cursor, появилась возможность использовать одни и те же инструменты в разных средах.

## Guidelines

1.  **Single Source of Logic**: Вся логика работы с внешними API (база знаний, управление задачами, Git) должна быть упакована в MCP-серверы в папке `mbb/mcp/`.
2.  **Dual Integration**:
    *   **Cursor**: Подключается через `settings.json` (или `cursor /mcp enable`). Используется для кодинга и ответов на вопросы.
    *   **n8n**: Подключается через ноду "MCP Client". Используется для регулярных задач и событийных триггеров.
3.  **Network Access**: Docker-контейнер n8n должен иметь сетевой доступ к MCP-серверам (через внутреннюю сеть Docker или `host.docker.internal`).

## Examples
*   **Skill Management**: MCP-сервер `skills-mcp` используется Cursor'ом для поиска навыков при написании кода и n8n'ом для еженедельной генерации дайджеста навыков.
