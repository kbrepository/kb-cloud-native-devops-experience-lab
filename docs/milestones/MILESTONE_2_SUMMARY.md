# Milestone 2: Multi-Container Application

## Objective

Evolve the standalone FastAPI container into a reproducible multi-container application backed by PostgreSQL.

## Architecture
## Current Architecture

```text
Client
  |
  v
FastAPI Container
  |
  | Internal Compose Network
  v
PostgreSQL Container
  |
  v
Persistent Named Volume

```


## Features Implemented

FastAPI and PostgreSQL multi-container stack
Docker Compose configuration
Internal service networking
DNS-based service discovery
Environment-based configuration
Database health check
API readiness endpoint
Persistent PostgreSQL storage
SQLAlchemy database integration
Task creation and retrieval
Local workflow automation through Make

## Service Endpoints

Endpoint	    Purpose
/	            Application information
/health	        API process liveness
/ready	        Database dependency readiness
/tasks	        Create and retrieve persisted tasks
/docs	        Swagger UI
/redoc	        ReDoc API documentation

## Engineering Decisions
- Docker Compose was selected to define the local multi-container environment.
- PostgreSQL remains private to the Compose network.
- The API connects to PostgreSQL through the service name db.
- A named volume preserves database data across container replacement.
- Secrets and environment-specific values are excluded from source control.
- Liveness and readiness are represented by separate endpoints.
- Persistence Validation

A task was created and stored in PostgreSQL.

The containers were removed using:

docker compose down

After recreating the stack, the task remained available because the named volume was preserved.

## Failure Investigated

The API initially failed to connect when the database hostname was configured as localhost.

Inside a container, localhost refers to that same container. The configuration was corrected to use the Compose service name db.

## Skills Demonstrated
- Designing a multi-container environment
- Configuring Compose services
- Managing environment variables
- Implementing container service discovery
- onfiguring named volumes
- Implementing liveness and readiness checks
- Troubleshooting inter-container communication
- Validating data persistence
- Operating the stack using repeatable commands

## Useful Commands
```make up
make down
make ps
make logs
make health
make ready
make tasks
make test
```