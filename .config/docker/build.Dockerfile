FROM alpine:latest

RUN apk update && apk add nodejs npm curl

WORKDIR /opt/app

HEALTHCHECK --interval=5m --timeout=3s CMD curl -f http://localhost:4321/ || exit 1