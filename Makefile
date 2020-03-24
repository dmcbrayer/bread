vars ?= .env
include $(vars)

PWD=$(shell pwd)

build:
	docker image build -t $(DOCKER_TAG) -f Dockerfile.release .

release:
	docker run -it --rm -v $(PWD)/_build:/app/_build $(DOCKER_TAG)

deploy: ## Deploy the thing
	ssh $(DEPLOY_TARGET) sudo systemctl stop $(DEPLOY_SERVICE)
	rsync -avP _build/prod $(DEPLOY_TARGET):$(DEPLOY_DIR)
	ssh $(DEPLOY_TARGET) '$(DEPLOY_DIR)/prod/rel/bread/bin/bread eval "Bread.Release.migrate"'
	ssh $(DEPLOY_TARGET) sudo systemctl start $(DEPLOY_SERVICE)

all: build release deploy
