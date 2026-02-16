# Docker Disaster Recovery Protocol (v1.0)

> **Goal**: Rapid restoration of the MBB containerized environment after failure.
> **SSOT**: `docker-compose.yml`

## 🚨 EMERGENCY RECOVERY (recover)

If containers fail to start or are in a `restarting` loop:

1.  **Full Reset**:
    ```bash
    docker compose down --remove-orphans
    docker compose up -d --force-recreate
    ```
2.  **Cache Purge**:
    ```bash
    docker builder prune -a
    docker compose build --no-cache
    ```
3.  **Volume Check**:
    If SQLite is corrupted, restore from `_migration_backup/` or OneDrive version history.

## 🧹 MAINTENANCE (Ф1)

Use profiles to manage load:
- **Core only**: `docker compose --profile core up -d`
- **All services**: `docker compose --profile all up -d`

## 📊 LOG AUDIT (И3)

Logs are limited to 10MB x 3 files. To view real-time errors:
```bash
docker compose logs -f --tail 100 n8n
```

## 🛡️ HARDENING (С2)

- **Init Handling**: All Node.js containers use `tini` as PID 1 to prevent zombie processes.
- **Read-Only**: Critical templates are mounted as `:ro`.
- **Tmpfs**: `/tmp` is mounted in RAM to reduce SSD wear and speed up I/O.
