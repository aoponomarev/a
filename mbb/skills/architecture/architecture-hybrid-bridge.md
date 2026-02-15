# Architecture: Hybrid Bridge Control Plane

> **Context**: Safe MCP control plane for orchestrating n8n workflows from Agent tools.
> **Goal**: Keep Agent side stateless and provider-agnostic while preserving strict execution safety.

## 1. Scope
- Control plane lives in `control-plane/`.
- It is a dedicated MCP server (stdio transport).
- It proxies operational calls to n8n API and logs every action.

## 2. Mandatory Tools
- `check_system_health`: verify n8n and optional infra health endpoints.
- `list_active_workflows`: read-only inventory of active workflows.
- `execute_workflow`: write operation with safety gates.
- `get_workflow_logs`: fetch recent execution entries.

## 3. Safety Gates (Must Keep)
- Default mode is dry-run (`CONTROL_PLANE_DRY_RUN_DEFAULT=true`).
- Runtime writes disabled unless `CONTROL_PLANE_ALLOW_MUTATIONS=true`.
- Destructive/side-effecting execution requires `confirmToken`.
- Invalid gate conditions must return `blocked`, not throw raw errors.

## 4. Paths and Logging
- Path resolution must use `scripts/path-resolver.js` as SSOT.
- Control-plane events are written to `logs/control-plane.log`.
- Never log secrets (`N8N_API_KEY`, confirm token).

## 5. Reliability Rules
- Timeouts required for all HTTP calls.
- Normalize endpoint compatibility (`/run` and `/execute` fallback).
- Health checks should degrade gracefully when optional endpoints are unset.

## 6. Evolution Checklist
- When adding new tool endpoints, update:
  - `control-plane/README.md`
  - `HYBRID_BRIDGE_PLAN.md`
  - skill anchors in affected `.js` files
