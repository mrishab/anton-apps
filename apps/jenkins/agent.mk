.PHONY: build push

REPOSITORY:= # Include a slash at the end when value is not empty
IMAGE:=mrishab/jenkins-agent
VERSION:=1.4.0 # Update this for every new build

## Execute them on ubuntu machine otherwise it leads to platform incompatibility issues

build:
	docker build -f agent.Dockerfile -t ${REPOSITORY}${IMAGE}:${VERSION} .

push:
	docker push ${REPOSITORY}${IMAGE}:${VERSION}