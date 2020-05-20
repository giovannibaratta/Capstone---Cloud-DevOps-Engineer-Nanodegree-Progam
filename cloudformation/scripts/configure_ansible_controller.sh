#! /bin/bash

# $1 -> ansible controller private key path
# $2 -> key to push

if [ "$#" -ne 2 ]
then
    echo "You need to specify the private ansible private key path and the private key to copy to the controller."
    exit 1
fi

ANSIBLE_PRIVATE_KEY_PATH=$1
PUSH_PRIVATE_KEY_PATH=$1

if [ ! -f "$ANSIBLE_PRIVATE_KEY_PATH" ]
then
    echo "$ANSIBLE_PRIVATE_KEY_PATH doesn't exist."
    exit 1
fi

if [ ! -f "$PUSH_PRIVATE_KEY_PATH" ]
then
    echo "$PUSH_PRIVATE_KEY_PATH doesn't exist."
    exit 1
fi


VIRTUAL_ENV_PATH="$HOME/capstone_venv/bin/activate"
source $VIRTUAL_ENV_PATH
cd ansible

ansible-playbook -i inventory/ansible_controller_aws_ec2.yml \
    configure_ansible_controller.yml \
    --private-key "$ANSIBLE_PRIVATE_KEY_PATH" \
    --extra-vars "{'key_to_push':'$PUSH_PRIVATE_KEY_PATH'}"

deactivate