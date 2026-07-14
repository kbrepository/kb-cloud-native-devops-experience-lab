# Incident 001: Health Check Contract Failure

## Objective

Validate that the application health endpoint returns the response expected by automated tests and downstream infrastructure.

## Symptom

The health endpoint test failed because the API returned `unhealthy` instead of `healthy`.

## Investigation

Executed:

```bash
pytest -v