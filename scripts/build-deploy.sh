#!/bin/bash

if [[ `git status --porcelain` ]];
then
  echo "There are untracked changes, please commit them first"
  exit 1
fi

start=`date +%s`
PROJECT=$(gcloud config list project --format "value(core.project)" )
SERVICE=$(echo $FUNCTION_TARGET | tr '[:upper:]' '[:lower:]')
IMAGENAME=gcr.io/$PROJECT/$SERVICE
echo "==== using image: ===="
echo $IMAGENAME

tag=$(git rev-parse --verify HEAD)
docker tag $IMAGENAME:dev $IMAGENAME:$tag
docker push $IMAGENAME:$tag 
gcloud alpha run deploy $SERVICE --image=$IMAGENAME:$tag $DEPLOY_ARGS
