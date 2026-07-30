# KB Cloud Native DevOps Experience Lab

> A production-inspired cloud-native application built to demonstrate hands-on DevOps engineering practices using Docker, Kubernetes, CI/CD, Infrastructure as Code, and AWS.

---

## Project Goal

The objective of this repository is to build and evolve a cloud-native application by following production engineering practices rather than isolated tutorials.

Each milestone introduces a real engineering problem, implements a solution, explores intentional failures, and documents important architectural decisions.

---

## Current Status

### ✅ Milestone 1 – Docker Fundamentals

Implemented:

- FastAPI REST application
- Health endpoint
- Docker image creation
- Container execution
- Port publishing
- Docker image inspection
- Image layer analysis
- Intentional container networking failure
- Root cause analysis
- Architecture Decision Record
- Incident documentation

### ✅ Milestone 2 – Multi-Container Application with Docker Compose

Implemented:

- FastAPI and PostgreSQL multi-container application
- Docker Compose orchestration
- Internal Docker networking
- DNS-based service discovery
- Environment-based configuration
- PostgreSQL health checks
- API liveness and readiness endpoints
- SQLAlchemy database integration
- Persistent database storage using named volumes
- Task creation and retrieval APIs
- Repeatable local workflows using Make

---

## Current Architecture

```text
                Client
                   │
                   │ HTTP :8000
                   ▼
          +----------------+
          |  FastAPI API   |
          +----------------+
                   │
        Docker Internal Network
                   │
                   ▼
          +----------------+
          |   PostgreSQL   |
          +----------------+
                   │
                   ▼
        Persistent Named Volume
```

For additional details, see:

- [Milestone 2 Architecture](docs/architecture/milestone-2-architecture.md)
- [Milestone 2 Summary](docs/milestones/MILESTONE_2_SUMMARY.md)

---

## Technology Stack

| Category | Technology |
|----------|------------|
| Language | Python 3.12 |
| API Framework | FastAPI |
| ORM | SQLAlchemy |
| Database | PostgreSQL |
| Database Driver | Psycopg |
| Testing | Pytest |
| Containerization | Docker |
| Local Orchestration | Docker Compose |
| Workflow Automation | Make |
| Version Control | Git |
| Documentation | Markdown |

---

## Project Structure

```text
.
├── app/
│   ├── database.py
│   ├── main.py
│   ├── models.py
│   └── schemas.py
├── docs/
│   ├── architecture/
│   ├── decisions/
│   ├── framework/
│   ├── incidents/
│   └── milestones/
├── tests/
├── .env.example
├── compose.yaml
├── Dockerfile
├── Makefile
├── requirements.txt
└── README.md
```

---

## Quick Start

### Prerequisites

Ensure the following tools are installed:

- Git
- Docker
- Docker Compose
- Make

### 1. Clone the Repository

```bash
git clone https://github.com/kbrepository/kb-cloud-native-devops-experience-lab.git
cd kb-cloud-native-devops-experience-lab
```

### 2. Create the Local Environment File

```bash
cp .env.example .env
```

The `.env` file contains the local application and PostgreSQL configuration.

It is excluded from Git and should not be committed.

### 3. Start the Complete Stack

```bash
make up
```

This command:

- Builds the FastAPI image
- Starts PostgreSQL
- Waits for the database health check
- Starts the API container
- Creates the internal Docker network
- Creates the persistent database volume

### 4. Check Service Status

```bash
make ps
```

Expected services:

```text
kb-devops-api
kb-devops-db
```

The PostgreSQL service should report a healthy status.

### 5. Validate the Application

Check API liveness:

```bash
make health
```

Check database readiness:

```bash
make ready
```

Retrieve stored tasks:

```bash
make tasks
```

Run automated tests:

```bash
make test
```

---

## API Documentation

With the stack running, interactive API documentation is available at:

- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

---

## API Usage

### Application Information

```bash
curl http://localhost:8000/
```

### Check Liveness

```bash
curl http://localhost:8000/health
```

Expected response:

```json
{
  "status": "healthy"
}
```

### Check Readiness

```bash
curl http://localhost:8000/ready
```

Expected response:

```json
{
  "status": "ready",
  "database": "reachable"
}
```

### Create a Task

```bash
curl -X POST http://localhost:8000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Complete Docker Compose milestone"}'
```

### Retrieve Tasks

```bash
curl http://localhost:8000/tasks
```

---

## Persistence Validation

Create a task and then remove the running containers:

```bash
docker compose down
```

Recreate the stack:

```bash
docker compose up -d
```

Retrieve the tasks again:

```bash
curl http://localhost:8000/tasks
```

The previously created task should still exist because PostgreSQL data is stored in a named Docker volume.

To intentionally remove the database data:

```bash
make reset
```

> `make reset` removes the containers and the PostgreSQL named volume.

---

## Make Commands

| Command | Purpose |
|---------|---------|
| `make help` | Display available commands |
| `make build` | Build the application image |
| `make up` | Build and start the complete stack |
| `make down` | Stop and remove containers |
| `make restart` | Restart the services |
| `make logs` | Follow service logs |
| `make ps` | Display service status |
| `make test` | Run automated tests |
| `make health` | Check API liveness |
| `make ready` | Check database readiness |
| `make tasks` | Retrieve tasks |
| `make clean` | Remove containers and the local API image |
| `make reset` | Remove containers and database volume |

---

## Standalone Docker Workflow

The standalone workflow from Milestone 1 can still be used to run only the FastAPI container.

### Build the Image

```bash
docker build -t kb-devops-api:1.0 .
```

### Run the Container

```bash
docker run -d \
  --name kb-devops-api \
  -p 8000:8000 \
  kb-devops-api:1.0
```

### View Running Containers

```bash
docker ps
```

### Inspect the Image Layers

```bash
docker history kb-devops-api:1.0
```

### Inspect the Container

```bash
docker inspect kb-devops-api
```

### View Container Logs

```bash
docker logs kb-devops-api
```

### Stop the Container

```bash
docker stop kb-devops-api
```

> Database-backed endpoints require the Docker Compose environment introduced in Milestone 2.

---

## Documentation

### Architecture

Architecture documentation is located under:

```text
docs/architecture/
```

### Architecture Decision Records

Engineering decisions are documented under:

```text
docs/decisions/
```

### Incident Reports

Incident reports are located under:

```text
docs/incidents/
```

Each incident follows a consistent structure:

- Summary
- Impact
- Symptoms
- Investigation
- Root Cause
- Resolution
- Validation
- Preventive Actions
- Lessons Learned

### Milestone Summaries

Completed milestone summaries are located under:

```text
docs/milestones/
```

### Engineering Framework

The engineering and learning principles used throughout the project are located under:

```text
docs/framework/
```

---

## Roadmap

- ✅ Milestone 1 – Docker Fundamentals
- ✅ Milestone 2 – Multi-Container Application with Docker Compose
- ⏳ Milestone 3 – Production-Ready Docker Image
- ⏳ Milestone 4 – CI/CD Pipeline
- ⏳ Milestone 5 – Kubernetes Deployment
- ⏳ Milestone 6 – Infrastructure as Code
- ⏳ Milestone 7 – AWS Deployment

---

## Repository Philosophy

This repository focuses on engineering experience rather than theoretical definitions.

Every milestone includes:

- Working implementation
- Architectural decisions
- Failure analysis
- Troubleshooting
- Validation
- Production-oriented practices

The goal is to build systems that can be confidently demonstrated, explained, operated, and extended in real-world DevOps environments.

---

## License

This project is licensed under the MIT License.