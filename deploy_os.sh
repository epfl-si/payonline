#!/usr/bin/env bash
# (c) All rights reserved. ECOLE POLYTECHNIQUE FEDERALE DE LAUSANNE, Switzerland, VPSI, 2020
image='payonline'

printerror () {
  echo "=========================================================================================="
  echo "=";
  echo "= FAILURE: $1";
  echo "=";
  echo "=========================================================================================="
  exit 1;
}

usage() { echo "Usage: $0 [-t <tag name>] -n <namespace>" 1>&2; exit 1; }

while getopts ":t:n:" option; do
    case "${option}" in
        t)
            tagname=${OPTARG}
            ;;
        n)
            namespace=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))
if [ -z "${namespace}" ]; then
    usage
fi
if [ -z "${tagname}" ]; then
    tagname='develop'
fi
env=`echo $namespace | grep -oP "[a-z]+\-\K(test|prod)"`
# Checkout code on tag
git checkout $tagname
if [ $? -ne 0 ]; then printerror "Couldn't checkout code at $tagname"; fi
# Check that prod deployment references the new image
if ! grep -q "$namespace/$image:$tagname" "./k8s/$env/deployment.yml"; then
  printerror "It seems that deployment wasn't updated with new image tag $tagname";
fi
# Check that you are connected to OS and select namespace
oc project $namespace
if [ $? -ne 0 ]; then printerror 'oc failure, make sure it is installed, that you are logged in, and the project exists of you are granted on it'; fi
# Build image
docker build -t $image:$tagname .
if [ $? -ne 0 ]; then printerror 'could not build image'; fi
# Tag image with imagetag
docker tag $image:$tagname os-docker-registry.epfl.ch/$namespace/$image:$tagname
# Push image
docker login os-docker-registry.epfl.ch
docker push os-docker-registry.epfl.ch/$namespace/$image:$tagname
if [ $? -ne 0 ]; then printerror "could not push image to registry, check you are logged in on the right namespace ($namespace)"; fi
oc apply -f ./k8s/$env/deployment.yml