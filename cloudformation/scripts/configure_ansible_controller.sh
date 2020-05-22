#! /bin/bash

# $1 -> ansible controller private key path
# $2 -> key to push
# $3 -> repo root path

if [ "$#" -ne 3 ]
then
    echo "Args: ansible_private_key key_to_push repo_to_push"
    exit 1
fi

ANSIBLE_PRIVATE_KEY_PATH=$1

if [ ! -f "$ANSIBLE_PRIVATE_KEY_PATH" ]
then
    echo "$ANSIBLE_PRIVATE_KEY_PATH doesn't exist."
    exit 1
fi

PUSH_PRIVATE_KEY_PATH=$2

if [ ! -f "$PUSH_PRIVATE_KEY_PATH" ]
then
    echo "$PUSH_PRIVATE_KEY_PATH doesn't exist."
    exit 1
fi

REPO_ROOT_PATH=$3

if [ ! -d "$REPO_ROOT_PATH" ]
then
    echo "$REPO_ROOT_PATH doesn't exist."
    exit 1
fi

VIRTUAL_ENV_PATH="$HOME/capstone_venv/bin/activate"
source $VIRTUAL_ENV_PATH
cd ansible

ansible-playbook -i inventories/ansible_controller_aws_ec2.yml \
    configure_ansible_controller.yml \
    --private-key "$ANSIBLE_PRIVATE_KEY_PATH" \
    --extra-vars "{'key_to_push':'$PUSH_PRIVATE_KEY_PATH','local_repo_root_dir':'$REPO_ROOT_PATH'}"

deactivate