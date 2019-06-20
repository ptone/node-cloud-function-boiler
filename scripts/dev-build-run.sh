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
docker build  -t $IMAGENAME:dev --build-arg target=$FUNCTION_TARGET -f ./docker/full.dockerfile  .
echo
end=`date +%s`
runtime=$((end-start))
echo "Rebuild time: $runtime seconds"
echo
echo "==== Running ===="

extra=""
if [[ -n GOOGLE_APPLICATION_CREDENTIALS ]];
then
  extra="--volume ${GOOGLE_APPLICATION_CREDENTIALS}:/key.json -e \"GOOGLE_APPLICATION_CREDENTIALS=/key.json\" -e \"GOOGLE_CLOUD_PROJECT=$PROJECT\""
else
  extra="-e GOOGLE_CLOUD_PROJECT=$PROJECT"
fi
# using eval as was hitting some glitch getting -e env vars passed correctly otherwise
eval "docker run $extra -p 8080:8080 $IMAGENAME:dev"