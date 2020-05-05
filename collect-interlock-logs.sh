#!/bin/bash

LOGDIR="/tmp/interlock-logs$(hostname)-$(date -u +'%s')"
mkdir $LOGDIR

for i in $(docker ps -a -f name=interlock -q); do
    docker container logs $i &> $LOGDIR/$i.log
done

for i in $(docker service ls -f name=ucp-interlock -q); do docker service inspect $i > $LOGDIR/$i-inspect.json; done
