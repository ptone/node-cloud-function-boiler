Opinionated Usage:

```bash
curl -L https://github.com/ptone/node-cloud-function-boiler/tarball/master | tar -xvz
mv ptone-node-cloud-function-boiler-* my-func
cd my-func
yarn
export FUNCTION_TARGET=helloWorldHTTP
code .
```

Serve locally:
```bash
npm start
```

deploy via gcloud:

```bash
npm run compile && npm run deploy
```


Inspired by: https://github.com/amsokol/gcp-cloud-functions-typescript-starter
