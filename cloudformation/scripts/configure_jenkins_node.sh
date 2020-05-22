#! /bin/bash

# $1 -> ansible controller private key path

if [ "$#" -ne 1 ]
then
    echo "You need to specify the jenkins node private key path."
    exit 1
fi

JENKINS_PRIVATE_KEY_PATH=$1

if [ ! -f "$JENKINS_PRIVATE_KEY_PATH" ]
then
    echo "$JENKINS_PRIVATE_KEY_PATH doesn't exist."
    exit 1
fi

VIRTUAL_ENV_PATH="$HOME/capstone_venv/bin/activate"
source $VIRTUAL_ENV_PATH
cd ansible

ansible-playbook -i inventories/jenkins_node_aws_ec2.yml \
    configure_jenkins_node.yml \
    --private-key "$JENKINS_PRIVATE_KEY_PATH"

deactivate