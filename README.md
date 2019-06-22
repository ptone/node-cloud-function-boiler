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
npx degit ptone/node-cloud-function-boiler my-func
cd my-func
git init
yarn
export FUNCTION_TARGET=helloWorldHTTP
code .
```

Serve locally, this includes hot reload via [tsc-watch](https://www.npmjs.com/package/tsc-watch):

```bash
yarn run dev
```

In another terminal swindow:

```bash
curl localhost:8080
```


deploy via gcloud as Cloud Function:
Note: this assumes you have your current project configured in gcloud

```bash
yarn run deploy-gcf
```
As you develop a function, you should:

* Update the `FUNCTION_TARGET` env var
* Update the details in package.json
* git init and manage your function in VCS


## Cloud Run

The same code which you can deploy on Cloud Functions can be deployed to the managed Cloud Run service.

### Iterate on function code in container locally

This will rebuild and run the docker container on every code change. It uses the prepared base images to focus on just your code changes without re-installing all dependencies.

```
yarn run dev-run
```

Note: If you have a `GOOGLE_APPLICATION_CREDENTIALS` env variable pointing to a service account json key, this will get mounted in the container.

### Deploy the container once you are happy

This will tag the most recently built local:dev container tagged with the current git commit, push to the project registry, and deploy to cloud run. This will fail if you have uncommited changes.

```
yarn run deploy-run
```

### Build Remote

```
gcloud config set builds/use_kaniko True
export PROJECT=$(gcloud config list project --format "value(core.project)" )
export IMAGENAME=`echo gcr.io/$PROJECT/$FUNCTION_TARGET | tr '[:upper:]' '[:lower:]'`
gcloud builds submit --config cloudbuild.yaml --substitutions _FUNCTION_TARGET=$FUNCTION_TARGET,_IMAGENAME=$IMAGENAME .
```

Inspired by: https://github.com/amsokol/gcp-cloud-functions-typescript-starter

This is not a Google Product.

Photo Credit: [Colin Avery](https://unsplash.com/photos/InMS8UZ5Ki8)