FROM node:alpine as runner

# @TODO add AWS SAM CLI later
MAINTAINER Vladimir Lukyanov <vladimir@lukyanov.net>

RUN apk add --update nodejs npm && \
    npm install -g typescript && \
    npm install -g cdk > '/dev/null' 2>&1

WORKDIR /app

ENTRYPOINT ["cdk"]