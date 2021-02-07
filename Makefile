tokenfile := _token
TOKEN :=$(file < $(tokenfile))
versionfile := _version
VERSION :=$(file < $(versionfile))
IMAGE := brokenpip3/rtt
LOCALCONFIG := example-settings.py
REMOTECONFIG := /usr/src/app/settings.py

.PHONY: all build push docker-run

all: build push docker-run

build:
	docker build -t $(IMAGE):$(VERSION) . --no-cache

push:
	docker push $(IMAGE):$(VERSION)

docker-run:
	docker run -i -t --rm -e TGTOKEN=$(TOKEN) -v ${PWD}/${LOCALCONFIG}:${REMOTECONFIG} $(IMAGE):$(VERSION)
