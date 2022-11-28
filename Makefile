DOCKERBUILD = docker build -t
DOCKERRUN = docker run --rm --name

DOCKER_DIR = ./tests/docker/

.DEFAULT_GOAL := help

all: help docker-build-ubuntu docker-build-archlinux docker-run-ubuntu install-ubuntu

.PHONY: help all

docker-build-ubuntu: ## docker build ubuntu_test image
	$(DOCKERBUILD) ubuntu_test -f $(DOCKER_DIR)ubuntu/Dockerfile .

docker-build-archlinux: ## docker build archlinux_test image
	$(DOCKERBUILD) archlinux_test -f $(DOCKER_DIR)archlinux/Dockerfile .

docker-run-ubuntu: ## docker run ubuntu_test image
	$(DOCKERRUN) ubuntu -it ubuntu_test

docker-run-archlinux: ## docker run archlinux_test image
	$(DOCKERRUN) archlinux -it archlinux_test

install-ubuntu: ## run the setup development environment script with defaults
	./src/setup_dev_env_ubuntu.sh

help: ## generate make help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
