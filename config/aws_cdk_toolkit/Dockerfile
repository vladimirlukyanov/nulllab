FROM node:alpine as runner

MAINTAINER Vladimir Lukyanov <vladimir@lukyanov.net>

RUN apk add --update nodejs npm && \
    npm install -g typescript && \
    npm install -g cdk

WORKDIR /app

#By default container will perform synth operation, Override as required
ENTRYPOINT ["cdk"]
