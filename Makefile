PWD=$(shell pwd)
PASS=qwer1234

build:
	docker image build -t bread:0.1.0 -f Dockerfile.release .

release:
	docker run -it --rm -v $(PWD)/_build:/app/_build bread:0.1.0

deploy: ## Deploy the thing
	rsync -aP _build/prod bread.droplet:~/bread
	echo $(PASS) | ssh -tt bread.droplet sudo systemctl restart bread

all: build release deploy
