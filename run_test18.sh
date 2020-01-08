#!/bin/bash

DOCKER_CONTAINER_NAME="ansible-test"
DOCKER_KEEP_AFTER_TEST=false
ANSIBLE_VERBOSE=false

# Loop through arguments and process them
for arg in "$@"
do
    case $arg in
        -k|--keep)
        DOCKER_KEEP_AFTER_TEST=true
        shift # Remove --keep from processing
        ;;
        -v)
		ANSIBLE_VERBOSE=true
		shift # Remove --keep from processing
		;;
    esac
done

echo "Creating test container"
docker run -d --privileged --name $DOCKER_CONTAINER_NAME --volume=`pwd`/playbooks:/etc/ansible/roles/role_under_test:ro geerlingguy/docker-ubuntu1804-ansible:latest

if [ "$ANSIBLE_VERBOSE" = true ] ; then
	docker exec --tty $DOCKER_CONTAINER_NAME env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/test.yaml -vvv
else
	docker exec --tty $DOCKER_CONTAINER_NAME env TERM=xterm ansible-playbook /etc/ansible/roles/role_under_test/test.yaml
fi

if [ "$DOCKER_KEEP_AFTER_TEST" = true ] ; then
	docker exec -it ansible-test /bin/bash
else
	docker stop $DOCKER_CONTAINER_NAME
	docker rm $DOCKER_CONTAINER_NAME
fi
