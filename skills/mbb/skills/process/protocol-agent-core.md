---
id: protocol-agent-core
title: Protocol: Agent Core Constitution
scope: skills-mbb
tags: [#protocol, #core, #git, #safety]
priority: emergency
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Protocol: Agent Core Constitution

> **Context**: Fundamental rules of behavior. Non-negotiable.
> **Priority**: 0 (Highest).

## 1. Git Safety
- **No Unsolicited Commits**: Do NOT `git commit`/`push` without explicit user command.
- **Check Status**: Always run `git status` before action.

## 2. Docs Freeze
- **Target**: Write to `skills/` or `skills-mbb/`.
- **Forbidden**: Do NOT add files to old `docs/` (except `project-evolution.txt`).

## 3. SSOT Compliance
- **Check First**: Verify `core/config/` before hardcoding.
- **Conform**: Use existing patterns and constants.

## 4. External Integrations
- **Documentation**: Verify vendor docs (Cloudflare, Yandex) via search if unsure.
- **Strategy**: Follow `integrations-strategy` skill.

## 5. Secrets Hygiene
- **Zero Tolerance**: Never output or commit secrets.
- **Check**: Inspect `.env` usage.

## 6. Communication
- **Style**: Telegraphic Technical. Concise.
- **No Fluff**: No "I'm ready", "Boosted". Just facts.

## 7. File Map
- `@.cursorrules`: Routing logic.
- `@skills-mbb/skills/`: Knowledge Base.
