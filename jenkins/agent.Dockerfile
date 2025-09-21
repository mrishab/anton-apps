FROM jenkins/agent:alpine3.22-jdk21

USER root

RUN apk update && \
    apk add --no-cache docker-cli docker-compose build-base rsync aws-cli && \
    rm -rf /var/lib/apt/lists/*

USER jenkins