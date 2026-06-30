# AI SEO Agent - Installation Guide

## Overview

This guide explains how to set up the AI SEO Agent project on a brand-new computer using Docker.

After completing this guide, you will have:

- PostgreSQL Database
- n8n Workflow Engine
- AI SEO Agent Workflows
- Sample Database
- Email Notifications
- AI Backlink Analysis

No manual PostgreSQL installation is required.

---

# System Requirements

## Operating System

- Windows 10 / Windows 11
- Ubuntu 22+
- macOS (Docker Supported)

---

## Required Software

Install the following software before continuing.

### Docker Desktop

Download:

https://www.docker.com/products/docker-desktop/

Verify installation

```bash
docker --version
docker compose version
```

Expected Output

```text
Docker version xx.xx.xx

Docker Compose version xx.xx.xx
```

---

### Git

Download

https://git-scm.com/downloads

Verify

```bash
git --version
```

---

# Clone Repository

Clone the project.

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
```

Example

```bash
git clone https://github.com/username/AISeoAgent.git
```

Move into project folder.

```bash
cd AISeoAgent
```

---

# Project Structure

```
AISeoAgent
│
├── Database
│   ├── schema.sql
│   ├── seo_agent_db.backup
│   └── README.md
│
├── Docs
│
├── Images
│
├── Workflows
│
├── .env.example
├── docker-compose.yml
├── README.md
└── LICENSE
```

---

# Environment Variables

Create a new file.

```
.env
```

Copy everything from

```
.env.example
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

# Start Docker

Start Docker Desktop.

Wait until Docker is fully running.

Verify

```bash
docker version
```

---

# Start Services

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

# Open n8n

Open browser

```
http://localhost:5678
```

Create Owner Account.

Example

```
Name

Email

Password
```

Login.

---

# Restore Database

Copy backup into PostgreSQL container.

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

Expected Tables

```
competitors

competitor_backlinks

backlink_sources

backlink_analysis

backlink_opportunities

email_logs

error_logs
```

---

# Import Workflows

Inside n8n

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

# Configure Credentials

Configure the following credentials.

## PostgreSQL

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

Test Connection

Expected

```
Connection Successful
```

---

## OpenAI

Configure your OpenAI API Key.

---

## Gmail

Configure OAuth2 credentials.

---

## SE Ranking

Configure API Key.

---

# Execute Workflow

Open

```
Agent 1 SEO Competitor Monitor
```

Click

```
Execute Workflow
```

Expected

- Agent 1 Success
- Agent 2 Success
- Agent 3 Success

---

# Expected Result

Workflow should

- Fetch competitors
- Fetch backlinks
- Analyze backlinks
- Generate Excel Report
- Store data in PostgreSQL
- Send email to Marketing Team

---

# Verification Checklist

Verify the following.

```
Docker Running

PostgreSQL Running

n8n Running

Database Restored

7 Database Tables

3 Workflows Imported

PostgreSQL Connected

OpenAI Connected

Gmail Connected

SE Ranking Connected

Agent 1 Success

Agent 2 Success

Agent 3 Success

Email Received

Excel Attachment Generated
```

---

# Stop Services

```bash
docker compose down
```

---

# Remove Containers

```bash
docker compose down -v
```

---

# Installation Completed

Congratulations!

The AI SEO Agent has been installed successfully.