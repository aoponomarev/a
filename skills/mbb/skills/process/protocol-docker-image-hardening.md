# Docker Image & Runtime Hardening (v1.0)

> **Goal**: Ensure lightweight, secure, and performant container execution.
> **Skill Anchor**: `docker/continue-cli/Dockerfile`

## 🏗️ BUILD STRATEGY (Ф2)

- **Base Image**: Always use `-slim` or `-alpine` variants.
- **BuildKit Cache**: Use `--mount=type=cache,target=/root/.npm` to speed up builds.
- **Multi-Stage**: (Optional) Use multi-stage builds to keep production images small.

## 🏃 RUNTIME SECURITY (С2)

- **PID 1**: Always use an init system (`tini`) to handle signals and reap zombies.
- **Non-Root**: (Planned) Transition services to run as `node` user instead of `root`.
- **Resource Limits**: (Н1 - Optional) Define `mem_limit` and `cpus` in `docker-compose.yml` for critical services.

## 📡 NETWORKING (Н3)

- **Isolation**: Use internal networks for backend-to-backend communication.
- **Host Gateway**: Use `host.docker.internal` to access services running on the Windows host (like Obsidian or Ollama).
