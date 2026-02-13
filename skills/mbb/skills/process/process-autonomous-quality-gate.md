---
id: process-autonomous-quality-gate
title: "Autonomous Quality Gate"
description_ru: "Автоматизированный контроль качества релизов с использованием n8n и Currents.dev для E2E тестирования."
scope: devops, testing, n8n
tags: [qa, testing, ci-cd, n8n]
priority: high
created_at: 2026-02-02
updated_at: 2026-02-02
---

# Autonomous Quality Gate

## Overview
Внедрение автоматических проверок качества (Quality Gate) в пайплайн доставки кода, управляемый n8n.

## Context
Для обеспечения стабильности релизов необходим этап объективного контроля, который не зависит от усталости разработчика.

## Guidelines

1.  **Trigger**: Запуск тестов происходит автоматически при пуше в `main` или создании PR.
2.  **Execution**: n8n инициирует запуск тестов (Playwright/Cypress) и отправляет результаты в Currents.dev.
3.  **Analysis**: n8n получает отчет от Currents.dev. Если есть ошибки, логи передаются LLM для генерации гипотез исправления.
4.  **Blocker**: Релиз блокируется, если Quality Gate не пройден.

## Examples
*   После обновления UI-компонента n8n запускает E2E тесты. Если тест "Login Flow" падает, агент получает уведомление с точным местом ошибки и скриншотом.
