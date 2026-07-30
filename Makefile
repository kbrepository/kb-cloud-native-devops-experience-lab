.PHONY: help build up down restart logs ps test health ready tasks clean reset

help:
	@echo "Available commands:"
	@echo "  make build    Build application image"
	@echo "  make up       Start the complete stack"
	@echo "  make down     Stop containers"
	@echo "  make restart  Restart the stack"
	@echo "  make logs     Follow service logs"
	@echo "  make ps       Show service status"
	@echo "  make test     Run automated tests"
	@echo "  make health   Check API liveness"
	@echo "  make ready    Check API readiness"
	@echo "  make tasks    Retrieve tasks"
	@echo "  make clean    Stop stack and remove local images"
	@echo "  make reset    Delete containers and database volume"

build:
	docker compose build

up:
	docker compose up --build -d

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs --follow

ps:
	docker compose ps

test:
	pytest

health:
	curl --fail http://localhost:8000/health

ready:
	curl --fail http://localhost:8000/ready

tasks:
	curl --fail http://localhost:8000/tasks

clean:
	docker compose down --remove-orphans
	docker image rm kb-devops-api:2.0 2>/dev/null || true

reset:
	docker compose down --volumes --remove-orphans