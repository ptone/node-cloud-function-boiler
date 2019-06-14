FROM node:10

WORKDIR .
COPY . .

RUN yarn install