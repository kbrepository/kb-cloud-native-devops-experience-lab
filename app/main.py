from fastapi import FastAPI
from contextlib import asynccontextmanager

from fastapi import Depends, FastAPI, HTTPException, status
from sqlalchemy import select, text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session

from app.database import Base, engine, get_db
from app.models import Task
from app.schemas import TaskCreate, TaskResponse

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

@asynccontextmanager
async def lifespan(_: FastAPI):
    Base.metadata.create_all(bind=engine)
    yield


app = FastAPI(
    title="KB Cloud Native DevOps Experience Lab",
    lifespan=lifespan,
)


@app.get("/")
def root():
    return {"message": "KB Cloud Native DevOps Experience Lab"}


@app.get("/health")
def health():
    return {"status": "healthy"}


@app.get("/ready")
def readiness(db: Session = Depends(get_db)):
    try:
        db.execute(text("SELECT 1"))
        return {
            "status": "ready",
            "database": "reachable",
        }
    except SQLAlchemyError as exc:
        raise HTTPException(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            detail="Database is unavailable",
        ) from exc


@app.post(
    "/tasks",
    response_model=TaskResponse,
    status_code=status.HTTP_201_CREATED,
)
def create_task(payload: TaskCreate, db: Session = Depends(get_db)):
    task = Task(title=payload.title)

    db.add(task)
    db.commit()
    db.refresh(task)

    return task


@app.get("/tasks", response_model=list[TaskResponse])
def list_tasks(db: Session = Depends(get_db)):
    statement = select(Task).order_by(Task.id)
    return list(db.scalars(statement))