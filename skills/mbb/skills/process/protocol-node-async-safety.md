# Node.js Async Safety & Performance (v1.0)

> **Goal**: Ensure reliable and performant execution of Node.js services.
> **Skill Anchor**: `control-plane/server.js`

## 🛡️ ASYNC SAFETY (С1)

- **Error Handling**: Always wrap `await` calls in `try/catch` or use `.catch()` to prevent `unhandledRejection`.
- **Promise.allSettled**: Prefer `Promise.allSettled` over `Promise.all` when independent tasks (like health checks) should not fail the entire operation.
- **Graceful Shutdown**: Implement `SIGTERM/SIGINT` handlers to close resources (DB, files) before exit.

## ⚡ PERFORMANCE (Ф4)

- **Worker Threads**: Use `node:worker_threads` for CPU-intensive tasks (like deep indexing) to avoid blocking the event loop.
- **Diagnostics**: Enable `--report-on-fatalerror` to generate crash reports in `logs/` for debugging.
- **Source Maps**: Enable `--enable-source-maps` for accurate stack traces in production.

## 🔗 INTEGRATION (И4)

- **Env Validation**: Use `Zod` to validate `process.env` at startup. Fail fast if critical keys are missing.
- **Production Mode**: Always set `NODE_ENV=production` in Docker to enable optimizations.
