# Milestone 2 Architecture

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
          |  PostgreSQL    |
          +----------------+
                   │
                   ▼
          Named Docker Volume
```

## Components

| Component | Responsibility |
|-----------|----------------|
| FastAPI | Serves REST API |
| PostgreSQL | Stores application data |
| Docker Compose | Orchestrates services |
| Named Volume | Persists database files |
| Docker Network | Enables service discovery |

## Service Discovery

The API connects to PostgreSQL using:

```
db:5432
```

rather than

```
localhost
```

because each container has its own network namespace.

## Persistence

Database files are stored inside the named Docker volume:

```
postgres_data
```

which survives container recreation.