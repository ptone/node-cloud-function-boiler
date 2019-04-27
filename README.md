# Quick Typescript Google Cloud Functions development

![](boiler.jpg)

### Features:

* [Functions Framework](https://github.com/GoogleCloudPlatform/functions-framework-nodejs)
* Live reload
* Deploy shortcut (including Nodejs 10 runtime by default)
* [Google Typescript style](https://www.npmjs.com/package/gts) 

### Usage:

```bash
curl -L https://github.com/ptone/node-cloud-function-boiler/tarball/master | tar -xvz
mv ptone-node-cloud-function-boiler-* my-func
cd my-func
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


Inspired by: https://github.com/amsokol/gcp-cloud-functions-typescript-starter

This is not a Google Product.