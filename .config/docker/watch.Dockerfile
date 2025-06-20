FROM alpine:latest

RUN apk update && apk add nodejs-current npm curl

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

WORKDIR /opt/app

HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost:4321/ || exit 1