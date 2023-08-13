#!/bin/bash

if [ "$#" != 1 ]; then
IMAGE_NAME="esp-idf-v4_builder"
else
IMAGE_NAME=$1
fi

CMD="docker build . -f $(cd $(dirname $0); pwd)/Dockerfile -t ${IMAGE_NAME} \
            --build-arg USER_NAME=$(id -u -n) \
            --build-arg USER_ID=$(id -u) \
            --build-arg GROUP_NAME=$(id -g -n) \
            --build-arg GROUP_ID=$(id -g) \
            --build-arg PASSWORD=password \
            --build-arg IMAGE_NAME=${IMAGE_NAME}"

echo ${CMD}
${CMD}
