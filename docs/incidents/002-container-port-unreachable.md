# Incident 002: Container Port Was Published but Application Was Unreachable

## Objective

Run the FastAPI application inside Docker and access it from the host through port 8000.

## Symptom

The container was running and Docker showed port `8000` as published, but requests from the host failed.

## Investigation

Checked:

```bash
docker ps
docker logs broken-api
curl http://localhost:8000/health