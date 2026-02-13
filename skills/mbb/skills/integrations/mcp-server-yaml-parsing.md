---
id: mcp-server-yaml-parsing
title: MCP Server YAML Parsing
description_ru: Навык для разбора YAML-файлов серверной конфигурации MCP (Master Control Program) с валидацией и извлечением ключевых параметров.
scope: integrations, configuration
tags: [YAML, Parsing, Configuration, MCP, Architecture]
priority: high
created_at: 2026-02-01
updated_at: 2026-02-01
---

# MCP Server YAML Parsing

## Overview
This skill is designed for processing YAML configuration files for MCP servers. It includes structure parsing, validation of mandatory parameters, and extraction of key configurations.

## Steps

### 1. Load YAML File
```javascript
const yaml = require('js-yaml'); // Use js-yaml for reliable parsing
const fs = require('fs');

function loadConfig(path) {
    try {
        const content = fs.readFileSync(path, 'utf8');
        // Handle environment variable substitution if needed
        const substituted = content.replace(/\${(\w+)}/g, (m, key) => process.env[key] || m);
        return yaml.load(substituted);
    } catch (e) {
        console.error(`[Config] Failed to load ${path}:`, e.message);
        return null;
    }
}
```

### 2. Manual Line-by-Line Parsing (Bypassing CLI Bugs)
For critical components like `continue-cli` where official parsers might fail due to empty arrays or specific flags, a robust line-by-line parser is preferred:
```javascript
function loadModelsFromConfig(content) {
    const models = [];
    const lines = content.split('\n');
    let currentModel = null;
    let inModelsSection = false;
    
    for (const line of lines) {
        if (line.match(/^models:\s*$/)) { inModelsSection = true; continue; }
        if (inModelsSection && line.match(/^[a-zA-Z]/) && !line.startsWith(' ')) { inModelsSection = false; }
        if (!inModelsSection) continue;
        
        if (line.match(/^\s*- name:\s*/)) {
            if (currentModel) models.push(currentModel);
            currentModel = { name: line.replace(/^\s*- name:\s*/, '').trim() };
            continue;
        }
        // ... parse properties like model:, provider:, apiBase:
    }
    return models;
}
```

### 3. Extract Server Parameters
- Parse `apiBase`, `apiKey`, and `model` identifiers.
- Handle environment variable substitution (e.g., `${GROQ_API_KEY}`).

### 4. Network & Security Validation
- Validate API hostnames and endpoint paths.
- Ensure sensitive data is not hardcoded but referenced via environment variables.

## Validation
1. **Structural Validation**: Ensure all required sections exist.
2. **Type Validation**: Verify numeric values (ports, timeouts) and string formats (IDs).
3. **Semantic Validation**: Check for valid provider names (mistral, groq, openrouter).
