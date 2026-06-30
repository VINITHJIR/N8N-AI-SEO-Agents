
# AI SEO Agent - Deployment Guide

# Overview

This guide explains how to deploy the AI SEO Agent on a new machine using Docker Compose.

This deployment process has been tested and verified.

Deployment Flow

```

Git Clone

↓

Create .env

↓

Docker Compose

↓

Restore Database

↓

Import Workflows

↓

Configure Credentials

↓

Run Agent 1

↓

Agent 2

↓

Agent 3

↓

Email Report

```

---

# Step 1 - Clone Repository

```bash
git clone https://github.com/<YOUR_USERNAME>/AISeoAgent.git
```

Go into project folder

```bash
cd AISeoAgent
```

---

# Step 2 - Configure Environment

Copy

```
.env.example
```

to

```
.env
```

Example

```env
POSTGRES_DB=seo_agent_db
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

N8N_PORT=5678
N8N_HOST=localhost
N8N_PROTOCOL=http

GENERIC_TIMEZONE=Asia/Kolkata
TZ=Asia/Kolkata
```

---

# Step 3 - Start Docker

Run

```bash
docker compose up -d
```

Expected

```
seo-postgres

seo-n8n
```

Verify

```bash
docker ps
```

Expected

```
seo-postgres

seo-n8n
```

---

# Step 4 - Open n8n

Open

```
http://localhost:5678
```

Create the Owner Account.

Login.

---

# Step 5 - Restore Database

Copy backup

```bash
docker cp Database/seo_agent_db.backup seo-postgres:/tmp/seo_agent_db.backup
```

Restore

```bash
docker exec -it seo-postgres pg_restore -U postgres -d seo_agent_db --clean --if-exists -v /tmp/seo_agent_db.backup
```

Verify

```bash
docker exec -it seo-postgres psql -U postgres -d seo_agent_db
```

Inside PostgreSQL

```sql
\dt
```

Expected

```
7 Tables
```

Exit

```sql
\q
```

---

# Step 6 - Import Workflows

Import

```
01_Agent1_SEO_Competitor_Monitor.json

02_Agent2_Backlink_Analyzer.json

03_Agent3_Competitor_Gap_Analysis.json
```

Verify

```
3 Workflows
```

---

# Step 7 - Configure PostgreSQL

Create PostgreSQL Credential.

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

SSL

```
Disabled
```

Test Connection.

Expected

```
Connection Successful
```

---

# Step 8 - Configure OpenAI

Create OpenAI Credential.

Paste

```
OpenAI API Key
```

Test Connection.

---

# Step 9 - Configure Gmail

Create Gmail OAuth2 Credential.

Authenticate Google.

Test Connection.

---

# Step 10 - Configure SE Ranking

Create API Credential.

Paste

```
SE Ranking API Key
```

Save.

---

# Step 11 - Verify Execute Workflow Nodes

After importing workflows into a new n8n instance:

Open Agent 1.

Locate

```
Execute Workflow
```

Re-select

```
Agent 2 – Backlink Analyzer
```

Save.

Open Agent 2.

Locate

```
Execute Workflow
```

Re-select

```
Agent 3 – Competitor Gap Analysis
```

Save.

This updates internal workflow references.

---

# Step 12 - Execute Agent 1

Open

```
Agent 1
```

Click

```
Execute Workflow
```

Expected

```
Agent 1

↓

Agent 2

↓

Agent 3
```

All three workflows should complete successfully.

---

# Step 13 - Verify Results

Database

```sql
SELECT COUNT(*) FROM competitor_backlinks;
```

```sql
SELECT COUNT(*) FROM backlink_sources;
```

Verify

Email received.

Excel attachment generated.

Marketing report delivered.

---

# Deployment Checklist

Verify

```
Docker Running

Docker Compose Running

seo-postgres Running

seo-n8n Running

Database Restored

3 Workflows Imported

PostgreSQL Connected

OpenAI Connected

Gmail Connected

SE Ranking Connected

Agent 1 Success

Agent 2 Success

Agent 3 Success

Excel Generated

Email Sent
```

---

# Stop Deployment

```bash
docker compose down
```

---

# Remove Everything

```bash
docker compose down -v
```

---

# Deployment Status

Docker

✅

PostgreSQL

✅

n8n

✅

OpenAI

✅

Gmail

✅

SE Ranking

✅

AI Analysis

✅

Excel Reporting

✅

Email Notification

✅

Deployment

Production Ready