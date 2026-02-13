---
id: libs-repo-setup
title: Libs: Repository Setup
scope: skills-mbb
tags: [#libs, #git, #setup, #cdn]
priority: low
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Libs: Repository Setup

> **Context**: How to initialize or restore the `libs` submodule.

## 1. Architecture
- **Type**: Standalone Git Repository.
- **Role**: Serves as a CDN via GitHub Pages.
- **Branch**: `main`.

## 2. Workflow
1.  **Clone**: `git clone https://github.com/aoponomarev/libs`.
2.  **Populate**: Run `download-libs.sh`.
3.  **Enable Pages**: Settings -> Pages -> Source: Deploy from branch `main` / `root`.

## 3. Maintenance
- **Update**: Add new version folder -> Commit -> Push.
- **Clean**: Remove old unused versions to save space.

## 4. File Map
- `@libs/download-libs.sh`: Setup script.
