---
id: skills-architecture-ssot
title: Skills Architecture SSOT
description_ru: "Способность проектировать и поддерживать архитектуру единого источника истины (SSOT) для навыков"
scope: architecture, meta
tags: [architecture, SSOT, knowledge_management, single_source_of_truth]
priority: high
created_at: 2026-02-01
updated_at: 2026-02-01
---

# Skills Architecture SSOT

## Overview
Designing and maintaining a Single Source of Truth (SSOT) for skills ensures consistency and ease of updates across different AI agents. This involves a centralized management system where metadata, dependencies, and versions are stored in one place.

## Key Components
1. **Centralized Repository**: `skills/` and `skills-mbb/` folders.
2. **Versioning System**: Git-based tracking of all skill changes.
3. **Synchronization Mechanism**: Ensuring OneDrive/Cloud sync for all machines.
4. **API for Interaction**: MCP servers providing `list_skills` and `read_skill` tools.
5. **Monitoring & Audit**: `skills-events.log` for tracking usage and extractions.

## Steps

### 1. Analyze Current State
- Identify all skill sources and their dependencies.
- Audit for synchronization issues or duplicates.

### 2. Design SSOT Structure
- Define folder hierarchy: `index/`, `architecture/`, `process/`, `integrations/`.
- Establish standard YAML front-matter schema.

### 3. Implementation
- Set up automated index generation (`generate-indexes.js`).
- Configure MCP servers to point to correct relative paths.

### 4. Integration
- Develop adapters for UI/CLI to interact with the skill repository.
- Ensure backward compatibility during major refactors.

## Validation
1. **Consistency Check**: All systems use the same skill versions.
2. **Audit Check**: All skill changes are recorded in Git history.
3. **Tool Accessibility**: Agents can reliably find skills using semantic search.
