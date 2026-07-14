from fastapi import FastAPI

app = FastAPI(
    title="Cloud-Native DevOps Experience Lab",
    description="A production-style application used to learn Docker, Kubernetes, and CI/CD.",
    version="0.1.0",
)


@app.get("/")
def root() -> dict[str, str]:
    return {
        "application": "cloud-native-devops-experience-lab",
        "message": "Application is running",
    }


@app.get("/health")
def health_check() -> dict[str, str]:
    return {
        "status": "healthy",
    }