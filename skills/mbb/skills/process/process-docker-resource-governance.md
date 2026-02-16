# Docker Resource & Profile Governance (v1.0)

> **Goal**: Manage host resource allocation based on operational context.
> **Skill Anchor**: `docker-compose.yml` (profiles)

## 🎭 OPERATIONAL PROFILES (Ф1)

| Profile | Services | Use Case |
| :--- | :--- | :--- |
| **`core`** | n8n, continue-cli | Standard automation & AI assistance. |
| **`all`** | All + Maintenance tools | Deep indexing, migrations, audits. |

## 💾 I/O OPTIMIZATION (Н2)

- **`nocopy`**: Use on all bind-mounts to prevent Docker from trying to copy data from the container to the host during initialization.
- **`tmpfs`**: Map `/tmp` to RAM to avoid disk I/O for short-lived temporary files.

## 📈 MONITORING (И4)

- **Logs**: Max 3 files of 10MB each per container.
- **Health**: Aggressive healthchecks (10s interval) ensure that dependent services (like n8n) only start when their dependencies (like continue-cli) are fully ready.
