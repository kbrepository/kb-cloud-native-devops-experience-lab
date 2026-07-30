# Incident 003: API Could Not Connect to PostgreSQL

## Summary

The FastAPI application failed to establish a connection with the PostgreSQL database after migrating to a Docker Compose multi-container architecture.

---

## Impact

- Database operations failed.
- The `/tasks` endpoint returned database errors.
- The `/ready` endpoint reported that the database was unreachable.
- The API process itself remained healthy.

---

## Symptoms

The application started successfully, but database requests failed with connection errors similar to:

```text
connection refused
```

The PostgreSQL container appeared healthy:

```bash
docker compose ps
```

---

## Investigation

The following checks were performed:

```bash
docker compose ps

docker compose logs api

docker compose logs db

docker inspect kb-devops-api
```

Observations:

- PostgreSQL container was healthy.
- FastAPI container was running.
- Docker network was created successfully.
- The application configuration attempted to connect using:

```text
localhost
```

---

## Root Cause

Inside Docker, each container has its own network namespace.

Using

```text
localhost
```

inside the FastAPI container points back to the FastAPI container itself—not the PostgreSQL container.

Docker Compose automatically provides internal DNS.

Each service becomes reachable using its service name.

The PostgreSQL service name is:

```text
db
```

---

## Resolution

Updated the application database configuration to use the Compose service hostname.

Before:

```text
postgresql+psycopg://appuser:******@localhost:5432/appdb
```

After:

```text
postgresql+psycopg://appuser:******@db:5432/appdb
```

The application reads this value from the `DATABASE_URL` environment variable defined in the `.env` file.

After updating the configuration, the stack was recreated:

```bash
docker compose down

docker compose up --build -d
```

---

## Validation

Verified application readiness:

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

Verified database access:

```bash
curl http://localhost:8000/tasks
```

The API successfully returned persisted records.

---

## Preventive Actions

- Never use `localhost` for communication between Docker containers.
- Use Docker Compose service names for inter-container communication.
- Store application configuration in environment variables.
- Validate dependencies using a readiness endpoint.
- Keep database configuration externalized through `.env`.

---

## Lessons Learned

Docker networking is fundamentally different from host networking.

There are two common communication patterns:

### Host → Container

```text
localhost:published-port
```

Example:

```text
localhost:8000
```

---

### Container → Container

```text
service-name:container-port
```

Example:

```text
db:5432
```

Understanding this distinction is essential when designing containerized applications.