---
id: troubleshoot-continue-cli-response-mismatch
title: "Troubleshooting: continue-cli Returns Wrong API Response"
scope: skills-mbb
tags: [#troubleshooting, #continue-cli, #docker, #api, #debugging]
priority: high
created_at: 2026-02-09
updated_at: 2026-02-09
---

# Troubleshooting: continue-cli Returns Wrong API Response

> **Context**: `curl http://127.0.0.1:3002/api/...` returns a response with missing fields or old behavior, despite `server.js` being correctly updated in the Docker container.
> **Incident**: Feb 2026 -- `/api/infra/model/add` returned 3 fields instead of 5.

## 1. Problem Pattern

You modify `mcp/continue-wrapper/server.js` to add new fields to an API response. You verify:
- File on host has the change.
- `docker exec grep` inside container shows the change.
- `md5sum` matches between host and container.

But `curl` still returns old response. Container logs don't show your request. Hours of debugging `sendJSON`, `Transfer-Encoding`, Node.js caching -- all dead ends.

## 2. Root Cause (Port Shadow)

A **local `node mcp/continue-wrapper/server.js`** process was running directly on Windows (outside Docker), also bound to port 3002. Windows allowed both Docker's `com.docker.backend.exe` and the local `node.exe` to listen on `0.0.0.0:3002`. The local Node.js served the old code.

## 3. Diagnosis Protocol (30 seconds)

```bash
# Step 1: How many listeners?
netstat -ano | findstr "3002"
# Expected: ONE PID. If TWO -> port shadow.

# Step 2: Who are they?
powershell -command "Get-Process -Id PID1 | Select-Object Name,Path"
powershell -command "Get-Process -Id PID2 | Select-Object Name,Path"

# Step 3: Kill the rogue
powershell -command "Stop-Process -Id ROGUE_PID -Force"

# Step 4: Test again
curl -s http://127.0.0.1:3002/api/infra/model/add -X POST \
  -H "Content-Type: application/json" \
  -d '{"uid":"test","modelId":"test/model:free","provider":"openrouter"}'
```

## 4. Differential Diagnosis

Before blaming port shadow, also rule out:
- **`docker-compose restart` vs `--force-recreate`**: Restart may not re-execute CMD on all Docker versions.
- **OneDrive sync lag**: Check `md5sum` inside container vs host.
- **Docker Desktop vpnkit**: Rarely, Docker's networking proxy caches connections.

## 5. Hard Constraints

- **FIRST ACTION on "response mismatch"**: Run `netstat -ano | findstr PORT`. Always.
- If internal test (`docker exec node -e "..."`) works but external doesn't -> 100% port/network issue.
- NEVER debug `sendJSON`, serialization, or Transfer-Encoding before checking port listeners.

## 6. File Map

- `@docker-compose.yml`: Port mapping `3002:3000`.
- `@mcp/continue-wrapper/server.js`: The server being shadowed.
