# Quick Typescript Google Cloud Functions development

![](boiler.jpg)

### Features:

* Uses [Functions Framework](https://github.com/GoogleCloudPlatform/functions-framework-nodejs)
* Has request, response, and event typings
* Live reload of local server
* Deploy shortcut (including Nodejs 10 runtime by default)
* [Google Typescript style](https://www.npmjs.com/package/gts) 

### Usage:

```bash
mkdir my-func
cd my-func
curl -L https://github.com/ptone/node-cloud-function-boiler/tarball/master | tar --strip 1 -C ./ -xvz
yarn
export FUNCTION_TARGET=helloWorldHTTP
code .
```

Serve locally, this includes hot reload via [tsc-watch](https://www.npmjs.com/package/tsc-watch):

```bash
yarn run develop
```

In another terminal swindow:

```bash
curl localhost:8080
```


deploy via gcloud as Cloud Function:
Note: this assumes you have your current project configured in gcloud

```bash
yarn run deploy
```
As you develop a function, you should:

* Update the `FUNCTION_TARGET` env var
* Update the details in package.json
* git init and manage your function in VCS


## Cloud Run

Build the Docker image:
```
export PROJECT=$(gcloud config list project --format "value(core.project)" )
export IMAGENAME=`echo gcr.io/$PROJECT/$FUNCTION_TARGET | tr '[:upper:]' '[:lower:]'`

### Build locally

```
docker build -t $IMAGENAME --build-arg target=$FUNCTION_TARGET .
docker push $IMAGENAME 
```

### Run locallly

```
docker run -p 8080:8080 -e GOOGLE_CLOUD_PROJECT=$PROJECT $IMAGENAME 
```

gcloud config set builds/use_kaniko True

gcloud builds submit --config cloudbuild.yaml .

Inspired by: https://github.com/amsokol/gcp-cloud-functions-typescript-starter

This is not a Google Product.

Photo Credit: [Colin Avery](https://unsplash.com/photos/InMS8UZ5Ki8)