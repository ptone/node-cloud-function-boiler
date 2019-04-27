Opinionated Usage:

```bash
curl -L https://github.com/ptone/node-cloud-function-boiler/tarball/master | tar -xvz
mv ptone-node-cloud-function-boiler-* my-func
cd my-func
yarn
export FUNCTION_TARGET=helloWorldHTTP
code .
```

Serve locally, this includes tsc watch:
```bash
yarn run develop
```

In another terminal swindow:
```bash
curl localhost:8080
```


deploy via gcloud:

```bash
yarn run compile && yarn run deploy
```


Inspired by: https://github.com/amsokol/gcp-cloud-functions-typescript-starter
