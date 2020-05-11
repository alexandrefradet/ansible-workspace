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

### Error case
"Failed to connect to the host via ssh: ssh: connect to host localhost port 32768: Connection refused\r\n"
=> Check docker logs, you probably already had an existing container with that name (used -k flag ?).

## Current
- Building dotfiles roles
- Improve script test to specify playbook to run / variabalize in some way.


## Documentation

### Variables

#### Notation
foo['field1']
foo.field1

#### Keywords to avoid with dot notation

add, append, as_integer_ratio, bit_length, capitalize, center, clear, conjugate, copy, count, decode, denominator, difference, difference_update, discard, encode, endswith, expandtabs, extend, find, format, fromhex, fromkeys, get, has_key, hex, imag, index, insert, intersection, intersection_update, isalnum, isalpha, isdecimal, isdigit, isdisjoint, is_integer, islower, isnumeric, isspace, issubset, issuperset, istitle, isupper, items, iteritems, iterkeys, itervalues, join, keys, ljust, lower, lstrip, numerator, partition, pop, popitem, real, remove, replace, reverse, rfind, rindex, rjust, rpartition, rsplit, rstrip, setdefault, sort, split, splitlines, startswith, strip, swapcase, symmetric_difference, symmetric_difference_update, title, translate, union, update, upper, values, viewitems, viewkeys, viewvalues, zfill.

### Facts

#### Explanation

Variables derived from remote system interaction
[Documentation officielle](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variables-discovered-from-systems-facts)

To see what information is available, try the following in a play:
```yml
- debug: var=ansible_facts
```

