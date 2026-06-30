# 🚀 AI SEO Competitor Backlink Monitoring System

![Docker](https://img.shields.io/badge/Docker-Ready-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-17-blue)
![n8n](https://img.shields.io/badge/n8n-Latest-orange)
![OpenAI](https://img.shields.io/badge/OpenAI-GPT-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

## 📌 Project Overview

The **AI SEO Competitor Backlink Monitoring System** is an end-to-end SEO automation platform that monitors competitor backlinks, performs AI-powered backlink analysis, identifies high-value backlink opportunities, generates Excel reports, and automatically emails the results to the marketing team.

The project is built using **n8n**, **PostgreSQL**, **Docker**, **OpenAI**, **SE Ranking API**, and **Gmail**.

The complete project has been tested and verified in a fresh Docker environment.

---

# 🎯 Features

- 🔍 Monitor competitor backlinks automatically
- 🤖 AI-powered backlink quality analysis
- 📊 Opportunity score calculation
- 📈 Excel report generation
- 📧 Automatic email notification
- 🐳 Docker-based deployment
- 🗄 PostgreSQL database
- 🔄 Modular workflow architecture
- 📚 Complete documentation
- ⚡ Easy deployment on any machine

---

# 🏗 System Architecture

```
                     SE Ranking API
                            │
                            ▼
               Agent 1 - SEO Competitor Monitor
                            │
                     Fetch Backlinks
                            │
                            ▼
                    PostgreSQL Database
                            │
                            ▼
               Agent 2 - AI Backlink Analyzer
                            │
                    OpenAI Analysis
                            │
                            ▼
                    PostgreSQL Database
                            │
                            ▼
            Agent 3 - Competitor Gap Analysis
                            │
               Generate Excel Report
                            │
                            ▼
                     Gmail Notification
                            │
                            ▼
                     Marketing Team
```

---

# ⚙ Technology Stack

| Category | Technology |
|----------|------------|
| Workflow Engine | n8n |
| Database | PostgreSQL 17 |
| AI | OpenAI GPT |
| SEO API | SE Ranking API |
| Notification | Gmail |
| Reporting | Excel |
| Containerization | Docker Compose |
| Version Control | Git & GitHub |

---

# 📂 Project Structure

```
AISeoAgent
│
├── Database
│   ├── schema.sql
│   ├── seo_agent_db.backup
│   └── README.md
│
├── Docs
│   ├── 01_Installation.md
│   ├── 02_Database.md
│   ├── 03_Workflows.md
│   ├── 04_Architecture.md
│   ├── 05_ErrorHandling.md
│   ├── 06_Deployment.md
│   └── 07_FAQ.md
│
├── Images
│
├── Workflows
│   ├── 01_Agent1_SEO_Competitor_Monitor.json
│   ├── 02_Agent2_Backlink_Analyzer.json
│   └── 03_Agent3_Competitor_Gap_Analysis.json
│
├── .env.example
├── .gitignore
├── docker-compose.yml
├── LICENSE
├── README.md
└── Requirements.md
```

---

# 🤖 Workflow Overview

The system consists of three independent workflows.

| Workflow | Responsibility |
|----------|----------------|
| Agent 1 | Fetch competitor backlinks from SE Ranking |
| Agent 2 | Analyze backlinks using OpenAI |
| Agent 3 | Generate reports and email notifications |

---

## Workflow Execution

```
Agent 1
    │
    ▼
Collect Backlinks
    │
    ▼
PostgreSQL
    │
    ▼
Agent 2
    │
    ▼
AI Analysis
    │
    ▼
PostgreSQL
    │
    ▼
Agent 3
    │
    ▼
Generate Excel Report
    │
    ▼
Send Email
```

---

# 🗄 Database Overview

The project uses PostgreSQL as the central database.

| Table | Purpose |
|--------|---------|
| competitors | Stores monitored competitors |
| backlink_sources | Master backlink repository |
| competitor_backlinks | Competitor backlink mapping |
| backlink_analysis | AI analysis results |
| backlink_opportunities | Opportunity scoring |
| email_logs | Email history |
| error_logs | Error logging |

---

## Database Relationship

```
competitors
      │
      ▼
competitor_backlinks
      │
      ├────────► backlink_analysis
      │                 │
      │                 ▼
      │       backlink_opportunities
      │
      ▼
backlink_sources

email_logs

error_logs
```

---

# 🚀 Quick Start

## Clone Repository

```bash
git clone https://github.com/<YOUR_USERNAME>/AISeoAgent.git
cd AISeoAgent
```

---

## Create Environment File

Copy

```
.env.example
```

to

```
.env
```

---

## Start Docker

```bash
docker compose up -d
```

---

## Open n8n

```
http://localhost:5678
```

Create the Owner Account.

---

## Restore Database

```bash
docker cp Database/seo_agent_db.backup seo-postgres:/tmp/seo_agent_db.backup
```

```bash
docker exec -it seo-postgres pg_restore -U postgres -d seo_agent_db --clean --if-exists -v /tmp/seo_agent_db.backup
```

---

## Import Workflows

Import

- Agent 1
- Agent 2
- Agent 3

from

```
Workflows/
```

---

## Configure Credentials

Create credentials for:

- PostgreSQL
- OpenAI
- Gmail
- SE Ranking

---

## Execute

Run

```
Agent 1
```

The workflow automatically triggers:

```
Agent 2

↓

Agent 3
```

---

# 📖 Documentation

| Document | Description |
|----------|-------------|
| [Installation Guide](Docs/01_Installation.md) | Complete installation instructions |
| [Database Guide](Docs/02_Database.md) | Database schema and restoration |
| [Workflow Guide](Docs/03_Workflows.md) | Workflow architecture and execution |
| [Architecture Guide](Docs/04_Architecture.md) | System architecture |
| [Error Handling](Docs/05_ErrorHandling.md) | Common errors and solutions |
| [Deployment Guide](Docs/06_Deployment.md) | Deploy on a new machine |
| [FAQ](Docs/07_FAQ.md) | Frequently asked questions |

---

# ✅ Verification Checklist

After deployment verify:

- Docker running
- PostgreSQL running
- n8n running
- Database restored
- Workflows imported
- PostgreSQL credential connected
- OpenAI credential configured
- Gmail credential configured
- SE Ranking credential configured
- Agent 1 executed
- Agent 2 executed
- Agent 3 executed
- Excel report generated
- Email notification received

---

# 🚀 Future Improvements

- User Authentication
- Role-Based Access Control
- Dashboard Analytics
- Multi-Project Support
- Slack Notifications
- Microsoft Teams Integration
- Historical Trend Analysis
- REST API
- Kubernetes Deployment
- Grafana Monitoring
- Prometheus Metrics

---

# 📸 Screenshots

Add screenshots in the `Images` folder:

- Homepage
- Agent 1 Workflow
- Agent 2 Workflow
- Agent 3 Workflow
- PostgreSQL Tables
- Docker Containers
- Email Report

---

# 📜 License

This project is licensed under the MIT License.

---

# 👨‍💻 Author

**Vinith Ji**

**AI Agent Developer**

GitHub:
https://github.com/VINITHJIR

---

# ⭐ Project Status

```
Project Status

✅ Docker Verified

✅ PostgreSQL Verified

✅ n8n Verified

✅ AI Workflow Verified

✅ OpenAI Verified

✅ Gmail Verified

✅ SE Ranking Verified

✅ Database Verified

✅ Documentation Completed

✅ Production Ready

Version : v1.0.0
```