---
id: docker-container-networking-debug
title: Troubleshooting: Docker Networking
scope: skills-mbb
tags: [#troubleshooting, #docker, #networking, #localhost]
priority: high
created_at: 2026-01-28
updated_at: 2026-02-01
---

# Troubleshooting: Docker Networking

> **Context**: Communicating between containers and host.
> **Rule**: `localhost` in container != `localhost` on host.

## 1. The Problem
App inside Docker cannot reach API on `localhost:3002`.

## 2. Solution
- **Host -> Container**: Use mapped port (e.g. `3002`).
- **Container -> Container**: Use Service Name (e.g. `http://continue-cli:3000`) or Internal Port.
- **Container -> Host**: Use `host.docker.internal`.

## 3. Common Pitfall
Using **External Port** (3002) inside the container.
- **Wrong**: `http://localhost:3002` (inside Docker).
- **Correct**: `http://localhost:3000` (Internal port).

## 4. File Map
- `@docker-compose.yml`: Network definitions.
