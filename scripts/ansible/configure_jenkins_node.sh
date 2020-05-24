#! /bin/bash
# $1 -> virtual_env root path
# $2 -> jenkins node private key path

if [ "$#" -ne 2 ]
then
    echo "Args: <virtual_env_dir> <jenkins_private_key>"
    exit 1
fi

VIRTUAL_ENV_PATH="$1"

if [ ! -d $VIRTUAL_ENV_PATH ]
then
    echo "$VIRTUAL_ENV_PATH doesn't exist."
    exit 2
fi

JENKINS_PRIVATE_KEY_PATH=$2

if [ ! -f "$JENKINS_PRIVATE_KEY_PATH" ]
then
    echo "$JENKINS_PRIVATE_KEY_PATH doesn't exist."
    exit 3
fi

VIRTUAL_ENV_PATH="$VIRTUAL_ENV_PATH/bin/activate"
source $VIRTUAL_ENV_PATH
cd ansible

ansible-playbook -i inventories/jenkins_node_aws_ec2.yml \
    configure_jenkins_node.yml \
    --private-key "$JENKINS_PRIVATE_KEY_PATH"

deactivate