---
id: process-n8n-browser-cache
title: Troubleshooting: n8n Browser Cache
scope: skills-mbb
tags: [#troubleshooting, #n8n, #browser, #404]
priority: medium
created_at: 2026-01-31
updated_at: 2026-02-01
---

# Troubleshooting: n8n Browser Cache

> **Context**: 404 errors in n8n UI after database reset.

## 1. Symptoms
- `GET /rest/workflows/XYZ 404` in Console.
- UI stuck or showing errors on load.

## 2. Cause
Browser `localStorage` caches IDs of workflows that no longer exist in the new DB.

## 3. Fix
1.  **F12** -> Application Tab.
2.  **Storage** -> Clear Site Data.
3.  **Reload**.

## 4. Prevention
Use Incognito mode when testing DB migrations.
