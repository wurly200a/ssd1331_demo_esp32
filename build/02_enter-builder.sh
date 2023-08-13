#!/bin/bash

if [ $(dirname $0) = . ]; then
echo "This script should be run in one directory above."
exit
fi

if [ "$#" != 1 ]; then
IMAGE_NAME="esp-idf-v4_builder"
else
IMAGE_NAME=$1
fi

USER_NAME=$(id -u -n)
GROUP_NAME=$(id -g -n)

CMD="docker run --rm -it"
CMD+=" -u ${USER_NAME}:${GROUP_NAME}"
CMD+=" -v ${PWD}:${HOME}/work"
CMD+=" -w ${HOME}/work"
CMD+=" ${IMAGE_NAME}"

echo "***********************************************"
echo "*                                             *"
echo "* You can run 'get_idf' to shorten the build. *"
echo "*                                             *"
echo "***********************************************"

echo ${CMD}
${CMD}
