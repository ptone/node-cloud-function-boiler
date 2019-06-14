FROM boiler-tsc as build

WORKDIR .
COPY . .

RUN yarn run compile

FROM boiler-prod
WORKDIR .

# Copy local code to the container image.
COPY --from=build ./build ./build
EXPOSE 8080
# Run the web service on container startup.
ARG target=helloWorldHTTP
ENV FUNCTION_TARGET=$target
CMD [ "npm", "start" ]