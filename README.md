Opinionated Usage:

```bash
curl -L https://github.com/ptone/node-cloud-function-boiler/tarball/master | tar -xvz
mv ptone-node-cloud-function-boiler-* my-func
cd my-func
yarn
code .
```
deploy via gcloud:

```bash
npm run compile && npm run deploy --- helloWorldHTTP
```


Inspired by: https://github.com/amsokol/gcp-cloud-functions-typescript-starter
