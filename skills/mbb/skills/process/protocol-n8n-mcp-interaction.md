# MCP-to-n8n Interaction Protocol (v1.0)

> **Goal**: Standardize communication between AI Agents (via MCP) and n8n Workflows.
> **Skill Anchor**: `control-plane/src/n8n-client.js`

## 📡 TRIGGER MODES (И2)

| Mode | Endpoint | Use Case | Latency |
| :--- | :--- | :--- | :--- |
| **Manual (Sync)** | `/execute` | Default for agent tasks. Waits for result. | Low |
| **Manual (Async)** | `/run` | Long-running tasks. Returns execution ID. | Medium |
| **Webhook** | `/webhook/...` | High-performance, custom path triggers. | Lowest |

## 📥 INPUT STRUCTURE

AI Agents should provide data in the following format:

```json
{
  "action": "string",
  "payload": { ... },
  "metadata": {
    "agent": "cursor-agent",
    "timestamp": "ISO-8601"
  }
}
```

## 📤 OUTPUT EXPECTATIONS

Workflows should return a JSON object with at least:

```json
{
  "success": true,
  "result": { ... },
  "error": null
}
```

## 🛠️ TROUBLESHOOTING

- **404 Not Found**: Check if the workflow is **Active**.
- **401 Unauthorized**: Verify `N8N_API_KEY` in `.env`.
- **Timeout**: Default is 30s. For longer tasks, use `mode: "manual"` (async) and poll for status.
