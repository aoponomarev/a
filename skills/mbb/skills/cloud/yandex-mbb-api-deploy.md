---
id: yandex-mbb-api-deploy
title: Cloud - Yandex mbb-api Function Deployment
scope: skills-mbb
tags: [#cloud, #yandex, #deploy, #postgres, #migration]
priority: high
created_at: 2026-02-14
updated_at: 2026-02-14
---

# Cloud: Yandex mbb-api Function Deployment

> **Context**: The `mbb-api` Cloud Function is the PostgreSQL gateway. Deploying it requires YC CLI with OAuth.

## 1. Function Identity
- **Function ID**: `d4e4884229p96ea4kt1e`
- **Name**: `mbb-api`
- **Runtime**: `nodejs22`
- **API Gateway**: `d5dl2ia43kck6aqb1el5.k1mxzkh0.apigw.yandexcloud.net`
- **Folder ID**: `b1gv03a122le5a934cqj`
- **Cloud ID**: `b1g8tsm4n7rh8cn0tddl`

## 2. Deploy via YC CLI

### 2.1 Authenticate (one-time per session)
```bash
# Get OAuth token from browser:
# https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb
yc config profile create mbb-deploy
yc config set token <OAUTH_TOKEN>
yc config set cloud-id b1g8tsm4n7rh8cn0tddl
yc config set folder-id b1gv03a122le5a934cqj
```

### 2.2 Get current env vars (CRITICAL: preserve DB credentials)
```bash
yc serverless function version list --function-name mbb-api --limit 1
# Note the version ID, then:
yc serverless function version get <VERSION_ID> --format json > /tmp/fn-version.json
# Extract env vars for reuse in deploy command
```

### 2.3 Create ZIP and deploy
```bash
# From project root:
powershell -Command "Set-Location 'cloud\yandex\functions\mbb-api'; Compress-Archive -Path 'index.js','package.json','package-lock.json','node_modules' -DestinationPath 'mbb-api-deploy.zip' -Force"

yc serverless function version create \
  --function-name mbb-api \
  --runtime nodejs22 \
  --entrypoint index.handler \
  --memory 128m \
  --execution-timeout 30s \
  --source-path mbb-api-deploy.zip \
  --environment "DB_HOST=<host>,DB_NAME=mbb_db,DB_PASSWORD=<pass>,DB_PORT=6432,DB_USER=mbb_admin"
```

### 2.4 Cleanup (security)
```bash
# Delete profile to remove token from disk:
yc config profile create temp-empty
yc config profile delete mbb-deploy
# Delete ZIP:
rm mbb-api-deploy.zip
```

## 3. DB Migration Pattern (via temporary admin endpoint)
When you need to run DDL on live PostgreSQL but have no direct DB access:
1. Add a temporary `POST /api/admin/migrate` endpoint to `index.js` with hardcoded safe DDL.
2. Deploy the function (step 2.3).
3. Call the endpoint: `curl -X POST https://<gateway>/api/admin/migrate -H "Content-Type: application/json" -d '{}'`.
4. Verify results in the JSON response.
5. **Remove** the admin endpoint from code immediately.
6. Redeploy the clean version.

This pattern avoids needing `psql` or direct DB access from the developer machine.

## 4. Verification
```bash
curl -s https://d5dl2ia43kck6aqb1el5.k1mxzkh0.apigw.yandexcloud.net/health
# Expected: {"status":"OK","server_time":"..."}
```

## 5. File Map
- `@cloud/yandex/functions/mbb-api/index.js`: Function code.
- `@cloud/yandex/functions/mbb-api/package.json`: Dependencies (pg).
- `@cloud/yandex/schema-postgres.sql`: Canonical DB schema.
- `@cloud/yandex/migrations/`: Migration scripts.
