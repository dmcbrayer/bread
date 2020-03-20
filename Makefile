PWD=$(shell pwd)

build:
	docker image build -t bread:0.1.0 -f Dockerfile.release .

release:
	docker run -it --rm -v $(PWD)/_build:/app/_build bread:0.1.0

deploy:
	rsync -aP _build/prod bread.droplet:~/bread

all: build release deploy
