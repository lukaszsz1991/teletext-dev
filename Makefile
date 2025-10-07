.PHONY: rebase pull

rebase:
	@echo "Pulling latest changes from teletext-dev and submodules"
	@git pull --rebase
	@git submodule update --init --recursive --remote --jobs 2