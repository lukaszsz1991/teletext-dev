.PHONY: rebase pull build logs up down build-up push-backend push-frontend

rebase:
	@echo "Pulling latest changes from teletext-dev and submodules"
	@git pull --rebase
	@git submodule update --init --recursive --remote --jobs 2

push-backend:
	@echo "Pushing newest backend changes to the dev repository"
	@git add backend
	@git commit -m "chore: update backend submodule"
	@git push -u origin $$(git rev-parse --abbrev-ref HEAD)

push-frontend:
	@echo "Pushing newest frontend changes to the dev repository"
	@git add frontend
	@git commit -m "chore: update frontend submodule"
	@git push -u origin $$(git rev-parse --abbrev-ref HEAD)

build:
	@echo "Building compose services"
	@docker compose build --no-cache

build-up:
	@echo "Building and restarting compose services"
	@docker compose up --build -d

up:
	@echo "Starting compose services"
	@docker compose up -d

down:
	@echo "Stopping compose services"
	@docker compose down

logs:
	@echo "Showing compose service logs"
	@docker compose logs -f

restart:
	@echo "Restarting and rebuilding all services"
	@docker compose down
	@docker compose up -d --build

restart-frontend:
	@echo "Restarting and rebuilding frontend service"
	@docker compose down frontend
	@docker compose up -d --build frontend

restart-backend:
	@echo "Restarting and rebuilding backend service"
	@docker compose down backend
	@docker compose up -d --build backend