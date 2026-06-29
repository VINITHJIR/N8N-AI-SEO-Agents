# 🚨 Error Handling

The AI SEO Agents project implements centralized error handling to ensure reliable workflow execution and simplify troubleshooting.

Whenever an error occurs, the workflow captures the failure details, stores them in PostgreSQL, and safely terminates the current execution.

---

# Error Handling Strategy

The project follows the following strategy.

```text
Workflow Execution
        │
        ▼
Error Occurs
        │
        ▼
Capture Error
        │
        ▼
Store in error_logs
        │
        ▼
Stop Current Workflow
```

---

# Error Logging

Every workflow writes execution failures to the `error_logs` table.

The following information is captured.

- Workflow Name
- Agent Name
- Node Name
- Error Type
- Error Message
- Input Data
- Timestamp

---

# Agent-Level Exception Handling

## Agent 1 – SEO Competitor Monitor

Possible Errors

- PostgreSQL connection failure
- SE Ranking API request failure
- Invalid API response
- Duplicate backlink insertion
- Database insert failure

Recovery Strategy

- Capture the error.
- Store error details in the `error_logs` table.
- Stop the current workflow execution safely.

---

## Agent 2 – Backlink Analyzer

Possible Errors

- PostgreSQL read failure
- OpenAI API failure
- Invalid JSON response
- Token limit exceeded
- Database insert/update failure

Recovery Strategy

- Capture the error.
- Store error details in the `error_logs` table.
- Stop the current workflow execution safely.

---

## Agent 3 – Competitor Gap Analysis

Possible Errors

- Opportunity score calculation failure
- PostgreSQL insert failure
- Excel report generation failure
- Gmail sending failure

Recovery Strategy

- Capture the error.
- Store error details in the `error_logs` table.
- Record email failures in the `email_logs` table.
- Stop the current workflow execution safely.

---

# Logging Tables

The project uses two dedicated logging tables for monitoring and auditing.

## error_logs

Stores workflow execution failures.

| Column | Description |
|---------|-------------|
| workflow_name | Name of the workflow |
| agent_name | Agent where the error occurred |
| node_name | n8n node that generated the error |
| error_type | Type of error |
| error_message | Detailed error message |
| input_data | Workflow input at the time of failure |
| created_at | Error timestamp |

---

## email_logs

Stores email delivery history.

| Column | Description |
|---------|-------------|
| recipient_email | Email recipient |
| subject | Email subject |
| attachment_name | Generated report name |
| status | SUCCESS / FAILED |
| sent_at | Email sent timestamp |
| error_message | Failure reason (if applicable) |

---

# Error Recovery Flow

```text
Workflow Starts
        │
        ▼
Business Processing
        │
        ▼
Error Occurs
        │
        ▼
Capture Exception
        │
        ▼
Insert into error_logs
        │
        ▼
Stop Current Workflow
```

---

# Best Practices

The following best practices are implemented throughout the project.

- Centralized exception handling
- Database transaction safety
- Structured error logging
- Email delivery tracking
- Safe workflow termination
- Modular workflow design
- Production-ready monitoring

---