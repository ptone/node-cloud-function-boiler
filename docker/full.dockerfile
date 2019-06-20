FROM node:10 as builder

WORKDIR .
COPY . .

RUN yarn install
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