# Database

This folder contains all database-related resources required for the AI SEO Competitor Backlink Monitoring System.

## Files

### schema.sql
Creates the PostgreSQL database schema including tables, indexes, constraints, and relationships.

Use this file if you want to create an empty database from scratch.

---

### seo_agent_db.backup
A PostgreSQL backup containing sample data used by the project.

Restore this backup to quickly start the project with preloaded data.

---

## Recommended Approach

For local development, restore `seo_agent_db.backup`.

For production or a fresh database, execute `schema.sql` first and then import your own data.