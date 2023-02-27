# MLflow POC

This is a MLflow POC. You can expect to have a MLFlow with artifacts server separated from tracking. The metadata is stored in a "postgres" (postgres deployment) and the artifacts in a "s3" (minio deployment)

> **Warning**
> This is a a proof of concept and is in its "first version"

> **Warning**
> Do not store secrets or other sensitive data in github (this repository has secrets because it is only a demo)

## Running this example
### 0. Have a working kubernetes cluster and a container runtime installed
### 1. Build images:
```
make build
```
### 2. Run kubernetes resources:
```
make apply
```

### 3. Put your example inside application folder
### 4. Spin up the deployment with your example:
```
make run
```
### 5. Exec into applications pod
### 6. Run your example

You can check the results are saved by checking the postgres deployment and the minio deployment.

## Cleanup:
### 1. Clean only kubernetes resources:
```
make clean-kube
```
### 2. Clean kubernetes resources and images 
> **Warning**
> It runs a system prune, please do not run this and delete images individually if this might affect your other projects
```
make clean
```




## TODOS:
1. Make an enriched example (with a "quickstart")
2. Create tests (git actions)
3. Update and improve this readme (and create more documentation resources)
4. Improve cleanup