THIS_MAKEFILE_PATH:=$(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
THIS_DIR:=$(shell cd $(dir $(THIS_MAKEFILE_PATH));pwd)
PARENT_DIR:=$(notdir $(patsubst %/,%,$(dir $(THIS_DIR))))
THIS_MAKEFILE:=$(notdir $(THIS_MAKEFILE_PATH))

USER=$(PARENT_DIR)
REPO=mercury-bootstrap
VERSION=rotd-2016-01-03
TAG=$(VERSION)
FQN=$(USER)/$(REPO):$(TAG)
DOCKERFILE=Dockerfile

.PHONY: build
build: update
	docker build -t $(FQN) - < $(DOCKERFILE)

.PHONY: pull
pull:
	docker pull $(FQN)

.PHONY: push
push: build
	docker push $(FQN)

.PHONY: update
update:
	sed -i 's/_VERSION .\+/_VERSION $(VERSION)/' $(DOCKERFILE)
	sed -i 's/is: .\+/is: $(VERSION)/' README.md
	sed -i 's/^VERSION=.\+$$/VERSION=$(VERSION)/' Makefile
	( git add $(DOCKERFILE) README.md Makefile && git commit -m "Updated to Version $(VERSION)" ) || true

.PHONY: help
help: build
	docker run -v $(PWD):/data $(FQN) --help

