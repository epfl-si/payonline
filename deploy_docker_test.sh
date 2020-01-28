#!/usr/bin/env bash
set -x
NAME=payonline
docker build -t $NAME .
docker save -o /tmp/$NAME.tar $NAME
scp /tmp/$NAME.tar dinfo@exopgesrv111.epfl.ch:/home/dinfo/docker/images
ssh -t dinfo@exopgesrv111.epfl.ch "/home/dinfo/docker/deploy_service.sh $NAME"