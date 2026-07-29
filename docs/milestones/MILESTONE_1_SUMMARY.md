# Milestone 1 – Docker Fundamentals

## Objective

Containerize the FastAPI application and understand the complete lifecycle of building, running, debugging, and validating a Dockerized service.

---

## Features Implemented

- FastAPI REST application
- Dockerfile
- .dockerignore
- Docker image creation
- Container execution
- Port publishing
- Health endpoint
- Image inspection
- Layer inspection
- Container inspection

---

## Engineering Decisions

- Containerize the application instead of manually installing dependencies.
- Publish the application using Docker port mapping.
- Bind the application to `0.0.0.0` inside the container.
- Separate production and development dependencies.
- Keep the Docker image focused on application runtime.

---

## Production Concepts Learned

- Docker Image vs Container
- Build Context
- Docker Layers
- Image Caching
- Port Publishing
- Container Networking
- Image Inspection
- Container Inspection

---

## Failure Investigated

### Application not reachable from host

Symptoms

- Container was running.
- Application was inaccessible.

Root Cause

The application was listening on `127.0.0.1` inside the container instead of `0.0.0.0`.

Resolution

Updated the application startup command to bind to `0.0.0.0`.

Validation

Successfully accessed the application using:

```bash
curl http://localhost:8000/health
```

---

## Useful Commands Practiced

```bash
docker build
docker run
docker ps
docker logs
docker inspect
docker history
docker stop
docker rm
```

---

## Interview Outcome

After completing this milestone, I can confidently explain:

- Why Docker is used
- Docker image lifecycle
- Image vs Container
- Dockerfile structure
- Build Context
- Docker Layers
- Port Mapping
- Docker networking basics
- Why applications inside containers should bind to `0.0.0.0`
- Basic Docker troubleshooting using `docker ps`, `docker logs`, `docker history`, and `docker inspect`

---

## Next Milestone

Build a multi-container application using Docker Compose with:

- FastAPI
- PostgreSQL
- Docker Networks
- Docker Volumes
- Environment Variables
- Persistent Storage