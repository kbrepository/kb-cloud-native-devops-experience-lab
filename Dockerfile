# ----------------------------------------------------
# Base Image
# ----------------------------------------------------
FROM python:3.12-slim

# ----------------------------------------------------
# Environment Variables
# ----------------------------------------------------
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# ----------------------------------------------------
# Working Directory
# ----------------------------------------------------
WORKDIR /app

# ----------------------------------------------------
# Create Non-Root User
# ----------------------------------------------------
RUN groupadd --system appgroup \
    && useradd --system --gid appgroup --create-home appuser

# ----------------------------------------------------
# Install Dependencies
# ----------------------------------------------------
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# ----------------------------------------------------
# Copy Application
# ----------------------------------------------------
COPY app/ ./app/

# ----------------------------------------------------
# Change Ownership
# ----------------------------------------------------
RUN chown -R appuser:appgroup /app

RUN mkdir -p /app/runtime \
    && chown -R appuser:appgroup /app

# RUN mkdir -p /app/runtime \
#     && chown -R appuser:appgroup /app/runtime \
#     && chmod 750 /app/runtime

# ----------------------------------------------------
# Switch User
# ----------------------------------------------------
USER appuser

# ----------------------------------------------------
# Expose Port
# ----------------------------------------------------
EXPOSE 8000

# ----------------------------------------------------
# Health Check
# ----------------------------------------------------
HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=10s \
            --retries=3 \
CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')" || exit 1

# ----------------------------------------------------
# Start Application
# ----------------------------------------------------
CMD [ "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000" ]