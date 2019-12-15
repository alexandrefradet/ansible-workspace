#!/bin/bash

# Credit to Ayesha M
# https://medium.com/@ayeshasilvia/testing-ansible-playbook-in-a-docker-container-21628e9ee256

DOCKER_CONTAINER_NAME="ansible-test"

cd docker && docker build -t test-ubuntu18-ansible .

docker run -ti --privileged --name $DOCKER_CONTAINER_NAME -d -p 32768:22 test-ubuntu18-ansible

cd ../playbooks && ansible-playbook -i ../hosts.yaml test.yaml -vvv

docker stop $DOCKER_CONTAINER_NAME

# docker rm $DOCKER_CONTAINER_NAME