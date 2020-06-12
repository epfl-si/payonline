#!/usr/bin/env bash
image='payonline'
project="$image-test"

printerror () {
  echo "=========================================================================================="
  echo "=";
  echo "= FAILURE: $1";
  echo "=";
  echo "=========================================================================================="
  exit 1;
}

# Check that you are connected to OS and select project
oc project $project
if [ $? -ne 0 ]; then printerror 'oc failure, make sure it is installed, that you are logged in, and the project exists of you are granted on it'; fi
# Generate tag from timestamp
#imagetag='develop-'`date "+%Y%m%d%H%M%S"`
imagetag='develop'
# Build image
docker build -t $image:$imagetag .
if [ $? -ne 0 ]; then printerror 'could not build image'; fi
# Tag image with imagetag
docker tag $image:$imagetag os-docker-registry.epfl.ch/$project/$image:$imagetag
# Push image
docker login os-docker-registry.epfl.ch
docker push os-docker-registry.epfl.ch/$project/$image:$imagetag
if [ $? -ne 0 ]; then printerror "could not push image to registry, check you are logged in on the right project ($project)"; fi
# Deploy
oc replace -f ./k8s/test/deployment.yml