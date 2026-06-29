# 🏗️ System Architecture

The AI SEO Agents project follows a modular multi-agent architecture.

Each agent is responsible for a specific business function and communicates through a shared PostgreSQL database.

The workflow is fully automated using n8n.

---

# High-Level Architecture

```text
Scheduler
    │
    ▼
Agent 1
(SEO Competitor Monitor)
    │
    ▼
PostgreSQL
    │
    ▼
Agent 2
(Backlink Analyzer)
    │
    ▼
PostgreSQL
    │
    ▼
Agent 3
(Competitor Gap Analysis)
    │
    ▼
Excel Report
    │
    ▼
Email Report
    │
    ▼
Marketing Team
```

---

# Agent Responsibilities

## Agent 1 – SEO Competitor Monitor

Responsibilities

- Read active competitors from PostgreSQL.
- Connect to the SE Ranking API.
- Fetch competitor backlinks.
- Store unique backlink source domains.
- Store competitor backlink information.
- Prevent duplicate backlink insertion.
- Trigger Agent 2 after all competitors are processed.

---

## Agent 2 – Backlink Analyzer

Responsibilities

- Fetch only unanalyzed backlinks.
- Send backlink data to OpenAI GPT.
- Analyze backlink quality.
- Calculate:
  - Relevance Score
  - Spam Score
  - Authority Score
  - Opportunity Score
- Store analysis results.
- Update competitor backlinks as analyzed.
- Trigger Agent 3.

---

## Agent 3 – Competitor Gap Analysis

Responsibilities

- Read backlink analysis results.
- Calculate final opportunity score.
- Classify opportunities into:
  - HIGH
  - MEDIUM
  - LOW
- Store opportunity records.
- Generate Excel report.
- Send report to the marketing team.
- Store Email Logs.
- Store Error Logs.

---

# Data Flow

The following diagram explains how data moves through the system.

```text
Scheduler Trigger
        │
        ▼
Read Active Competitors
(PostgreSQL)
        │
        ▼
Agent 1
        │
        ▼
SE Ranking API
        │
        ▼
Fetch Competitor Backlinks
        │
        ▼
Store Backlink Sources
(PostgreSQL)
        │
        ▼
Store Competitor Backlinks
(PostgreSQL)
        │
        ▼
Agent 2
        │
        ▼
Read Unanalyzed Backlinks
(PostgreSQL)
        │
        ▼
OpenAI GPT Analysis
        │
        ▼
Store Backlink Analysis
(PostgreSQL)
        │
        ▼
Agent 3
        │
        ▼
Calculate Opportunity Score
        │
        ▼
Store Backlink Opportunities
(PostgreSQL)
        │
        ▼
Generate Excel Report
        │
        ▼
Send Email Report
        │
        ▼
Marketing Team

```

---

# Exception Handling Flow

The project implements centralized exception handling to ensure workflow reliability and simplify troubleshooting.

## Agent 1

Possible Exceptions

- PostgreSQL Connection Failure
- SE Ranking API Failure
- Duplicate Backlink Insert Failure
- Workflow Execution Failure

Action

- Store error details in the `error_logs` table.
- Stop the current execution safely.

---

## Agent 2

Possible Exceptions

- PostgreSQL Read Failure
- OpenAI API Failure
- JSON Parsing Failure
- Backlink Analysis Insert Failure

Action

- Store error details in the `error_logs` table.
- Stop the current execution safely.

---

## Agent 3

Possible Exceptions

- Opportunity Calculation Failure
- PostgreSQL Insert Failure
- Excel Generation Failure
- Gmail Sending Failure

Action

- Store error details in the `error_logs` table.
- Store email delivery status in the `email_logs` table.
- Stop the current execution safely.

---

## Logging

Two logging tables are used.

| Table | Purpose |
|--------|---------|
| error_logs | Stores workflow execution errors. |
| email_logs | Stores email delivery history and status. |

---