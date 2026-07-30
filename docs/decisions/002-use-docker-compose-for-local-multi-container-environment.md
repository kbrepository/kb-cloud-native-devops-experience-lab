# ADR 002: Use Docker Compose for the Local Multi-Container Environment

## Status

Accepted

## Context

The application now depends on PostgreSQL for persistent task storage.

Running the API and database manually requires developers to create containers, configure networking, provide environment variables, publish ports, configure persistent storage, and start services in the correct order.

This creates inconsistent local environments and increases the number of manual setup steps.

## Decision

Docker Compose will define and operate the local multi-container application.

The Compose configuration will manage:

- FastAPI application container
- PostgreSQL database container
- Internal service networking
- Environment-based configuration
- Database health checking
- Application startup dependency
- Persistent database storage

The API will connect to PostgreSQL using the Compose service name `db`.

## Alternatives Considered

### Run PostgreSQL directly on the host

Rejected because it introduces host-specific installation and configuration differences.

### Manage containers using separate Docker commands

Rejected because manual commands make the environment harder to reproduce and operate.

### Use Kubernetes locally

Rejected for this milestone because Kubernetes would introduce unnecessary complexity before the application’s container relationships are established.

## Consequences

### Positive

- The complete environment starts with one command.
- Service configuration is version-controlled.
- Containers communicate through an isolated Compose network.
- PostgreSQL data persists through a named volume.
- Database readiness is checked before the API starts.
- Local onboarding becomes repeatable.

### Negative

- Docker Compose becomes a local runtime dependency.
- Compose startup ordering does not replace application-level retry logic.
- Local Compose behavior is not identical to production orchestration.

## Outcome

Docker Compose provides a reproducible local environment while preparing the application for future Kubernetes deployment.