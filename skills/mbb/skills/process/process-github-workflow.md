---
id: process-github-workflow
title: "Process: GitHub Agentic Collaboration"
scope: skills-mbb
tags: [#github, #workflow, #automation, #copilot, #actions]
---
version: 1.0.0
priority: medium
shadow_index: "Guidelines for hybrid cloud-local collaboration using GitHub Copilot Workspace and Actions with minimal token usage."
relations: [protocol-command-vzp, process-external-integration-closure]
updated_at: 2026-02-15
---

# Process: GitHub Agentic Collaboration

> **Goal**: Leverage GitHub's cloud intelligence while maintaining local self-sufficiency and minimizing token costs.

## 1. The Beacon Strategy

We use `.github/copilot-instructions.md` as a "Beacon" to guide cloud agents.
- **SSOT**: The file is updated automatically by `mbb-index-gen.js`.
- **Purpose**: Provides context to GitHub Copilot Workspace without manual prompt engineering.

## 2. Token-Saving Workflow (L3 Tasks)

For complex system-level tasks (L3), follow the **Planning-Only** pattern:

1.  **Create Issue**: Describe the task in a GitHub Issue.
2.  **Label Gating**: Add the label `L3-Discovery` to trigger the cloud analysis.
3.  **Workspace Planning**: Open the issue in Copilot Workspace.
4.  **Request Plan**: Use the prompt: *"Provide a detailed step-by-step plan only. Do not generate code yet."*
5.  **Local Execution**: Copy the plan to your local Cursor environment and execute using the `ВЗП` protocol.

## 3. Automated Quality Control

GitHub Actions (`quality-check.yml`) act as a "Free Guard":
- Runs `env:check` to ensure `.env.example` is synced.
- Runs `mbb-index-gen.js` to verify skill graph integrity.
- Performs syntax checks on MCP servers.

## 4. Hard Constraints

- **No Direct Cloud Commits**: Cloud agents should only propose changes via Pull Requests or Plans.
- **Local Validation**: Any code suggested by cloud agents MUST be verified locally via console before merging.
- **Zero-Cost**: Never use or suggest paid GitHub features beyond the free tier.

---
*MBB KM v2.0 | Principle: Hybrid Intelligence*
