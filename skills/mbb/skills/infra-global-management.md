# Skill: Global Infrastructure Management (OneDrive SSOT)

## Context
The project uses a "Total Globalization" strategy where all critical registries, logs, and configurations are stored in a global OneDrive zone (`OneDrive/AI/Global`). This ensures consistency across different machines and environments (Docker, Local, WSL).

## Core Principles
1. **Single Source of Truth (SSOT)**: The `infra-registry.json` in OneDrive is the master record for all AI agents and models.
2. **Centralized Proxy**: `server.js` (Continue Wrapper) is the sole gateway for data access. No other node (n8n, UI, Scripts) should read/write global files directly if an API endpoint exists.
3. **Atomic Operations**: All writes to global JSON files must use the `registry-service.js` locking mechanism to prevent race conditions.
4. **Computed Status**: Agent availability is not just a flag; it's computed from software status, hardware (API keys), and health stats.

## File Structure
- `global/LLM/infra-registry.json`: Master registry of agents and models.
- `global/Logs/ai-activity.log`: Unified event stream.
- `global/n8n/processed_registry.json`: n8n stateless tracking.
- `global/Git/mbb-scan-registry.json`: Git history tracking.

## Implementation Patterns

### 1. Accessing Global Data in Node.js
Use the `scripts/path-resolver.js` utility (or env var `GLOBAL_ROOT`):
```javascript
const pathResolver = require('./scripts/path-resolver');
const GLOBAL_ROOT = pathResolver.resolveGlobalRoot();
```

### 2. Atomic Writes
Use the `registry-service.js`:
```javascript
const registryService = require('./lib/registry-service');
await registryService.writeJSON(PATH, data);
```

### 3. Hot Reloading
Use `fs.watch` to react to changes in the global registry without restarting the process.

### 4. Docker Configuration
Ensure the global zone is mounted using the `GLOBAL_ROOT` environment variable:
```yaml
volumes:
  - ${GLOBAL_ROOT}:/workspace/global:rw
```

## Maintenance
- Use the "Infrastructure" tab in Dashboard V2 to monitor connection status and API key health.
- Use "Force Global Sync" to manually refresh memory caches if `fs.watch` fails.
