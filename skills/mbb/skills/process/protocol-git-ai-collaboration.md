# Git AI Collaboration Protocol (v1.0)

> **Goal**: Harmonize human and AI agent contributions to the same repository.
> **Skill Anchor**: `.gitmessage`

## 🤝 COLLABORATION PATTERNS (С3)

- **Atomic Commits**: One logical change per commit. AI agents MUST follow the `.gitmessage` template.
- **Branching**: For complex tasks, AI agents should work in a feature branch (e.g., `agent/task-name`) and use PRs for review.
- **Conflict Resolution**: If a conflict occurs between human and AI, the human decision takes precedence. AI should provide a "Resolution Plan" before applying changes.

## 📝 METADATA (Ф1)

- **Git Notes**: Use `git notes add -m "AI_AGENT_ID: <id>"` to tag AI-generated commits without polluting the main message.
- **ROI Tracking**: Every commit MUST include an ROI assessment in the message to justify the change.

## 🛡️ PROTECTION (Ф3)

- **Secrets Masking**: The `mask-secrets` filter is active. Never bypass it.
- **Long Paths**: `core.longpaths` is enabled to support deep skill hierarchies on Windows.
