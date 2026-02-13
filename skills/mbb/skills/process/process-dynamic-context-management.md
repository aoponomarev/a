---
id: process-dynamic-context-management
title: "Dynamic Context Management"
description_ru: "Методика динамического управления контекстом агента через Cursor CLI для фокусировки на конкретных задачах."
scope: workflow, cursor, cli
tags: [productivity, cursor, cli, context]
priority: high
created_at: 2026-02-02
updated_at: 2026-02-02
---

# Dynamic Context Management

## Overview
Навык использования возможностей Cursor CLI (vCLI) для переключения наборов инструментов "на лету", предотвращая засорение контекста агента.

## Context
Избыток инструментов в контексте LLM ухудшает качество ответов. Новый CLI позволяет включать инструменты только тогда, когда они нужны.

## Guidelines

1.  **Context Modes**:
    *   `architect`: Включены `filesystem`, `search`, выключены `coding-tools`.
    *   `coder`: Включены `coding-tools`, `linter`, `terminal`.
2.  **Switching Command**: Агент должен использовать терминал для смены режима:
    ```bash
    cursor /mcp disable all
    cursor /mcp enable needed-server
    ```
3.  **Session Start**: В начале сложной задачи агент должен явно определить и активировать необходимый минимальный набор инструментов.

## Examples
*   Перед рефакторингом базы данных агент отключает инструменты фронтенда и включает MCP для работы с SQL.
