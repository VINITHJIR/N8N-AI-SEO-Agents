# AI SEO Agent - Workflow Guide

## Overview

The AI SEO Agent consists of three independent n8n workflows working together to automate SEO backlink monitoring.

Each workflow has a dedicated responsibility.

```
Agent 1
      │
      ▼
Collect Competitor Backlinks
      │
      ▼
PostgreSQL
      │
      ▼
Agent 2
      │
      ▼
AI Backlink Analysis
      │
      ▼
PostgreSQL
      │
      ▼
Agent 3
      │
      ▼
Generate Report
      │
      ▼
Excel + Email
```

---

# Complete Workflow Architecture

```
                SE Ranking API
                       │
                       ▼
          Agent 1 - SEO Competitor Monitor
                       │
          Fetch Competitor Backlinks
                       │
                       ▼
                 PostgreSQL Database
                       │
                       ▼
          Agent 2 - AI Backlink Analyzer
                       │
            Analyze New Backlinks
                       │
                       ▼
                 PostgreSQL Database
                       │
                       ▼
       Agent 3 - Competitor Gap Analysis
                       │
      Opportunity Scoring & Prioritization
                       │
          ┌────────────┴────────────┐
          ▼                         ▼
    Excel Report             Email Notification
```

---

# Workflow 1

## Agent 1 – SEO Competitor Monitor

### Purpose

Collect competitor backlinks from the SE Ranking API and store them inside PostgreSQL.

---

## Responsibilities

- Read active competitors
- Call SE Ranking API
- Fetch backlinks
- Remove duplicates
- Insert backlink sources
- Insert competitor backlinks
- Log errors
- Trigger Agent 2

---

## Input

```
competitors
```

---

## Output

```
backlink_sources

competitor_backlinks
```

---

## Execution Flow

```
Manual Trigger
      │
      ▼
Read Active Competitors
      │
      ▼
Loop Competitors
      │
      ▼
HTTP Request
(SE Ranking API)
      │
      ▼
Process Response
      │
      ▼
Insert backlink_sources
      │
      ▼
Insert competitor_backlinks
      │
      ▼
Call Agent 2
```

---

## Database Tables Updated

```
backlink_sources

competitor_backlinks

error_logs
```

---

## External Services

SE Ranking API

PostgreSQL

---

# Workflow 2

## Agent 2 – AI Backlink Analyzer

### Purpose

Analyze every new backlink using OpenAI.

---

## Responsibilities

- Read unanalyzed backlinks
- Send backlink details to OpenAI
- Generate SEO analysis
- Calculate scores
- Store recommendations
- Mark backlinks as analyzed
- Trigger Agent 3

---

## AI Analysis

OpenAI calculates

- Domain Rating
- Authority Score
- Relevance Score
- Spam Score
- Opportunity Score
- Link Type
- Recommendation

---

## Execution Flow

```
Triggered by Agent 1
        │
        ▼
Read New Backlinks
        │
        ▼
OpenAI
        │
        ▼
Receive Analysis
        │
        ▼
Insert backlink_analysis
        │
        ▼
Update competitor_backlinks
        │
        ▼
Trigger Agent 3
```

---

## Database Tables Updated

```
backlink_analysis

competitor_backlinks

error_logs
```

---

## External Services

OpenAI

PostgreSQL

---

# Workflow 3

## Agent 3 – Competitor Gap Analysis

### Purpose

Generate actionable backlink opportunities and send reports to the marketing team.

---

## Responsibilities

- Read AI analysis
- Calculate opportunity ranking
- Generate Excel report
- Send email
- Log execution

---

## Execution Flow

```
Triggered by Agent 2
        │
        ▼
Read backlink_analysis
        │
        ▼
Generate Opportunities
        │
        ▼
Insert backlink_opportunities
        │
        ▼
Generate Excel
        │
        ▼
Send Gmail
        │
        ▼
Store Email Log
```

---

## Database Tables Updated

```
backlink_opportunities

email_logs

error_logs
```

---

## External Services

Gmail

PostgreSQL

---

# Workflow Communication

```
Agent 1
      │
Execute Workflow
      ▼
Agent 2
      │
Execute Workflow
      ▼
Agent 3
```

---

# Data Flow

```
Competitors
      │
      ▼
SE Ranking
      │
      ▼
backlink_sources
      │
      ▼
competitor_backlinks
      │
      ▼
OpenAI
      │
      ▼
backlink_analysis
      │
      ▼
backlink_opportunities
      │
      ▼
Excel Report
      │
      ▼
Marketing Team
```

---

# Error Handling

Each workflow supports:

- Continue On Error
- Error Logging
- Database Error Logs
- Email Logs

All workflow failures are stored inside

```
error_logs
```

---

# Workflow Dependencies

```
Agent 1

↓

Agent 2

↓

Agent 3
```

Each workflow depends on the previous workflow completing successfully.

---

# Workflow Execution Order

```
1. Execute Agent 1

↓

2. Agent 1 triggers Agent 2

↓

3. Agent 2 analyzes backlinks

↓

4. Agent 2 triggers Agent 3

↓

5. Agent 3 generates Excel

↓

6. Gmail sends report
```

---

# Workflow Verification

Successful execution should result in:

✅ Backlinks collected

✅ AI analysis completed

✅ Opportunity scores generated

✅ Excel report created

✅ Email delivered

✅ Database updated

---

# Common Issues

## Workflow does not exist

Cause

Imported workflows receive new internal IDs.

Solution

Open each Execute Workflow node and re-select the target workflow.

---

## PostgreSQL connection failed

Verify

```
Host

seo-postgres
```

---

## OpenAI Authentication

Verify API Key.

---

## Gmail Authentication

Reconnect OAuth credentials.

---

## SE Ranking Authentication

Verify API Key and endpoint.

---

# Summary

Three independent workflows

↓

Database-driven architecture

↓

AI-powered backlink analysis

↓

Automated reporting

↓

Production-ready automation