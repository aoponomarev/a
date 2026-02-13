---
id: process-n8n-docker-code-nodes
title: Process: n8n Code Nodes & Docker
scope: skills-mbb
tags: [#process, #n8n, #docker, #security, #troubleshooting]
priority: high
created_at: 2026-01-31
updated_at: 2026-02-01
---

# Process: n8n Code Nodes & Docker

> **Context**: Running custom Node.js logic inside n8n Code Nodes within a secured Docker environment.
> **SSOT**: `docker-compose.yml` (n8n service)

## 1. Problem
By default, n8n in Docker blocks access to native modules (`fs`, `child_process`) and prevents `Execute Command` nodes for security.

## 2. Configuration Fix
In `docker-compose.yml`:

```yaml
environment:
  # Allow Built-in Modules
  - NODE_FUNCTION_ALLOW_BUILTIN=child_process,fs,path,http,https,crypto,os,url,util
  # Allow External Modules (if needed)
  - NODE_FUNCTION_ALLOW_EXTERNAL=*
  # CRITICAL: Disable isolated runners to run code in main process
  - N8N_RUNNERS_ENABLED=false
  # Allow Env Var access
  - N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
```

## 3. Usage Pattern
Use `Code Node` instead of `Execute Command`.

```javascript
const { execSync } = require('child_process');
const stdout = execSync('node /home/node/mbb/scripts/myscript.js', { encoding: 'utf8' });
return [{ json: { stdout } }];
```

## 4. Hard Constraints
1.  **Runners Disabled**: Must set `N8N_RUNNERS_ENABLED=false` or code nodes will fail to import modules.
2.  **File Paths**: Use mapped paths (e.g., `/home/node/mbb/`) inside the container, not host paths (`D:/...`).
3.  **Restart**: Changing env vars requires `docker compose up -d --force-recreate`.

## 5. File Map
- `@docker-compose.yml`: Env vars configuration.
