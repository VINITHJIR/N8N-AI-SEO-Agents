# 🛠️ Installation Guide

This document explains how to set up the AI SEO Agents project from scratch.

---

# Prerequisites

Before running this project, install the following software:

| Software | Version |
|----------|---------|
| PostgreSQL | 17+ |
| n8n | Latest |
| Git | Latest |
| GitHub Desktop or VS Code | Latest |

---

# Clone Repository

```bash
git clone https://github.com/VINITHJIR/N8N-AI-SEO-Agents.git
```

Open the project folder.

---

# Create PostgreSQL Database

1. Open **pgAdmin 4**.
2. Connect to your PostgreSQL server.
3. Create a new database.

Example:

- Database Name: `seo_agent_db`

---

# Import Database Schema

Open the **Query Tool** for the newly created database.

Open the following file:

```
Database/schema.sql
```

Execute the complete SQL script.

After execution, verify that the following database objects are created successfully.

### Tables

- competitors
- backlink_sources
- competitor_backlinks
- backlink_analysis
- backlink_opportunities
- error_logs
- email_logs

---

# Verify Database

Run the following SQL query:

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;
```

You should see all seven tables listed above.

---

# Import n8n Workflows

Start the n8n application.

Import the workflow files from the **Workflows** folder in the following order.

1. 01_Agent1_SEO_Competitor_Monitor.json
2. 02_Agent2_Backlink_Analyzer.json
3. 03_Agent3_Competitor_Gap_Analysis.json

Verify that all workflows are imported successfully before proceeding.

---
# Configure Credentials

Create the following credentials inside n8n.

## PostgreSQL

- Host
- Port
- Database
- Username
- Password

---

## OpenAI

- API Key

---

## SE Ranking API

- API Key

---

## Gmail OAuth2

- Client ID
- Client Secret
- Refresh Token

Verify that every credential shows a successful connection.

---

# Run the Project

Execute the workflows in the following order.

1. Agent 1 – SEO Competitor Monitor
2. Agent 2 – Backlink Analyzer
3. Agent 3 – Competitor Gap Analysis

Expected Result

- Competitor backlinks are collected.
- AI analyzes backlink quality.
- Opportunity scores are calculated.
- Excel report is generated.
- Email report is delivered.
- Error logs and email logs are stored in PostgreSQL.

---