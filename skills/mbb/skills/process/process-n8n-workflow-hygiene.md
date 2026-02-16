# n8n Workflow Hygiene & Performance (v1.0)

> **Goal**: Maintain high performance and reliability of the "Brain" (n8n) in a resource-constrained environment.
> **SSOT**: `.env` (n8n section)

## 🧹 DATA PRUNING (И1)

To prevent SQLite database bloat and performance degradation:
- **Max Age**: 168 hours (7 days).
- **Max Count**: 1000 executions.
- **Success Strategy**: Only save failed executions if the workflow is high-frequency and stable.
- **Manual Cleanup**: Periodically check `datasets/` size.

## ⚡ PERFORMANCE HACKS (Н1)

- **WAL Mode**: Enabled via `DB_SQLITE_POOL_SIZE=5` (implicit in n8n's SQLite driver when pooling is used).
- **Concurrency**: Use "Split in Batches" for large datasets to avoid memory spikes.
- **Wait Nodes**: Use "Wait" nodes with caution in high-frequency workflows (they keep the execution active).

## 🛡️ ERROR HANDLING (Ф1)

- **Global Error Workflow**: Every critical workflow MUST have an "Error Trigger" node connected to a notification system (Telegram/Email).
- **Retry Logic**: Use "Retry on Failure" settings for HTTP Request nodes (3 retries, 5s interval).
- **Fallback Values**: Always provide defaults for optional data to prevent "Expression error".

## 🧬 PARALLELISM (Ф2)

- **Parallel Execution**: Use the "Parallel" node for independent tasks to reduce total execution time.
- **Resource Limits**: Limit parallel branches to 3-5 to avoid CPU saturation on the host.

## 🔗 MCP SYNERGY (С1)

- **Direct Trigger**: Prefer `mode: "webhook"` or `/execute` endpoint for synchronous responses to AI agents.
- **Context Injection**: Pass `agent_id` and `session_id` in the `input` payload for traceability.
