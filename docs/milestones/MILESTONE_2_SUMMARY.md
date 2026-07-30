# Milestone 2: Multi-Container Application with Docker Compose

## Objective

Evolve the standalone FastAPI application into a reproducible multi-container environment backed by PostgreSQL using Docker Compose.

---

## Architecture

```text
                Client
                   │
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

---

## Features Implemented

- FastAPI and PostgreSQL multi-container application
- Docker Compose orchestration
- Internal Docker networking
- DNS-based service discovery
- Environment-based configuration using `.env`
- PostgreSQL health checks
- API readiness endpoint
- Persistent database storage using named volumes
- SQLAlchemy database integration
- Task creation and retrieval APIs
- Local developer workflow using `Makefile`

---

## Service Endpoints

| Endpoint | Purpose |
|----------|---------|
| `/` | Application information |
| `/health` | API liveness check |
| `/ready` | Database readiness check |
| `/tasks` | Create and retrieve tasks |
| `/docs` | Swagger UI |
| `/redoc` | ReDoc API documentation |

---

## Engineering Decisions

- Docker Compose was selected to orchestrate the local multi-container environment.
- PostgreSQL remains private to the Docker Compose network and is not exposed to the host.
- The API communicates with PostgreSQL using the Compose service name (`db`) instead of `localhost`.
- Database data is persisted using a named Docker volume.
- Environment-specific configuration is externalized through `.env`.
- Separate liveness and readiness endpoints were implemented to distinguish application health from dependency availability.

---

## Persistence Validation

A task was successfully created and stored in PostgreSQL.

The application stack was stopped using:

```bash
docker compose down
```

The stack was then started again:

```bash
docker compose up -d
```

Previously created tasks were still available, confirming that the named Docker volume preserved the database across container recreation.

---

## Failure Investigated

### API Could Not Connect to PostgreSQL

**Symptoms**

- API started successfully.
- Database operations failed.
- Readiness endpoint returned an error.

**Root Cause**

The application attempted to connect to PostgreSQL using:

```text
localhost
```

Inside a container, `localhost` refers to the container itself, not another service.

**Resolution**

Updated the database connection string to use the Docker Compose service name:

```text
db
```

This enabled successful communication between the API and PostgreSQL containers through Docker's internal DNS.

---

## Skills Demonstrated

After completing this milestone, this project demonstrates practical experience with:

- Designing a multi-container application
- Docker Compose orchestration
- Environment variable management
- Container service discovery
- Docker networking
- Named volume management
- SQLAlchemy integration
- Liveness and readiness endpoints
- Persistent database storage
- Troubleshooting inter-container communication
- Automating local workflows using Make

---

## Useful Commands

```bash
make up
make down
make restart
make ps
make logs
make health
make ready
make tasks
make test
make clean
make reset
```

---

## Documentation Produced

- Architecture Diagram
- Architecture Decision Record (ADR)
- Incident Report
- Milestone Summary
- Updated README
- Makefile
- Environment configuration template (`.env.example`)

---

## Next Milestone

Milestone 3 focuses on creating a **production-ready container image** by implementing:

- Multi-stage Docker builds
- Non-root container execution
- Image size optimization
- Layer optimization
- Container-native health checks
- Dependency hardening
- Security best practices