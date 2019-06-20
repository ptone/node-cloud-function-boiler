FROM node:10 as builder

WORKDIR .
# COPY . .
COPY *.json ./
COPY *.lock ./
RUN mkdir ./src
RUN touch ./src/index.ts

RUN yarn install

COPY src/* ./src/
RUN yarn run compile

FROM node:10
WORKDIR .

COPY package*.json ./
RUN yarn install --production=true
# Copy local code to the container image.
COPY --from=builder ./build ./build
EXPOSE 8080
# Run the web service on container startup.
ARG target=helloWorldHTTP
ENV FUNCTION_TARGET=$target
CMD [ "npm", "start" ]