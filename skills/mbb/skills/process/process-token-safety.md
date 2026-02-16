---
id: process-token-safety
title: "Process: Token-Safe Search & Grep Protocol (Anti-Token-Eater)"
scope: skills-mbb
tags: [#tokens, #safety, #grep-performance, #indexing, #anti-pattern]
version: 1.0.0
priority: high
shadow_index: "Protocol to prevent excessive token consumption during code search. Mandatory index-first search, path-limited grep, and avoidance of full-file reads for large files."
---

# Process: Token-Safe Search & Grep Protocol (Anti-Token-Eater)

> **Context**: Prevention of "Token Eater" incidents where AI agents consume millions of tokens by performing unoptimized full-codebase searches or reading massive files.

## 1. The "Token Eater" Anti-Pattern
- **Blind Grep**: Running `grep` or `rg` on the workspace root without path filters.
- **Massive Read**: Using `read_file` on files > 100KB without `offset`/`limit`.
- **Repeated Search**: Running the same broad search multiple times in a loop.

## 2. Mandatory Search Protocol

### Step 1: Index-First (Zero Token Cost)
Before using `grep` or `read_file`, ALWAYS use:
1. `skills-manifest.json` (via `search_skills` or reading the manifest) to find logic by "Shadow Index".
2. `Glob` to find files by name patterns.
3. `find_skills_for_file` to see what rules govern a specific file.

### Step 2: Scoped Grep (Low Token Cost)
If you must use `grep`:
1. **NEVER** search the root `[]` if you can narrow it down to a directory (e.g., `mcp/`, `scripts/`).
2. **ALWAYS** use `type` or `glob` filters (e.g., `type: "js"`, `glob: "*.html"`).
3. **LIMIT** output using `head_limit`.

### Step 3: Chunked Read (Safe Token Cost)
If a file is large (> 50KB or > 1000 lines):
1. **DO NOT** read the whole file.
2. Use `grep` to find the line numbers of interest.
3. Use `read_file` with `offset` and `limit` (e.g., 100 lines around the match).

## 3. Skill Anchors for Safety
Every file > 2000 lines MUST have a safety anchor at the top:
```javascript
// Skill anchor: process-token-safety (Large file: use chunked reads only)
```

## 4. Enforcement
If an agent detects a "Token Eater" behavior (e.g., a tool call returning "File too large" or thousands of grep matches):
1. **STOP** immediately.
2. Switch to `Plan` mode.
3. Use the `indexer` (manifest) to find a more surgical approach.
