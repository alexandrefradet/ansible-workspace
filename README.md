# Ansible workspace

Just started to use Ansible. Used to manage my workspace installation on new computer with bash script.
Will try to transpose this in ansible.

## Objectives

- Aimed at setting up a dev workspace on newly install system.
- Target OS is Ubuntu:18.04, plan on adding some RH distrib after (Fedora / CentOS)

## Testing

To allow easy testing, there is a docker image setup to allow easy ssh from ansible.
To run a test on playbook, run script 'run_test.sh', this will build the test image, create a container based on it and run the playbook in the container, then stop and delete container.

Script handles following flags / var :
-k / --keep : prevent the docker container deletion at the end of the test

## Current
- Building dotfiles roles
- Improve script test to specify playbook to run / variabalize in some way.
