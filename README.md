# KB Cloud Native DevOps Experience Lab

> A production-inspired cloud-native application built to demonstrate hands-on DevOps engineering practices using Docker, Kubernetes, CI/CD, Infrastructure as Code, and AWS.

---

## Project Goal

The objective of this repository is to build and evolve a cloud-native application following production engineering practices rather than isolated tutorials.

Each milestone introduces a real engineering problem, implements a solution, intentionally explores failures, and documents important architectural decisions.

---

## Current Status

### ✅ Milestone 1 – Docker Fundamentals

Completed

Implemented:

- FastAPI REST application
- Health endpoint
- Dockerized application
- Docker image creation
- Container execution
- Port publishing
- Docker image inspection
- Image layer analysis
- Intentional networking failure
- Root cause analysis
- Architecture Decision Records (ADR)
- Incident documentation

---

## Technology Stack

| Category | Technology |
|----------|------------|
| Language | Python 3.12 |
| Framework | FastAPI |
| Testing | Pytest |
| Containerization | Docker |
| Version Control | Git |
| Documentation | Markdown |

---

## Project Structure

```
.
├── app/
├── docs/
│   ├── decisions/
│   ├── framework/
│   └── incidents/
├── tests/
├── Dockerfile
├── requirements.txt
└── README.md
```

---

## Quick Start
```markdown
## Start the Complete Stack

Copy the example configuration:

```bash
cp .env.example .env

### Clone Repository

```bash
git clone https://github.com/kbrepository/kb-cloud-native-devops-experience-lab.git
cd kb-cloud-native-devops-experience-lab
```

### Build Docker Image

```bash
docker build -t kb-devops-api:1.0 .
```

### Run Container

```bash
docker run -d \
  --name kb-devops-api \
  -p 8000:8000 \
  kb-devops-api:1.0
```

### Verify Application

Root endpoint

```bash
curl http://localhost:8000/
```

Health endpoint

```bash
curl http://localhost:8000/health
```

---

## Useful Docker Commands

View running containers

```bash
docker ps
```

View image history

```bash
docker history kb-devops-api:1.0
```

Inspect container

```bash
docker inspect kb-devops-api
```

View logs

```bash
docker logs kb-devops-api
```

Stop container

```bash
docker stop kb-devops-api
```

---

## Documentation

```markdown
### API Documentation

With the stack running, interactive API documentation is available at:

- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

#### API Usage

Create a task:

```bash
curl -X POST http://localhost:8000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Complete Docker Compose milestone"}'
```

Retrieve tasks:

```bash
curl http://localhost:8000/tasks
```

Check liveness:

```bash
curl http://localhost:8000/health
```

Check dependency readiness:

```bash
curl http://localhost:8000/ready
```

### Architecture Decisions

Located under

```
docs/decisions/
docs/architecture/
```

### Incident Reports

Located under

```
docs/incidents/
```

Each incident documents:

- Symptoms
- Investigation
- Root Cause
- Resolution
- Validation
- Preventive Actions

---

## Roadmap

- ✅ Milestone 1 – Docker Fundamentals
- ⏳ Milestone 2 – Multi-container Application (Docker Compose)
- ⏳ Milestone 3 – Production-ready Docker Image
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
- Production practices

The goal is to build systems that can be confidently demonstrated, explained, and extended in real-world DevOps environments.

---

## License

MIT License