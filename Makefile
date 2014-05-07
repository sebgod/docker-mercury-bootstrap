THIS_MAKEFILE_PATH:=$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_DIR:=$(shell cd $(dir $(THIS_MAKEFILE_PATH));pwd)
PARENT_DIR:=$(notdir $(patsubst %/,%,$(dir $(THIS_DIR))))
THIS_MAKEFILE:=$(notdir $(THIS_MAKEFILE_PATH))

USER=$(PARENT_DIR)
REPO=mercury-bootstrap
TAG=latest
FQN=$(USER)/$(REPO):$(TAG)

.PHONY: build
build:
	sudo docker build -t $(FQN) .

.PHONY: pull
pull:
	sudo docker pull $(FQN)

.PHONY: push
push: build
	sudo docker push $(FQN)
