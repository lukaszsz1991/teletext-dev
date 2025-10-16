.PHONY: rebase pull

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

up:
	@echo "Starting compose services"
	@docker compose up -d

down:
	@echo "Stopping compose services"
	@docker compose down

logs:
	@echo "Showing compose service logs"
	@docker compose logs -f