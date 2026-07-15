# ADR 001: Containerize the Application

## Status

Accepted

## Context

The application currently runs directly on a developer machine using a Python virtual environment. This creates dependency on the local operating system, installed Python version, package versions, and manual setup steps.

We need a consistent and portable runtime that can later be used by CI/CD pipelines and Kubernetes.

## Options Considered

1. Run the application directly on virtual machines.
2. Package the application as a Docker container.
3. Use a serverless deployment model.

## Decision

We will package the application as a Docker container.

## Reasons

- Consistent runtime across development, CI/CD, and production.
- Application dependencies are packaged with the image.
- Faster and lighter than maintaining a separate virtual machine per application.
- Compatible with Kubernetes and Amazon EKS.
- Supports immutable and versioned application releases.

## Trade-offs

- Docker adds image-building and container-management complexity.
- Container security and image vulnerabilities must be managed.
- Persistent data cannot be treated like container-local storage.
- Developers must understand networking, volumes, and container lifecycle.

## Consequences

The application will be packaged using a Dockerfile and executed as a container. Future CI/CD pipelines will build and publish versioned images, and Kubernetes will deploy those images.