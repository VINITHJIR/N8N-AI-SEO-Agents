# AI SEO Agent - Error Handling Guide

# Overview

This document describes common errors that may occur while setting up or running the AI SEO Agent and provides verified solutions.

The solutions in this document are based on actual testing performed during project validation.

---

# Error Categories

The project consists of multiple components.

```
Docker

↓

PostgreSQL

↓

n8n

↓

Credentials

↓

External APIs

↓

Workflow Execution
```

Each layer can generate different errors.

---

# Docker Errors

## Error

Containers are not running.

Example

```
Cannot connect to Docker daemon
```

## Cause

Docker Desktop is not running.

## Solution

Start Docker Desktop.

Verify

```bash
docker version
```

Expected

```
Client

Server
```

---

# PostgreSQL Connection Error

## Error

```
Database does not exist
```

or

```
Connection refused
```

---

## Cause

Wrong hostname.

Example

```
localhost

docker-postgres-1
```

---

## Correct Configuration

Host

```
seo-postgres
```

Database

```
seo_agent_db
```

User

```
postgres
```

Password

```
postgres
```

Port

```
5432
```

---

# Database Empty

## Error

```
Did not find any relations.
```

---

## Cause

Database created successfully.

Backup not restored.

---

## Solution

Copy backup

```bash
docker cp Database/seo_agent_db.backup seo-postgres:/tmp/seo_agent_db.backup
```

Restore

```bash
docker exec -it seo-postgres pg_restore -U postgres -d seo_agent_db --clean --if-exists -v /tmp/seo_agent_db.backup
```

Verify

```sql
\dt
```

---

# Workflow Does Not Exist

## Error

```
Workflow does not exist
```

---

## Cause

Execute Workflow node references an old internal workflow ID.

This occurs after importing workflows into a new n8n instance.

---

## Solution

Open the Execute Workflow node.

Re-select the target workflow from the dropdown.

Save the workflow.

Execute again.

---

# Gmail Authentication Error

## Error

```
Authentication failed
```

---

## Cause

OAuth token expired.

---

## Solution

Reconnect Gmail OAuth credentials.

Save.

Test connection.

---

# OpenAI Authentication Error

## Error

```
401 Unauthorized
```

---

## Cause

Invalid API Key.

---

## Solution

Create a new OpenAI credential.

Paste valid API key.

Save.

---

# SE Ranking Error

## Error

```
401 Unauthorized
```

or

```
403 Forbidden
```

---

## Cause

Invalid API Key.

Incorrect endpoint.

Expired subscription.

---

## Solution

Verify

- API Key
- API Endpoint
- Active Subscription

---

# PostgreSQL Restore Error

## Error

```
too many command-line arguments
```

---

## Cause

Linux command copied into Windows PowerShell.

---

## Incorrect

```powershell
pg_restore \
```

---

## Correct

```powershell
docker exec -it seo-postgres pg_restore -U postgres -d seo_agent_db --clean --if-exists -v /tmp/seo_agent_db.backup
```

Always use the single-line command in Windows PowerShell.

---

# Docker Network Error

## Error

```
Host not found
```

---

## Cause

Wrong hostname.

---

## Solution

Always use

```
seo-postgres
```

Never use

```
localhost

127.0.0.1

docker-postgres-1
```

inside Docker containers.

---

# Execute Workflow Failure

## Error

Agent 2 not executing.

---

## Cause

Workflow reference broken.

---

## Solution

Re-select Agent 2 in Execute Workflow node.

Save.

Execute again.

---

# Gmail Report Not Received

## Possible Causes

- Gmail authentication
- SMTP quota
- Workflow stopped
- Empty dataset

---

## Verify

email_logs

```sql
SELECT *
FROM email_logs;
```

---

# OpenAI Timeout

## Error

```
Timeout
```

---

## Solution

Retry execution.

Verify OpenAI service availability.

---

# Docker Volume Issues

## Problem

Old data still exists.

---

## Solution

Remove containers and volumes.

```bash
docker compose down -v
```

Restart

```bash
docker compose up -d
```

Restore backup again.

---

# Useful Verification Commands

Running containers

```bash
docker ps
```

Docker logs

```bash
docker logs seo-n8n
```

Database

```bash
docker exec -it seo-postgres psql -U postgres -d seo_agent_db
```

Tables

```sql
\dt
```

Competitors

```sql
SELECT COUNT(*) FROM competitors;
```

Backlink Sources

```sql
SELECT COUNT(*) FROM backlink_sources;
```

---

# Troubleshooting Checklist

Before reporting an issue verify:

✅ Docker Desktop Running

✅ docker compose up -d completed

✅ PostgreSQL Running

✅ n8n Running

✅ Database Restored

✅ Workflows Imported

✅ PostgreSQL Connected

✅ Gmail Connected

✅ OpenAI Connected

✅ SE Ranking Connected

✅ Agent 1 Working

✅ Agent 2 Working

✅ Agent 3 Working

---

# Error Logging

The project stores runtime failures inside

```
error_logs
```

Email execution history is stored inside

```
email_logs
```

This enables debugging and auditing.

---

# Summary

Most issues can be resolved by verifying:

- Docker
- Database
- Credentials
- Workflow References
- API Keys

Following the Installation Guide step by step should prevent the majority of setup problems.