FROM alpine:latest

RUN apk update && apk add nodejs npm

WORKDIR /app

RUN npm i --audit=false --fund=false

CMD ["npm", "start"]
