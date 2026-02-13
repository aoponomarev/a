---
id: integrations-n8n-code-node-v2
title: Integrations: n8n Code Node Patterns
scope: skills-mbb
tags: [#integrations, #n8n, #javascript, #troubleshooting]
priority: medium
created_at: 2026-01-27
updated_at: 2026-02-01
---

# Integrations: n8n Code Node Patterns

> **Context**: Best practices for JS logic inside n8n 2.x.

## 1. API Changes (v1 vs v2)
- **Input**: Use `$input.all()` instead of `items`.
- **First Item**: Use `$input.first()` instead of `items[0]`.
- **Node Data**: Use `$node["Name"].json`.

## 2. Common Gotchas
- **Async**: Ensure the node is toggled to "Async" if using `await` or `fetch`.
- **Console**: `console.log` is NOT visible in Docker logs. Return a debug object instead.
- **Binary**: Access binary data via `item.binary.data` and convert using `Buffer.from(..., 'base64')`.

## 3. Execution Commands
`Execute Command` nodes are disabled by default in MBB for security.
**Alternative**: Use an HTTP Request to the `continue-cli` wrapper or a custom Node.js script.

## 4. Hard Constraints
1.  **No Heavy Logic**: If a script exceeds 50 lines, move it to a standalone `.js` file in `scripts/` and call it via a wrapper.
2.  **Error Handling**: Always wrap Code Node logic in `try/catch` and return an error object.

## 5. File Map
- `@process-n8n-docker-code-nodes.md`: Environment setup.
