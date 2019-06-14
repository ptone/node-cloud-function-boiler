#!/bin/bash

docker build -t boiler-tsc -f ./docker/tsc.dockerfile .
docker build -t boiler-prod -f ./docker/prod.dockerfile .
