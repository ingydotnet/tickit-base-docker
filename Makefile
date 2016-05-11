NAME := termui/tickit-base
VERSION := 0.0.1

build:
	docker build -t $(NAME) .

push: build
	docker push $(NAME):$(VERSION)

shell: build
	docker run -it -v $$PWD:/src --entrypoint /bin/bash $(NAME)
