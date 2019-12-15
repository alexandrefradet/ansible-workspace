#!/bin/bash

# Credit to Ayesha M
# https://medium.com/@ayeshasilvia/testing-ansible-playbook-in-a-docker-container-21628e9ee256

DOCKER_CONTAINER_NAME="ansible-test"
DOCKER_KEEP_AFTER_TEST=false

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -k|--keep)
        DOCKER_KEEP_AFTER_TEST=true
        shift # Remove --keep from processing
        ;;
    esac
done

echo "# DOCKER_KEEP_AFTER_TEST: $DOCKER_KEEP_AFTER_TEST"

cd docker && docker build -t test-ubuntu18-ansible .

docker run -ti --privileged --name $DOCKER_CONTAINER_NAME -d -p 32768:22 test-ubuntu18-ansible

cd ../playbooks && ansible-playbook -i ../hosts.yaml test.yaml -vvv

if [ "$DOCKER_KEEP_AFTER_TEST" = false ] ; then
	docker stop $DOCKER_CONTAINER_NAME
	docker rm $DOCKER_CONTAINER_NAME
fi
