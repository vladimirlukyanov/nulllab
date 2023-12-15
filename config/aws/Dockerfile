# † aws + go
FROM golang:latest as golang
FROM alpine:latest as runner

# @TODO add AWS SAM CLI later
MAINTAINER Vladimir Lukyanov <vladimir@lukyanov.net>

RUN apk add --update nodejs npm && \
    npm install -g typescript && \
    npm install -g cdk > '/dev/null' 2>&1

COPY --from=golang /usr/local/go /usr/local/go

ENV PATH /usr/local/go/bin:$PATH
ENV GOTOOLCHAIN=local
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 1777 "$GOPATH"

WORKDIR /app