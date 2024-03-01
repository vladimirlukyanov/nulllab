FROM node:lastest

WORKDIR /app

COPY ./backend .

RUN npm ci --audit=false --fund=false

CMD ["npm", "start"]
