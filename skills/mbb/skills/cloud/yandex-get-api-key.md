---
id: cloud-yandex-get-api-key
title: Cloud: Yandex API Key Retrieval
scope: skills-mbb
tags: [#cloud, #yandex, #iam, #security]
priority: low
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Cloud: Yandex API Key Retrieval

> **Context**: Obtaining credentials for Yandex Cloud services.

## 1. Procedure
1.  **IAM Section**: Go to Yandex Cloud Console -> IAM.
2.  **Service Account**: Select the `mbb` account.
3.  **Create Key**: Click "Create API Key" in the "Keys" tab.
4.  **Save**: Copy the key immediately (`AQVN...`). It is shown only once.

## 2. Usage
- Add to `MBB/.env` as `YANDEX_API_KEY`.
- Add to Cloud Function Environment Variables.

## 3. Security
- **Leak**: If leaked, delete the key in Console and rotate immediately.
- **Lost**: If lost, create a new one. Old keys cannot be recovered.

## 4. File Map
- `@.env`: Local storage (gitignored).
