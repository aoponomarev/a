---
id: process-agent-commands
title: Process: Agent Commands (KM v2.0)
scope: skills
tags: [#process, #agent, #commands, #омк, #km-v2]
version: 2.0.0
priority: high
shadow_index: "Dictionary of system commands (ОМК, ЕИП, АИС, ФИН) used to trigger specific agent behaviors and protocols. Essential for intent routing."
relations: [protocol-command-omk, architecture-ssot, architecture-core-stack, process-external-integration-closure]
created_at: 2026-01-25
updated_at: 2026-02-15
---

# Process: Agent Commands (KM v2.0)

> **Context**: User commands controlling Agent behavior.
> **Triggers**: `ОМК`, `ЕИП`, `АИС`, `КАИ`, `ФИН`.

## 1. Command Dictionary
- **`ОМК`**: "Answer Maximally Briefly". No fluff.
- **`ЕИП`**: SSOT verification (Unified Source of Truth).
- **`АИС`**: Full Architecture & Infrastructure analysis.
- **`КАИ`**: Код/Архитектура/Инфраструктура (Full CAI analysis).
- **`ФИН`**: Finalization of integration (Closure Protocol).
- **`ВЗП`**: Planned autonomous execution (Default).

## 2. Rules
1.  **Intent Detection**: When a command is present, the agent MUST prioritize the corresponding protocol skill.
2.  **SSOT**: Final rules live in Skills, not chat.
3.  **Read-Only**: Do not edit Skills without explicit "Update Skill" command or during a dedicated KM task.

## 3. File Map
- `@process/protocol-command-omk.md`: `ОМК` Protocol.
- `@process/process-external-integration-closure.md`: `ФИН` Protocol.
- `// Skill anchor: Command Interface`: Located in `skills-router.mdc`.
