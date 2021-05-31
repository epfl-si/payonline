#!/bin/sh

cd "$(dirname "$0")"
set -e -x

docker build -t os-docker-registry.epfl.ch/payonline-test/payonline:develop .
docker push os-docker-registry.epfl.ch/payonline-test/payonline:develop
