vars ?= .env
include $(vars)

PWD=$(shell pwd)

build:
	docker image build -t $(DOCKER_TAG) -f Dockerfile.release .

release:
	docker run -it --rm -v $(PWD)/_build:/app/_build $(DOCKER_TAG)

deploy: ## Deploy the thing
	rsync -aP _build/prod $(DEPLOY_TARGET):$(DEPLOY_DIR)
	echo $(PASS) | ssh -tt $(DEPLOY_TARGET) sudo systemctl restart $(DEPLOY_SERVICE)

all: build release deploy
