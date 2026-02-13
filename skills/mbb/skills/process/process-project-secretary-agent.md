---
id: process-project-secretary-agent
title: "Project Secretary Agent"
description_ru: "Внедрение агента-секретаря через интеграцию n8n и Microsoft Agent 365 для управления коммуникациями и документами."
scope: automation, n8n, microsoft-365
tags: [automation, office365, agent]
priority: medium
created_at: 2026-02-02
updated_at: 2026-02-02
---

# Project Secretary Agent

## Overview
Навык интеграции n8n с экосистемой Microsoft 365 через протокол Agent 365 для автоматизации административных задач проекта.

## Context
MBB тесно интегрирован с OneDrive. Использование нативного агента MS позволяет работать с файлами и коммуникациями легально и безопасно.

## Guidelines

1.  **Scope**: Агент занимается только административными задачами (календарь, почта, сортировка файлов в OneDrive).
2.  **Identity**: Агент действует от имени выделенной "Service Identity" или делегированного доступа пользователя.
3.  **Integration**: Использовать ноду "Microsoft Agent 365 Trigger" в n8n для реакции на входящие письма или обновления документов.

## Examples
*   Агент мониторит папку "Входящие" в OneDrive, классифицирует файлы и раскладывает их по папкам проекта MBB, уведомляя владельца в Teams/Telegram.
