---
id: protocol-slash-commands-usage
title: "Protocol: Slash Commands Usage"
scope: skills
tags: [#protocol, #continue, #commands, #automation]
---
version: 1.0.0
priority: medium
shadow_index: "Standard for using and creating custom slash commands in Continue AI to automate MBB protocols."
relations: [protocol-command-vzp, process-external-integration-closure]
updated_at: 2026-02-15
---

# Protocol: Slash Commands Usage

> **Goal**: Accelerate routine tasks by turning textual protocols into executable IDE commands.

## 1. Core Commands

- `/vzp`: Initiates the **ВЗП** protocol (Planned Execution).
- `/fin`: Initiates the **ФИН** protocol (Closure & Discovery).
- `/edit`: Standard command for file modifications.

## 2. Usage Rules

1.  **Context Pinning**: Use slash commands in combination with context providers (e.g., `/vzp @file`).
2.  **Output Verification**: Every command that modifies the system must end with a verification summary.

## 3. Automation (Future)

Custom slash commands will be mapped to n8n workflows via `control-plane` to automate complex multi-step processes like "Create New Skill" or "Sync All Sources".

---
*MBB KM v2.0 | Principle: Command-Driven Workflow*
