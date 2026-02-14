# Process: Project Evolution Logging

> **Context**: Protocol for maintaining the `docs/project-evolution.txt` file to ensure a cumulative, non-redundant history of major project milestones.
> **SSOT**: `docs/project-evolution.txt`

## 1. Triggers for Logging
Add an entry when any of the following occur:
- Major architectural changes (e.g., switching to a new DB, adding a proxy layer).
- New integrations (e.g., GitHub Workspace, Cloudflare Workers).
- Significant refactorings affecting multiple modules.
- Introduction of new core systems (e.g., Skills System, Agent Layer).
- Deployment of major UI/UX paradigms (e.g., WorkFlow UI V2).

## 2. Analysis Protocol (CAI)
Before logging, the agent **MUST** perform a deep scan of the repository:
1. **Code (К)**: `git diff` and `git log` to identify logic changes.
2. **Architecture (А)**: Check for new files, directories, or structural shifts (e.g., Monorepo migration).
3. **Infrastructure (И)**: Check `.env`, `docker-compose.yml`, `package.json`, and CI/CD workflows.

## 3. Formatting Rules
- **Date Format**: `DD/MM/YY` (e.g., `14/02/26`).
- **Cumulative Principle**: **NEVER** create multiple entries for the same date. 
  - If an entry for today already exists, **merge** new information into it.
  - Summarize the essence of the day's work into a single, dense, high-level paragraph.
- **Separator**: Use `--------` (8 dashes) between different date blocks.
- **Tone**: Telegraphic Technical (dry, precise, no emojis).
- **Location**: Always add new entries to the **TOP** of the list (right after the "RULES" section).

## 3. Maintenance Protocol
- **Agent Responsibility**: Before closing a session (Handoff), the agent must check if any "Evolution-worthy" changes were made.
- **Verification**: Ensure no duplicate dates exist in the file.
- **Exclusions**: Do not log minor bug fixes, UI tweaks, or documentation-only updates (unless it's a major documentation system overhaul).

## 4. Automation & AI
- Agents should proactively suggest an update to `project-evolution.txt` after a successful `ВЗП` (Planned Execution) task.
- Use `grep` or `read_file` to check the last entry date before writing.
