---
id: yandex-access-binding-issue
title: Troubleshooting: Yandex IAM Binding
scope: skills-mbb
tags: [#troubleshooting, #yandex, #iam, #permission]
priority: medium
created_at: 2026-01-24
updated_at: 2026-02-01
---

# Troubleshooting: Yandex IAM Binding

> **Context**: `PermissionDenied` when deploying Cloud Functions.

## 1. Rule
Role must be assigned to the **Folder**, not just the Service Account.

## 2. Fix
```bash
yc resource-manager folder add-access-binding <folder-id> \
  --role editor \
  --subject serviceAccount:<sa-id>
```

## 3. Validation
Check "Access Bindings" tab in Yandex Console for the Folder.
