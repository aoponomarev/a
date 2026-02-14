---
id: process-skill-code-loop-anchors
title: Process - Skill-to-Code Loop Anchors
scope: skills-mbb
tags: [#process, #meta-skill, #cross-links, #comments, #regression, #anchors]
priority: high
created_at: 2026-02-12
updated_at: 2026-02-14
---

# Process: Skill-to-Code Loop Anchors

> **Context**: В MBB сложные баги часто повторяются как "новые", хотя паттерн решения уже оформлен в skills.
> **Цель**: привязать паттерн к коду в точках повторного риска.

## 1. Триггер
Применять всегда, когда:
- создается новый skill;
- существенно обновляется существующий skill;
- фикс оформляет повторяемый паттерн (retry/fallback/merge/cache).

## 2. Полный workflow создания/обновления skill

### Шаг A — Проверка существующих skills (ОБЯЗАТЕЛЬНО)
Перед созданием нового skill:
1. `search_skills("ключевые слова проблемы")` — найти пересекающиеся skills.
2. `find_skills_for_file("путь/к/файлу.js")` — найти skills, уже привязанные к файлу.
3. Если найден существующий skill на ту же тему — **обновить его**, а не создавать новый.
4. Если найден устаревший/конфликтующий skill — обновить или пометить для архивации.

### Шаг B — Создание/обновление skill
1. Frontmatter: без кавычек, без двоеточий в `title` (см. `process-skill-frontmatter-rules`).
2. Содержание: проблема, root cause, решение, file map.
3. Проверить что `read_skill(id)` возвращает правильный `title`.

### Шаг C — Обновление якорей в коде (ОБЯЗАТЕЛЬНО)
1. **Извлечь правило** из нового/обновленного skill.
2. **Найти hotspot** в коде, где это правило реально исполняется.
3. **Добавить/обновить header link** в JSDoc файла:
   ```js
   * Skill: a/skills/mbb/skills/category/skill-name.md
   ```
4. **Добавить inline anchor** в risk-ветке:
   ```js
   // Skill anchor: <причина существования ветки>.
   // See a/skills/mbb/skills/category/skill-name.md
   ```
5. **Удалить устаревшие якоря**, если skill был переименован/перемещён/удалён.

### Шаг D — Верификация
1. `find_skills_for_file("путь/к/файлу.js")` — убедиться что якоря видны MCP-серверу.
2. `audit_skill_coverage` — проверить что покрытие не упало.

## 3. Принцип размещения якорей
Недостаточно только шапки файла.
Ссылки должны стоять в ветках, где разработчик снова пойдет "искать с нуля":
- `retry/backoff` и `429` обработка;
- fallback ветки (локальный кэш / stale cache);
- merge + dedup логика наборов;
- классификация ошибок/статусов;
- cache-guard и invalidation развилки;
- KV/DB schema-зависимые участки;
- provider-specific data handling.

## 4. Формат якоря
```js
// Skill anchor: защищает от регрессии в 429/retry ветке.
// See a/skills/mbb/skills/integrations/integrations-rate-limiting.md
```

## 5. Критерий готовности
- [ ] Проверены существующие skills на пересечение (`search_skills`).
- [ ] У каждого нового/обновленного skill есть хотя бы один non-header якорь в risk-ветке.
- [ ] По комментарию понятно, почему ветка существует.
- [ ] Устаревшие якоря удалены/обновлены.
- [ ] `find_skills_for_file` подтверждает связь.
- [ ] В коде нет "декоративных" ссылок вне проблемных мест.
