# Incident 004: Non-Root Container Failed to Write Runtime File

## Summary

The FastAPI container failed during startup after the image was hardened to run as a non-root user.

## Impact

- The API container could not start successfully.
- Liveness and readiness endpoints were unavailable.
- Task operations were unavailable.
- PostgreSQL remained healthy and unaffected.

## Symptoms

The API container entered a failed or restarting state.

The application logs reported:

```text
PermissionError: [Errno 13] Permission denied: '/app/runtime/startup.txt'
```

## Investigation

The following commands were used:

```bash
docker compose ps -a
docker compose logs api
docker inspect kb-devops-api
```

The configured image user was checked using:

```bash
docker image inspect kb-devops-api:2.0 \
  --format '{{.Config.User}}'
```

The image was configured to run as:

```text
appuser
```

Directory ownership and permissions were inspected using a temporary root shell:

```bash
docker run --rm \
  --entrypoint /bin/sh \
  --user root \
  kb-devops-api:2.0 \
  -c "id && ls -ld /app /app/runtime"
```

The runtime directory was owned by `root:root` and writable only by root.

## Root Cause

The container process ran as the non-root user `appuser`, but `/app/runtime` was owned by root and configured with restrictive permissions.

The application attempted to create:

```text
/app/runtime/startup.txt
```

during startup and received an operating-system permission error.

## Resolution

The Dockerfile was updated to create the runtime directory and assign ownership to the application user:

```dockerfile
RUN mkdir -p /app/runtime \
    && chown -R appuser:appgroup /app/runtime \
    && chmod 750 /app/runtime
```

The container continued to run as:

```dockerfile
USER appuser
```

## Validation

The stack was rebuilt and started:

```bash
docker compose build --no-cache
docker compose up -d
```

Application health was validated:

```bash
make health
make ready
make tasks
```

The startup marker was successfully created:

```bash
docker exec kb-devops-api \
  cat /app/runtime/startup.txt
```

The runtime identity remained:

```text
appuser
```

## Preventive Actions

- Identify all runtime-writable directories before switching to a non-root user.
- Assign ownership during image construction rather than at container startup.
- Avoid broad permissions such as `chmod 777`.
- Keep the container process running as a dedicated non-root user.
- Include startup and health validation in CI/CD.
- Review writable paths whenever application behavior changes.

## Lessons Learned

Running a container as non-root is not only a Dockerfile change.

The application user must have explicit access to every directory it needs to write to at runtime.

The correct fix is targeted ownership and permissions—not returning to root execution or granting unrestricted write access.