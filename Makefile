NAME := termui/tickit-base

build:
	docker build -t $(NAME) .

shell: build
	docker run -it -v $$PWD:/devel --entrypoint /bin/bash $(NAME)

push: build
	docker push $(NAME)
