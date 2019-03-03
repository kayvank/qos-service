#!/bin/bash
##########################################
## run the docker image generated from packaging this project
## must provide image name
## dependency: requires ./.envrc pointing to a suitable env
##########################################

if [[ $# -lt 1 ]]; then 
  echo "usage is $0 dockeriamge" 
  exit -1
fi
##for i in `docker ps -a | grep 'qos' | awk '{print $1}'`;do docker rm -f $i;done
##for i in `docker images | grep 'qos' | awk '{print $3}'`;do docker rmi -f  $i;done

 docker run  \
   -p 5432:5432 \
   -e POSTGRES_PASSWORD=qos \
   -e POSTGRES_USER=qos \
   -e POSTGRES_DB=qos \
  $1
