#! /bin/bash

# $1 -> ansible controller private key path

if [ "$#" -ne 1 ]
then
    echo "You need to specify the ansible controller private key path."
    exit 1
fi

ANSIBLE_PRIVATE_KEY_PATH=$1

if [ ! -f "$ANSIBLE_PRIVATE_KEY_PATH" ]
then
    echo "$ANSIBLE_PRIVATE_KEY_PATH doesn't exist."
    exit 1
fi

ANSIBLE_CONTROLLER_ADDRESS=$( cat /tmp/ansible_controller_address )

REMOTE_COMMAND='~/repo/cloudformation/scripts/configure_kubernetes_nodes.sh'

ssh -i $ANSIBLE_PRIVATE_KEY_PATH centos@$ANSIBLE_CONTROLLER_ADDRESS $REMOTE_COMMAND