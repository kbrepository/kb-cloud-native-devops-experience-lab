# ADR 002: Containerize the Application

## Status

Accepted

## Context

The FastAPI application currently depends on the developer machine having the correct Python version, libraries, environment configuration, and startup command.

Running it on another machine requires manually recreating the same runtime environment.

## Problem

Differences between development, testing, and production environments can cause the application to behave inconsistently.

Examples include:

- Different Python versions
- Missing libraries
- Different package versions
- Incorrect startup commands
- Missing environment variables
- Operating-system differences

## Options Considered

1. Install and configure the application manually on every server.
2. Package the application inside a virtual machine.
3. Package the application as a Docker image.
4. Deploy the application using a serverless platform.

## Decision

Package the application as a Docker image.

## Reasons

- Provides a reproducible runtime environment
- Packages the application and dependencies together
- Reduces machine-specific configuration differences
- Supports immutable and versioned releases
- Can be used consistently in local development, CI/CD, and Kubernetes
- Is lighter and faster to distribute than a complete virtual machine image

## Trade-offs

- Docker introduces additional operational complexity
- Images must be scanned and updated
- Container networking must be understood
- Persistent data must be stored outside the container filesystem
- Containers share the host kernel and are not identical to virtual machines

## Consequences

Future deployments will run the application from versioned Docker images rather than installing application dependencies manually on each target server.