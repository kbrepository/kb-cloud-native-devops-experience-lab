# Incident 003: API Cannot Connect to PostgreSQL Using Localhost

## Summary

The FastAPI container could not establish a connection to the PostgreSQL container even though both services were running.

## Impact

- API database operations failed.
- The readiness endpoint returned an error.
- Task creation and retrieval were unavailable.
- The liveness endpoint remained healthy because the API process itself was running.

## Symptoms

The API logs reported a database connection failure similar to:

```text
connection refused
```