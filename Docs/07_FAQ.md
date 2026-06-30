# AI SEO Agent - Frequently Asked Questions (FAQ)

## Overview

This document answers common questions about installing, configuring, and running the AI SEO Agent.

---

# General Questions

## 1. What is the AI SEO Agent?

The AI SEO Agent is an automated SEO competitor backlink monitoring system built using:

- n8n
- PostgreSQL
- Docker
- OpenAI
- SE Ranking API
- Gmail

It automatically:

- Monitors competitors
- Collects backlinks
- Performs AI analysis
- Identifies backlink opportunities
- Generates Excel reports
- Sends email notifications

---

## 2. Why does this project use Docker?

Docker provides:

- Easy setup
- Same environment for every developer
- No manual PostgreSQL installation
- Easy deployment
- Platform independence

---

## 3. Which operating systems are supported?

Supported platforms:

- Windows
- Linux
- macOS

As long as Docker Desktop is installed.

---

# Database Questions

## 4. Why is the database empty after `docker compose up -d`?

This is expected.

Docker Compose only creates:

- PostgreSQL container
- Database
- Docker volume

It does **not** restore sample data.

Restore the backup manually:

```bash
docker cp Database/seo_agent_db.backup seo-postgres:/tmp/seo_agent_db.backup
docker exec -it seo-postgres pg_restore -U postgres -d seo_agent_db --clean --if-exists -v /tmp/seo_agent_db.backup
```

---

## 5. Why is `seo_agent_db.backup` included?

The backup provides:

- Sample competitors
- Sample backlink data
- Table structure
- Constraints
- Indexes

It allows developers to start immediately without creating sample data manually.

---

## 6. Can I use `schema.sql` instead?

Yes.

Use `schema.sql` if you want an empty database.

Use `seo_agent_db.backup` if you want a ready-to-use development environment.

---

# n8n Questions

## 7. Why do I see "Workflow does not exist"?

When workflows are imported into a new n8n instance, they receive new internal IDs.

The Execute Workflow nodes still point to the old IDs.

### Solution

Open the Execute Workflow node.

Re-select the target workflow.

Save the workflow.

---

## 8. Why are there 0 workflows after starting Docker?

This is normal.

The n8n Docker volume is empty.

Import the workflows from:

```
Workflows/
```

---

## 9. Why are there no credentials?

Credentials are never stored in GitHub.

Each developer must create:

- PostgreSQL
- OpenAI
- Gmail
- SE Ranking

credentials locally.

---

# PostgreSQL Questions

## 10. Why shouldn't I use `localhost`?

Inside Docker, containers communicate using the Docker network.

Always use:

```
seo-postgres
```

instead of:

- localhost
- 127.0.0.1
- docker-postgres-1

---

## 11. How do I verify the database?

Connect:

```bash
docker exec -it seo-postgres psql -U postgres -d seo_agent_db
```

Show tables:

```sql
\dt
```

Count competitors:

```sql
SELECT COUNT(*) FROM competitors;
```

---

# API Questions

## 12. Which external services are required?

The project uses:

- OpenAI
- SE Ranking
- Gmail

---

## 13. Can I replace OpenAI?

Yes.

If your workflows are updated, you can replace OpenAI with another supported LLM provider such as Azure OpenAI or other compatible APIs.

---

## 14. Can I use another SEO provider?

Yes.

Agent 1 can be modified to call a different backlink provider instead of SE Ranking.

---

# Gmail Questions

## 15. Why didn't I receive the email?

Check:

- Gmail credential
- OAuth connection
- Workflow execution
- `email_logs` table

---

# Docker Questions

## 16. How do I stop the project?

```bash
docker compose down
```

---

## 17. How do I completely reset the project?

```bash
docker compose down -v
```

Then:

```bash
docker compose up -d
```

Restore the database again.

---

## 18. Where is PostgreSQL data stored?

Docker Volume:

```
postgres_data
```

---

## 19. Where is n8n data stored?

Docker Volume:

```
n8n_data
```

---

# Development Questions

## 20. How do I add a new competitor?

Insert a new record into the `competitors` table with status set to `ACTIVE`.

The next execution of Agent 1 will automatically process it.

---

## 21. How do I update API keys?

Open n8n.

Go to:

```
Credentials
```

Update:

- OpenAI
- Gmail
- SE Ranking

Save the changes.

---

## 22. How do I verify everything is working?

Checklist:

- Docker containers running
- PostgreSQL connected
- Database restored
- Workflows imported
- Credentials configured
- Agent 1 executed
- Agent 2 executed
- Agent 3 executed
- Excel generated
- Email received

---

# Project Maintenance

## 23. How do I update the workflows?

1. Open the workflow in n8n.
2. Make the required changes.
3. Export the workflow.
4. Replace the JSON file inside the `Workflows` folder.
5. Commit the updated file.

---

## 24. How do I contribute?

1. Fork the repository.
2. Create a new branch.
3. Make changes.
4. Test the changes.
5. Submit a Pull Request.

---

# Support

If you encounter issues:

1. Read the Installation Guide.
2. Check the Error Handling Guide.
3. Verify Docker containers.
4. Verify credentials.
5. Verify database restoration.
6. Review workflow execution logs.

---

# FAQ Summary

The AI SEO Agent is designed to be:

- Easy to install
- Easy to deploy
- Easy to maintain
- Docker-based
- Modular
- Production-ready