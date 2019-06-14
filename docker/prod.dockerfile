FROM node:10
WORKDIR .

COPY package*.json ./
RUN yarn install --production=true