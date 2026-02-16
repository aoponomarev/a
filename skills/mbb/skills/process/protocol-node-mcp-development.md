# Node.js MCP Development Protocol (v1.0)

> **Goal**: Standardize the creation and maintenance of MCP servers.
> **Skill Anchor**: `control-plane/server.js`

## 🏗️ ARCHITECTURE (С3)

- **SDK**: Use `@modelcontextprotocol/sdk` for standard-compliant implementation.
- **Transport**: Default to `StdioServerTransport` for local AI agent integration.
- **Schema**: Use `Zod` for tool input validation to provide clear error messages to agents.

## 🛠️ TOOL DESIGN

- **Null Safety**: Always handle `params || {}` in tool handlers.
- **Logging**: Use a dedicated logger to record tool usage and errors in `logs/`.
- **Safety Gates**: Implement dry-run and confirmation tokens for tools with side effects.

## 📡 CONNECTIVITY

- **Timeouts**: Implement timeouts for external API calls (e.g. n8n) using `AbortController`.
- **Health Checks**: Provide a `check_system_health` tool to verify connectivity to all dependencies.
