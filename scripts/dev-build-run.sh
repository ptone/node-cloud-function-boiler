#!/bin/bash
start=`date +%s`
PROJECT=$(gcloud config list project --format "value(core.project)" )
IMAGENAME=`echo gcr.io/$PROJECT/$FUNCTION_TARGET | tr '[:upper:]' '[:lower:]'`
echo "==== using image: ===="
echo $IMAGENAME
echo
echo "==== Removing running image ===="
# docker rm $(docker kill $(docker ps -a -q --filter ancestor=$IMAGENAME:dev --format="{{.ID}}"))
docker rm -f $(docker ps -a -q --filter ancestor=$IMAGENAME:dev --format="{{.ID}}")
echo
echo "==== Building new image ===="
docker build  -t $IMAGENAME:dev --build-arg target=$FUNCTION_TARGET -f ./docker/build.dockerfile  .
echo
end=`date +%s`
runtime=$((end-start))
echo "Rebuild: $runtime"
echo
echo "==== Running ===="
docker run -p 8080:8080 -e GOOGLE_CLOUD_PROJECT=$PROJECT $IMAGENAME:dev 
