#!/usr/bin/env bash
set -x
NAME=payonline
hosts='exopgesrv111 exopgesrv116'
docker build -t $NAME .
docker save -o /tmp/$NAME.tar $NAME
for h in ${hosts}; do
    scp /tmp/$NAME.tar dinfo@${h}.epfl.ch:/home/dinfo/docker/images
    ssh -t dinfo@${h}.epfl.ch "/home/dinfo/docker/deploy_service.sh $NAME"
done