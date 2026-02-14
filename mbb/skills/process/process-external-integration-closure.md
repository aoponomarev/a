# Process: External Integration Closure (Meta-Skill)

> **Context**: Protocol for ensuring 100% completion of any external service, library, or framework integration.
> **Goal**: Prevent "blind spots" by automatically updating sources, evolution logs, and skill anchors.

## 1. Trigger
This protocol **MUST** be activated immediately after:
- Successful integration of a new external API or service (e.g., GitHub Workspace, CoinGecko).
- Adding a new library to `package.json` (e.g., `better-sqlite3`).
- Implementing a new infrastructure layer (e.g., Docker, Yandex Cloud Functions).

## 2. Closure Checklist (The "Three Pillars")

### Pillar I: Knowledge & Monitoring (Sources)
- [ ] **Identify**: Find the official Changelog, RSS feed, or Blog tag for the integrated service.
- [ ] **Register**: Add the URL to `events/NEWS_SOURCES.json`.
  - *Priority*: 8-10 for core infra, 5-7 for libs.
  - *Note*: Ensure `type` is correctly set (`github`, `official`, or `llm-api`).
- [ ] **Status Mapping**:
  - **IF** the source is NOT yet integrated into MBB code/logic:
    - Set `integrated: false` in `NEWS_SOURCES.json`.
    - *UI Rule*: These sources are displayed at the bottom with `.opacity-50`.
  - **IF** the source is already integrated:
    - Set `integrated: true`.
    - *UI Rule*: These sources are displayed in the primary zone.
- [ ] **Verify**: Ensure n8n `V2_NEWS_Swarm` can reach the source.

### Pillar II: History & Context (Evolution)
- [ ] **Log**: Add a cumulative entry to `docs/project-evolution.txt`.
  - *Protocol*: Follow `process-project-evolution-logging.md`.
  - *Content*: Summarize Code (К), Architecture (А), and Infrastructure (И) changes.

### Pillar III: Code-Skill Loop (Anchors)
- [ ] **Skill Creation**: Ensure a dedicated Skill file exists for the integration.
- [ ] **Anchoring**: Apply `process-skill-code-loop-anchors.md`.
  - Add `* Skill:` to file headers.
  - Add `// Skill anchor:` to risk branches (API calls, fallbacks, config loading).

## 3. Automation Heuristics for Agents
Before reporting "Task Completed", the agent must:
1. Scan `package.json` and `docker-compose.yml` for new entries.
2. Search for "Changelog" or "Releases" URLs for any new dependency.
3. If `NEWS_SOURCES.json` is missing the source -> **Propose/Add it**.
4. If `project-evolution.txt` is not updated for today -> **Update it**.

## 4. Failure Recovery
If this meta-skill fails to trigger:
- The `scripts/skills-background-worker.js` (running every 6h) will flag missing sources for new dependencies.
- The developer should manually invoke `ВЗП: Заверши интеграцию [Service Name]`.
