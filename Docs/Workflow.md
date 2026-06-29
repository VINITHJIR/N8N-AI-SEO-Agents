# 🔄 Workflow Documentation

The AI SEO Agents project is divided into three independent workflows.

Each workflow performs a specific business operation and passes data to the next workflow through PostgreSQL.

---

# Workflow Sequence

```text
Scheduler

↓

Agent 1
SEO Competitor Monitor

↓

PostgreSQL

↓

Agent 2
Backlink Analyzer

↓

PostgreSQL

↓

Agent 3
Competitor Gap Analysis

↓

Excel Report

↓

Email Report
```

---

# Workflow Overview

| Agent | Responsibility |
|--------|----------------|
| Agent 1 | Collect competitor backlinks from SE Ranking API |
| Agent 2 | Analyze backlinks using OpenAI GPT |
| Agent 3 | Calculate opportunity score, generate reports and send email |

---

# Agent 1 – SEO Competitor Monitor

## Objective

Agent 1 is responsible for collecting competitor backlinks from the SE Ranking API and storing them in PostgreSQL.

---

## Input

- Active competitors from the `competitors` table

---

## Processing Steps

1. Read all active competitors from PostgreSQL.
2. Process competitors one by one using a loop.
3. Call the SE Ranking Backlink API.
4. Parse the API response.
5. Store unique backlink source domains in the `backlink_sources` table.
6. Store competitor backlink records in the `competitor_backlinks` table.
7. Prevent duplicate backlink insertion using database constraints.
8. After all competitors are processed, trigger Agent 2.

---

## Output

- New records in `backlink_sources`
- New records in `competitor_backlinks`

---

## Exception Handling

The workflow handles the following exceptions:

- PostgreSQL connection failure
- SE Ranking API failure
- Duplicate insert attempts
- Database insert failure

When an exception occurs:

- The error is stored in the `error_logs` table.
- The workflow stops safely to avoid inconsistent data.

---

# Agent 2 – Backlink Analyzer

## Objective

Agent 2 is responsible for analyzing collected backlinks using OpenAI GPT and storing AI-generated scores in PostgreSQL.

---

## Input

- Unanalyzed backlinks from the `competitor_backlinks` table

---

## Processing Steps

1. Read backlinks where `is_analyzed = false`.
2. Batch multiple backlinks into a single request to reduce token usage.
3. Send the batch to OpenAI GPT for analysis.
4. Parse the structured JSON response.
5. Calculate:
   - Relevance Score
   - Spam Score
   - Authority Score
   - Opportunity Score
6. Store the analysis results in the `backlink_analysis` table.
7. Update the corresponding backlink records as analyzed.
8. Trigger Agent 3 after all analysis records are stored.

---

## Token Optimization

To reduce OpenAI API costs:

- Multiple backlinks are analyzed in a single request.
- Numeric indexes are used instead of UUIDs during AI processing.
- Compact JSON input and output formats are used.
- UUIDs are restored after AI analysis before storing results.

This significantly reduces token consumption while maintaining accurate analysis.

---

## Output

- AI analysis records in `backlink_analysis`
- Updated `competitor_backlinks` records with `is_analyzed = true`

---

## Exception Handling

The workflow handles the following exceptions:

- PostgreSQL read failure
- OpenAI API failure
- JSON parsing failure
- Database insert/update failure

When an exception occurs:

- The error is stored in the `error_logs` table.
- The workflow stops safely to prevent incomplete analysis.

---

# Agent 3 – Competitor Gap Analysis

## Objective

Agent 3 is responsible for identifying high-value backlink opportunities, generating reports, and notifying the marketing team.

---

## Input

- Backlink analysis records from the `backlink_analysis` table.

---

## Processing Steps

1. Read analyzed backlink records.
2. Calculate:
   - Domain Rating Score
   - Relevance Score
   - Difficulty Score
   - Final Opportunity Score
3. Assign priority levels:
   - HIGH
   - MEDIUM
   - LOW
4. Store results in the `backlink_opportunities` table.
5. Generate a daily Excel report.
6. Send the report to the marketing team via Gmail.
7. Record successful email deliveries in the `email_logs` table.

---

## Output

- New records in `backlink_opportunities`
- Daily Excel report
- Email notification to the marketing team
- Email delivery logs

---

## Exception Handling

The workflow handles the following exceptions:

- Opportunity calculation failure
- PostgreSQL insert failure
- Excel generation failure
- Gmail sending failure

When an exception occurs:

- Error details are stored in the `error_logs` table.
- Email failures are recorded in the `email_logs` table.
- The workflow stops safely to prevent incomplete reporting.

---

# Overall Workflow Summary

The complete automation executes in the following order.

```text
Scheduler
    │
    ▼
Agent 1
(Backlink Collection)
    │
    ▼
PostgreSQL
    │
    ▼
Agent 2
(AI Backlink Analysis)
    │
    ▼
PostgreSQL
    │
    ▼
Agent 3
(Opportunity Analysis)
    │
    ▼
Excel Report
    │
    ▼
Gmail
    │
    ▼
Marketing Team
```

---