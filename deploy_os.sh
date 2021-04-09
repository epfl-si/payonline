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

usage() {
    echo "Usage: $0 [-t <tag name>] -n <namespace>" 1>&2;
    echo "   <tag name>  is the image tag to be used 'develop' (without quotes)";
    echo "   <namespace>  is the project name ex. 'payonline-test' (without quotes)";
    exit 1;
}

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

if [ -z "$NOBRANCHCHECK" ]; then
    BRANCH=$(git rev-parse --abbrev-ref HEAD);
    if [[ "$BRANCH" == "develop" && "$env" != "test" ]]; then
         echo "Aborting script deploying branch $BRANCH into $env environment";
         echo "NOBRANCHCHECK=1 $0 # to bypass"
         exit 1;
    fi
fi

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
if [ $? -ne 0 ]; then printerror "could not push image to registry, check you are logged in on the right project ($project)"; fi
# Deploy
oc replace -f ./k8s/$env/deployment.yml
